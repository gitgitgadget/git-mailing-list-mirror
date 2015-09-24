From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Thu, 24 Sep 2015 21:44:53 +0100
Message-ID: <CAE5ih79OBdGP-PgoYWKBn3_xv-w6dfN-3u0iPBDjWbQb_MMbsw@mail.gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com>
	<CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com>
	<A29B974F-2B42-475F-92B6-8B25A54FCDEE@gmail.com>
	<CAE5ih7-NqSd+zSqTungDt5oWzy4QT--vjYaShd=YDzGxHosz3A@mail.gmail.com>
	<ECBECF84-28A9-4E10-907C-8E670F864A25@gmail.com>
	<CAE5ih7_StiXA-c5yER9jhc941vsKfvEUONLXQ4E7JANOhCxMxQ@mail.gmail.com>
	<CAE5ih7_m050wcWZ+7UvL3GscKgSxLWGT+bj4_gSVA8R7RZm=tg@mail.gmail.com>
	<F05CC31A-ECE2-41E4-9805-F1747DD02713@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 22:45:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDO3-0001p2-KO
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbIXUoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2015 16:44:54 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34796 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbbIXUoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2015 16:44:54 -0400
Received: by obbda8 with SMTP id da8so67888482obb.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5Fci0iXH0Ey0cdOudYTn8hzBGFEBMVp2JnGWR1Suu08=;
        b=VtYJB2BtU8vt4NCk2K02I6rwvZPOqkpZFNU6q/DV1fhqHavQAzeSzwgqWzINsKvYw8
         7PbXwxhM/x/BEbu3OkPoxiv52Iv1Lx9nK308076w1n+1F/vmzv5RfEufz4AJ4BCnbfry
         L0kDVpmMCpr69JOEzkOrhMLwS8n0G/c6qpS5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Fci0iXH0Ey0cdOudYTn8hzBGFEBMVp2JnGWR1Suu08=;
        b=bR98Kg8FmNIm1QQSF5NvjErj7Qh93O6uISmGAgS1lxVHoIQsMrFgeypTYc4aoEzoel
         J7G0n4yxkkgcyxp6p8+4MAiDTZ7WBI730OoUaDJFpmRTHsp+AVWpdIO9xn0kusnMKiLS
         TW4sRNzyRHlezbuIvaUdxvQijZ4/15rw72dn51W4E/HKK+t5FxVgmTpe5rPIAhF25Afj
         3Len4Z2xV+60xivSfFk74bBk8Ip9dZUM9L7vv0R0aGSDr7hIp7twhOvERLbCrzVXOjFf
         saSNLmlZFCueyMdu24aLUjt2aGqAd/t0OyG+pz/t1HSYRlkErUCgof0OyiLRpFNUfIYZ
         Azbw==
X-Gm-Message-State: ALoCoQku5dRztamCkIDC/0UwYr1yISyPekXAEEzThsMRgS47gqFcB31/WbXYiVh6y04wmJaab/Uj
X-Received: by 10.182.221.134 with SMTP id qe6mr515172obc.56.1443127493434;
 Thu, 24 Sep 2015 13:44:53 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Thu, 24 Sep 2015 13:44:53 -0700 (PDT)
In-Reply-To: <F05CC31A-ECE2-41E4-9805-F1747DD02713@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278557>

On 23 September 2015 at 12:42, Lars Schneider <larsxschneider@gmail.com=
> wrote:
>
> On 23 Sep 2015, at 13:25, Luke Diamand <luke@diamand.org> wrote:
>
>> Adding back git@vger.kernel.org, which I inadvertently dropped off t=
he thread.
>>
>> On 23 September 2015 at 12:22, Luke Diamand <luke@diamand.org> wrote=
:
>>> On 23 September 2015 at 11:09, Lars Schneider <larsxschneider@gmail=
=2Ecom> wrote:
>>>>
>>>> On 23 Sep 2015, at 11:22, Luke Diamand <luke@diamand.org> wrote:
>>>>
>>>>> On 23 September 2015 at 09:50, Lars Schneider <larsxschneider@gma=
il.com> wrote:
>>>>>>
>>>>>> On 23 Sep 2015, at 10:18, Lars Schneider <larsxschneider@gmail.c=
om> wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>>
>>>>>> I think I found an easy fix. Can you try it?
>>>>>>
>>>>>> (in case my mail app messes something up: I changed line 2240 in=
 git-p4.py to 'self.cloneDestination =3D os.getcwd()=E2=80=99)
>>>>>
>>>>> It fixes the problem, but in re-running the tests, I'm seeing t98=
08
>>>>> fail which doesn't happen on next.
>>>> Confirmed. I fixed it.
>>>> Do you think it makes sense to create a new roll v8 for Junio?
>>>
>>> How about we leave it a day or two in case anything else crawls out=
 of
>>> the woodwork?
>>>
>>> Thanks!
>>> Luke
> sounds good to me!

OK, not sure if I'm just doing something daft here....but it seems to
be ignoring the size limit!

I've got the version from the branch:

   8fee565 git-p4: add Git LFS backend for large file system

Plus the couple of oneliner fixes for cloneDestination.

I've created a repo with a file called foo, size 16MB, and another
file called foo.mp4, which is just a symlink to foo.

I then do:

$ mkdir a
$ cd a
$ git init .
$ git config git-p4.largeFileSystem GitLFS
$ git config git-p4.largeFileExtensions mp4
$ git config git-p4.largeFileThreshold 100k
$ git-p4.py sync -v //depot

That reports that both foo and foo.mp4 have been pushed into LFS:

  //depot/foo --> foo (16 MB)
  Reading pipe: ['git', 'config', '--bool', 'git-p4.pushLargeFiles']
  foo moved to large file system
(/home/lgd/git/git/x/git/a/.git/lfs/objects/08/0a/080acf35a507ac9849cfc=
ba47dc2ad83e01b75663a516279c8b9d243b719643e)
  //depot/foo.mp4 --> foo.mp4 (0 MB)
  foo.mp4 moved to large file system
(/home/lgd/git/git/x/git/a/.git/lfs/objects/2c/26/2c26b46b68ffc68ff99b4=
53c1d30413413422d706483bfa0f98a5e886266e7ae)

But the file system says otherwise:

$ ls -l
-rw-r--r-- 1 lgd lgd 16777216 Sep 24 21:38 foo
-rw-r--r-- 1 lgd lgd        3 Sep 24 21:38 foo.mp4

As does git:

git ls-files --debug
=2Egitattributes
  ctime: 1443127106:535552029
  mtime: 1443127106:535552029
  dev: 65025    ino: 13638459
  uid: 1000     gid: 1000
  size: 94      flags: 0
foo
  ctime: 1443127106:579552030
  mtime: 1443127106:579552030
  dev: 65025    ino: 13638462
  uid: 1000     gid: 1000
  size: 16777216        flags: 0    <<<<<<<<<<<<< Quite large!
foo.mp4
  ctime: 1443127106:599552030
  mtime: 1443127106:599552030
  dev: 65025    ino: 13638463
  uid: 1000     gid: 1000
  size: 3       flags: 0

What's going on?

Thanks!
Luke
