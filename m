Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773E37F31C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488830; cv=pass; b=cE4J21teWw54p4t8b6r3CJgsJ67x9WrzCIad1rijkNtN6ppgnLTI5wDGS2qMVyfdBoBrYmWyc0ShSqgsh0wNDacJm9+zGXeQfRe7dLbdJC2S7kRJkaWB+wSIrV6ONNLtmMtIC4MQKCWpcFhS5OO/KV/KEbcBCdax/bDcZjBpEEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488830; c=relaxed/simple;
	bh=Kvrb8IQD2Tmdn40PD3sZFpUuBw0j6xh5o0c9u10WkNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/N/dxTeXQvbAE7niFFLlizthbyGOwuTYu3AodjlD8M2jb4rJIEcUarg7jHm/rKQPzSx43DfTnPHTp1oNkEPLNVHSlztvjfr8vm2V9q9YpPhnYltb6oXMYd7LfEpG4dmdYRnkv/asKSJkZLYXiFVyepxS4MBYI82msnbWq39qic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub05OT1g; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub05OT1g"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d032846c95so28862035ad.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 12:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791488828; cv=none;
        d=google.com; s=arc-20260327;
        b=lmLm9CsMFqVofanj5x/uVY8jUHxzpn5STYtOZnjqH1RCg0O9QELtDM1JMYn5YSQJgL
         mwuxr98URKpOC8uZ/MeN2iSsaXHMDKwfrZ5RPTZxuSDZ+16GH51wfJznRQB62nNv0G09
         8W5VyG2nQq8zOvkzDmA0qNFp39Jx08MuEoWoq2djxA0BQJKcKbke+AZdj0kExQ3oziJJ
         dzvaAmVwK0qDyBo8zpK518Cl7n4RtI6HnSVF+wf0e6B4HReUdc19L3VUIEIhlnZgbPu1
         WLfG3Xu4/sII+htSgHZL5kpi2QeVhY8StZN6crUITTSvFhV8eJhH4znwdSkG/iid2OHU
         7iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGs5ozGiwvrOl/RLBIy5iGxwbAWyhVIWmo+HMkl4Z8E=;
        fh=mH5n3R9+7POqIDVOh8VIMxxKIXinFZRmKMCtjQe9DKY=;
        b=dzQ4UCUKjk7u4D5i1gLcAbH0BLBNpG6tdMQtW2IeKFGxXqGZloB+5iafJ9UQm45nH/
         1gNxXX4Z/h88j/FcPB4HNnVpFXWUCfcKj20xMVbEQd0U64ZCC5oigagn7+9JeF3zbEE0
         xbL+qpUM6T3Mfu4rGHhXyRJOPCkaNMOXXpLgcbreobTQYJOZpEJcu32/J0shMKzjzKN8
         GbQ6zYI/xDs+vxFiz8tBOi0KuJM1/andTDeASNY9bpb+kkO7393XOESOZTaJ73jbuKFZ
         DhL5QScDWsO8h5PlkxIOrVbMZL+t2E67S3S69lnAsePYmseJPMScbPZi3FlFW9hmSs6V
         vjOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488828; x=1792093628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGs5ozGiwvrOl/RLBIy5iGxwbAWyhVIWmo+HMkl4Z8E=;
        b=Ub05OT1g9qb+j78r2ppANRgOpMtpueQ7mm/yz8+KEkk/hz74M9iWYCPB08vVQ3GwzE
         ZGIHoUQt5Yr5zc7XoH2/zEzuD6TNVAsFsT9HLEhBjgJem0EAQglTzcCky/QUdRSFZCmB
         U4n65mr9A2cu0QQm7jkvp9n9/ruNI0UDCKRYcVzZ/LSiyA14B0xrSarQjsQGZ6lIjiHk
         +OBs9pSEeD3Oi9tlCWmyaS2oAo6ISHw+KiQq2sHcuF8BE+JZsksfDRQnEfE1sYXKTJKj
         5bST2lr3zRPI/BXfG981hp41TYJmpeRHn9o/MdxtaWmwmExp3wh1muoNRVEmtuS+qMdl
         NgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488828; x=1792093628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGs5ozGiwvrOl/RLBIy5iGxwbAWyhVIWmo+HMkl4Z8E=;
        b=I/iSf/CBN4lyl/gekorhSqwLfWkszHK/fJxXIEmwCsekGOU2MaSwmv821xovvpxOb8
         M3GSQoUrNlhIK6+Tz0lNjMcWBRBiT2jn3919ye+xaV6FiIZ2bL5NyeYqZet+jqPATpfJ
         8g+OC5l+dCUt/lozmUKa0LSAHt3g5yVQQfa+t+cJcXYyPX0iVbsh0b5wy/FZsQW1sCcR
         /rwA39uH+qhYEQFJwvZoYjOvPd3wiVZ5O28gK9W77nIsRYLndNz56/BGcmx6NM+kMppK
         1LO+b460Nvtn6EdlcoSPNVMbgxsDTuqhwMW8lQSMLSXpDJcS4xTrZrwgDc7KJJpc7sej
         KNoA==
