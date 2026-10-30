Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392525;
	b=I/Vvq2ObzJnN6WTQfwrIDhwZ56G3cN+R9hzOLLBT0SSH8pc5R6G1ViHRuICD3Q+gKeMx
	 sIQMbnk3V2i2LQr3S9l4wFrAm0YALoLFOXjZ8s/iY0X0mwCZpzQ5vQO9lMH1b4oGQfhyn
	 QJv0pfdfeCsoh+MGdUbC4vh6WPSUNrGAyBoCZOBFfna/wKU785kGCFtNhOJVqmyR74TOA
	 9/Os/tVjiN1LcVQwcgQYkTSWsFxsJE3iKyZKjFpzilhRj5deDP2nX2bLx1i3jkxFqtFYs
	 5QCwNp4ZeKZPG+xAOnQ3BxFvKJOZbxgMiUsfILu6RCCLXskijkTB6EJoocc/CQjcOJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392525;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=1b0kd7b2WDIUmPf2/iF45ABdDPC+pfSvv6ed02F1vdw=;
	b=jeTslkqE/jKS7CBpIcsk8neCXBiGwElv6v3l/JOFyeMdJL6zPcG0XFBF1fRf+eWLZCuF
	 YHf87/nlM8PSIx+3JpJMETANp8v8rlCwSpVFenYeceKtFBq/XKU570mU3QP2c5jYsYSaq
	 03UU6sk2nFInqQnizsEtSvhT1LiUMcUkBw6V4n8FgN1yHKysIMr0uKXYL37VdCTw92ZNs
	 PWZVldfl0oX4YZuPhsAH1CEYyYb5grsGUageBzdeigDQujcfnu9eYBgZxG1Pt6RsIrFz+
	 RLihe+hZ/BrjuOdTGIsjUBv5cmbN2UckSmhwABURfu+bNV9BaEt1K1IwZLzZrwasutg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=H2+TyX9r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u7tnZdH2;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1ED606A327
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 20:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E1ED606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=H2+TyX9r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u7tnZdH2
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B1AB1D0015C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:35:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 16:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793392522;
	 x=1793478922; bh=1b0kd7b2WDIUmPf2/iF45ABdDPC+pfSvv6ed02F1vdw=; b=
	H2+TyX9rJWaG9IlqOSQjICPYWP5AVCaF8680eJplRYUnqcexTrkogo3JGEhWVf9P
	zNsBnNIkA6DEJRlWYL94RVqfYfYREcYlGYnQSaA3eM0mqec58pwlqajZ8C7N5tlp
	JpSH9vr/TBDTN5ok/NOmI/SJHokDNJcjjH/Fzcv+DkrNsiiX+1eQyB9pKdySjYT5
	3gAHr4yI63suU5UPhKLSyUZHxYKZOPOGkLY4OnieHnfIPBWM47NnSJhLkaM+H3oH
	v8Tl4Ov13+ywVhMFqzBTk2a+cMm3S00lmRC2Zi0iNVdRfDJ9R8M8x/yWYw1/OO8i
	1nIZ1gAU3Z7rk2ZYOFA3Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793392522; x=
	1793478922; bh=1b0kd7b2WDIUmPf2/iF45ABdDPC+pfSvv6ed02F1vdw=; b=u
	7tnZdH2yvd00ItJWrgmnJU9KiomA9zP5sn3ZnX1CLdwedM3Y23as51vR6kcuBowO
	wVfCk1DuPFeTmCt/VDWPfvRurQCHsczepnNoCy1XxosqGEAYbNv8SceC4rKMAY+y
	7hfnGvPu8ZK66ugZ9ry4NaoDSk8PJZyURqAjuhTwEAJ4pyJWEcpLSc0mj6VLtm1F
	91EHcGg1oaeC0a2eWhjkzzQdm+DZ0EBmvgJFMEv7GrXLL3VPURKloughPAO/voIY
	f7nK+NzwU5VlzrEztOE1Oowqc7UlVyR4mY7CmzGw2aBzDUIK2772b7dynyMnfAks
	bW+QF39Xj5EO57Evyhd7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793392522; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IT54wdG2y8JKClOy8sv77RPb6nLLBORTcaUmcxSnCgZO4Oc
	bVO7HpnR4t0lOhMMtr98bAbgUSI9UD395fBwC9BygC45vJ+JQN9IWM53HbavpEV8
	5kyIT3mAT1byn0miCuSC3ZmC6cpA3ii4+Liqi/+H5ZZW4Yvi1b4Dnr+sqga16L5i
	hwetoSaQIJeFo9szcjOMU60K1dkQOQPpt+YSt3ZZd7c48SDoY/Aqg+DV+3lrPcTd
	uJVtBkLdLQ0RzsFA+iM49DALhdUet9CoJMZVioIgG6Z8QebuBA+G30xr3gMF5jnw
	HQC052uLpX3VQqKAb1/SE907ET0v5Wu6t9oFfPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7v41qRa0pecuazv8K8jmGPkRV/ctSIKoDowcmY0g9rQ=:C11Z25kek+lZnlrqMrEKAopN0+X3Aj1XabO12jjJo5s=;
