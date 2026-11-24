Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540586;
	b=OJX7ojXwYjW17oDG8wj31TzeaaNKW29r5mmHzXprNmeR870viTXkUy+NoowTTXcRBxx8
	 hGn2KTQo0y3x2mXjndi4Buq0U2oxGZ1Gc9AuWl2jGbMZPLwGePIFjhGPCQ5JJPtVEmj1l
	 mjhg/pxtXasilaC0AUKDG03T6IMIoODs+7cupgRi5e+wNJgzY7/59dnkGblEPiTHR3e3s
	 SfBd1v/qV4uhMP6aY57iq4nUZmw/poSMQ6l8rLmr0jwLEQQztBHJPJcNNkv1B06/xSYwj
	 4j/odQIXihbX8nXH44ocDoN2/KcECmBFh2vfPpkUANGJcvowzEuVe/vUsSDGmJ6vhfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540586;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=xptx+72BhLRFn1Dm+ttumQpHJSgl2UKuwhFMDfCNTT8=;
	b=tmLCgod49CIiL+bGeN2BnfjGF5m5xQPIUGSijQj0zsICi8N6SFV00puqOL7Zle8BvLwd
	 2Jy54pN6/jZ9vnAnHABVHT/xk+d4EIRPtJL38yS9UF2lFZFR4l3weXb8gjKuptZkuMlgH
	 ozpdWp7HqNSSL6V2Orf3n2nKYn5Hx1yS1BrLbA3pLlyZvmnpLskaVEPvIATBhOQtA5+mG
	 V4adCE6DUxLdjcncpIfZkbMl2rVKfAr0VQbndMoJm6+aw+u6JIoq21jt0h+rCfHCPQW9L
	 0k17BfD6B/1EM1HbtauXt+dMVQZ5DZe+tWFk7RSbuhrAsqarGhXzxvkIcv0FKmG3zMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VcADrOwP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LxfUdcQg;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57A606A326
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F57A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VcADrOwP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LxfUdcQg
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A7B91EC0B0B
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 12:16:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 12:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795540584; x=1795626984; bh=xptx+72BhL
	RFn1Dm+ttumQpHJSgl2UKuwhFMDfCNTT8=; b=VcADrOwP8aBTTBkaU+HZFoSKNX
	LBNPbGemoDiOVvZi1+15f2cfSw5chv/lX752KJmifWpkErX5r0WHk2dhuFydV9Jb
	BHUAoJM23NtiZw0B2Vsi1zXPZZC/cRsUXUpTS6n+g2h+b01ZfDI2sFAy8u3ePtwg
	EFSSh8v0IYT9omLK4QKQZwwWB8EJeLuyOmEHPaXyMKO6WzPivhhcGJ8mhbfWVJzY
	kmqbxtXueSkCrdmIanKIBktF15TMoiqLc6okMwPeIAYjggUlxyTRFHuGDARsvvMd
	OQONwfq4jdkU7XRgq6/RZBMwHlPnNEDGexq+758mkhbCr1XUC5cZ7x7ywSFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795540584; x=1795626984; bh=xptx+72BhLRFn1Dm+ttumQpHJSgl2UKuwhF
	MDfCNTT8=; b=LxfUdcQgtZFFoFMAwSqpUrQAN41Oz6Khr8DR8BUisb4cdkeO56F
	5Jig280VO7YoVlkioPNaw7g47OUs/ySfjk1zFm/f6G6pQAGLY5n/HGg9cJQGrJpB
	wIIBnMmqvrhP+77Q1W0QzTKi8z8jqDySL4fDoDRsiqJMqd/YBu9iBK29CgoJDvjs
	EB2ScnpRWQuVzfUgGRgvqvet1w5+Bg967+I7gQWjJmTkp/6CEPK/htKOOknhwZs8
	xsk/uI0l/8kQP4B9dj+Y0NTaivRbC6hgxyWjUfNcb4FaGFG5zwMhPC0ZwUpujiaa
	iX8fDDO8bsvtA0x/HcWJhg23AYxSwh/86Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795540584; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xa8dXyj4Zx/EtDsDbIdHz784Imdp6LB5xVHA9Afr2Xb4f/n
	MiKRC9yyDVx4qpEiXjGD9RrJzZwuVIDK/w/w7Z/FAO4cFImGh/cr13WgvTJ5sAEj
	4aQdzCxIFEfJgfYmhJAdlf5upJ/tcNx0pWQrpV1+URgX2RusW8XQGtW4jDrtGXIm
	MJaIKWyujcoMSxLTMcXyuGQ+xkgYp9RWfiErE1NEOEy3gMIo1pp91t0wr8nGWQO1
	POF+AVhmvVvI0jPYKh5Y14ecx9+lEmnH9PtiysmxFDdP1i3nrVKzRfwcpjOFHcry
	JY/jy8gN5RxoV0SilYMUpLDra2hb5ANffqkrkyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JHz01wtPZNCoFQZao7W9vbgOdE0vGP3khw4hdcgMIpI=:92I8lizAQy4+/iWzoiMcZdiLOEWdB+jInV9W0QrlwDw=;
