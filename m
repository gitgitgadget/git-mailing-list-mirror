Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC6DC433DF
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8515820717
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ryHCD+3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGSGcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:32:03 -0400
Received: from mout.web.de ([212.227.15.3]:41417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSGcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 02:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595140317;
        bh=IwLRegYZpXl9F3MmD1sI0Z4DiCDZivWbfyXpYn7kJf8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ryHCD+3ponFNLERO8d+uGaRsRHhVhegqgqemkLeD0NVV7aPpQmHfReW063j0ZIbfv
         jvyJ20Ims3gQ+jP70f5ZdMDJkgE+dIFDZYXe/jJUlE5Pv70fG603nZ47dJ+NnvV1oO
         6N77dgundd+f2r1fhRejHEU/bs3qcKfPphRthRus=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lgs1W-1kb2mh1IlK-00oEeg; Sun, 19
 Jul 2020 08:31:57 +0200
Date:   Sun, 19 Jul 2020 08:31:56 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Paul D. Smith" <Paul.D.Smith@metaswitch.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git bug - Windows subst/net use, Windows drive letter prefix
Message-ID: <20200719063156.rm6tr3m43enxsxg4@tb-raspi4>
References: <DM6PR02MB52762B49AFBA042B541CE039BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
 <DM6PR02MB52769C88FFC893FE3D44E901BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
 <DM6PR02MB5276FB15B1E9E66E98A0B7AFBD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR02MB5276FB15B1E9E66E98A0B7AFBD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:8eMTUAa8fPYYvQGmJKRd87Vt3yTcPbijSWG8qGnQTKJiATEjpOR
 2JtdbNuo66yiGEEc7xLX6uoU2pqtQ8LSppKMiqJ+MoiPgKDi5R05FvY36IGdEb7bDIQuXNM
 vMz5S0bXjZnyKbjOQXLu8iWrXjhjc/M2554TmYRk0q+Xu5QPVH/5bRu49Awe9eG5hi2So4f
 nAY8lS/hn6cn8nmM7Lwgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QWMm/lhaBFA=:WM0m1XV3Tg4md67AMlmGkF
 wqSP9KJNMQGrBXhqETeeTKbhnEpCGTd5X8DLRs4iFRpMlNHp49Vvr1PHR8N1de2pYvHYdncO7
 975HkOmLndYkqfIpb3hasZonwAC5/FdBn29SB/hV8de8PXz0vz7IleTh80Ft4aKW7suMdw7Ch
 VQefMPljBHQRXT6RcgPcaCIsjq2ppCskIvMT9np0MC1/Mx7Em9LITJJRaq0cM5a5nSLU1R5So
 /XT9dbi/92ovK7j9TkGJlCxVjCMLyRlgDGYvlWcllNmGSk4Vch+JPA11VghxKLbM1azvOGSip
 Cs2bT0gsXSKkNr843asAOkl25RsTXHDQ73B1KN+qo3+SfCoYP8y7StnIe0KPw95NOSVI8QdQw
 Z15RXHBLgTzFbl5ChEPxwAO5vFmOJYRNOAvnJOo6TXKNcVK6ccTwl5TIo3F1eoLLC/3DBFyeI
 f01emw9LZ/Asg0ITN0aCI0bgK81uqiqOyxpm9RaU7cvcR62/VZMHoqPr3wnDbGim04ccniPzg
 CFs2+q755I+VljBpiwPXmYSWwNwmfzAHd6nrOnAcu5m/ie9kZMcQTH6uChFfS70iIG2MS1WZ4
 mZ25Mc6YQpj7Hde2IE0om/dVm73fXNJu0JDa0LZ+g5fCTzHVNmitnVzCVL91ehJR0VZ/aoQfU
 iVp/kF4OtllmtVhL2HCqgAf6Bzw/EL6fYwKULq+CWJQs4GSusUJtKTv7tku0QGP7/+Gme5iNo
 eEI6X8DmJqDzYQFYzueCvXpPVgjDNb8IpvbUaPOBPdMwQP1yHWF5RZcD64VJVqrcLNdM0q85k
 iB8PYIBRKiMsH3J8ZaA4gCb1WQpbQly3QFDeqfI3SKsoPab+bF9DViMOGR/enjYKFypGHmTIz
 Xtn0IXLerKAA83sGjfyCHXiRcWTUxNTG8aDpmLjDLLVgLwx2OA0shG/ZRBEC2zZSfonSH60sx
 XHBobTtPY9CSlDLK7yCXsbuRa/+8AL9Fq6X1XO1DGYoOkdvw4rXKZPY2F3vI1DXlj4FzZMjGm
 0dAbLHHewrMC0DW+9OzTKR4EoPdu8IBYfsqyGsM/0wU6q0f8+6TzxKWRSZ735nWDPLEGR3jLa
 dTF3YJsNbSxrYSi2ZaeU9OtmS246gB7B5p1IGnuZbaZ7DQDOYBdkzzLt3Sze5L811+oHpWDgU
 zy1GnYIPoYyTItEa1dU1fyZaym/V5Us7s8yiu/+216qXp9L7mBpxhO7P3NpRiJ0rRGByORtCM
 K6hMaw+XlR0n+WSKF
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 11:03:22AM +0000, Paul D. Smith wrote:
> I believe there is a subtle bug in Git that can mean that a "git add" fa=
ils, complaining that "fatal: <filename>: '<filename>' is outside reposito=
ry at '//<server>/<share>/<directory> /'
>
> It may be possible to reproduce this with simpler steps, but this is wha=
t I have that fails.
>
> 1. A Git repo on system <server> below directory <directory> that can be=
 reached via the Windows share <share>
> 2. On a second system, perform "net use z: file://%3cserver%3e/%3cshare>=
"
> 3. Now you can "cd /d z:\<directory>" and run "git status" quite happily
> 4. At this point I can also so this:
> 	a. "cd /d z:" then "git add <z:\some-changed-file>"
> 		i. Note the drive letter prefixing the full-filename
> 5. Now do a subst or a net use as follows:
> 	a. subst v: z:\directory
> 	b. net use w: file://%3cserver%3e/%3cshare%3e/%3cdirectory>
> 6. You can do both of these
> 	a. "cd /d v:" then "git status"
> 	b. "cd /d w:" then "git status"
> 7. However both of these FAIL:
> 	a. "cd /d v:" then "git add <v:\some-changed-file>"
> 	b. "cd /d w:" then "git add <w:\some-changed-file>"
> 		i. Note the drive letter prefixing the full-filename
> 8. Performing the above requests WITHOUT the drive letter prefixing the =
filename works!
>
> I assume that this is supposed to work and there is some subtle error me=
rging the repository root and the filename-with-drive-prefix.
>
> Regards,
> Paul D.Smith.
>

Thanks for reporting your issue.
It's good to get well-written reports like this.

As a general note, this is specific to the "Git for Windows" project,
and issues can be reported there:
https://github.com/git-for-windows/git

More specific, I could reproduce the issue without using a network:

C:
cd Users/tb
mkdir 200719-git-test-subst
cd 200719-git-test-subst
git init
echo FILE >FILE.txt

Now I can use
git add C:\Users\tb\200719-git-test-subst\FILE.txt

That surborised me a little bit, since an absolute path name was given to =
Git.
However, Git is able to figure out, that

C:\Users\tb\200719-git-test-subst\FILE.txt
is the same as
FILE.txt

as you can see running
git ls-files

The file names (and path components) in Git are always tracked "relative".
Relative to the root of the Git repo.
And here Git translates
"C:\Users\tb\200719-git-test-subst\FILE.txt" into "FILE.txt"

In that sense, drive letters are not trackesd at all, you can clone that r=
epo to any drive
letter, or even to a network share.

If I now use
subst T: C:\Users\tb\200719-git-test-subst

I can use the same repo under T:\

file/path names are still relative, so if you change into T:\
and run
git ls-files
you will still see FILE.txt

Now mixing those 2 does not work.
Git is unable to figure out the "T:\" is the same as "C:\Users\tb\200719-g=
it-test-subst"

In general, different drive letters host different file systems, so Git as=
sumes that
they don't point to the same directory.

Adding this functionality may be possible, I don't know the Windows APIs g=
ood enough.
But:
That will cost sone time (in terms of development) and give a run-time pen=
alty for
Git itself for many Git invocations.
It may even open up for security issues, since the "check if X: is the sam=
e as Y:"
needs to be done in one step, and the the operation needs to be done in th=
e next
step, opening a small timing window, where bad things may happen.

This was my limited view on how things work, there may be details missed (=
or wrong).




