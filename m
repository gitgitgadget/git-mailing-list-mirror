From: =?windows-1251?B?0fLu6ffuINHr5e/27uI=?= 
	<stoycho.sleptsov@gmail.com>
Subject: git list files
Date: Sun, 13 Jan 2013 14:05:45 +0200
Message-ID: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:06:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMKF-0006Vw-I3
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab3AMMFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 07:05:47 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33834 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab3AMMFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:05:46 -0500
Received: by mail-lb0-f178.google.com with SMTP id l5so2322052lbo.9
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CNKSDzasg//dyPIpemeKoqfIDx/MXN1agTy4nAr6JLY=;
        b=I4BvquP/eULZ+0+RstyfNWOHa1Sl1ghXsxiSrFIattJwVmjqXwTvhrEzd8uaMf6LL4
         fidPClfW+d34FsLaz+yzyuBiP71858ZueowemPDe+UTiaORQwDT/B5Nmn1e6HovPaF7h
         210sME48c7E1YKcP/yBDPXaHh35wD0jbb3RIUYWvksvnVozoq3Z3cndescJGqy6i9f9K
         GvTwwFrjdQ3G9BoATBZOqcLvCyfbWmYXmEELVcS3EGer+XNuVLdoZ/jItVxErLsTLL7y
         0/ElFS4379hRSON/FkhXkf0K+m37Zok/mgPgHQOwpIkUo6fMG+7pX8WUkPmv/Kl0utG2
         lCww==
Received: by 10.112.86.232 with SMTP id s8mr33706991lbz.86.1358078745096; Sun,
 13 Jan 2013 04:05:45 -0800 (PST)
Received: by 10.112.60.36 with HTTP; Sun, 13 Jan 2013 04:05:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213337>

Hi,

I was searching for some git- command to provide me a list of files
(in a git directory), same as ls,
but showing information from the last commit of the file instead.

lets, say the equivalent of the $ls -d b* within git.git root directory
would look like:

----------------
98746061 jrnieder 2010-08-12 17:11 Standardize-do-.-while-0-style   base85.c
c43cb386 pclouds  2012-10-26 22:53 Move-estimate_bisect_steps-to-li bisect.c
efc7df45 pclouds  2012-10-26 22:53 Move-print_commit_list-to-libgit bisect.h
837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla blob.c
837d395a barkalow 2010-01-18 13:06 Replace-parse_blob-with-an-expla blob.h
ebcfa444 gitster  2012-07-23 20:56 Merge-branch-jn-block-sha1       block-sha1
d53a3503 pclouds  2012-06-07 19:05 Remove-i18n-legos-in-notifying-n branch.c
f9a482e6 peff     2012-03-26 19:51 checkout-suppress-tracking-messa branch.h
c566ea13 gitster  2013-01-11 18:34 Merge-branch-jc-merge-blobs      builtin
cf6c52fc gitster  2013-01-10 13:46 Merge-branch-jc-maint-fmt-merge- builtin.h
568508e7 gitster  2011-10-28 14:48 bulk-checkin-replace-fast-import
bulk-checkin.c
568508e7 gitster  2011-10-28 14:48 bulk-checkin-replace-fast-import
bulk-checkin.h
8c3710fd gitster  2012-06-04 11:51 tweak-bundle-verify-of-a-complet bundle.c
b76c561a gitster  2011-10-21 16:04 Merge-branch-jc-unseekable-bundl bundle.h
----------------

(pretty the same idea as what we see in github when reviewing a
repository under the "Files" tab.)

Unfortunately I couldn't find any suitable.

As suggested at http://git-scm.com/community I asked my question at
the "Git user mailing list on Google Groups which is a nice place for
beginners to ask about anything",
and one of the valuable answers was:

"Also I wouldn't hesitate to ask this question on the main Git list as
this question appears to be hard-core enough to warrant assisting of
someone knowledgeable about Git internals."

So here I am...

So is there such a command, or I have to build my own script, starting
from, lets say git-rev-list in addition with some diff?

At the beginning I was hoping that $git rev-list HEAD --no-walk
--all-match -- <paths> + some git status --porcelain could do the job
for me,
but seems git rev-list, same as git log stops at the first found
matching commit, without to take care that there are still more files
unsatisfied in the list...

isn't it supposed to satisfy all the files in the list when
--all-match -- <paths> are given?

Thank you in advance,
Blind.
