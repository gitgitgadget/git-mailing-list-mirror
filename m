From: lytles <srlytle.list@gmail.com>
Subject: push fails -- temporary sha1, no such file / corruptiion ???
Date: Tue, 21 Jul 2009 19:21:59 -0700 (PDT)
Message-ID: <1248229319591-3297467.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 04:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTRT8-00032F-4h
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZGVCWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755805AbZGVCWA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:22:00 -0400
Received: from kuber.nabble.com ([216.139.236.158]:36873 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbZGVCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:21:59 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1MTRSx-0000Bf-JF
	for git@vger.kernel.org; Tue, 21 Jul 2009 19:21:59 -0700
X-Nabble-From: srlytle.list@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123731>


i have a "centralized" bare repository, and 2 local clones. i make changes on
the local clones and push the changes (to origin). i'm using ssh as my
transport. this has been working for about a year, but i don't make frequent
commits

today i tried to push to origin (from both a remote machine, and the machine
on which the central repo lives), and the push failed:

--------------------------------------------------------------------------------------------------------------------------------
# git push
Counting objects: 3, done.
Compressing objects: 100% (2/2), done.
error: unable to create temporary sha1 filename ./objects/2f: No such file
or directory

fatal: failed to write object
Writing objects: 100% (2/2), 260 bytes, done.
Total 2 (delta 1), reused 0 (delta 0)
error: unpack failed: unpacker exited with error code
To /home/*****/repos/git/home.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to '/home/*******/repos/git/home.git'
--------------------------------------------------------------------------------------------------------------------------------

the "object/2f" varies with attempts to push from different remote repos,
but it's always an "object/??". multiple attempts to push from the same
remote repo always results in the same "object/??"

git version 1.6.0.4
ubuntu 9.04 (jaunty)
amd64

"git fsck --full" doesn't return any errors for either the remote or the
central repos. a fresh clone of the central repo results in the same error
when i attempt to push. cloning the remote repos works, and pushes succeed.
i did a /forcefsck and didn't see any errors (but also couldn't find any
real logs - hidden by the splash screen i guess)

i'm not sure which version of git was used to create the repository, but it
was probably 1.5.4 (ie, ubuntu hardy). incidentally, i have another
repository "triplet" that i use for a different set of code that is working
fine, that was created and used with the same machines/toolchains/versions

any idea what is going wrong ???


-- 
View this message in context: http://n2.nabble.com/push-fails----temporary-sha1%2C-no-such-file---corruptiion-----tp3297467p3297467.html
Sent from the git mailing list archive at Nabble.com.
