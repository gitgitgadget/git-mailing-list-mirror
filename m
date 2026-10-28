Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208406;
	b=FW4tlCEr0nkXyWxt0vcIcvB6k2chq8dVMtjwEhFCeqjb2W+dU2TShPbJTyeX/PaUnYRf
	 aDkqX+ZoI5W5vHtNMaqek17wuxu+1sFzd/wMZpkN8RfimuyGH7SrO290drdIaI1KepwfK
	 Cu5OWOzWUkrhQCQFpMAQKyulRsA3jEmIeOkc+iSCJxD22pv/LqvrnD5YNeNmszGN7VLLi
	 DpTxLmNN+YnNJCi9zJhiASuVH1Qn2YSRjb/5eGZkUyBIHEQPNCjrpuG4ZFatl6pCv1QQ4
	 xFOY4LIAJd89udodNxH6ptWVY77fM1XpIs520R42xHNk3PAX9CE2VEKlMv5zMZyKfzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208406;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eEGQ/3axL+R9Ejk3N9+h5yKGTW+bNTnaFeztty6Hm2E=;
	b=fIc5+qnJkph/+VdcFODGUwdmAzQaQdnEtPuZtL1AprP3xFq+GLhVegnW3qyQgo3Y2F6y
	 /epR7NkNBIpplPky9M07tcEsVwI4OmSRmZ6SE8PqS/fbiof3U1886yWJX9y4c1spPDjp0
	 tg1I61zo2KZ9GSmFl3XS+lQN3eyX8FVd00TBXPUK3Iga2sGtN6v+DrhaGDRc5TDGcyDfs
	 33G1qcsys8ENNDPMnzBIHVINt4XSAP398li/1nAsdaJx63oCFmhaMQTjbs6DZsIi9nW44
	 HUxFYwTjOhkKmUytHzjtQc8rJ2hQecULV5Tu6QVZ+tpg8Yl5hSg4xwbC0cTzSibH37A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="dTYek/tJ";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JrGp2dsL;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74593606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74593606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dTYek/tJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JrGp2dsL
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B42077A00B4
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:26:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 13:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793208404; x=1793294804; bh=eEGQ/3axL+
	R9Ejk3N9+h5yKGTW+bNTnaFeztty6Hm2E=; b=dTYek/tJvQz+w2Ou0aKdrgY38w
	Ses/Mv392NRIsKVrBgzqkkGVtn9AauGLrfdV4gpo2KZgJs4c1y0kitw0klgwEYRv
	Rtdr2BE4Ekf1ahwkLhQH53KDZdUVlu1yXd6d7R1EfXa8tmLMnktx5+O605SFuuYL
	vOx3KBa7mWJiA6Hhtax94bzaLhAxvXQMfmRMWSdh6Y+M+sotc/dsAl5PPgfg9YDa
	9Jim2CojHWidxwBXZymGL3NWlwVCt1SwxAWvJE+1qR7QnIGymX+tE+vqMVCEcWHd
	+Hms2AadgRo74Rsg+uSp7L8CsuUJAc67C6e3LD0R4JCDrqK+v0kI8s9cfasA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793208404; x=1793294804; bh=eEGQ/3axL+R9Ejk3N9+h5yKGTW+bNTnaFez
	tty6Hm2E=; b=JrGp2dsLIW24/CIwp/ujk1aLGhkGz/B2sACGX7KQBbVBi6/B9AV
	SITWpps7Kuxdn9ALlfF0TBB1y9vgeZed+lf/YOYhA+SARZdOlHQq787i8/zeZUyy
	p+BMsSjt2zOICtyZjqdIHnNIxAEvK+Mix+hdpFE3tTLlUOJssVSstPC0N5k4xcaM
	L5CnDoZ9S2bRgXJQoqxVLrY5Zs1LhARVcWfkE3X5e28U1VPly8TmXZUyZ8vWUvKX
	CnQs+7ILtezgMv9KUuz7eLC6LyJUDWbwjMP6vcPnZxfhYcmJ7r8D2Ph2hZOvfxVi
	N9a0LhdWb3z9BDuwThodRG9qdkYPigN3mvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793208404; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oqdyyFJxPLKiYpJ8CVEV2NqmJHmTxi6ySAtCQNXZXKWWGVo
	EksekdL5pgADzNhbYJ0/NQNmFkWYLOLP9FiMqtAXksyaxH/PbxNz1bqSikoQS0st
	OlDQVr0tZJIEkvsEDTGLUcig3tm0bbVjZMEsgqSbNPB0MghNz007KhfSoJjuz0IK
	N52alBsenlmfVF8DryYWhNWa5Gn293/CfohFTm5sZN8zlv7RwjrVRuNkdZhTvxox
	5tSR1ydmHnOm+GE4754Zr8USTo05sVC9AtmrtKPG3KnRNopkvCo4yZjO657zYXzk
	u3GvahqIha+IseQY4dKOUT/3UIernk9YySSUfFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tB1RioopcEkwveBpQQnqV0BgQKRIY31PQIupuAb/7b8=:cSHSAm90KyqjfVjcgVK03PRj8NKMRvrfHdmFY0Klx4k=;
