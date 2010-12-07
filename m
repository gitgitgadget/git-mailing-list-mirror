From: demerphq <demerphq@gmail.com>
Subject: Re: git diff --summary only seems to work when combined with --stat
Date: Tue, 7 Dec 2010 07:55:01 +0100
Message-ID: <AANLkTinOCR1UpgZJNyxQNUTgK1A603YhOoEy-y-0v8AP@mail.gmail.com>
References: <AANLkTimCAy8kcQaKNaxz4UJp2ZB=_HeRMmeaQ5ZHNV4g@mail.gmail.com>
	<20101206210304.GA9735@burratino>
	<AANLkTinuQoJLfDq8HhUd=FLoqosVD23MU6ch6Ea2iVSJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 07:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPrSA-0002xz-R9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 07:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab0LGGzE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 01:55:04 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40983 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab0LGGzC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 01:55:02 -0500
Received: by qyk11 with SMTP id 11so4621676qyk.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 22:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rwBmNvb/nmIUuZl9U6mr2vBGPIBpTHpcsDTS2MrSuoM=;
        b=AvR0lMU07oWo69VjEabcnjBmsRYUGgyzIhl3T9pS7YAoX63CF01uWd0l2beFG/k1g0
         k5exXKVej8fvMim+kKKQTAKbiEFXSCMwgP03mJVRYf5nrgUJ/w7c1N2PDei1ooKDynJx
         JQOZ1XjFgELOKVJYlAYaX2CoIKAt7jMNnIXHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V6Txr4tn+ukfP0DfQMVh23k9Cpi5HrflX/ekze6Exhz64xsrhekW6ijHWVXEls0kxC
         YbTUMPJPErD/V7GFkh0pP6hNs24poSrbXfieeg5lLRCp4WPu9SFUeI3wmV/9Hy0uoqkc
         QXeTgazkZH9MEqn2qBjDxu52yHJ8hI2NRJmYA=
Received: by 10.229.183.135 with SMTP id cg7mr5170089qcb.296.1291704901982;
 Mon, 06 Dec 2010 22:55:01 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Mon, 6 Dec 2010 22:55:01 -0800 (PST)
In-Reply-To: <AANLkTinuQoJLfDq8HhUd=FLoqosVD23MU6ch6Ea2iVSJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163070>

On 7 December 2010 07:53, demerphq <demerphq@gmail.com> wrote:
> On 6 December 2010 22:03, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi Yves,
>>
>> demerphq wrote:
>>
>>> It seems like the --summary option only works in combination --stat=
=2E
>>>
>>> It doesn't seem to work if I use it by itself, nor in combination w=
ith
>>> --name-status or --num-stat. And depending on the order, it either
>>> does nothing, or causes a usage note.
>>
>> It is tricky, but as you noticed --summary is not actually about the
>> diffstat. =A0--summary affects the output summarizing new files and
>> renamed files.
>>
>> Example:
>>
>> =A0 =A0 =A0 =A0$ git diff --summary v1.7.2..v1.7.3
>> =A0 =A0 =A0 =A0delete mode 100644 Documentation/RelNotes-1.5.0.1.txt
>> =A0 =A0 =A0 =A0delete mode 100644 Documentation/RelNotes-1.5.0.2.txt
>> =A0 =A0 =A0 =A0[...]
>>
>>> $ git diff --name-status --sumary HEAD^
>>> usage: git diff <options> <rev>{0,2} -- <path>*
>>
>> There is an 'm' missing here. :)
>
> Thanks for your reply. It turns out that was a mis-paste. I tried bot=
h
> splelings of summary. ;-)
>
> And none of them produce output.
>
> $ git diff --summary HEAD^..HEAD
> $ git diff --summary HEAD^^..HEAD
> $ git diff --summary HEAD..HEAD^
> $ git diff --summary HEAD^
>
> So why does it work for you but not for me?

Ah. Not enough coffee. It "doesnt work" because I am not adding or
renaming a file here?

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