X-Gm-Message-State: AFq9FYIH8W9l8t7c7vnVLagCSGDhvS0MMOdXeSeGiM258nL5w9UQpiI6
	F6pts/M4qYF/uDGIIgi4iH8xNSfqrHkllwt5pYZKOmgH0BgIHtoVBqg5K1VvrtNewWccjUrSfTZ
	I6klPb6iPGZRwMxRKYQ7R9ZnwKIrtLGNqYp/4pAM=
X-Gm-Gg: AYBFou3DWmzsaV9atgEz3h9H/lH6+NuePECxEI/oiZKRQcrHZBor7C6J4TvGTKrqC4v
	Ff25S7F/NgU8EBssgugyrp6OzAuNlwlUOxf73pAy+0kvcWubyuV0xhr/vXxB77Qx3GB47M+shWA
	+r11dYu+8So74jW7HSeM9+DEV7BOFl2Cju2+qPReneW/bu21KuHZx6m6vnn9uZFbPUngeBDUR/E
	/Qys6rWOLdp8ew91gFeGVnwxf7KdIUyesDQM8V7X/UftcUhzRvJ1DpHPCuJTNYjPRjSXuBB9OJg
	rR3xluczVBEQXmHPmZkeMkv8PqyVuoMcsLUQqX/d2jt073j5PzJ2H5bmQ3c/jR1Ugped1chDIzQ
	4nOJy8/fs5Xp2fnnvRahx569Qvazw8a98rDOmtfHXI0tH3R7/i/X8Thq3Dhuz8tWKfTrS1FQzlm
	cU3wjb4Tg4NB2Jlj7ODf90N0lT78M5Ow==
X-Received: by 2002:a17:902:dac6:b0:2e6:2868:e572 with SMTP id
 d9443c01a7336-2e62868e699mr43334465ad.6.1791488828430; Thu, 08 Oct 2026
 12:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <V2_BrCh_become_manpage.dc5@m5gid.xyz>
In-Reply-To: <V2_BrCh_become_manpage.dc5@m5gid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Oct 2026 15:46:55 -0400
X-Gm-Features: AclHuK9jSdrRQO-TVXaYLb0Iu1T_5ka0-Tr7QrLPbnxB48gJSfeNiIhuOlcw-t4
Message-ID: <CALnO6CB8yQy_dtnoTYerqfyY9mcM=rKSWtZkQPtrGuHShoL3VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] doc: BreakingChanges: transform to a manpage
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:38=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> w=
rote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The breaking changes document is not a regular Git documentation page.
> That means that you cannot navigate to the doc with git(1), i.e. with:
>
>     git help BreakingChanges
>
> You instead have to download the Git project source. Or go to
> git-scm.com.[1] Then you get this disclaimer:[2]
>
>     This information is specific to the Git project
>
>     Please note that this information is only relevant to you if you
>     plan on contributing to the Git project itself. It is in no shape or
>     form required reading for regular Git users.
>
> But this document is relevant to *all* Git users. Everyone should have
> as easy access to it as the other doc and guide pages.

Sorry for not mentioning this earlier, but you can (depending on your
distribution's package?) find the document under "git --html-path" for
example

I agree that's drastically less discoverable, though, and I welcome
making it a manual in the spirit of datamodel and others.

I don't think the message needs updated, so not worth a re-roll, just
something to point out for folks that like interesting corners of Git
;) (cf. https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-doc
and accompanying completion
https://github.com/benknoble/Dotfiles/blob/master/links/zshfns/_git_doc).

--=20
D. Ben Knoble
