Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F352EA75E
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962999; cv=none; b=gpVBtpYJGVl2OWqCqRmhOh/7rRaC0pdgxqxVumlx6Qyql/EgGglrZFZpoIJ+fmM8pVx4VC0PssvFRCGzIX1OKr/3xiP7EXgvCTKZvwYI25RgPKBd8jSahCBrH59TkSD1oCsV5EEGVTTGD33qw9pWa81qS3lJ9LMo9HnNKMNelgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962999; c=relaxed/simple;
	bh=jhF0lDlzeX1hLqpfDj5pgAuhV2na/6imK34n9HMBv/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQOnwDKE/CdmCNgyaeI3jQINPn6he5TAO6y9FQCsXUYQE5EXw8o7kuVspXXljDUVmZjVa5sjoP1PqQhX4H1kj2OqTr9OTH7I7jF0GX8a+i6JnMWomn1+QmtTyAShDx7iQ8KVWIX+1cDwj4f6/naYYxgGKStgC3P/UR1DJLdRHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eYJnsDcG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIgJX9YD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eYJnsDcG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIgJX9YD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69AB37A0197;
	Mon,  8 Jun 2026 19:56:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 19:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780962997; x=1781049397; bh=8QX1nBPKwG
	bEL/lSGETL9DOdvFlP5p/SK9IEEWTxpM8=; b=eYJnsDcGas07lbF4wxPS+0zPB8
	OcMT+ZFvU42iob0FzE+wAdnct7DS8SdIrCqE2km+QKmC8pWiytVAsse5FieIgw1c
	ILCwM4CBUxxTWoPU4dxXxzrlE9XSSgyQ+UMzmzNqTTZ9ssHTbYzWEEwPcE2hqrkf
	Uux/nXY84dYbT9BQMgnHvl94c/89Ju6uSFyCOI7oFotWQqqhiSCqMJKhLcga6h3/
	OrPG/0vkMDNoeUxN+UOmnA556k1vamanGoSvN5A7TZzSsO0cD02/w8dLV6NenXgo
	qsLEVvt1gSg8aIK3R3keub9xSSdHKbLgJSLGVmtg9XXCbXpZTMyvNZ0/lbog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780962997; x=1781049397; bh=8QX1nBPKwGbEL/lSGETL9DOdvFlP5p/SK9I
	EEWTxpM8=; b=RIgJX9YDD2jNHF/uE7efRsNJ1TB98ZCX1jvCisw66g2lSS1SqRl
	pxrbhg3TPkOdcc5HqAs4CpZSfeWGRs4OI6QpcMs89NAaJAIWZnSHZZZQjV8CY1ks
	veqcJOs7DzLMXeeWNVuEziNJk2+btDvHleWZqPIqmcVBCqDVB76sLg3LD26iD3sq
	xlUpH2T5MFjK9/WVnS268cvUMxXpGUsqYlB8A+CxWvr7HFTx0dh7eJ1j36aGhuce
	csEiZ0/6eTaPk6uWFaAKlZj/uhkMMRae1IKyUdq2ttfLAJ5pdRlZEQbnnQKvgwsJ
	55dYLbNSkf4eMNhVi5dmNtrBFZ9tx6AvXAg==
X-ME-Sender: <xms:tVYnatEkcQeMs2zq7VLTwT4O09Ocieukig0nSJ2GNqAizzirclVzgQ>
    <xme:tVYnakl3uv98h1WSiWQNW0b896OqojRu0SJA70wKWqw4iJJpu7TA0pXMcMwbxTuv_
    vXHNghXOXjydc3_AHyyNEDyXcGoeXhjNPNym-S-UdX8PR2Iq3AeLg>
