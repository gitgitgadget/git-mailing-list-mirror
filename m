From: "Torne (Richard Coles)" <torne@google.com>
Subject: Re: git grep -F doesn't behave like grep -F?
Date: Fri, 18 May 2012 13:41:44 +0100
Message-ID: <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com>
	<4FB6426C.7040202@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 18 14:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVMVD-0006gc-8K
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 14:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965663Ab2ERMlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 08:41:47 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36070 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759789Ab2ERMlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 08:41:46 -0400
Received: by ghrr11 with SMTP id r11so83638ghr.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=bAqLbiQRVMY3g83VQeZcYyqyIyZ4rmeKEoN/gb2FIXc=;
        b=Gbk1ZzfwkWqM7tEsdAdwPPsxzpZrPYD9RyKJ+fDjlhTKbe2DAZnElkXplhPhHNUDTI
         aWWeH66grMRfAHLpLS9sVwVfNpOljvUQfNah1FjqOiDhST0Ti86mQWl/VQO+wZjEb7LW
         7PySAkhSjNiTclxhnzh5DV2hOkZoJps1Ierzd6/ThqztByF0LWAYAnyxOFV11Sff5Ajs
         Hi/rFa0CnRQD10tjPVrX9TMAMxsD0ab0UzzPR10Up9bVraJbgXJsd7TDwG2Vk8ig3588
         SP79qumWdq4aXKC+nNVND9uMHAVTVO2+5awDlCMEm69syvQC16kKDGzNiKRFIeAWMA7L
         sfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=bAqLbiQRVMY3g83VQeZcYyqyIyZ4rmeKEoN/gb2FIXc=;
        b=DXNyP1HUDMMTg79Cun1Pi5OZkmj/i3PiNqWh06BnBmLYN9kCZBUjRlY8TBEmmujoyJ
         yE0k+YOvyUNpbxGf36RyBWcXq6Evzd/GWNFT0y37fcSjxua7moCuqHHf6HNZ1F3zNntG
         Sj2of9vCl/baPR3S53MTcII5DJ/pVCnS/USSRvQfi9EAN7HV358MDKQ7hWXsLFkEotKt
         154m8zb9arJIUkDjJNP+CDILLfbHV8Yq+qtU5ykjY/H2HmjzHfGk0njI7+xDVDtX7t2+
         j3rsONErBCLExvmVXgLaDsbvZkaK4/FOMRx6Jdv5kJFw3d7N75bbFxqvZy6P/nI3zP2C
         +uUw==
Received: by 10.50.45.234 with SMTP id q10mr338899igm.54.1337344904893;
        Fri, 18 May 2012 05:41:44 -0700 (PDT)
Received: by 10.50.45.234 with SMTP id q10mr338882igm.54.1337344904683; Fri,
 18 May 2012 05:41:44 -0700 (PDT)
Received: by 10.231.111.131 with HTTP; Fri, 18 May 2012 05:41:44 -0700 (PDT)
In-Reply-To: <4FB6426C.7040202@lsrfire.ath.cx>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkq0x7sKa7wghIaTnaiVX02OhHOb4dc8aaEWMDX5oHmYmOmfI0XAWyRAapIYPpxMRgPwzEmpYVCurk7XwhSNibH5whDTU9IBxjKbUURAJEoVbLmChX0xoLSNJCu9I4P1pOa72o8D0hPI6MHTZ7KnZ3xyS8thw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197953>

On 18 May 2012 13:37, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrot=
e:
> Am 18.05.2012 13:00, schrieb Torne (Richard Coles):
>
>> Hi folks,
>>
>> git grep -F is documented as: "Use fixed strings for patterns (don=92=
t
>> interpret pattern as a regex)."
>>
>> whereas grep -F is documented as "Interpret PATTERN as a =A0list =A0=
of
>> fixed =A0strings, =A0separated =A0by newlines, =A0any =A0of =A0which=
 is to be
>> matched."
>>
>> This accurately describes how they behave, which means that git grep
>> -F with a pattern containing newlines never matches anything (at lea=
st
>> as far as I can see). Is this intentional, or an oversight? The
>> ability to grep -F for a list (e.g. the output of another grep) is
>> pretty handy...
>
>
> You could use -f- (read patterns from stdin).

Ah, yes, rewriting

git grep -F "`git grep -o someregex`"

as

git grep -o someregex | git grep -F -f-

works, but it's not how I immediately think to do it :)

> That said, it looks like a missing feature to me -- at least I didn't=
 know
> that grep -F takes newline separated lists of search strings. =A0And =
this
> doesn't seem to be restricted to invocations with -F, only; a plain g=
rep
> with regexps does it as well.

Yeah, it doesn't seem like adding it would break anything; patterns
with newlines don't match any lines by definition currently :)

--=20
Torne (Richard Coles)
torne@google.com
