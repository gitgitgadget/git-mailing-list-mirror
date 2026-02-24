Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364382765C4
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913751; cv=pass; b=NG3y3qrJjZTQMxUTy/74e5wTwDukKhNXbXO/LIWBvYyt0kjKIfy4Y01jT9eoLza8CAr0zO3ar/lqt7pyd6sr1+fec4jzg9a2LzPt/9MHsTvxXe6cAQIvf80ac0zr/VgeSKwpt3T1a1spVprcUiXNSvAASgUbIH2kpvHGVgEDbTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913751; c=relaxed/simple;
	bh=Y7LfwksJIGJM2JIPCXxtNFN+MWM97y+e9GwK4SlYdtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3L0Ho0ZAbOGRYjHmLD1BBuyS+2SmEhPjc1Jq/4BhaupFvjJGyK4kFH5IUFMmxylxhA+Jm1lFrSvcanvfNsEn812jrjtBP4S3BS7O7aq8pnBjv+mFEc2td34j/PPuIAleluq/J/r9SAyadbQTJEZxFQE+GxmsdF80GZTSmX76n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahIu/7ZX; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahIu/7ZX"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a0fb5ef6e9so148494e87.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 22:15:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771913748; cv=none;
        d=google.com; s=arc-20240605;
        b=DAq+3bMbfnUPkm0Z09rS8bSBicbpQNmXZfdefog3A0SCGpsr2ZzBWwT0+Ez9fqZNTI
         Hw4vzOWBXF2dejxvhtg1/0vx9BQCCSSBooiIaGfkG/gLEXFue14kiwEEK8Zi480OxC5D
         DxQ0WGYU5LuJRczEuTOGnSpC+Cjv+0j4qDvlQkMUd16yPQC4GwgwT6doZZuF6woqSgTb
         FrcFc0Ajs2gA03Bg8ZH5jyleJvDAZmPINv5990+w1cBD9+mwGJSP7D4PTPPhgfqKBS1C
         epHBToluUW1gvTAwF2zmAuZfO6EQRYwe3qS6DkgpRYZ2+xDTTnFYjXGdN9rbxsvLENap
         lEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baZqKMTHFynnKoofxhs4/QW00HtGwGURbYoMNwbzyq8=;
        fh=N3tv4emqQWfhZVujWT4kdBfOt/tgS/wIn2V0F476X44=;
        b=R6Bov5YrlnABKWPtOfwQw7I291uWa3fvg3S46G01Vm5Aj5KbZAoZgPgiC8oMqRZnFm
         51AVpMzVwGnQzcXYQJl0ZnTIkw6GGN7g/qymeSPwHMv9vZUYdIqJ1dJUZJuV1U1s4+36
         LcQdSWNpw1JW6Pk03XC1jKugqzCZPpo299ZlswNvn3gDECqa+dTdk02VYLjZCm/Pxb/g
         SSz91bjSnRhMhS/1xlrsmJx1Ztur2ESYUaVZSGEG1iln4dGplJpFKLfET63k0oS8XHMn
         7nXs0VRH6YBIwZz+A3p+Ht/Q/BosSpKD6M8ZvEQfpL4ux1t674EED+mkxUSGUaLaN2iM
         qpyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771913748; x=1772518548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baZqKMTHFynnKoofxhs4/QW00HtGwGURbYoMNwbzyq8=;
        b=ahIu/7ZXtNdsz/h4+dM+kETm6Sq22RWVOTOAet7Mn6dHqM+S4tDg7mdd7MZFmk8z+1
         bSg4Flu3NrHWGNCMawVDsv+xTEre8qJYn6ZV5X84TA7+BNbgZs6My+bUiLWM7y6EV23u
         aTTZi/5jYAro/whtmozllHhOvhE939RDiqAGP7xNVXb0iVIfQqx7WPqHfucGVCS23ppI
         Ygq1VaH8D052CXUrb6UVKIg//HB5QQKw/gI0CLjNgL4eohNxQuODDxKXnBCDY+G8dJZS
         9hFQ56wfaww0f5oGPDcnicL4ijMpl4KZK72NP9+qecE4r4FdGcAWcnVMaX9sBMYJLmiq
         35nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913748; x=1772518548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baZqKMTHFynnKoofxhs4/QW00HtGwGURbYoMNwbzyq8=;
        b=wuoK0HZO1j5bPRMiJAIuOsOlACoofFXsL8PpVRY0IuOuapxTEyF0y+dXdlEq3fOpr7
         CQP8OUo3+PXdromOWhjjsz2n10xHIvM3Th9aONs1qObioJNNCYB8jTnF4BYGd6x3N1u1
         NpQYm3DvQsGhDD7Kh+0aXNF2zu8JzrZScxMVpcmXNJV9a5T2BRQddsYLs+d3vbt/saFk
         23EtKJJ2gv0RYN6uZ+ejrs4XQKT/FzqXC2iE06X4nFk6c5SXGMLtu8HRCV4lrlGKW65e
         mWt4TB6VWoDh2s7x9w9PLKaXZqTTkEF2jzzMEgggIqcp0IVmgaROXlzPC9yfma+REQE9
         QKVA==
