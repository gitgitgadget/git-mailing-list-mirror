Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3744CF52
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752079; cv=none; b=G7Od1Qee+iDqxYreiJMLFdI2/J7t76j2i4LftfY1lgJ1jqj4QR20J1GrJiTrB7/a3CNmC8u9pEMX4a3tcNjYHC7XgSkYkmtyNrNBl1s23Kz9+biJ2tFblMEp+kuyEaHTl2vhLfDBBQ86F6DIjKnU803oErej92PuHA3GMmN6Ug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752079; c=relaxed/simple;
	bh=YNAkv8fyPbi68lGKi26BIrkH/zgy2auZ4sKZPDK7wf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fEeQ0tYlr3FfDNs97obQ8GRBFhXHmio5y/A5LsTBNNGFD5MNwWpLIgEr3urA1/bd2lB5MgnBeosij7VPdvA67gM3SqUAd43fO9Oc6RPTJCkhqjZqyADIPHaaGWmpSy9FoDzZPg6a3pXo2rl12Gw+qQBwiG4+4BMb+S/0jLbbK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AxnEf5Ko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwYON2QT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AxnEf5Ko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwYON2QT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C14B1D0011A;
	Mon, 29 Jun 2026 12:54:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 12:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782752076; x=1782838476; bh=HLhd9x6veS
	1KOJZjGOu7SHDMAnuwbiV+UdGeirZA+Ow=; b=AxnEf5KoXoHY+HKDC8NQbAuTDk
	YrDlTwwLRbCfVFKIBbUKbt+N8RT3CcxNSTF31fyLhmdQq9S8ThSCIPICh8TbX67e
	fiRjcV5FPLbnHO5q1KbWyhwqVM4rf6HFeysmktL9hQgwNVivMeIyc9O6P+F3ezmv
	ZOIiEqMUeVylY3rpAJFny+Gjsb4NielxTaf8+4IYoVneOCxfYiVmxNg6jsEOBDrS
	tbXxr+GY2A26dvK8T+nXSWkhzR9m2WUIGEo374vZr6kas61Y1y9R7RtoMqQBiGnd
	4wHu9JsdVW4cB9vaLSjxhN7Zz9bwUNJF/njQWFezkenIxGHsUV/Cv1tSIsQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782752076; x=1782838476; bh=HLhd9x6veS1KOJZjGOu7SHDMAnuwbiV+UdG
	eirZA+Ow=; b=AwYON2QT19jC3DFOgU9gSiEHePl/58zxJ+sQeshTUPiQ7uHQIR3
	iLDpF9hR/+k9nUpAMidpQ4gPaxfMvYc0DJF07sbqNBP8Dk3/4AmAn0bsgkR8jJpk
	UkI4NvJL5NLy+OxSJRrqgOEC7ny9/ITYICpSs7y6AClryI/4tpAW7Yo6CCYhnRYM
	BIPEpY9Z+kVdwu2O/1ajW8n/CS48V3eq4fzxRQle4GiiEGKuHqZRmT/EBPplbs/6
	Kn4ncqfG76W7GSIouAX5HjyJcmdYdw8r+2FQ/ucbYPZMaMwDL5aBY7/K7bbUVdYU
	jBXD80Yjjt2FzcjPOmoMB3rAPYOnbEqroSQ==
X-ME-Sender: <xms:TKNCajyN73hkR-EmomLAIAoFYwNhPGmq_EMsU_CkFEdFLckVG1rSRA>
    <xme:TKNCar944oAqN6U7wCg4tuEaFsHhB4N9o96sUdwc9Uo8sXhKjlE7EcK5HcZUr9hZW
    _Ao5FRzokfV7uXfd6r5EcXPPqw3pj2W8h0QuBMZBoVmHZMlIVpZeg>
