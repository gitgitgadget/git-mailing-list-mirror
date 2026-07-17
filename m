Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD673A9850
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267417; cv=none; b=VlZIxgReksOfgpVSSP9mo5XagQWKxSVLzNLOlsFu0a5uKxrG+DIHrxZNfJHeJIhNDrhZWZ0Ynq3Z9hKcWLpUe6pPmVS3iy+LL9Zz9Ep57bqte+r8x1FWV5Gsjk22E9z9QWL+fNM/Wx+D4Nm/nZTQC5oKbCmjOaNBJGggmmTRfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267417; c=relaxed/simple;
	bh=E+Gvru1yZAgZ2jIsF+EJGzHL+1I583U/REwVxhftHxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SxvnVV6tfnF+XvaA1lvlQHK62dFf9yDW/YkoxRNxn7A4Z+F1Ll5XApt1Y2vA4Vgkxk39T5O/5oBOxBBnisop4VsYAZollUtCaK4WxxWXl9h4fKaMzsfe8a67etZ1najj5Wer4b5gK1jQV0Yb+rmxvcf/6/Ce1s8my9jBHtpF6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HNIooBDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNxf/bcU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HNIooBDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNxf/bcU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 99387EC00AD;
	Fri, 17 Jul 2026 01:50:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 01:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784267412; x=1784353812; bh=YZTFBxZ8sk
	pqH+D50cx/ETmvg6pxEOOCdD6ceGPBhHI=; b=HNIooBDAVlFws6nXGhwRLyux9K
	Yygl3e2dYO6sZ2AyJD+YENJTYhPx9QD1lFwIdm0wqC9uCydv3xFwbm/ZLcQaB93M
	1xPqoMIWkUH4tkjc5Vi1rrMYpi6jF8jDqz851wGYrMgAqH8N4bTnuqoBbpGoOrdS
	vLUW0GvtZGgveR476HaaghwA9A8KqqHMc+zPBw1KXpBG1c/NoZ6YgqLSo/k9+oeM
	PoXWSmWY1tqwVkNHLhurvm4VcOkTsMnyYDsXJqbA8EHqYlLK/2T2uElyMTPUYpiR
	uM4RIoFnsYp9QpwFZ8uy3e4S7UDRgF6dt21ASTHeQpKVOfAXdoIoGpkb/nxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784267412; x=1784353812; bh=YZTFBxZ8skpqH+D50cx/ETmvg6pxEOOCdD6
	ceGPBhHI=; b=MNxf/bcUyyzYzVsZE1gy6qQOfaSUPa7CaB+MafWUr3o6CWNF8MT
	Q8foypnNexECyluol9j3drH+f3/mRk7AIWLv/S4ti1QAN1WU+BzvmxPYKGv2lCu2
	mRgL/lvUINdPbxOBX3uTyb6IZ3e07P9rZoJlsQbFoPtlu6F23eviU+oCkPsJml0t
	eyMt7HpWjzI3kgNVqHquFnYVdoDes43ntAkeEQGcnpJkE8NcoySHjCOfbFhgn4uT
	hVBb37q7ILTMPHEPO5g3LLpArgoJtX4KDWzV3kX3iFcVtesVoJnxFKWhcNYx+XMf
	6FPQ84ANc4qbgfB5i4O2s0jQDP3NrP0hkHA==
X-ME-Sender: <xms:lMJZaoxIbOQX1ur84JpN_2lY7TgRrsyWI9cNFA4oPPnMTZVvjwkChQ>
    <xme:lMJZapZobgmMbU8n5m7XnjCKKjJQtzsMpCHYpANo1B1O_4zhXEBDRHEj5qcwo6Ggc
    z7A8DiQckagAYDcBRDniZMnkRaUDo4qmEmz7dF63ns_RjUpNSThAqc>
