From: Jeff Adamson <jwa@urbancode.com>
Subject: Debugging Git push failure
Date: Wed, 9 Feb 2011 13:57:11 -0500
Message-ID: <AANLkTimcGtDKZ2YU0Z_pc-aRtp-etXFWZ9-drSzpS3KN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 19:57:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnFEe-000067-By
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 19:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955Ab1BIS5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 13:57:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36651 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1BIS5n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 13:57:43 -0500
Received: by fxm20 with SMTP id 20so520670fxm.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 10:57:41 -0800 (PST)
Received: by 10.223.95.202 with SMTP id e10mr10611542fan.32.1297277861665;
 Wed, 09 Feb 2011 10:57:41 -0800 (PST)
Received: by 10.223.127.18 with HTTP; Wed, 9 Feb 2011 10:57:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166434>

Several developers on my team are experiencing an occasional failure
during push. =A0A subsequent push executed immediately afterward the
failure will work fine. =A0We are a small team of developers (about 10)
and only a couple users seem to experience this and then only
intermittently (every few days).
This is happening on a LAN environment with otherwise reliable
connectivity. =A0We have some hook scripts for post-update and update
configured within the repo.

the server has git=A0version 1.7.3.3 installed
$ cat /etc/issue
CentOS release 5.5 (Final)
Kernel \r on an \m
$ uname -a
Linux=A0core1.example.com=A02.6.18-194.26.1.el5 #1 SMP Tue Nov 9 12:54:=
20
EST 2010 x86_64 x86_64 x86_64 GNU/Linux

Here is some output from one of the users during two sequential runs
of `git push -v`. =A0This user is=A0git version 1.7.3.1.msysgit.0 (thou=
gh
similar behavior has been seen by another user with version 1.7.0.4 on
ubuntu 10.04 LTS)
>git push -v
Pushing to ssh://git.example.com/data/git/example/scratch/bdd/cssearch-=
mockup.git
Counting objects: 9, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 505 bytes, done.
Total 5 (delta 4), reused 0 (delta 0)
fatal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly
>git push -v
Pushing to ssh://git.example.com/data/git/example/scratch/bdd/cssearch-=
mockup.git
Counting objects: 9, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 505 bytes, done.
Total 5 (delta 4), reused 0 (delta 0)
To ssh://git.example.com/data/git/example/scratch/bdd/cssearch-mockup.g=
it
=A0 bffa1a7..8fd772d =A0master -> master


Anyone know what could be causing this and, just as important, how to
debug it and issues like it in the future?
Thanks for any help/insight which can be offered.
--Jeff
