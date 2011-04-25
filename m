From: Siddique Hameed <siddii@gmail.com>
Subject: Re: GIT cloning(or pull/push) doesn't work properly if you have a
 sub-folder as its own GIT repo
Date: Mon, 25 Apr 2011 17:34:13 -0500
Message-ID: <BANLkTik+CStXOOdk7JY6UmB0xDP+FKrEUA@mail.gmail.com>
References: <BANLkTi=YsEr9hOz7-u_t3BJUiMt+34P+ZA@mail.gmail.com> <4DB3D863.4080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:34:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEUMa-0004Nf-Vb
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 00:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757014Ab1DYWef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2011 18:34:35 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48010 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969Ab1DYWef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 18:34:35 -0400
Received: by yia27 with SMTP id 27so32734yia.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Cll1PUuhGQ/uJ3FDq5vsGWrqPqz8Aya2lcNVxMxaFos=;
        b=fSOrzyHvgpt8hmHXn1VNubEuRL9APhWF88TcS5zNriixgHjFAcRTI4IwHt2n9vYd1m
         1TuNRhv/M4v6nYGOfayCQZcWrV3w6WVRnmfw/oIYgJjJZXkHNI/eN0f3d3tqeaxZGIPe
         u/46xRkeRbF2CX0k1EGridRQ2Q7HaGjA+shX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iVg88Y4VWvyQtopqewPSleQYP0lB8CF+A+9UU6/QqjfHoMdb4qba5BavnT2kMCGcVm
         mWrx0QOVA0oyDzqHFZZIDx9tyLPunkVZvJ6HZwYQ2QHvdmXBOfogfQFvaIkh41A4XMVf
         Ij5SzAqxlITh3H0MGwl36cZzXfkkpZIONoSE8=
Received: by 10.90.23.17 with SMTP id 17mr64177agw.147.1303770874081; Mon, 25
 Apr 2011 15:34:34 -0700 (PDT)
Received: by 10.90.113.17 with HTTP; Mon, 25 Apr 2011 15:34:13 -0700 (PDT)
In-Reply-To: <4DB3D863.4080500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172052>

Hi Chris,

Thanks for your response. I figured out what I was doing wrong -
http://groups.google.com/group/git-users/browse_thread/thread/d34523680=
b0ad093

On Sun, Apr 24, 2011 at 2:59 AM, Chris Packham <judge.packham@gmail.com=
> wrote:
> On 24/04/11 05:04, Siddique Hameed wrote:
>>
>> I don't want to categorize this as bug until I hear expert panel's
>> opinion. Spare me if its a known issue or if I am doing something
>> silly :) I did enough research online and couldn't find a good answe=
r.
>
> Not exactly an expert but I'll try to help.
>
>> Here it goes..
>>
>> Let's say if I have a folder called "ParentGITRepo" which is a local
>> GIT repo. I have sub folders called "Child1Repo" and "Child2" with
>> some files on it. For some reason, whether accidentally or
>> deliberately, I make "Child1Repo" a GIT repo on its own. GIT
>> recognizes ParentGITRepo& =A0Child1Repo as separate GIT repositories=
=2E
>> But, if I clone "ParentGITRepo" into somewhere else, I am missing
>> everything from Child1Repo.
>
> That's expected behaviour as far as I'm concerned (based on your exam=
ple).
> ParentGITRepo and Child1Repo are completely independent at this point=
=2E
> Cloning ParentGITRepo won't get you any untracked files that happen t=
o be in
> the work-tree of the repository you're cloning.
>
>> The worse thing is, even if I cleanup
>> "Child1Repo" by removing it's .git folder, the parent GIT repo is
>> ignoring any activity I do in that folder.
>
> So your options at this point are to make Child1Repo a submodule or t=
o
> re-write ParentGITRepo and Child1Repo into a new repository combining=
 the
> history of both. Depending on your exact needs one option may be bett=
er than
> the other so do some more googling to find something that suits your =
case.
>
>> I think, the right way to do this setup is probably using git sub
>> modules or something. But given this scenario, what is the expected
>> behaviour? Am i missing? It would really make more sense if you can =
go
>> thro the following steps (test cases) outlined below.
>>
>>
>> # Setting up ParentGITRepo& =A0Child1Repo and Child2
>> $ cd ~
>> $ mkdir ParentGITRepo
>> $ cd ParentGITRepo/
>> $ git init .
>> $ mkdir Child1Repo
>> $ mkdir Child2
>> $ cd Child1Repo/
>> $ git init .
>> $ echo "Child1RepoFile"> =A0Child1RepoFile.txt
>> $ git add .
>> $ git commit -a -m "Adding Child1Repo content"
>
> At this point you could have just treated Child1Repo as a normal
> subdirectory. One thing some people struggle with is the fact that gi=
t
> doesn't track empty directories, as soon as there a files in those
> directories it'll work just fine.
>
>> [master (root-commit) 01ccc52] Adding Child1Repo content
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Child1RepoFile.txt
>>
>> $ cd ../Child2/
>> $ echo "Child2 file content"> =A0Child2File.txt
>> $ cd ..
>> $ echo "Parentfile"> =A0ParentFile.txt
>> $ git add .
>> $ git commit -a -m "Adding Parent content"
>> [master (root-commit) b31d0a5] Adding Parent content
>> =A03 files changed, 3 insertions(+), 0 deletions(-)
>> =A0create mode 160000 Child1Repo
>> =A0create mode 100644 Child2/Child2File.txt
>> =A0create mode 100644 ParentFile.txt
>>
>> ---------------------------------------
>> =A0# Now verify ParentGITRepo& =A0Child1Repo working independently
>> $ cd ~/ParentGITRepo/
>> $ git log
>> commit b31d0a5aef19c6b119d89718f560905ad0f34aa7
>> Author: Siddique Hameed<siddii+git@gmail.com>
>> Date: =A0 Fri Apr 22 11:25:15 2011 -0500
>>
>> =A0 =A0Adding Parent content
>>
>> $ cd ~/ParentGITRepo/Child1Repo/
>> $ git log
>> commit 01ccc52931f8b40f6d92b29769300a254d8dd411
>> Author: Siddique Hameed<siddii+git@gmail.com>
>> Date: =A0 Fri Apr 22 11:22:00 2011 -0500
>>
>> =A0 =A0Adding Child1Repo content
>>
>> --------------------------------------------
>>
>> # Now try cloning ParentGITRepo& =A0verify the contents inside it
>> $ cd ~
>> $ git clone ParentGITRepo/ ParentGITRepoClone/
>> Cloning into ParentGITRepoClone...
>> done.
>> $ cd ParentGITRepoClone/
>> $ ls -a
>> ./ =A0../ =A0.git/ =A0Child1Repo/ =A0Child2/ =A0ParentFile.txt
>>
>> $ cd Child1Repo/
>> $ ls -a
>> ./ =A0../
>>
>> $ git log
>> commit b31d0a5aef19c6b119d89718f560905ad0f34aa7
>> Author: Siddique Hameed<siddii+git@gmail.com>
>> Date: =A0 Fri Apr 22 11:25:15 2011 -0500
>>
>> =A0 =A0Adding Parent content
>>
>> --------------------------------------------
>>
>> As you can see there is nothing in Child1Repo after its was cloned. =
I
>> also tried the reverse of this. Like, having a child folder as GIT
>> repo and make a ParentFolder a repo on its own& =A0clone the parent
>> folder and the cloned folder doesnt contain anything from child repo=
=2E
>>
>> Let me know if you have more questions.
>>
>> Thanks,
>>
>> Siddique
>> --
>
