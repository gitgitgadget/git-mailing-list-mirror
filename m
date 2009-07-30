From: Mark A Rada <marada@uwaterloo.ca>
Subject: Add Gitweb support for LZMA compressed snapshots
Date: Thu, 30 Jul 2009 01:48:01 -0400
Message-ID: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-457-42741892
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 08:22:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWP0m-0004AJ-AR
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 08:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZG3GUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 02:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZG3GUs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 02:20:48 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:40921 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150AbZG3GUs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 02:20:48 -0400
X-Greylist: delayed 1956 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2009 02:20:48 EDT
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n6U5m6Ve023910
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 30 Jul 2009 01:48:11 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Thu, 30 Jul 2009 01:48:11 -0400 (EDT)
X-Miltered: at psyche with ID 4A713416.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: d2fb92de-9a06-4494-a64d-1ac99fb955ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124443>


--Apple-Mail-457-42741892
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I thought I would submit this little patch I made to my gitweb. I am  
on a relatively slow
connection, and so LZMA compression time is less of a  concern than  
bandwidth---I'm
guessing that I am not the only person who suffers from slow internet  
connection
syndrome.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--Apple-Mail-457-42741892
Content-Disposition: attachment;
	filename=0001-Add-Gitweb-support-for-LZMA-compressed-snapshots.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Add-Gitweb-support-for-LZMA-compressed-snapshots.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20a080ce5e8467317a3f20c6de8814549e5c4f46f2=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Mark=20Rada=20<marada@uwaterloo.ca>=0ADate:=20=
Wed,=2029=20Jul=202009=2021:27:32=20-0400=0ASubject:=20[PATCH]=20Add=20=
Gitweb=20support=20for=20LZMA=20compressed=20snapshots=0A=0A=
Signed-off-by:=20Mark=20Rada=20<marada@uwaterloo.ca>=0A---=0A=20=
gitweb/gitweb.perl=20|=20=20=20=208=20++++++++=0A=201=20files=20changed,=20=
8=20insertions(+),=200=20deletions(-)=0A=0Adiff=20--git=20=
a/gitweb/gitweb.perl=20b/gitweb/gitweb.perl=0Aindex=2038492d0..e131ea4=20=
100755=0A---=20a/gitweb/gitweb.perl=0A+++=20b/gitweb/gitweb.perl=0A@@=20=
-184,6=20+184,13=20@@=20our=20%known_snapshot_formats=20=3D=20(=0A=20=09=09=
'format'=20=3D>=20'tar',=0A=20=09=09'compressor'=20=3D>=20['bzip2']},=0A=20=
=0A+=09'txz'=20=3D>=20{=0A+=09=09'display'=20=3D>=20'tar.lzma',=0A+=09=09=
'type'=20=3D>=20'application/x-lzma',=0A+=09=09'suffix'=20=3D>=20=
'.lzma',=0A+=09=09'format'=20=3D>=20'tar',=0A+=09=09'compressor'=20=3D>=20=
['lzma']},=0A+=0A=20=09'zip'=20=3D>=20{=0A=20=09=09'display'=20=3D>=20=
'zip',=0A=20=09=09'type'=20=3D>=20'application/x-zip',=0A@@=20-196,6=20=
+203,7=20@@=20our=20%known_snapshot_formats=20=3D=20(=0A=20our=20=
%known_snapshot_format_aliases=20=3D=20(=0A=20=09'gzip'=20=20=3D>=20=
'tgz',=0A=20=09'bzip2'=20=3D>=20'tbz2',=0A+=09'lzma'=20=20=3D>=20'txz',=0A=
=20=0A=20=09#=20backward=20compatibility:=20legacy=20gitweb=20config=20=
support=0A=20=09'x-gzip'=20=3D>=20undef,=20'gz'=20=3D>=20undef,=0A--=20=0A=
1.6.4=0A=0A=

--Apple-Mail-457-42741892
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit





--Apple-Mail-457-42741892--
