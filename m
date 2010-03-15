From: =?utf-8?Q?=C5=81ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>
Subject: Re: merging unmanaged working tree
Date: Mon, 15 Mar 2010 16:19:24 +0100
Message-ID: <87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
	<46a29168.6d880e7c.4b9e296c.483a1@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 16:25:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCAK-0008VN-SV
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177Ab0COPZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 11:25:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:52897 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965070Ab0COPZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 11:25:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NrCAB-0008Pr-Ho
	for git@vger.kernel.org; Mon, 15 Mar 2010 16:25:03 +0100
Received: from dasa3.iem.pw.edu.pl ([194.29.147.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:25:03 +0100
Received: from lukasz.stelmach by dasa3.iem.pw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:25:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dasa3.iem.pw.edu.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:x9g1s+ANLDz1VPTPVobHgqCQxqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142210>

Daniel <mjucde@o2.pl> writes:

>> Is there a method to (dry?) run git-merge to detect conflicts
>> on:
>>=20
>> * current HEAD (or working tree)
>> * selected previous revision (the one used to "branch")
>> * directory tree (or a single file) "branched" with git-archive
>>=20
>> I'd like to synchronize portable working tree but don't want to keep
>> history in it.
> Does "git-merge --squash" do what you want? You still need to have
> the other tree managed by git (even for a while).

Not really. Well, what I want is abit odd so let me try another way

1. There is a repository (non-bare one) with all changes
   commited. Commit A.

2. I take some files put them on my pendrive. I take a note that they c=
ome
   from commit A. I don't clone the repository.

3. I make changes here (in the repository) and commit them (commits B,
   C, D) and there (on my pendrive).

4. I want to merge things with something like this

$ git diff3 file1.c(D) file1.c(A) /media/project/file1.c

* file1.c(D) is the lates version in my repository and working tree
* file1.c(A) is the point where I branched
* /media/project/file1.c is the unmanaged version of the file with chan=
ges
  I made on the go.

Does git allow to retrieve (to stdout) a particular revision of a singl=
e
file? If so I could use "<(git retrieve A file1.c)" bash trick.

Or (this is my goal) is there another way not to keep the whole history
of my repository on the pendrive? Just the changes I made since the
brnaching point. And then clean (yeah squash, but it's not the same I a=
m
afraid) everything after merging.

--=20
Mi=C5=82ego dnia,
=C5=81ukasz Stelmach
