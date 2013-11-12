From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Tue, 12 Nov 2013 18:38:26 +0400
Message-ID: <CAJc7Lbqaas0Czdvcfn8+iceoyxaVSHOaV9jCJsy4mWH+AbV41Q@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
	<CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 15:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgF6u-00015c-Os
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 15:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab3KLOi3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 09:38:29 -0500
Received: from mail-ve0-f169.google.com ([209.85.128.169]:44374 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab3KLOi1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Nov 2013 09:38:27 -0500
Received: by mail-ve0-f169.google.com with SMTP id pa12so1912927veb.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TfkS5ug/tKVmNcENlUsYYtnzXWPJHOs0skxC1m4kSks=;
        b=W8SBHS2MOkywom++78aRSy3qrO+KP3NhOmRG8FqFkhuRBfNruokIFCJwbc7uV1c/Uj
         wFtbB6Hyy7FCZqcC2vECOP1MbjCqFUKBvfLNWuPeOLM6oKpM7XX2IKSKxviz2w04OGGj
         o4B7SpocHxp/sTFULZJz9GLQhewJqwiiAdz97q0mu06g7m7UrYsj2chaB7uGR2v7ZvZ1
         7pSXBzPlM09YXxApIE4weJerAUw/j9GzNNcuuaj06zGi0guB664RH1CvUAdHQltkTVyt
         kK+edcxDm7/Cc6UpizeQzkOPstzHcsJm0NxqbCHWVEZVgJPWqlv6/mbV6pu2UHwcTypb
         q8Bw==
X-Received: by 10.58.255.71 with SMTP id ao7mr29372402ved.16.1384267106800;
 Tue, 12 Nov 2013 06:38:26 -0800 (PST)
Received: by 10.58.109.71 with HTTP; Tue, 12 Nov 2013 06:38:26 -0800 (PST)
In-Reply-To: <CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237710>

I use linux.

I can't publish repo - it's proprietary, it weights ~300M unpacked,
and it uses references ~3Gb.
Error message doesn't contain "remote:" prefix.
The majority of opened files have name like:
objects/pack/pack-<hash>.[ pack | idx ]
They all are from referenced repo.

I have disabled gc in the referenced repo - to prevent all local repos
from breaking. May this be the cause of problem?

On 12 November 2013 18:19, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Nov 12, 2013 at 3:02 PM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=
=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
>> I get this error message every time I want to do a `git push`.
>> git version: 1.8.4.2
>>
>> Is it a known issue? Do you need additional info to investigate it?
>
> What OS do you use? If the repository can be published, please do.
> Compress the whole .git directory, don't push or anything. Does the
> error message begin with "remote: "? If not you could try strace and
> at least identify what files are opened.
> --
> Duy
