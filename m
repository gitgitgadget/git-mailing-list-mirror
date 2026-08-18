Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3841685C
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055196; cv=pass; b=tL4FeVgXzoCe8jiwi2xueioFwnkU6lF6j9v1F9W4hjPVBIAwCyi9VnQ7+7mLspS2L0GuTUgL6vTQ620ZHgSvfLLk5/ZRE+DkD7fRj4M3qXcfwFfIPaAXpMlBmB2zxO7TDznJF5SJ3z2/OtVREJMH6cMCKXmt2O9kKhLqqG/U0nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055196; c=relaxed/simple;
	bh=qVY/Icznbo5Hmg+U0YjWDpZrnG2rUscGQkopu1esGZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9/w6OGFVxiYtrWES9fUkZWmtuy16uiRdhLW8aFSF/wgV2WMwVzeOjaer+gV+TIk6p4PXb1bPSyeUHzLLH2zOzsaMlznBfRxZgHkEwXitR8fayBgPKTFBhnEgkzpeQu7qv1yi5Skvd+x4uNPawrpug0QMcDS8WhTQDGox3X1Ew0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXv2C7pP; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXv2C7pP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84874b52eabso6038411b3a.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 05:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787055195; cv=none;
        d=google.com; s=arc-20260327;
        b=SzILI5WDOdMAEfs9rUWwZzNNT7JH/8VU7l2H8anet0Xwqt3C7ebCPyOa3XuRfde1sg
         IXwwuUoBU0p4m0V2XK9vVz5xNHePGZJRzpDAt0sU3KhD99awjRU24k12gh7C1nWoqJyC
         iWXbF7LbxuMJBck76LsIN8nc5mkCdsFBFRatbFM81SaEzP7Gvj/cXEtP9OLRjvZbFxMe
         zPwvTjDqZnhtWNN1HnaWhjDZzvqtIi4WObA6BO7YslTnjEk6NWvnBi1jDktribAe8uW4
         1vEY0RtPHRfaL7zVP0i8N9ukzo/Uj/JkqTigNDDMQOzKsptggbKCivpb1G8MuT1wrXa9
         yK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKWqO7D5l+aiPI2hmgJGbYKctAHV2WqxDPmn2hgZKmo=;
        fh=DAUdOA0dQaXL4Mp2uUr7TUS//7tH8Sdbj3aEQ5r9sT8=;
        b=KiMSAG+AKIOXwMKcr4KEmrK13+bYio6c3FQ/7uO/c8DsbPAeehDFOHZj7+TwgEjK0q
         ZD4jGRd2O6qpdhHPtQDArSE02jjGfKT/qr5E5JGGVPomjrz6feS/EziZ6bbzTLKjmKmJ
         dIsDommZkMKevnxMp/a9O3ik/KlrVNHC5ktM1S8xn2AnqQS9W8Jv23JDA9lMOgMZtAgu
         3c9QLKZO4GLAG6x0nbe03RGFkh37I+/DiJEcVrars+ZNYFM3znH7ryUlW4Y/J/VlYCZR
         L9gQmYliT/tjpNvplzGz3SqtgXweWLHjRZB99haczxYmp/6MqacrG3XbQOhI6tREfd9L
         WZgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787055195; x=1787659995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKWqO7D5l+aiPI2hmgJGbYKctAHV2WqxDPmn2hgZKmo=;
        b=LXv2C7pPOARFB2fWpA4uELEtTRoQC7d5lAuHrW/ad9/OWkcAUztDXqHdN3xh4WTWSS
         fjg+EJb7tdtdJbesJn+G2QHpQc7gu7FbZVmhSWUyJMGNaAQMfzpRD7TBr2iLSkvUguax
         A8aNN/H78hkEcsUrANuIAxHbSyXBZZngxqZANCpw6izuAUBWwEtT7kjnt8Wy+wSi6Z8a
         crpWWtPgqkmSZr564RIJhEs9Ni0BaWI4tSdb7QQxH1P2lN/mogku1dYru6yb6uwVT+tK
         t0KsxUFgDsRwp33rxzo+n0XIwar8tCFrr/lSkOXs4q/Pq1vI6OouN2tUZIDfP5W0533U
         rSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055195; x=1787659995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKWqO7D5l+aiPI2hmgJGbYKctAHV2WqxDPmn2hgZKmo=;
        b=HW9FrSzfviYBOEKniyHgBh1TqBAZijq7JCGJ3hY3NuZ0J95QcaGDQAjIZxtuDvOzmN
         KWwj7l4j5yd2Vc+1POB9i8ZsrWr6P9MnLztr5ki1IIPNoT0avDCLVFGaFHcH08UGK/wt
         RJl0NT1aaGPvTrSYxPaHgqD1Jm8m6bbrbssM3BXmvn+n9dq772FCOj8Gg9ancxE/3F7T
         xNT60xhMcFDDaOu9Dc1/D79EGMha6iMT8MmCP2i8nC9fMG9O3xo+WKQTa+crZx1EMSg1
         g0ZpkSZSt2tQGMFRu4chQ6ggTTMiGAwxJ8zR89cn1vQfSEaXz9ISaruZw9qXxHyb59rG
         FApQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeFr1fb1h86DOdjdTMkeqI9yT2dXbDZABYiYZ6aCmXlJouiIboB7Mct68MsAAeJoSEK0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ir65ISBZIJH6tCYqjqJn6CEEKYg8sJum7TRXycMv7bsZ+vGc
	HFdlQL/8kx14celijiYzVofoKp6cpAoiGxNGMJHQ3lpbu/2Uzw+fhBD927910pEx76xTn6MWMsC
	Eues54gzD5bBa44G8kHCyJmi8ycqJhJw=