X-ME-Sender: <xms:if_kai4wXnnEAzMZoTblIY4jut0g6Fyl9f4COUQPznmsTdx7MX4SMA>
    <xme:if_kamurWnbmXs6-ruyxcLitJy0cSBoTwp-bRgA3oknOcX6mUuqiL7a9k0WmtXpD3
    ySWUbloypGnpqTi_qIA9O9QuGlHcPXqns78t5bbMQNAiIzIfb56kuuo>
X-ME-Proxy-Cause: dmFkZTEWlc/H+L+LAjPUwmtMkmVVob+tpn2HCCEO/7d4yDUOEt8LECrJtbik8sDEi00FiC
    OEImduscir244xPdowJPL5RcrP5ttNcBo/PCiF31QcMePZ6UpnO6eRyPRt70E417HL2Pfi
    h31YF4ZXPZQoKI+IiZQ05DzlQdwz39AYt72albvTe9dTh5heqReOJzeFDcrSXHrDms7XBB
    ORU7k0D7uXMOhnBY8iwHVJ641mwD/LngQb0bJ1v7mAq6Ht73dS18x0KCKQor6PYLaaWN5n
    j0tn4TZwo5wCkYvd7nZLB8CGMBpa3/qhEQ65iUwh8DnBFosgDlTnMkmg6UIhlDn6Q9jSgX
    rPWOLjims/qDPYzWrfQqBvAhJOOcrJugzBuJQkfUgMpHD6tVGWd+FsokM16p3aOcxZOXgT
    An8qwn9RpmMMniAaFMgyicOIUx6RmBHOu95noZwzVLxCwNHIadUnPfY/znsnHs6U93pldw
    eIYGvxWbMBEnvaDZXXWReGaAbRZiI2H52eXXrhUAMJhEogA7JobH/9vYTp0QR1uOeVwF2D
    6Q88yWMdnRiDVtpdfbcmpxicivGvP/dFi0edk4XL58cNyB0qrh1cGuyAg0peowpzW9MSaV
    9w1feqfhpL1sXMfvYmG0UhttNEiJzpsb0GbdyrU4upzMnsxVzuGhmWujZA1w
X-ME-Proxy: <xmx:if_kaqn7KuRkA2c1dVWb3llLQ0mziYKLJ0UihYx46w5cjdECeR2rQA>
    <xmx:if_karJsIDabySyD6OvLgWdw0NkaGGP2n9ySKnN6MqPUim54GkCPog>
    <xmx:if_kav4CBCQDWqk7YLtuliPfsP97GA_0xJrTMkDmufBpev5I5Mzzmg>
    <xmx:if_kav2YvYVvIvizZFmPji93EwTXKoPxH7Rg4D1Xt1UWVSl7lksHMg>
    <xmx:iv_kaggPffoZICSmVORb4CB0ofGaKYGPBVUUao8sqN5GWodxokZ-9cSA>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1A7F782738; Fri, 30 Oct 2026 16:35:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ApuIcoGem8Go
