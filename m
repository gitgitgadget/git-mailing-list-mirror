From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 16:54:55 -0600
Message-ID: <x2i600158c31005071554pdc399a46s1f97b1ddcd258d3e@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org> 
	<576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 00:55:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAWSE-0000iC-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab0EGWzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 18:55:18 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:58534 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0EGWzQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:55:16 -0400
Received: by yxe1 with SMTP id 1so1118660yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=j4rXEaKi44xXAyj+y9mAFh528jMRf17P48xZ2hF7PoY=;
        b=KtoKgj1+fZoqy9l2eo7UQEwtx4ING4zunfuVio8fxEsJqxQLjZr8SVEQBZlz7WPM7q
         gsZMOYq1S2NSIrlhxDECn8z/ZXgASGXxjkv+beTXJb9Zt2hFRp1066/6a/moON8RKIbb
         scObd7Hx7Q31idx7V7TWN/9zkjZAtqtqU4W/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RXQ1wQm3OOZOaRxlaVYOTiXWTBQ2qdJ9TJp7zpRwAcSsEdZnJbIzImMxC0L5yr5UqR
         g+4ktNFdgIZH/rUqaXCFqf6hNKDHhjwW/2deuCz4GSwGQY1Laxu04v8vI6zWx+UFN7uZ
         RJwpRXncMhWHls8vZ3Xn7eea9oewzG5O/g8tY=
Received: by 10.90.198.19 with SMTP id v19mr678555agf.100.1273272915153; Fri, 
	07 May 2010 15:55:15 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Fri, 7 May 2010 15:54:55 -0700 (PDT)
In-Reply-To: <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146614>

> Part of the confusion comes from the way the options are currently
> declared. =C2=A0set vs. unset vs. unspecified vs. "input" vs. "auto" =
for an
> option named "crlf" is just very, very, unfriendly. =C2=A0None of the=
 words
> *mean* anything.
>
> Maybe we should rethink this from the top. =C2=A0Imagine that we curr=
ently
> have no crlf options whatsoever. =C2=A0What *should* it look like? =C2=
=A0I
> suggest the following:
>
> Config:
> =C2=A0 core.eolOverride =3D lf / crlf / auto / binary / input
> =C2=A0 core.eolDefault =3D lf / crlf / auto / binary / input
>
> Attribute:
> =C2=A0 eol =3D lf / crlf / auto / binary / input
>
> If eolOverride is not "auto" or unspecified, we ignore eolDefault or
> any attributes.
>
> If the attribute is not "auto" or unspecified, we ignore eolDefault.
>
> For all entries, unspecified is equivalent to "auto".
>
> Of course the eol attribute could be named "crlf", but that might not
> increase the sanity as much as we would like.
>
> And "input" means "auto, but strip CR when committing." =C2=A0Or mayb=
e the
> problem is that it doesn't belong here at all: maybe it should be an
> entirely separate attribute that takes effect whenever the eol
> attribute/config resolves to "auto."
>
> Or maybe I'm just not thinking about it the right way?
>
> Avery
>

If we forget everything git has now, I would suggest the following:

- eol-normalization is per repository, per filetype (fnmatch filter)
- in a file separate from .git/config, such as .git/eol
- when you clone, you get this file

You specifies the 'standard' eol type for each file type in this projec=
t:

    *.c lf
    *.python lf
    *.vb crlf
    *.sln crlf
    etc (something like that)

committing and checking-out always normalize line endings; *always*

add (and commit) can take an option to keep eol as-is (i.e.
--no-eol-normalization or --keep-eol or --raw-eol)

In this model:

1- Anyone who clones gets the repository eol settings
2- No one can possibly commit in a different eol style unless he
explicitly says he wants to.
3- Naturally, eol-normalization doesn't apply to binary files

#2 is important, it's needed so you won't have someone making bad
commits because he has a settings some where in his global config to
always ignore eol normalization.
on the other hand, one can alias 'add --raw-eol' to something like
'eviladd', so he can do 'git eviladd file.c', which is fine because
it's explicit.

This would get rid of issues where an editor (such as VS) saves a file
with mixed line endings: we don't care because we normalize them.

This would also make it more transparent to windows users: they don't
even have to think about eol issues; they can't make bad commits
"by-accident". (provided the repo maintainer has set the eol filters
properly).

I have no idea what happens (or should happen) if the origin repo
maintainer updates the .git/eol file. Maybe it should be .giteol
instead of .git/eol