X-ME-Sender: <xms:UzDiagcvbJmotH9SdDnc0OjQe0JMKu5JIljPjXP2qLXJ-Y5W8Dhlig>
    <xme:UzDiakdUkvBluYaMizfm4Jyz2cSruK51UM214_fOhcrdGAxYT2SAMru5sxlvi1TMt
    IfTe1rVztL7rjqDAdVuGruJTjcXTVFQGvEeDxKPkcFUGDjZnb23sg>
X-ME-Received: <xmr:UzDiajyIvRQPq4B2JgZrqIDJVX3OAn7UFJl4I0NEj94IDmc1ReQXhznaLNzz70fWtR7VVa8yZ2IkG_jKhSu00iO-VitA3Q28wu6V>
X-ME-Proxy-Cause: dmFkZTF2N13PrNcUdc0ax+FmMwR3MrvJ1Z783tLJq1TTJwayU4m2zPaC3mood0o+cajJiV
    4N/8EdIs120kzKjML1igXoZp3AOjwQlBtatqgyTD6mvcSM0061UVG2Ok2OWbPM5YaPyEPO
    WwGiJSczaPiTmRdXXmM4vKhlViFD6CvQZUhkZl6YdhIV2KylIe0mG4hrbUX01UYbb/7iTU
    cUE3N878aMBRlfrH6zrUUyBNfQ7bkfilaV6SmkhCAmwledfR1vgUEHv88kHSZ8/bjI1ADO
    oDhMqhPG6noJz11/SG+m8E8SrETs6RUNHVVLHS4O+alhtNflr9npAP0RxOFckx/HP1QaNs
    QAOn5oVFGIPFzIITDMaWTZFPVQVDr0po6M3OdbY56iIGlog3aUBtk+gmkAUxPyTjDk5hwY
    u90A+d2nJzfO3CTkGhPWlhpeEshFH2VMvAbn/tuAcrxWTyvGwDK8rpb7h+h/pAWivnsVL0
    LR7eHU0Dfljo0fhl/mVWAxdMHgrWAMx/fTHzx2VBiroshyVWSFgWu4tAmhRZt+AVARNtTH
    YeTSwhNkUYzvmjVQSrAjiNo09qTlmMaBAt5aEmNLdpUYUUXp9pfekzFeROc6f+3IlwSDu2
    119j+5aAGKdFeIQCSSH3iApovf85/Zz9QNYKBa+VDXJCV15FLvgNCLBA8NRg