X-Gm-Gg: AR+sD1159Tn/IPs4f+GEyN77OYSIXijypZKMvdQgZpmtgm0HeRwJdD+SaGmGtThwxaT
	vZSgqSaPOubkwtIgbb4WKepVuHbpyR2FR34uFSsTZHhmUj7oQLY75G3J+BqelsT8UPlWEZHX1Y9
	Z+UrL1/yhp9wfQQ+ylEmtZaJExxn2G70rJpik/3EAtlMB8HI01t04ZnmFAR19p7YHmYfPRd3o98
	1ikSMkUhFBAHu+elXcW6IgXkyN0/fk+wY/DyiFYxSgtYVAg2wXc4G7SFOLa+3+V9JRGYAavXdf+
	96ifEBGoX2lkXqSkpX94HDpgW+rtuDvyRSU/fjHFQayuIHYeGEhrM855Mof7VcwSVtaMljjRuMr
	zsWqI+4DBZHeKaHRg/HEJk5A7Q2Ug+DJ8nX21oUpfyh0fBYUzDGSH/o3wHz1smauGhT2L8HbQNF
	usXPselUOQpcXpSvLLS4A=
X-Received: by 2002:a05:6a00:2392:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84fddf92abamr33959745b3a.4.1787055194638; Tue, 18 Aug 2026
 05:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
 <CALnO6CD9P4+e=YPdKaLfSBOk-H3_ir64pBP-qMKNNvzUNqunXQ@mail.gmail.com>
 <CALnO6CB1vJ7RtBzTUSJSfYtfH+W2MZCFEkqNWeBXbWJ2r3Pdyg@mail.gmail.com> <a6a9fe7c-e46d-462f-b3b0-7ae6c2d52fe4@app.fastmail.com>
In-Reply-To: <a6a9fe7c-e46d-462f-b3b0-7ae6c2d52fe4@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 18 Aug 2026 08:13:03 -0400
X-Gm-Features: AcwNN1VWZkvN3GxmAbz2YkpO04_55FUjb8nnW47GQ33gJQC80Iwnf32LaL1V8cM
Message-ID: <CALnO6CCWADaQycF7XcCFLDgCVtkTAsndKykAWzNhPqVAKWYGzA@mail.gmail.com>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
To: Lutz Lengemann <lutz@lengemann.net>
Cc: Lutz Lengemann <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:29=E2=80=AFPM Lutz Lengemann <lutz@lengemann.net>=
 wrote:
