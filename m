From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Q. regarding subtree merge
Date: Fri, 18 Apr 2008 12:09:54 +0200
Message-ID: <8aa486160804180309o26ab9c69j2b3b665a280bf7c4@mail.gmail.com>
References: <loom.20080418T091729-407@post.gmane.org>
	 <8aa486160804180302m43a7c942la93954401741b264@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Stefan_N=E4we?=" <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 16:09:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmnYJ-0005OL-OW
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 12:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbYDRKJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 06:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461AbYDRKJ6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 06:09:58 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:20366 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbYDRKJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 06:09:57 -0400
Received: by yw-out-2324.google.com with SMTP id 5so323391ywb.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vKdpDooLJPosoOK/Yny7RWJLnuTcfeGyEexd+7aEmX4=;
        b=bpQBcrmkYWWqmYKhF2TBumFdCMUtxbRz+85tcJPxqaG6ImxyB1hYOoxkyEXkd0M1LFFKEqrPsA3b5afe9HO3xhaTdq1seaeY8V57ZlkM/WtRd9VWPP8j1oJ2ZyQTDeij9Zs8WOywFRXhtEVyyT5Z58INCrNtH3vrpTC83PbFoow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oRuUG8vRl6rc2GnLUoeNTGgqGIbHqjFyfzsy0n431oFYIlVV9rgvK5t1e6COqHJ8Q+o6yglKAcurTFTYHENreDyvrHuKHngXpi2Ke9WeoxCvtyUjnmuNqian98YsWEOPGeALl1L9hhz/+UNK6lV1Qz2um1L2dSimkIZ6jVIj0Lc=
Received: by 10.151.44.18 with SMTP id w18mr3301061ybj.246.1208513394607;
        Fri, 18 Apr 2008 03:09:54 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Fri, 18 Apr 2008 03:09:54 -0700 (PDT)
In-Reply-To: <8aa486160804180302m43a7c942la93954401741b264@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79864>

On Fri, Apr 18, 2008 at 12:02 PM, Santi B=E9jar <sbejar@gmail.com> wrot=
e:
>
> On Fri, Apr 18, 2008 at 11:36 AM, Stefan N=E4we
>  <stefan.naewe+git@gmail.com> wrote:
>  > Hi all.
>  >
>  >  I tried the scenario described in
>  >  $GIT_DIR/Documentation/howto/using-merge-subtree.txt and have som=
e problems
>  >  with it.
>  >
>  >  My setup:
>  >
>  >  I use git to track my changes in three different "project directo=
ries", lets
>  >  say:
>  >
>  >  ...../src_root/libfoo
>  >  ...../src_root/appbar
>  >  ...../bin_root/installed
>  >
>  >  All three git repositories contain a topic branch (lets say 'curr=
ent-work')
>  >  that I want to track.
>  >
>  >  Now I want to setup one git repository containing only the three =
directories
>  >  'libfoo', 'appbar', and 'installed' that others can clone easily.=
 Reading the
>  >  above howto document, I think this should be possible.
>  >
>  >  I do:
>  >
>  >   $ mkdir super-prj
>  >   $ cd super-prj
>  >   $ git init
>  >   $ git add remote -f libfoo ../path/to/src_root/libfoo
>  >
>  >  OK. No problem.
>  >
>  >  The problem arises after the second step of the howto:
>  >
>  >   $ git merge -s ours --no-commit libfoo/current-work
>  >
>  >  Now, all files of 'libfoo' are in the current directory. This is =
not what I
>  >  want.
>  >
>  >  Could someone please tell me what I'm doing wrong?
>
>  You are trying to merge libfoo with an empty project, so the merge
>  just "fast-forward" to the other commit as you do not have an "ours"=
=2E
>
>  Simply skip the merge step.

Ups, I think you have to specify the parent for the new commit. Maybe
change the merge step with:

$ git reset --soft libfoo/current-work

Santi