X-ME-Sender: <xms:aMYFawULO_L7U6xV2TjjgKEtwdUfDDv8SLwjsYeJcPpBOEYN1WHcAA>
    <xme:aMYFa4RwF6UK2YaCZlGYJVmGSH24uc0l1ebciz_oflYRBxJwWa3VjGKsV56UBYy5S
    SjJvxubRj3vwWLCpL5E8PpNU5QiuvHkjsIM-fl-912JRovNce8yjUI>
X-ME-Received: <xmr:aMYFa-PahNT6brTbeiCpNZjfGTd2L9-Of0DJLvuR8Cs9z68Fr03tVqG5efqS4vHOF1ip5tIKDQoF8-uaZcfprMWsivhSBszFMHHqMfA>
X-ME-Proxy-Cause: dmFkZTF9/vtkAWR0dDTfATw71koYMSnlf/87EXuM45ef8JJpTLN3WX2SybHxaTdtgKUgfY
    l8NWVbiWuIEFY76N49lWtrKZrSi2LfvHhLYv9o212CxgEGzOSVvihTBgmRMbyWSDEDL5lC
    2roDYtOmSfJMDRO5IP8WaMJ1QpQokplY+aYUbTKieaDXZVfehm4eVojJzYAv5hKELyiFob
    vjL1TekfqMXEyWUtJgZEQfYSN/YWB86POsj/uax1J0RbNH9ql0mLAa3LLTeEdg9n0ih2KT
    so0ygN+XiQd5/BRQYV90OaG4kAvuiMxpLVuoViFJI+FxfNIarM3v4x535iq8FDOTQ+bMSf
    BBgNcQJhUgdjA8U5lJgahVTwwxbNUZ+ebtyff3jmDjMm/Eb4NrtJ9sR6BDPfhiURurSrCD
    OX4T5ONL0U61qVReY2uT+C5zicwrGadmrMYI70v3t1cr2cdbYG1WnrZp+PNPUaEYME2+e5
    V3gdkPX2+ilK7DWYI29wPF9T4HmOPuv316YhA7LH0BiGjHdrnaQGWOnoFXGmlVFscsqpXp
    ETXOtw1G9HTtbCHQ6O+T96TQPgVv49cpLK0dVCIAlg/jNmBFsxodUIzdjfitsI2Hj3cHqH
    ZlbLPkz7FXeEUIWiSesoKbUzo+BKGhrfdpkS2qTi9p2us+pAn3wf9I0GftUw
X-ME-Proxy: <xmx:aMYFa2SUamDxCbI6GAKF7sEwedd-xMYMQ3KmF3za6RD_B52BO2GVVA>
    <xmx:aMYFa8jVWLlcSYrlsEQYd-FZc5ntZNULJzSeanirdhmXc2tdZe4bBA>
    <xmx:aMYFa__UdM4c5NBKK0kUJnsE5x0DY117jI7hjXg1-w6xy_flZ6IT0w>
    <xmx:aMYFazFBOGpVOspB9l_atUNGP-os5kjyDk_cCVcf_DCaAbLA8-1m3w>
    <xmx:aMYFa-6DlEIly2KHgpvVHk355qFFVZnk-sb-4oac-gy_kMntJRGd_Ux7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 12:16:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
