From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: diff for deleted file only, when changed to directory
Date: Wed, 8 Dec 2010 16:56:32 +0700
Message-ID: <AANLkTinW4DjHnNORH3FRi7fQsYAf+Ky_Jr14ZxOu2So2@mail.gmail.com>
References: <AANLkTimXOKC_9TJU1foNkTqPHouFPouzZw3XU_9Za=na@mail.gmail.com>
 <20101208082103.GA4927@burratino> <AANLkTikMf5qRaqkdiOKP_PBf=Q68fMc2U5WVN-7SWFYC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 10:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQGlr-0005wx-8c
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 10:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0LHJ5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 04:57:06 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52751 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0LHJ5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 04:57:03 -0500
Received: by wwa36 with SMTP id 36so964882wwa.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=I2RcGKyHrDWJXLrTWbG5WFEYQ7LXI/WAetTsexcZ7hU=;
        b=qpFIPiGpfsC9kCiAB6DqoddMObYU1s7C/6e4rUh9SlUg2jKg4vy0THQuPfYPZCAAlv
         b4g7pzUh0dN5SjIGxwHmP3CzJ5LK7cPnRHeWsWyldd3uLyY2dgexuvTfS7ZqvdkVegwm
         4tV+pAVHFkUlkJQOy7AO2Yev0EobAW3awHzPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YERfOZtOB/xuIWm8jbuayN2Xzokut1TFNDQDdxKcHXnixsocJloELkZmLOUlskyZjF
         1VZVGR7AsGE3rdvEXqKLEHi3eKIFIWrYFT4qIAtCJUMEOSeChJNPIuMPtV2KzS0PnoxB
         +xDCoo2jk8Q/9KEWyESzi6NIyp+yTCFfe7uVk=
Received: by 10.216.169.6 with SMTP id m6mr444461wel.49.1291802222318; Wed, 08
 Dec 2010 01:57:02 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 8 Dec 2010 01:56:32 -0800 (PST)
In-Reply-To: <AANLkTikMf5qRaqkdiOKP_PBf=Q68fMc2U5WVN-7SWFYC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163181>

2010/12/8 Bert Wesarg <bert.wesarg@googlemail.com>:
> 2010/12/8 Jonathan Nieder <jrnieder@gmail.com>:
>> Bert Wesarg wrote:
>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0git
>>> diff --cached -- foo shows me the diff for both the file foo and fi=
le
>>> foo/bar.
>> [...]
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0But for the case
>>> file->directory, I would like to see only the deleted diff, not
>>> recursing into the directory.
>>
>> If I understand correctly, this is a documentation bug and feature
>> request.
>>
>> The documentation bug: the "git diff" documentation says something
>> like
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff [--options] [<tree>[..<tree>]] [=
--] [<path>...]
>>
>> but the <path>s after "--" are actually patterns (path specifiers).
>> See [1] ([RFD] git glossary: define pathspec, 2010-11-29).
>>
>> The feature request: there is no way to specify an "exact match"
>> or "negative match" when specifying paths. =C2=A0At least "negative
>> match" has been suggested before.
>>
>
> Thanks for the pointers.
>
> I don't expect that we can change <foo> to match only files and not d=
irectories.

Try

diff --cached -- '[f]'

=46rom top of my memory, directory matching does not work with
wildcards. By putting wildcards to your patterns, dir should never be
matched again. I haven't tested it though.
--=20
Duy
