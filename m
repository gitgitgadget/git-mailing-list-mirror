From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: diff for deleted file only, when changed to directory
Date: Wed, 8 Dec 2010 10:29:07 +0100
Message-ID: <AANLkTikMf5qRaqkdiOKP_PBf=Q68fMc2U5WVN-7SWFYC@mail.gmail.com>
References: <AANLkTimXOKC_9TJU1foNkTqPHouFPouzZw3XU_9Za=na@mail.gmail.com>
	<20101208082103.GA4927@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 10:29:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQGKv-00029m-JC
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 10:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab0LHJ3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 04:29:10 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:56469 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab0LHJ3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 04:29:08 -0500
Received: by iwn40 with SMTP id 40so1328321iwn.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3A7PJWaH9swwIDYJcfqsXThW6SRBoBu9Ar2UFRsznxE=;
        b=JzbrKRnU9tBhry5Jh8LzQfk/HXFDFeYGh86oMD4ATXMDpKQcVsF7+2UU8UtULHPEyk
         V0wKKUbv193GecuPGgvMczQrJh+9YPTDJ/U27xqgqyVbfAaDVZGVArR4MK6RjVdXo2r3
         7AE4F/mMht06pULgEojqcY7NpNbImG6p60JZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EAqSzwz7QzEaR5tCKL5RSCDsLEM5H7RuRR0tFO62Fikx6ZPpXmX1fu42wrSP1EK/9x
         Tjs0+7KFlCGMocfnnjn0V4WHV/3lOxJmzcYTCAcAfyE+f09JUrWfFlAEpN8gn0Qp4MkO
         VIJqGF3j9y1GndFnu7ke5fyrtM02XobR337YQ=
Received: by 10.42.224.136 with SMTP id io8mr81002icb.492.1291800547199; Wed,
 08 Dec 2010 01:29:07 -0800 (PST)
Received: by 10.42.172.193 with HTTP; Wed, 8 Dec 2010 01:29:07 -0800 (PST)
In-Reply-To: <20101208082103.GA4927@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163180>

2010/12/8 Jonathan Nieder <jrnieder@gmail.com>:
> Bert Wesarg wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0git
>> diff --cached -- foo shows me the diff for both the file foo and fil=
e
>> foo/bar.
> [...]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0But for the case
>> file->directory, I would like to see only the deleted diff, not
>> recursing into the directory.
>
> If I understand correctly, this is a documentation bug and feature
> request.
>
> The documentation bug: the "git diff" documentation says something
> like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff [--options] [<tree>[..<tree>]] [-=
-] [<path>...]
>
> but the <path>s after "--" are actually patterns (path specifiers).
> See [1] ([RFD] git glossary: define pathspec, 2010-11-29).
>
> The feature request: there is no way to specify an "exact match"
> or "negative match" when specifying paths. =C2=A0At least "negative
> match" has been suggested before.
>

Thanks for the pointers.

I don't expect that we can change <foo> to match only files and not dir=
ectories.

Bert

> [1] http://thread.gmane.org/gmane.comp.version-control.git/162379
>
