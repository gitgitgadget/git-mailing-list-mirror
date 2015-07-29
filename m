From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
Subject: git svn clone fails
Date: Wed, 29 Jul 2015 12:12:01 +0200
Organization: Swiss Post Solutions
Message-ID: <mpa8th$m80$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 12:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKOT9-00021U-O5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 12:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbbG2KUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2015 06:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:36347 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbbG2KUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 06:20:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZKOSx-0001sA-Tu
	for git@vger.kernel.org; Wed, 29 Jul 2015 12:20:03 +0200
Received: from 62.154.225.82 ([62.154.225.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:20:03 +0200
Received: from joerg.schaible by 62.154.225.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.154.225.82
User-Agent: KNode/4.14.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274890>

Hello guys,

we have to turn some projects managed by Subversion into a GIT-based=20
solution. However the conversion unfortunately fails with an error:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[...]
=46ound branch parent: (refs/remotes/origin/tags/v_2.1.1)=20
450fa2c84a8fc087a2a66e5fb3d6d22096671f81
=46ollowing parent with do_switch
        M       changes.xml
        M       pom.xml
couldn't truncate file at /usr/lib64/perl5/vendor_perl/5.20.2/Git.pm li=
ne=20
1325.
$ git --version
git version 2.5.0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Apart from the line number, the same error occurs also with GIT version=
=20
2.4.6 and 2.3.6 (latest stable version in Gentoo).

The command to create the GIT repository was:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
$ git svn clone http://websvn/svn/essvn/standard/java-commons/lang -s -=
-no-
metadata --preserve-empty-dirs -A ~/tmp/authors.txt commons-lang
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %< =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Note, that the command succeeds even for 2.4.6 if we drop the --preserv=
e-
empty-dirs option - at the cost of some empty directories which are use=
d to=20
trigger profiles for Maven; i.e. without those we cannot reproduce rele=
ased=20
versions.

Cheers,
J=C3=B6rg