X-Forwarded-Encrypted: i=1; AJvYcCVMtVW8XVl0QaW7PYHzmuDe0Zm8MnCqF26w1pv9NF//1FZnUYFZfUAGyytNphV/hvp4ARY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbwkftOM1XNDPJcWTjanJh2AdTqQdtqJlX8Cr1eEpp7NrcVYC
	s2ItoB5BAvkR1lIRNXsGnsVllBWjlkXcC3yyc5VBgEFfxZIIJxt8gqHtsqcZh4LW3Q2yDTLt/jI
	27DVFRpOubsnZ04MwHyGn7YYRgA/nndtRZndPo+A=
X-Gm-Gg: ATEYQzzPWuMlHpl7m+zOIhqsSX6N4XGQtPG8mUvqTjzS4UaGERZPv1NwkBoK7rCxLXs
	asR2sdvAGJwyePJhPMg7oY3pC3gcr4+6rDUFp8GCghJ3VkDSIwl7iRHzb08NypQ5TAjdHtVbyIh
	zR8Q6D1TE8iHlAiV7+GddgCwfNFOfteyCxPh1fTDKqaJ3ooHrhDovqn6geWJYqPzhQUznyQHQ0x
	6BasiEuNudapLhWa/3OY7nHpfjZm72lh8wPiwIO98tM8NIAuzRVy/UD9EfE/AIx7y5WMNZYYsYl
	jXTrig==
X-Received: by 2002:a05:6512:1252:b0:5a0:c5af:c3ca with SMTP id
 2adb3069b0e04-5a0ed884052mr3438366e87.17.1771913748005; Mon, 23 Feb 2026
 22:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2215.git.git.1771846234706.gitgitgadget@gmail.com> <xmqq5x7nnwyk.fsf@gitster.g>
In-Reply-To: <xmqq5x7nnwyk.fsf@gitster.g>
From: =?UTF-8?B?0JzQuNGF0LDQuNC7INCg0YvQttC40LrQvtCy?= <samonon@gmail.com>
Date: Tue, 24 Feb 2026 09:15:37 +0300
X-Gm-Features: AaiRm50WNcOCCSwNDqhb75tXfF8nfTwwMLwt-YBBfwdlhXxK0w8Kyi7JB8cPSYs
Message-ID: <CABqR6nAdC-GA3ePdJkm5o+W6DyViyJsJ0HkgEre=7ORwi-yH2Q@mail.gmail.com>
Subject: Re: [PATCH] docs: remove {litdd} usage
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Ryzhikov via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 9:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Hmph, I do not quite see the point of this churn.  We'd need to
> remember to do \-- instead of doing {litdd}, either way.
>
> I do not know what you want to say with "when exporting to other
> formats", as we already are formatting these source files into HTML
> and manual pages.

Let this e-mail be a summary post for similar suggestions.
If there is a reason to continue using legacy fix {litdd} there needs
to be an example
where it breaks output with current tools/setups (or even may be future set=
ups).
If it can be replaced there needs to be a list of required tests for
all setups (see 2.).

