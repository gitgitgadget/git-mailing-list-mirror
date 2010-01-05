From: Dongas <dongas86@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 5 Jan 2010 12:30:03 +0800
Message-ID: <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
	 <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 05:30:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS13j-0008JU-FW
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 05:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab0AEEaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 23:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463Ab0AEEaI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 23:30:08 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51896 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0AEEaH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 23:30:07 -0500
Received: by ywh6 with SMTP id 6so16061134ywh.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 20:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=okFZSak+V7iLVCrz65dLPl7Pr1beAX6jjygU92oM0JI=;
        b=HK6LuzsuEshjryM5nygRVSOZ9DQjubG5X4CFD58Xt7ztlhZ0BMo1fP8mOvHDNszuOQ
         /2XKUq1ze5yxREWQBaMub+ogZhP4LBmO/ptkwDtvhc1MY9aal0bpUEtj1DoniZyjT6y2
         59e+M2VwoCmXfmIZ5IyWvC2/UlzpzyoOWoJlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g0DFoO7E6GHAN2BwaoGamvbjBoe/qvBSRFQ/CSileITiKfItKfnOTn7qsLm+aGTEkg
         r9aJhMDahW7ZS4hAC1cmDpIwBFtFwOMA+QAl5ytPH8B6IQTHaR0GEprylnSAx1sh3e6K
         q9jtgiKs1dVgQa57eNJ/nM8py76qjeesOyuH4=
Received: by 10.90.163.17 with SMTP id l17mr10637819age.101.1262665803984; 
	Mon, 04 Jan 2010 20:30:03 -0800 (PST)
In-Reply-To: <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136159>

2010/1/5 Russell Steicke <russellsteicke@gmail.com>:
> On Mon, Jan 4, 2010 at 2:45 PM, Dongas <dongas86@gmail.com> wrote:
>> So i need to change the remote name manually.
>>
>> I tried modifying the .git/config file locally but it didn't work.
>>
>> Could someone help tell how to do it?
>
> After editing .git/config, do this:
>
> $ mv .git/refs/remotes/OLDNAME .git/refs/remotes/NEWNAME
>
> and optionally:
>
> $ mv .git/logs/refs/remotes/OLDNAME .git/logs/refs/remotes/NEWNAME
>
> Remember to rename the remote in any tracking branches in .git/config=
,
> as well as the name in the [remote "OLDNAME"] section, and the name i=
n
> any fetch and push lines. =A0ie
>
> [remote "OLDNAME"]
> =A0 =A0 =A0 =A0url =3D something
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/OLDNAME/*
> [branch "master"]
> =A0 =A0 =A0 =A0remote =3D OLDNAME
> =A0 =A0 =A0 =A0merge =3D refs/heads/master
>
> Becomes
>
> [remote "NEWNAME"]
> =A0 =A0 =A0 =A0url =3D something
> =A0 =A0 =A0 =A0fetch =3D +refs/heads/*:refs/remotes/NEWNAME/*
> [branch "master"]
> =A0 =A0 =A0 =A0remote =3D NEWNAME
> =A0 =A0 =A0 =A0merge =3D refs/heads/master

Thanks a lot, Russell.
I followed you instruction but it seemed it needs more changes.

Below are the steps:
Original:
root@ubuntu:/work/git-repo/free_monkey# tree -a
=2E
|-- .git
|   |-- HEAD
|   |-- branches
|   |-- config
|   |-- description
|   |-- hooks
|   |   |-- applypatch-msg.sample
|   |   |-- commit-msg.sample
|   |   |-- post-commit.sample
|   |   |-- post-receive.sample
|   |   |-- post-update.sample
|   |   |-- pre-applypatch.sample
|   |   |-- pre-commit.sample
|   |   |-- pre-rebase.sample
|   |   |-- prepare-commit-msg.sample
|   |   `-- update.sample
|   |-- index
|   |-- info
|   |   `-- exclude
|   |-- logs
|   |   |-- HEAD
|   |   `-- refs
|   |       |-- heads
|   |       |   `-- master
|   |       `-- remotes
|   |           `-- origin
|   |               `-- HEAD
|   |-- objects
|   |   |-- info
|   |   `-- pack
|   |       |-- pack-f4beae76253ca8d36af31c42320462b5cf4940fc.idx
|   |       `-- pack-f4beae76253ca8d36af31c42320462b5cf4940fc.pack
|   |-- packed-refs
|   `-- refs
|       |-- heads
|       |   `-- master
|       |-- remotes
|       |   `-- origin
|       |       `-- HEAD
|       `-- tags
`-- hello1

root@ubuntu:/work/git-repo/free_monkey# cat .git/config
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "origin"]
	url =3D git@192.168.1.116:free_monkey.git
	fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master
root@ubuntu:/work/git-repo/free_monkey#

Execute your steps....
Becomes:
root@ubuntu:/work/git-repo/free_monkey# tree -a
=2E
|-- .git
|   |-- HEAD
|   |-- branches
|   |-- config
|   |-- description
|   |-- hooks
|   |   |-- applypatch-msg.sample
|   |   |-- commit-msg.sample
|   |   |-- post-commit.sample
|   |   |-- post-receive.sample
|   |   |-- post-update.sample
|   |   |-- pre-applypatch.sample
|   |   |-- pre-commit.sample
|   |   |-- pre-rebase.sample
|   |   |-- prepare-commit-msg.sample
|   |   `-- update.sample
|   |-- index
|   |-- info
|   |   `-- exclude
|   |-- logs
|   |   |-- HEAD
|   |   `-- refs
|   |       |-- heads
|   |       |   `-- master
|   |       `-- remotes
|   |           `-- karmic
|   |               `-- HEAD
|   |-- objects
|   |   |-- info
|   |   `-- pack
|   |       |-- pack-f4beae76253ca8d36af31c42320462b5cf4940fc.idx
|   |       `-- pack-f4beae76253ca8d36af31c42320462b5cf4940fc.pack
|   |-- packed-refs
|   `-- refs
|       |-- heads
|       |   `-- master
|       |-- remotes
|       |   `-- karmic
|       |       `-- HEAD
|       `-- tags
`-- hello1

root@ubuntu:/work/git-repo/free_monkey# cat .git/config
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "karmic"]
	url =3D git@192.168.1.116:free_monkey.git
	fetch =3D +refs/heads/*:refs/remotes/karmic/*
[branch "master"]
	remote =3D karmic
	merge =3D refs/heads/master

But the result was:
root@ubuntu:/work/git-repo/free_monkey# git branch -a
* master
  karmic/HEAD
  origin/master
The 'origin/master' was still not changed.

I did a few more steps:
root@ubuntu:/work/git-repo/free_monkey# grep -wrin 'origin' .
=2E/.git/packed-refs:2:abfae429bb4081043e84681e5ee94102085f87e0
refs/remotes/origin/master
=2E/.git/refs/remotes/karmic/HEAD:1:ref: refs/remotes/origin/master

Change 'origin' to 'karmic' in above files.

Then,
root@ubuntu:/work/git-repo/free_monkey# git branch -a
* master
  karmic/HEAD
  karmic/master

The steps are a little complicated.
Do you know if there's a way to rename the remote on server side?
If there is, then everyone could just clone the project with a new
remote name rather than the defaul 'origin'.


Thanks

Regards
Dongas
