From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Fri, 25 Sep 2015 10:35:09 +0200
Message-ID: <571C8128-DFB9-457F-97AE-8F6BC0579465@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com> <CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com> <A29B974F-2B42-475F-92B6-8B25A54FCDEE@gmail.com> <CAE5ih7-NqSd+zSqTungDt5oWzy4QT--vjYaShd=YDzGxHosz3A@mail.gmail.com> <ECBECF84-28A9-4E10-907C-8E670F864A25@gmail.com> <CAE5ih7_StiXA-c5yER9jhc941vsKfvEUONLXQ4E7JANOhCxMxQ@mail.gmail.com> <CAE5ih7_m050wcWZ+7UvL3GscKgSxLWGT+bj4_gSVA8R7RZm=tg@mail.gmail.com> <F05CC31A-ECE2-41E4-9805-F1747DD02713@gmail.com> <CAE5ih79OBdGP-PgoYWKBn3_xv-w6dfN-3u0iPBDjWbQb_MMbsw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 10:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfOTS-00048L-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 10:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbbIYIfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2015 04:35:16 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34952 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbbIYIfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2015 04:35:12 -0400
Received: by wicge5 with SMTP id ge5so10399873wic.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OGugTgUxSH9k1Bn9y2k9VBspqxISYukEMJds9C2njgY=;
        b=e8YQoizOQnj4cGWXRhMSLrUcKvqCWDblT6xliQTMZZk2PfQ4O7MYPYWuEiA7cPlNxI
         u9e/G+WNG3+rs4ECQA7JAg72ntiPzCeU2f/7lNYlzD68q5aVSQ33pGMNAxSGwLjcGUke
         GjAKI7CkQuaFWtq5CEoaGmKwp3TubJkjMzqDNTQarMVVLryjDYUm1Gq5zVJEP3dCCGBh
         JsH9DD+fVnKv9GpVamY4WIWjhXwCtD1XZ0TyRr7YFe2ysWZhBd1FM5fwD1nYzc5uoZCH
         RUlVav00zTY0SU4d8L4LUG+jz5nFY2EpmdswqZnNX1OXaaAamVzjoJxkH+AY+9celIxw
         QD9A==
X-Received: by 10.180.8.36 with SMTP id o4mr2071491wia.82.1443170111313;
        Fri, 25 Sep 2015 01:35:11 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-102-071-165.188.102.pools.vodafone-ip.de. [188.102.71.165])
        by smtp.gmail.com with ESMTPSA id fs2sm2095129wib.12.2015.09.25.01.35.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Sep 2015 01:35:10 -0700 (PDT)
In-Reply-To: <CAE5ih79OBdGP-PgoYWKBn3_xv-w6dfN-3u0iPBDjWbQb_MMbsw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278652>


On 24 Sep 2015, at 22:44, Luke Diamand <luke@diamand.org> wrote:

> On 23 September 2015 at 12:42, Lars Schneider <larsxschneider@gmail.c=
om> wrote:
>>=20
>> On 23 Sep 2015, at 13:25, Luke Diamand <luke@diamand.org> wrote:
>>=20
>>> Adding back git@vger.kernel.org, which I inadvertently dropped off =
the thread.
>>>=20
>>> On 23 September 2015 at 12:22, Luke Diamand <luke@diamand.org> wrot=
e:
>>>> On 23 September 2015 at 11:09, Lars Schneider <larsxschneider@gmai=
l.com> wrote:
>>>>>=20
>>>>> On 23 Sep 2015, at 11:22, Luke Diamand <luke@diamand.org> wrote:
>>>>>=20
>>>>>> On 23 September 2015 at 09:50, Lars Schneider <larsxschneider@gm=
ail.com> wrote:
>>>>>>>=20
>>>>>>> On 23 Sep 2015, at 10:18, Lars Schneider <larsxschneider@gmail.=
com> wrote:
>>>>>>=20
>>>>>> <snip>
>>>>>>=20
>>>>>>>=20
>>>>>>> I think I found an easy fix. Can you try it?
>>>>>>>=20
>>>>>>> (in case my mail app messes something up: I changed line 2240 i=
n git-p4.py to 'self.cloneDestination =3D os.getcwd()=92)
>>>>>>=20
>>>>>> It fixes the problem, but in re-running the tests, I'm seeing t9=
808
>>>>>> fail which doesn't happen on next.
>>>>> Confirmed. I fixed it.
>>>>> Do you think it makes sense to create a new roll v8 for Junio?
>>>>=20
>>>> How about we leave it a day or two in case anything else crawls ou=
t of
>>>> the woodwork?
>>>>=20
>>>> Thanks!
>>>> Luke
>> sounds good to me!
>=20
> OK, not sure if I'm just doing something daft here....but it seems to
> be ignoring the size limit!
>=20
> I've got the version from the branch:
>=20
>   8fee565 git-p4: add Git LFS backend for large file system
>=20
> Plus the couple of oneliner fixes for cloneDestination.
>=20
> I've created a repo with a file called foo, size 16MB, and another
> file called foo.mp4, which is just a symlink to foo.
>=20
> I then do:
>=20
> $ mkdir a
> $ cd a
> $ git init .
> $ git config git-p4.largeFileSystem GitLFS
> $ git config git-p4.largeFileExtensions mp4
> $ git config git-p4.largeFileThreshold 100k
> $ git-p4.py sync -v //depot
>=20
> That reports that both foo and foo.mp4 have been pushed into LFS:
>=20
>  //depot/foo --> foo (16 MB)
>  Reading pipe: ['git', 'config', '--bool', 'git-p4.pushLargeFiles']
>  foo moved to large file system
> (/home/lgd/git/git/x/git/a/.git/lfs/objects/08/0a/080acf35a507ac9849c=
fcba47dc2ad83e01b75663a516279c8b9d243b719643e)
>  //depot/foo.mp4 --> foo.mp4 (0 MB)
>  foo.mp4 moved to large file system
> (/home/lgd/git/git/x/git/a/.git/lfs/objects/2c/26/2c26b46b68ffc68ff99=
b453c1d30413413422d706483bfa0f98a5e886266e7ae)
>=20
> But the file system says otherwise:
>=20
> $ ls -l
> -rw-r--r-- 1 lgd lgd 16777216 Sep 24 21:38 foo
> -rw-r--r-- 1 lgd lgd        3 Sep 24 21:38 foo.mp4
>=20
> As does git:
>=20
> git ls-files --debug
> .gitattributes
>  ctime: 1443127106:535552029
>  mtime: 1443127106:535552029
>  dev: 65025    ino: 13638459
>  uid: 1000     gid: 1000
>  size: 94      flags: 0
> foo
>  ctime: 1443127106:579552030
>  mtime: 1443127106:579552030
>  dev: 65025    ino: 13638462
>  uid: 1000     gid: 1000
>  size: 16777216        flags: 0    <<<<<<<<<<<<< Quite large!
> foo.mp4
>  ctime: 1443127106:599552030
>  mtime: 1443127106:599552030
>  dev: 65025    ino: 13638463
>  uid: 1000     gid: 1000
>  size: 3       flags: 0
>=20
> What's going on?
I believe this is correct. Git-LFS uses the clean/smudge filter to repl=
ace the LFS pointer with the actual file on checkout. Therefore you see=
 the actual file!
You can find details here: https://github.com/github/git-lfs/blob/maste=
r/docs/spec.md#intercepting-git

Can you run `du -hs .git/objects` in your Git repository? This should r=
eport a value well below 16 MB.

Cheers,
Lars