X-ME-Received: <xmr:TKNCarjXsZKGRGKhCD8Js4btWfo9C-BLOLw3eKnXjFE1t0hKD-9Xl-neLeW9JI5qSTKA1nYYpE_Ve5Dk10qw9j1jI3h6rgualgd_W_0>
X-ME-Proxy-Cause: dmFkZTEezDZU85Y2LOWm4mncbzDR8jyrvCuyl1iOS7kqzrsF1QNwbLLqkKOVEJzmPNtDb2
    1knaU31cNhBBE8DWwqe7h/pJniNL2+JADDVDCtn0B029d7aMgU2MZIo8KPalMTusAzJTyi
    EO1aQuzzYBj8ftP9Q/zUffI0JBLcKYms5OhDe5D66cDmMX4qIJabBIe4jmALrtrv2IwiQl
    uQutpRU8SvjdaGPOQMyTn32b6gJQGiPxqkpRdLcV9oXfoVL+O7ZcrzSB7TmRWaWIENy6Ka
    ZU23rAZy9H3pD6ZzjqM3AoDqTYm7VwNYoVGN0LS4pnuUJjkeL/yuD2FwfNmjShVs/XD9VW
    Gyhk2v4bk2c+VXvmSKFK0m8mAclfJykoq5WdWRUHkR6BwQEhs1Vs7obR7eWjqV/2astqcr
    t8SxnrxV4JFVdqiTgV/7EcMYDU4i2imQIxJrCJXI75Oz+x+YuTJ2uxxAhV8B5NsTb1M/9n
    nd3yu+91Vu3CLGRDfBidireYzRlXR/PQfHZT4NFJWzw6OH72VcfRYhJSsrh9TIaCoYav3j
    MqVF4eeS7IVfnXkkyE8MMQLnbRJup7eV0vXdBsFLDsS11dd8zBC+DFomv/IMqSrjTgDUvi
    zR1BVKkjMgyXPISAnpa9KOEoHefAo3OSWwfB5pDSAc67OsJD5uenHXOSb1qw
X-ME-Proxy: <xmx:TKNCaiGJdf0GFQ2fVRG0N0Vf6-QJmuue9tOZ9qKGyTV2AQiTLHehxg>
    <xmx:TKNCaq9khQCJOTGGg__uAmNd5_usf_jnMDmNEpjmIfScy4G1nDvLpA>
    <xmx:TKNCapwT_jLwvszC90-277AudNFeADIY3pc4YJbag5c3OWUO2Jp9bQ>
    <xmx:TKNCamM_KeuUbwLbxzTQW-83y4KgN7f9LIRGsaZVnI0XzEvfhN4bFQ>
    <xmx:TKNCasMazmQoCpxP4Lsau4qq92oOBxdjdReF0hgWCBmRcMIqMMR2OScl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:54:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  phillip.wood@dunelm.org.uk,  Harald
 Nordgren via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
In-Reply-To: <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com> (Phillip Wood's
	message of "Mon, 29 Jun 2026 16:51:19 +0100")
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
	<akIQLM6xZTHBudWT@pks.im>
	<3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
Date: Mon, 29 Jun 2026 09:54:34 -0700
Message-ID: <xmqqzf0dwalx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> It would be good to error out if the user tries squash a fixup! style 
> commit and range does not contain its target commit.

That's interesting.  It at least deserves a warning, even though the
choice to leave them out, with intentions to make it a separate fix
on top, may be deliberate.  If such a change-of-mind-in-the-middle
is rare, then erroring out would be perfect.  The user can first
reword the !fixup to make it a separate fix and then squash the
range in quesiton.

> We should sanitize what the user passes though - we do not want to 
> accept arbitrary rev-list options. Off the top of my head "--left-only" 
> and "--right-only" would allow the use of "A...B" and allowing "--not" 
> seems reasonable.

I would not recommend guessing what these rev-list "expressions"
would produce and blacklist some of the operations and notations.
It would be a more robust approach to let the machinery do its thing
to determine the set of commits, *and* inspect the shape of the
history these commits represent.  Are they connected?  Do they have
a single "bottom" that is just outside and below the range so that
we can replace it with the result of squashing everything together?
Do they have a single "top" whose children can be rewritten to have
the resulting single commit as one of their parents?  Starting from
the acceptable shape of the history we want to deal with, rather
than trying to enumerate rev-list operations and notations that
would prevent the resulting set of commits to fall outside the
acceptable shape of the history (and I am reasonably sure anybody
who attempts to do so would either end up with unusablly narrow
subset of what we can reasonably handle, or miss some cases that we
do not want to handle), would be a better approach.