Date: Fri, 30 Oct 2026 16:35:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Tuomas Ahola" <taahol@utu.fi>, "Richard Kerry" <richard.kerry@atos.ai>
Message-Id: <13af97a1-a86c-4077-9136-204c74f3d625@app.fastmail.com>
In-Reply-To: <xmqqpkwtag8d.fsf@gitster.g>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
 <4b40588c90c82549c9774f14cfeb4e4741b66386.1793198687.git.gitgitgadget@gmail.com>
 <xmqqpkwtag8d.fsf@gitster.g>
Subject: Re: [PATCH v4 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 28, 2026, at 1:26 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julia Evans <julia@jvns.ca>
>>
>> Introduce Git in two parts:
>>
>> Steps 1-7: Create an empty repo & make 2 commits (`git init`,
>> `git add`, `git commit`, `git status`, `git diff`)
>> Steps 8-12: Push the repo to a remote host like GitHub or GitLab
>> (`git remote add`, `git push`)
>>
>> Some design choices:
>>
>> - Only use commands present in 2.23.0 (when `git switch` as introduced),
>>   to support older versions of Git.
>> - Introduce a much smaller set of commands than the old tutorial, to
>>   keep the tutorial quick (doable in an hour). Some users found it to be
>>   very fast and some wanted to stop early (after step 7) so this seems
>>   to be a good balance.
>> - Have users start with an empty repository instead of an existing
>>   project, because many of the testers did not have an existing project
>>   to test, or were scared of using an existing project.
>> - Add a troubleshooting section, since in the testing some users got
>>   extremely stuck (for 4+ hours) on minor issues like needing to say
>>   "yes" when SSHing to a new host.
>> - Don't explain branches, because explaining branches and collaboration
>>   is complicated and deserves its own tutorial. Instead just tell users
>>   we're not going to explain them in this document.
>> - Tell users to set their default branch to `main`, because many Git
>>   hosts use it as their default branch and it really simplifies things.
>> - Keep it as vendor neutral as possible, while acknowledging the reality
>>   that Git hosting services like GitHub, GitLab, etc are extremely
>>   popular. Do this by creating the repo locally and then optionally
>>   pushing it later.
>> - Use SSH for authentication, explaining how to set up SSH in the
>>   easiest way possible (with disclaimers to check your security team's
>>   policy if applicable since the "easiest way" may not be the best), and
>>   giving some instructions for how to translate an HTTPS URL to an SSH
>>   URL.
>> - Use Git Credential Manager for authentication on Windows, since it's
>>   simpler, SSH auth is a very "unixy" thing to do,  and it comes with
>>   Git for Windows
>
> What does "it" in "and it comes with" refer to?  It is unclear
> between GCM or SSH and since SSH appeared later, it tempts readers
> to think that it says "and SSH comes with GfW".  But the early part
> of the same sentence says SSH is "unixy", which probably was used as
> a synonym to "non-Windowsy", implying that we do not want to
> recommend it.  It gives a conflicting and confused message.

Will replace "it" with "GCM".

>   - Use GCM for authentication on Windows, since it comes with GfW,
>     and is simpler than SSH authentication.
>
>> +Step 10 (Mac/Linux only): Create an SSH key if needed
>> +-----------------------------------------------------
>> +For Git to upload changes to another Git repository, it needs a way to
>> +login to that repository. One of the most popular ways to do this is
>> +with an SSH key.
>> +
>> +On Windows, you can skip this step and the next one because Git for
>> +Windows comes with
>> +https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager]
>> +to handle logging in. 
>
> This is the only mention of GCM.  As described in step 14 (push),
> GCM will kick in when needed.  It is great that Windows users do not
> need any handholding beyond this line ;-)

I hope so! I found a friend with a Windows computer to test this
and it did work as advertised. If there are issues hopefully we'll
hear from folks about it and we can adjust :)