1. I searched this mailing list for 'litdd' references (links will be
in the end) and understood
that it was introduced because of changes in asciidoc syntax (--
became emdash) and
bugs in asciidoc* converter more than 10 years ago. Should it be used
still for legacy code support?
I tested (cygwin + asciidoc) 'make all doc' and it works correctly
(but maybe it's only for me).
Since '\--' is a default asciidoc syntax for disabling text
replacement it should be used
for writing docs and converters now should know about this syntax.

2. What should be tested whether replacing {litdd} with '\--' doesn't
regress with current tools?
Should it work correctly (and create same textual output):
- with Win/Mac and all types of Linux/Unix/BSD?
- with all converters (including older versions): asciidoc, asciidoctor, et=
c...
- with all output formats (man, html, info, pdf, docbook, etc...)?
- with 'Git for Windows' repo and other forks?
Who can take their time and test all this?
Or release docs should come from a single source (like manpages and html do=
cs
at https://www.kernel.org/pub/software/scm/git)?

3. Development discussion forum.
3.1 I apologize for sending it directly to this mailing list - maybe
It should have been
discussed somewhere else beforehand? For example, Discord? Mailing
list is SO old school.
3.2 Maybe there should be a discord channel #docs for Git
documentation development?

---------------------------------------------------------------------------=
--
Previous important references to {litdd} in this mailing list. My
comments start with >>

https://lore.kernel.org/git/20110629053510.GC28690@elie/
[PATCH 1/2 maint] Documentation: quote double-dash for AsciiDoc
Use "\--" to avoid such misformatting in sentences in which "--"
represents a literal
double-minus command line argument that separates options and revs from
pathspecs, and use "{litdd}" in cases where the double-dash is embedded
in the command name.  The latter is just for consistency with
v1.7.3-rc0~13^2 (Work around em-dash handling in newer AsciiDoc, 2010-08-23=
).

https://lore.kernel.org/git/20120426085156.GB22819@sigill.intra.peff.net/
[PATCH] docs: stop using asciidoc no-inline-literal

https://lore.kernel.org/git/20150513045650.GA6070@peff.net/
[PATCH 0/8] asciidoc fixups

https://lore.kernel.org/git/1462220405-12408-2-git-send-email-larsxschneide=
r@gmail.com/
[PATCH v3 1/2] Documentation: fix linkgit references
>> previous attempt to remove {litdd}

https://lore.kernel.org/git/20171029211308.272673-1-sandals@crustytoothpast=
e.net/
[PATCH 0/2] Convert SubmittingPatches to AsciiDoc

https://lore.kernel.org/git/20180510071103.GC31779@sigill.intra.peff.net/
There are certainly a few that can't, though (e.g., config.txt uses
linkgit:git-web{litdd}browse[1]).
I agree that "\--" is less ugly there (and seems to work on my modern ascii=
doc).
There's some history on the litdd versus "\--" choice in 565e135a1e
(Documentation:
quote double-dash for AsciiDoc, 2011-06-29). That in turn references
the 2839478774
(Work around em-dash handling in newer AsciiDoc, 2010-08-23),
but I wouldn't be surprised if all of that is now obsolete with our
AsciiDoc 8+ requirement.

https://lore.kernel.org/git/20190320181715.GJ31362@pobox.com/
Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`

https://lore.kernel.org/git/xmqqsg2q9xts.fsf@gitster.g/
Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again  (14.05.2021)
A typesetting rule like "instead of double-dashes --, use {litdd}" is
an acceptable way out.
At least that wouldn't constrain what the final product that gets
delivered to the end-users can say.

https://lore.kernel.org/git/20220406184122.4126898-1-tmz@pobox.com/
[PATCH] doc: replace "--" with {litdd} in credential-cache/fsmonitor
Asciidoc renders `--` as em-dash.  This is not appropriate for command name=
s.
It also breaks linkgit links to these commands.
>> Currently it doesn't break linkgit: (but may be only for me).