X-ME-Received: <xmr:tVYnahY8IJodW3ZGEqwrYyhzHVGNFv_pDbY397LRgQfFwZnLzDFZTo30Yjm2ivH3YBYPUKkzO339-uiXqGTLN4631XC1VYy5Hsgv>
X-ME-Proxy-Cause: dmFkZTF+DAaEbxd00Sx2jsE9xcBI7Z4r2eSakzPmyI24viPDiOSfa92n0x6L24CBlLZdiL
    9he1bZgKoMV/uTG7nOQWpyRKn1/wVFj5QP5VTNGkinB5sGZMdu86j5Wot9df4wOcMUlMhb
    31CcTORKgdz42qktyrS5tR6sEoDqLus6Sg+yXwJNzAog30t/yig2kQlp+a2jnRwb2KhA7Z
    ZTuqZtTUIunDnZBAgIcLJb4m7A2kvQC89g+Z9kMGzuG3ofLMKbAV0KMQzEZt/UilGFo8CH
    sMHtqmCJRlVrQIrys9I8uwtmDE1rMY4ya/FlsKc3/TUae/tuutz80FgFJ2GS0eE+zR2Eg6
    53aBGyNg9tAZq9j+uZUC734WgP1TPrz0y222DxIycPEkusCH6U6ZDi/oKMPPAZdGYdPNxp
    110yNAM54faUeOPovC2Y9AX5xwEbZto6kdiZ9eBe+FrNUfNYXj9epwNytg6338IgyyKS+Q
    rZoOvrr5MfuJpGoyHJEb97KQdgIl6wtQ/VDGO6GUlJeF9Nm2RJM2gn8GCicWLFvRm3yK0Y
    xzMpOyuHiM8nOy4e1VHC9WM4UItqNeI+FYqs/FG6ja8Ty3fScnmP8DRJR+hAAbDOQu4hkq
    KnygEhMU8eGwGRjQ7AyVBNg+mIuBNWv9PUtqiUHSk00k9Nfuhod3zMAIcgoA
X-ME-Proxy: <xmx:tVYnapHHrJxTdA1Ot4Ld55oYElUl518Gb5SedmY0icjIRec_uqVEHA>
    <xmx:tVYnaiITPvDl_WUzzCqxW8Gc8o5AeeBvJfy9Mo9Xuo12p_XzzIvCxg>
    <xmx:tVYnakMRRIGbDbTdx8il0Ss_P9J7BKDUWfgIe8lJwcJn4-0mbnsZ_Q>
    <xmx:tVYnainnG6nvngtp5F_rsW9Deu7RqWunILffm_2eTBCEWPaCn-YkvA>
    <xmx:tVYnaqxn9C6ylt_yU7seikI9hqz3H-Y7inybHwPUsXSTpvM3bGmcnAB5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 19:56:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 2/6] branch: let delete_branches warn instead of
 error on bulk refusal
In-Reply-To: <a7672713f67d6a44992c0f0cf989770c7e9ca38b.1780684553.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 05 Jun 2026
	18:35:49 +0000")
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<a7672713f67d6a44992c0f0cf989770c7e9ca38b.1780684553.git.gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 16:56:35 -0700
Message-ID: <xmqq4ijcvb64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a warn-only mode to delete_branches() and check_branch_commit()
> so a bulk caller can report branches that are not fully merged as a
> short warning and carry on, rather than erroring with the longer
> "use 'git branch -D'" advice that the plain "git branch -d" path
> emits. Existing callers are unaffected.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/branch.c | 50 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)

This breaks t5404, t5514, and t5505, which contradicts with
"Existing callers are unaffected".

What's going on?  It is troubling that the breakage happens without
even getting merged with other topics in-flight, which means that
the environment you are developing in and testing on and the
environment that I apply patches on, integrate and test (something
based on Debian testing) are somehow behaving differently.

"cd t && sh t5404-*.sh -i -v" ends like so:

expecting success of 5404.7 'already deleted tracking branches ignored':
        git branch -d -r origin/b3 &&
        git push origin :b3 >output 2>&1 &&
        ! grep "^error: " output

error: the branch 'origin/b3' is not fully merged
hint: If you are sure you want to delete it, run 'git branch -D origin/b3'
hint: Disable this message with "git config set advice.forceDeleteBranch false"
not ok 7 - already deleted tracking branches ignored
#
#               git branch -d -r origin/b3 &&
#               git push origin :b3 >output 2>&1 &&
#               ! grep "^error: " output
#
1..7

but it may be possible that earlier steps are behaving differently
with the patches applied.  I didn't dig further but I think the CI
in the recent past have been affected by the same breakage.

