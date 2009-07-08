From: Fritz Anderson <fritza@uchicago.edu>
Subject: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 10:58:48 -0500
Message-ID: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 18:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOZhm-0000qZ-Hk
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 18:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbZGHQHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 12:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759779AbZGHQHG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 12:07:06 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:34962 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759738AbZGHQHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 12:07:05 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2009 12:07:04 EDT
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n68FwoeO027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 8 Jul 2009 10:58:50 -0500
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122903>

I get the error "fatal: index-pack failed" when I attempt to clone a =20
remote bare repository. The repository works well on other machines, =20
including the repository's own.

The repository lives on a version of Mac OS X I'm not allowed to talk =20
about (I repeat: It works well for working copies on other machines, =20
and on its own). The client is RHEL5. Git is version 1.6.3 on both =20
machines, and was built from the tarball.

Here's the debug transcript:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ sudo GIT_TRACE=3D1 git clone myusername@remote.example.com:/Users/=20
myusername/scientia/scientia.git
trace: built-in: git 'clone' 'myusername@remote.example.com:/Users/=20
myusername/scientia/scientia.git'
Initialized empty Git repository in /srv/scientia/.git/
trace: run_command: 'ssh' 'myusername@remote.example.com' 'git-upload-=20
pack '\''/Users/myusername/scientia/scientia.git'\'''
Password:
trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' '--=20
keep=3Dfetch-pack 17580 on local.example.com'
trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' '--=20
keep=3Dfetch-pack 17580 on local.example.com'
trace: exec failed: No such file or directory
trace: exec 'index-pack' failed: No such file or directory
fatal: index-pack failed
remote: Counting objects: 2797, done.
remote: Compressing objects: 100% (2388/2388), done.
$
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

/Users/myusername/scientia/scientia.git on remote is a symlink to =20
a .git repository on another volume. I've verified that the path is =20
valid.

One post I saw via Google said that attempting to clone large files =20
can choke the process. I've done git-rm on my largest, reconstructable =
=20
files, to no effect. (Though I suppose it does no good wrt the files =20
that are still in the history.)

I've fooled around with git-verify-pack without result.

Prior to all this, my last push to the repository failed with =20
"[rejected] ... non-fast forward". I got past that with a "git push --=20
force".

How can I get the clone done?

	=97 F
