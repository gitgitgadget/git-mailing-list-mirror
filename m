From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Wed, 2 May 2012 12:10:41 -0700
Message-ID: <CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
	<vpqfwbjnl4a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 02 21:10:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPewp-0005rV-4V
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 21:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab2EBTKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 15:10:42 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44436 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab2EBTKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 15:10:41 -0400
Received: by yhmm54 with SMTP id m54so1046923yhm.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UxmvvjMRAz6B30/X92q2l56jlmRIwDl3nW0Med4XIzQ=;
        b=pAQDlnJbSMrynB7DjX4bRbZlofJFbsO6Ala75qA3TREkWVS2zWeubRCX0PCQg5kRvm
         tDzXTpQHZIHA9zL7Gid+Vb7R50dt4tJdZ7Eomfb/8Lwtt8Q1zQy5MxPucL23VujGF8+K
         8nsDBs1uAltoX+PTTsqmW/SopdA6WAqboPEL3bK+P/hUbZS2Lo/8A6AwYt394qDZfzyl
         iYDEbb2vbex80htcawbYiIz50ditQcB0SIQp5iFE0j0WiT4EZMBp+ANeu9fcqvMsqRaF
         OfcCXgkdLlFrqfvGUyHxRv3b3tGfwSzQC8ywUHDev0F+etuAx4PA9YL9dljl/IlIhNur
         OGlg==
Received: by 10.236.76.41 with SMTP id a29mr32555087yhe.117.1335985841310;
 Wed, 02 May 2012 12:10:41 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Wed, 2 May 2012 12:10:41 -0700 (PDT)
In-Reply-To: <vpqfwbjnl4a.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196850>

On 1 May 2012 23:38, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> On 1 May 2012 13:33, Junio C Hamano <gitster@pobox.com> wrote:
>>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>>
>>>> Is there any way to get (some of) the Git hooks to run for everyon=
e
>>>> without everyone having to install them separately? If no, is this=
 by
>>>> design or simply a feature nobody has asked for (yet)?
>>>
>>> By design. =C2=A0Do you want me to include "rm -fr ~hilco" in some =
hook of
>>> git.git repository?
>>
>> Mmm, well, I might get quite famous if you did... ;-)
>>
>> But if you wanted to be evil then you could easily find another plac=
e
>> (the build scripts, the code itself, et cetera).
>
> Yes, but at least, you have the opportunity to examine the other plac=
es
> before they are ran. Hooks would be really, really nasty security-wis=
e.
> For example, "git clone" does a checkout, so should probably run the
> checkout hooks.

There is (or, rather, should be) absolutely no difference between code
changes and hook changes. Both would go through the same review
process. If it's possible to put in nasty hooks then it's possible to
put in nasty code.

>> So I don't think this is a good argument. Moreover, I do not work wi=
th
>> people that would ever consider such nastiness. You need to realize
>> that this is all closed source. Your argument would be more valid in
>> an open source environment (like git.git).
>
> That may be acceptable for you, but you can't ask for such feature to=
 be
> included in Git itself. At best, a standardized way to setup hooks (b=
ut
> something that would require a user-action to be set up) would be
> acceptable.

Given ${PROJECT}/.git, I would think that a simple config setting
(hooks.run-automatically-this-is-a-security-risk [defaulting to false,
of course]) and an extra directory like ${PROJECT}/.hooks (this should
probably be configurable as well: hooks.directory) would work
perfectly. Then it's up to the project to decide if they want to use
that feature. Moreover, you could then still have "personal" hooks in
${PROJECT}/.git/hooks.

Would such a setup be acceptable?
