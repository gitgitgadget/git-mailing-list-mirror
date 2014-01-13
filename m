From: =?utf-8?Q?Damien_G=C3=A9rard?= <damien@iwi.me>
Subject: git-p4: exception when cloning a perforce repository
Date: Mon, 13 Jan 2014 14:37:45 +0100
Message-ID: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 13 14:44:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2hok-0002nX-5t
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 14:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaAMNof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 08:44:35 -0500
Received: from catkin.iwi.me ([91.121.49.159]:56200 "EHLO catkin.iwi.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbaAMNod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 08:44:33 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2014 08:44:33 EST
Received: from imac-de-admin.private.4d.fr (unknown [194.98.194.79])
	(Authenticated sender: damien@iwi.me)
	by catkin.iwi.me (Postfix) with ESMTPSA id B7568A25EC
	for <git@vger.kernel.org>; Mon, 13 Jan 2014 14:37:46 +0100 (CET)
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240360>


Hi !

I am trying to clone a perforce repository via git and I am having the =
following backtrace :

{14:20}~/projects/####:master =E2=9C=97 =E2=9E=AD git p4 clone //depot/=
@all .
Importing revision =E2=80=A6
[...]
Importing revision 59702 (45%)Traceback (most recent call last):
  File "/opt/git/libexec/git-core/git-p4", line 3287, in <module>
    main()
  File "/opt/git/libexec/git-core/git-p4", line 3281, in main
    if not cmd.run(args):
  File "/opt/git/libexec/git-core/git-p4", line 3155, in run
    if not P4Sync.run(self, depotPaths):
  File "/opt/git/libexec/git-core/git-p4", line 3008, in run
    self.importChanges(changes)
  File "/opt/git/libexec/git-core/git-p4", line 2680, in importChanges
    self.initialParent)
  File "/opt/git/libexec/git-core/git-p4", line 2304, in commit
    self.streamP4Files(new_files)
  File "/opt/git/libexec/git-core/git-p4", line 2218, in streamP4Files
    cb=3DstreamP4FilesCbSelf)
  File "/opt/git/libexec/git-core/git-p4", line 482, in p4CmdList
    cb(entry)
  File "/opt/git/libexec/git-core/git-p4", line 2212, in streamP4FilesC=
bSelf
    self.streamP4FilesCb(entry)
  File "/opt/git/libexec/git-core/git-p4", line 2167, in streamP4FilesC=
b
    self.streamOneP4File(self.stream_file, self.stream_contents)
  File "/opt/git/libexec/git-core/git-p4", line 2078, in streamOneP4Fil=
e
    if data[-1] =3D=3D '\n':
IndexError: string index out of range


git =E2=80=94version: git version 1.8.5.2.309.ga25014b [last commit fro=
m master from github.com/git/git]
os : ubuntu 13.10


Any ideas ? :)

Best regards,
Damien