>
> Hi Ben
>
> (Resending, my earlier reply was rejected by the list for being HTML.)
>
> On Wed, Jul 15, 2026, at 00:34, D. Ben Knoble wrote:
> > Any progress here? I just found my local copy of this patch and was
> > briefly surprised to see it hadn't graduated anywhere (until I
> > realized conversation had stalled at this point).
>
> Sorry for the very late reply, I was on holiday and then other life
> things got in the way of answering :(  I do have a v2 ready, which I
> have just pushed to my fork, and which follows this message.

No worries! Hope you enjoyed. (I didn't see v2 come in anywhere, but
I'll keep my eye out.)

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Doesn't it want to do something similar to what __git_main in
> > git-completion.bash does at the beginning, namely, this part?
>
> It does, thanks.  v2 no longer skips only leading -C options, but walks
> the words in front of the command and skips over the global options and,
> where they take one, their arguments, like __git_main does.
>
> That also makes "git -p checkout <TAB>" and "git --git-dir=3D<path>
> checkout <TAB>" complete the arguments of the command, which they did
> not before.

Nice side-effect :)

> Two related gaps are left alone, as they are bugs in the _arguments
> specification rather than in the command lookup: -c is not listed there
> at all,

[no comment]

> and --git-dir and friends are spelled "--git-dir=3D-", which
> accepts only "--git-dir=3D<path>", not the "--git-dir <path>" form.  I ca=
n
> send patches for those separately.

We were discussing this recently in some threads about Bash
completion, and I think we landed on "gitcli(1) really prefers the
stuck form, and so do completion helpers, so let's stick with that for
now" ?

>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > But we mark these local, so how do they propagate to the other
> > functions?
>
> zsh scoping is dynamic, not lexical, so a variable declared "local" in
> __git_zsh_main is visible in the functions that are called from it, the
> bash helpers included.  That is how __git_dir and __git_cmd_idx are
> handed down already, and __git_C_args works the same way.

Thanks. I must have known that, but it's remarkably difficult to find
spelled out in the manual. The closest I can find is the "LOCAL
PARAMETERS" section of zshparam(1), which could really use an example
to demonstrate that local is still dynamic.

> > We should probably note in the log message that the _directories
> > completion will not account for previous -C
>
> I added a note about this in the log message.

Great

> > I think we could do _slightly_ better by using a state "->dir" or
> > something, accumulating the current prefix, and passing that to
> > _directories as a prefix with -W
>
> I tried that and it works, but it changes what -C offers, which is more
> than fixing the completion after -C, so I left it out; happy to send it
> on top.  Two things to watch out for there: the accumulated path has to
> be made absolute, as -W with ".." gave me the directories of "/", and
> the accumulation has to stop before the word that is being completed.

A follow-up is fine with me if you decide to send it (and if not,
that's fine, too).

> > By the way, I've realized that "git -<tab>" has the same problem (a
> > giant list of files after the other option completions)
>
> That one is older than this patch: the file listing comes from the
> fallback at the end of _git,
>
>         let _ret && _default && _ret=3D0
>
> which is where the "use-compctl" and "globbed-files" tags in your
> _complete_help dump come from.

Thanks for explaining!

> I could not reproduce the repeated
> description block with "zsh -f" and only the _complete completer, so
> something in my setup or yours may differ there.  Either way it wants
> its own topic.

Yes, I agree that can be its own topic. I've been re-studying the
completion system again recently, so maybe I'll be better equipped to
debug my setup later=E2=80=A6 I do play with the tag-order style for Git
completions, so I wonder if that's interfering.

Thanks!

--=20
D. Ben Knoble