X-ME-Proxy: <xmx:UzDiar9XGEtPP1BpoH2sUGQ13NnFxj_4julE6A74hfwqNbxj-RdcKA>
    <xmx:UzDiarjK-6VbmG5whomwfVGSo7r3syscCgzHptnN3Bs6Ezp1aTZuIQ>
    <xmx:UzDiaiEARKgxV2XSEOnnog1-PxWOde_tYLQ1DJ9MaR49EIC0d9PVNA>
    <xmx:UzDiaq8PWO2LX2n1brIihXyX8BvG5Y3GiaBmPtMadKKBqz9GVJQaHw>
    <xmx:VDDiapEIlPi98giR6SWiJUCtPPQNKGmxG57DZUMRu66v7qpuHcJVsKNQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 13:26:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Tuomas
 Ahola <taahol@utu.fi>,  Richard Kerry <richard.kerry@atos.ai>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <4b40588c90c82549c9774f14cfeb4e4741b66386.1793198687.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 28 Oct 2026 14:44:47
	+0000")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
	<4b40588c90c82549c9774f14cfeb4e4741b66386.1793198687.git.gitgitgadget@gmail.com>
Date: Wed, 28 Oct 2026 10:26:42 -0700
Message-ID: <xmqqpkwtag8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Introduce Git in two parts:
>
> Steps 1-7: Create an empty repo & make 2 commits (`git init`,
> `git add`, `git commit`, `git status`, `git diff`)
> Steps 8-12: Push the repo to a remote host like GitHub or GitLab
> (`git remote add`, `git push`)
>
> Some design choices:
>
> - Only use commands present in 2.23.0 (when `git switch` as introduced),
>   to support older versions of Git.
> - Introduce a much smaller set of commands than the old tutorial, to
>   keep the tutorial quick (doable in an hour). Some users found it to be
>   very fast and some wanted to stop early (after step 7) so this seems
>   to be a good balance.
> - Have users start with an empty repository instead of an existing
>   project, because many of the testers did not have an existing project
>   to test, or were scared of using an existing project.
> - Add a troubleshooting section, since in the testing some users got
>   extremely stuck (for 4+ hours) on minor issues like needing to say
>   "yes" when SSHing to a new host.
> - Don't explain branches, because explaining branches and collaboration
>   is complicated and deserves its own tutorial. Instead just tell users
>   we're not going to explain them in this document.
> - Tell users to set their default branch to `main`, because many Git
>   hosts use it as their default branch and it really simplifies things.
> - Keep it as vendor neutral as possible, while acknowledging the reality
>   that Git hosting services like GitHub, GitLab, etc are extremely
>   popular. Do this by creating the repo locally and then optionally
>   pushing it later.
> - Use SSH for authentication, explaining how to set up SSH in the
>   easiest way possible (with disclaimers to check your security team's
>   policy if applicable since the "easiest way" may not be the best), and
>   giving some instructions for how to translate an HTTPS URL to an SSH
>   URL.
> - Use Git Credential Manager for authentication on Windows, since it's
>   simpler, SSH auth is a very "unixy" thing to do,  and it comes with
>   Git for Windows

What does "it" in "and it comes with" refer to?  It is unclear
between GCM or SSH and since SSH appeared later, it tempts readers
to think that it says "and SSH comes with GfW".  But the early part
of the same sentence says SSH is "unixy", which probably was used as
a synonym to "non-Windowsy", implying that we do not want to
recommend it.  It gives a conflicting and confused message.

  - Use GCM for authentication on Windows, since it comes with GfW,
    and is simpler than SSH authentication.

> +Step 10 (Mac/Linux only): Create an SSH key if needed
> +-----------------------------------------------------
> +For Git to upload changes to another Git repository, it needs a way to
> +login to that repository. One of the most popular ways to do this is
> +with an SSH key.
> +
> +On Windows, you can skip this step and the next one because Git for
> +Windows comes with
> +https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager]
> +to handle logging in. 

This is the only mention of GCM.  As described in step 14 (push),
GCM will kick in when needed.  It is great that Windows users do not
need any handholding beyond this line ;-)