X-ME-Received: <xmr:lMJZapWlPbg5Kz6UkTNvQwKWkkgnjISRLLwOufXCZIXo1AkfI5419waPofReJLh2FkTl88DFHCxkABT3UMR_XGgB5IIJxkbz63IwNwA>
X-ME-Proxy-Cause: dmFkZTEPYxb3yURENJvmPwwq3SmI848wpPjusdqnGhwD6qCa7xNu9757C8M14+7eRY1I9T
    Qn6uaM+ZME8kIYsI44e8QQd31OMg52t18dln/CzgKfry+Dh2K83Za/hizOLAGSOmzCdXTN
    ykNHVPQ/lf61GJYMngEwoWGhrvDknRum0E0ncnoQ3qtfjb5fxTPG1REWRPMmSY2JJkVqdQ
    NPXsm64QqUPj+wE2hvRTVOtKLWGRIzg+U9TVOrYGXhBLZUTPVcDKJ1hguSQJXkHVfIMLr5
    zBLeS/HCgGS7bKpCs83lAFkUjzZAn9dd4KPW4YWeqE0dsj+e+/3R89ApP//+GKaUiEX6sb
    9EvV8i/M5Qc6zl0ivP+17sw3d846deF2tUJH1lwaVCDCIIpDgJYrqvWRzt+g7gbkR2x4Uo
    /ILweJqz0TXOdF0sI39d2snNmcHUOptU46YxSMOkfQw+t7/ZlsEoPNLyxTBEgWFKfOrmUK
    RsGCthpIFYJ9DpH2C2zaIdRSyCwI5KJycO3GCiDOdMgmeDFlD6xldjfjybbo2weA372PfP
    +TyNT4aB2sYNI3KxD834fedbmI9UCen5Oku8T8WTQy26pLhjj5mX8sz8+O4Qple7ZKjjCD
    6AtwDekfInTJuIqPcCQYPqKv79EKkDraRjA+uVZ+WQ8jMFWmmK0FGsW1Sa2A
X-ME-Proxy: <xmx:lMJZanimmAbUkC2kiuZZUYrp1jzqcaLtE4QRfy6gqA45N2xhuyeexA>
    <xmx:lMJZanvyn3JWMkHGlSvdkVFluIeTzufPtUWuU3nx-Fg3b4c4X3Lq2Q>
    <xmx:lMJZag4bHP6FbsMPA1d_kLttorrcz_lj-a8fbzC6FC5uXa18K-jlzQ>
    <xmx:lMJZarOIG2ulj1-dam2-ZceZcV-44XAmK04Ex-oPn-Ecc317Ds2VJw>
    <xmx:lMJZanKUM9bIyWdfzvVdak2nvIA2Grw5ig3cPZuOMOSWOJtej3iUsvJI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 01:50:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Travor@web.codeaurora.org
Cc: "Liu <travor_lzh"@outlook.com,  git@vger.kernel.org,  Travor Liu
 <travor_lzh@outlook.com>
Subject: Re: [PATCH 2/2] t9502: test gitweb index hash formatting with modes
In-Reply-To: <SA1PR10MB9977159B51766C2D9FFE98FD37F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
	(Travor@web.codeaurora.org's message of "Wed, 15 Jul 2026 17:11:30
	+0800")
References: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
	<SA1PR10MB9977159B51766C2D9FFE98FD37F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
Date: Thu, 16 Jul 2026 22:50:09 -0700
Message-ID: <xmqqjyqu6u7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Travor@web.codeaurora.org, "Liu <travor_lzh"@outlook.com writes:

> From: Travor Liu <travor_lzh@outlook.com>
>
> gitweb should shorten and link the object IDs in commitdiff index lines
> even when Git includes the trailing file mode:
>
>     index <old>..<new> 100644
>
> Add coverage for that common form by rendering a commitdiff for a
> regular file modification.  Check that the visible index line contains
> linked short blob IDs followed by the mode and file-type annotation,
> and that the full unlinked form is not emitted.
>
> Signed-off-by: Travor Liu <travor_lzh@outlook.com>
> ---
>  t/t9502-gitweb-standalone-parse-output.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

If the new test added by this patch validates the "fix" in
[PATCH 1/2], reviewing the change might be easier if the two
were squashed into a single patch.

> diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
> index 81d5625..7f37e26 100755
> --- a/t/t9502-gitweb-standalone-parse-output.sh
> +++ b/t/t9502-gitweb-standalone-parse-output.sh
> @@ -115,6 +115,20 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
>  '
>  test_debug 'cat gitweb.headers'
>  
> +test_expect_success 'commitdiff: index line shortens hashes with mode' '
> +	old_blob=$(git rev-parse HEAD:foo) &&
> +	old_short=$(git rev-parse --short=7 HEAD:foo) &&
> +	echo changed >foo &&
> +	git commit -am "change foo" &&
> +	new_blob=$(git rev-parse HEAD:foo) &&
> +	new_short=$(git rev-parse --short=7 HEAD:foo) &&
> +	gitweb_run "p=.git;a=commitdiff;h=HEAD" &&
> +	grep ">${old_short}</a>\\.\\.<a [^>]*>${new_short}</a> 100644" \
> +		gitweb.body >index_line &&
> +	grep "<span class=\"info\"> (file)</span>" index_line &&
> +	! grep "index ${old_blob}\\.\\.${new_blob} 100644" gitweb.body
> +'

Can we use "test_grep" (for positive "this string must be there") and
"test_grep !" (for negative "it is an error if this string appears"
(note that exclamation point comes after test_grep))?  It would make
it easier to diagnose a failing test.

Also, there is a topic in flight that enforces the use of test_grep in
these test scripts, and use of raw grep like the above would break
under those stricter rules.

Thanks.

