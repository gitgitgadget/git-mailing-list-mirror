From: Fritz Anderson <fritza@uchicago.edu>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 15:23:19 -0500
Message-ID: <7A134415-D275-4638-9674-5BCC18A14BC4@uchicago.edu>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <7viqi386th.fsf@alter.siamese.dyndns.org> <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu> <7vskh76pui.fsf@alter.siamese.dyndns.org> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu> <7vd48b6md8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOdg5-0005FE-Cl
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 22:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240AbZGHUXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 16:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbZGHUXb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 16:23:31 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:37924 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbZGHUXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 16:23:31 -0400
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n68KNLDt024170
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2009 15:23:21 -0500
In-Reply-To: <7vd48b6md8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122917>

On Jul 8, 2009, at 1:49 PM, Junio C Hamano wrote:

> Could you try your original (non-working) command with this debug =20
> patch?


(I had to apply the patch by hand; RHEL patch complained about a =20
malformatted patch file.)

=3D=3D=3D=3D=3D
$ sudo GIT_TRACE=3D1 git clone username@remote.example.com:/Users/=20
username/scientia/scientia.git
trace: setup_path: the $PATH was: /usr/bin:/bin
trace: setup_path: the $PATH is now: /usr/local/libexec/git-core:/usr/=20
bin:/bin
trace: built-in: git 'clone' 'username@remote.example.com:/Users/=20
username/scientia/scientia.git'
Initialized empty Git repository in /home/username/git-1.6.3/=20
scientia/.git/
trace: run_command: 'ssh' 'username@remote.example.com' 'git-upload-=20
pack '\''/Users/username/scientia/scientia.git'\'''
Password:
trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' '--=20
keep=3Dfetch-pack 32503 on scientia.uchicago.edu'
trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' '--=20
keep=3Dfetch-pack 32503 on scientia.uchicago.edu'
trace: exec failed: No such file or directory
trace: the $PATH was: /usr/local/libexec/git-core:/usr/bin:/bin
trace: exec 'index-pack' failed: No such file or directory
fatal: index-pack failed
remote: Counting objects: 2802, done.
remote: Compressing objects: 100% (2393/2393), done.
=3D=3D=3D=3D=3D

As a reminder:
=3D=3D=3D=3D=3D
$ sudo /usr/local/bin/git --exec-path
/usr/local/libexec/git-core
=3D=3D=3D=3D=3D

	=97 F
