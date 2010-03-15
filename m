From: Chris Packham <judge.packham@gmail.com>
Subject: Re: merging unmanaged working tree
Date: Mon, 15 Mar 2010 12:58:49 -0700
Message-ID: <a038bef51003151258q2a4ba7dfwe84b29854c03d7eb@mail.gmail.com>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
	 <46a29168.6d880e7c.4b9e296c.483a1@o2.pl>
	 <87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>
X-From: git-owner@vger.kernel.org Mon Mar 15 20:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrGRF-0005ya-NL
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 20:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936634Ab0COT6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 15:58:51 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:62544 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936605Ab0COT6u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 15:58:50 -0400
Received: by pzk38 with SMTP id 38so2473464pzk.33
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 12:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wTdayMd7VmFOri4snfuX3VBr8niw0M2ob1n4Sgm+qzU=;
        b=ORv98t26H3rszh9zvAGfmSwopGKqYZ5svh8/2UX/1sZknbemG51OAFhdGkyFmm7AVz
         SrwByY8su+UYoPEJff61wuxiNdVNzMWTwjv62bI+OjxKYjBTx+T0UdKicMShn7+cXl6a
         J4l277c5hrNtEEALNG6lAFOR69ZihRYM8ck7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W6hkVKZ/Gm8r+10z1WUqqGELIK4WbMzhP1zuzPrFe3s6stPF2l1Th6t9Vqp/pYDNjL
         o/BgGORuHsVJg3LwzXWGuVbmjNAmxaCo+aunxDnUhTP1695xpWVL48PG2eptuVrKkZZD
         miTuU63NYPqZC6QUBfNe3gqa6l2Z6BFspPG5U=
Received: by 10.114.215.2 with SMTP id n2mr5871252wag.141.1268683130046; Mon, 
	15 Mar 2010 12:58:50 -0700 (PDT)
In-Reply-To: <87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142247>

2010/3/15 =C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl>:
> Daniel <mjucde@o2.pl> writes:
>
>>> Is there a method to (dry?) run git-merge to detect conflicts
>>> on:
>>>
>>> * current HEAD (or working tree)
>>> * selected previous revision (the one used to "branch")
>>> * directory tree (or a single file) "branched" with git-archive
>>>
>>> I'd like to synchronize portable working tree but don't want to kee=
p
>>> history in it.
>> Does "git-merge --squash" do what you want? You still need to have
>> the other tree managed by git (even for a while).
>
> Not really. Well, what I want is abit odd so let me try another way
>
> 1. There is a repository (non-bare one) with all changes
> =C2=A0 commited. Commit A.
>
> 2. I take some files put them on my pendrive. I take a note that they=
 come
> =C2=A0 from commit A. I don't clone the repository.
>
> 3. I make changes here (in the repository) and commit them (commits B=
,
> =C2=A0 C, D) and there (on my pendrive).
>
> 4. I want to merge things with something like this
>
> $ git diff3 file1.c(D) file1.c(A) /media/project/file1.c
>
> * file1.c(D) is the lates version in my repository and working tree
> * file1.c(A) is the point where I branched
> * /media/project/file1.c is the unmanaged version of the file with ch=
anges
> =C2=A0I made on the go.
>
> Does git allow to retrieve (to stdout) a particular revision of a sin=
gle
> file? If so I could use "<(git retrieve A file1.c)" bash trick.
>
> Or (this is my goal) is there another way not to keep the whole histo=
ry
> of my repository on the pendrive? Just the changes I made since the
> brnaching point. And then clean (yeah squash, but it's not the same I=
 am
> afraid) everything after merging.
>
> --
> Mi=C5=82ego dnia,
> =C5=81ukasz Stelmach
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

One option, assuming you do record "Commit A" every time you do this,
would be to use a short lived branch to merge your changes back in.

e.g.

git checkout -b work_from_home <sha of commit a>
cp /media/... .
git status # at this point you can check that what you about to commit
is what you intended, and
git commit -a # if it is good
git checkout master
git merge work_from_home # this is where any conflicts would be resolve=
d
git branch -d work_from_home

The downside with this is that it is very likely that your files will
pick up an executable bit from the file system on your pen drive which
will need to be fixed up before you commit them.