In-Reply-To: <pull.2307.git.1794259990263.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 09 Nov 2026 21:33:10 +0000")
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 09:16:22 -0800
Message-ID: <xmqqa4myup3t.fsf@gitster.g>
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
> ...
> +Next, edit README.md and make another commit, like this:
> +
> +----
> +git commit -am "Update README.md"
> +----
> +
> +`git commit -am` commits the current version of all files that Git is
> +tracking.
> +
> +Now we're set up and we can start creating branches.
> +
> +Step 2: Find your current branch
> +--------------------------------
> +
> +In Git, you normally have a "current branch". You can see your current
> +branch by running `git status`. It's usually on the first line, like this:
> +
> +----
> +$ git status
> +
> +On branch main
> +----

After reading through the steps, the abrupt appearance of the "$" prompt
feels a bit disorienting.  You have a good reason to use a prompt here,
to make it possible to tell what you type and what the commands tell you
apart.  Wouldn't it be better to use the prompt consistently, e.g.,
making the last example of the previous step

----
$ git commit -a -m "Update README.md"
----

instead?

	Side note.  Yesterday I learned while reviewing an unrelated
	patch that we encourage users not to squish short options
	together into a single word, so I split your "-am <msg>" in the
	above rewrite of the example.

There are a handful of other places where you add the "$" prompt in a
block that has both input and output, and many blocks that lack the "$"
prompt.  The mixture looks rather messy.

> +Example: Emilia the PhD student
> +-------------------------------
> +
> +Emilia is writing her PhD thesis. She follows the steps from
> +linkgit:gittutorial[7] to set up a Git repository on the Internet so
> +that she can back up her work.
> +
> +To back up her work after making a commit, she runs:
> +
> +----
> +git push origin main
> +----
> +
> +Sometimes, she creates a branch to make an experimental change she's not
> +sure that she's going to keep, like `rewrite-chapter-5`.
> +
> +She does this by running:
> +
> +----
> +git switch -c rewrite-chapter-5
> +----

Would it help to explicitly mention that after running 'switch -c'
to create the branch, Emilia actually does some work on it before
the "If she decides to keep/If she decides to discard" paragraphs?

> +
> +If she decides that the experimental change should be merged, she merges
> +it into `main` like this:
> +
> +----
> +git switch main
> +git merge rewrite-chapter-5
> +----
> +
> +Or if she decides the rewrite of chapter 5 was a bad idea, she can
> +delete the branch:
> +
> +----
> +git branch -D rewrite-chapter-5
> +----

This is slightly misleading after saying "Or if she decides", which
implies that the previous one did not happen.  If she did not switch
to 'main' and merge, she would still be on the rewrite-chapter-5
branch, and the "branch -D", even with a capital "-D", would fail.

Perhaps make the example switch back to 'main' before discarding the
branch?

> +Example: Daniela and Carmen with the cat shelter website
> +--------------------------------------------------------
> +
> +Daniela and Carmen create a Git repository for their cat shelter website.

A very minor thing, but wouldn't breaking the alphabetical order of
appearance of the characters be a bit jarring to readers?  Does this
example need to be about Daniela and Carmen, not Carmen and Daniela?

> +They both clone it onto their computer like this:
> +
> +----
> +git clone git@example.com:cat-shelter/kitties.git
> +----
> +
> +They decide to work together by just pushing all of their commits to the
> +`main` branch, without using any other branches.
> +
> +When Daniela wants to do work, she first runs `git pull` on the main
> +branch, like this:
> +
> +----
> +git pull
> +----
> +
> +She also checks in with Carmen to make sure they won't be working on
> +the same files. Then she works on her changes. Then, before pushing her
> +changes, she runs this command to merge any changes Carmen has made.

Wouldn't it be helpful to be more explicit that before running this
command (git pull), she commits all her work?  We assume that "pull"
somehow finishes cleanly, so ...

> +----
> +git pull --no-rebase
> +----
> +
> +We don't have space for a full introduction to linkgit:git-pull[1]
> +here, but `git pull` fetches Carmen's changes and merges them into the
> +current branch. The `--no-rebase` flag tells Git to use `git merge` to
> +do the merge.
> +
> +Then she pushes her changes with:
> +
> +----
> +git push
> +----

... there is no extra need for "git commit" before the "git push" that
comes after the "git pull --no-rebase".

Thanks.
