From: "Paul Lotz" <plotz@lsst.org>
Subject: difftool sends malformed path to exernal tool on Windows
Date: Mon, 17 Feb 2014 15:14:01 -0700
Message-ID: <011301cf2c2d$90442810$b0cc7830$@lsst.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 17 23:14:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFWSL-00069m-LV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 23:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbaBQWOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 17:14:05 -0500
Received: from mail.lsstcorp.org ([140.252.15.63]:13209 "EHLO mail.lsst.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbaBQWOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Feb 2014 17:14:04 -0500
Received: from PaulLaptop ([140.252.119.210]) by mail.lsst.org with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 17 Feb 2014 15:14:02 -0700
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQEufHkGEOiHV2v+DzDiyf0qz7tl4w==
Content-Language: en-us
X-OriginalArrivalTime: 17 Feb 2014 22:14:02.0282 (UTC) FILETIME=[9047F8A0:01CF2C2D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242268>

=46rom the Git Bash command line, I enter
$ git difftool

and type =91y=92 when the file I want to difference appears.=A0 Git cor=
rectly
calls the external diff tool (LVCompare.exe), but the path for the remo=
te
file Git passes to that tool is malformed (e.g.,
C:\/Users/Paul/AppData/Local/Temp/QCpqLa_calcLoadCellExcitation.vi).=A0
Obviously the \/ (backslash forwardslash) combination is incorrect.

=46or the record, I have successfully made calls to LVCompare.exe manua=
lly
from a Windows command prompt directly (without Git).

The relevant portion of the .gitconfig file is:
[diff]
=A0=A0=A0=A0 tool =3D "LVCompare"
[difftool "LVCompare"]
=A0=A0=A0=A0 cmd =3D 'C:/Program Files (x86)/National Instruments/Share=
d/LabVIEW
Compare/LVCompare.exe' \"$LOCAL\"=A0 \"$REMOTE\"


=46or the record, the operating system is Windows 8.1.

Paul
