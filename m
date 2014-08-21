From: Reiner Nothdurft <reiner@jnc-business.de>
Subject: Bug in Git 1.9.4 (20140815) for Windows - cannot clone from SVN
Date: Thu, 21 Aug 2014 11:53:08 +0200 (CEST)
Message-ID: <592191693.140260.1408614788186.open-xchange@patina.store>
Reply-To: Reiner Nothdurft <reiner@jnc-business.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 11:53:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKP3T-0002Oc-JU
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 11:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbaHUJxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Aug 2014 05:53:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:21085 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbaHUJxK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2014 05:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1408614788; l=1536;
	s=domk; d=jnc-business.de;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:
	Reply-To:From:Date;
	bh=/v/ZpXeofvS2T5SDIq9NIpVrVRw=;
	b=XTeWJZQtx+Au+zQ6wxPY+BjBsV2g3NJB2eNejVex0xU8YAK1iJQvJu+IUlniSSEuuq2
	0T8qXg7EoS8YRxRrWwtia+w5YF1lT7lWdA6LKbflyyG2TiUh7hpGXdzYlN4HMeiBCI7mD
	ULhfu2e28rrk3vLq8NzlnWIO0/86lA+x+A0=
X-RZG-AUTH: :PmkNe0W6W/XBNQOEKZbbQOKlIDTh3hn4e8Ej9dvgvbFGf0KgrdYMWAdTVI+QlfHPAQ==
X-RZG-CLASS-ID: mo00
Received: from patina.store (com4.strato.de [81.169.145.237])
	by smtp-ox.front (RZmta 35.8 AUTH)
	with ESMTPSA id L02e99q7L9r8BEM
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Thu, 21 Aug 2014 11:53:08 +0200 (CEST)
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.4.2-Rev27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255604>

Hi all,
=C2=A0
I tried to move a repository from SVN to Git, but all my tries - on thr=
ee
different machines running Windows 7 with the latest patches - failed w=
ith the
same reason. I am running the latest version of Git for Windows
1.9.4-preview-20140815. One of my first steps was to clone the reposito=
ry from
my server into my local file system, which led to the following reprodu=
cible
error:
=C2=A0
Command: git svn clone svn:////jnc
C:\Program Files (x86)\Git\bin\perl.exe: *** unable to remap C:\Program=
 Files
(x86)\Git\bin\libneon-25.dll to same addre ss as parent -- 0x850000
=C2=A0 =C2=A0 =C2=A0 0 [main] perl.exe" 1608 sync_with_child: child 104=
60(0x184) died before
initialization with status code 0x1
=C2=A0 =C2=A0 748 [main] perl.exe" 1608 sync_with_child: *** child stat=
e child loading
dlls C:\Program Files (x86)\Git\bin\perl.exe: *** unable to remap C:\Pr=
ogram
=46iles (x86)\Git\bin\libsvn_repos-1-0.dll to same=C2=A0 address as par=
ent -- 0x850000
5066339 [main] perl.exe" 1608 sync_with_child: child 13188(0x198) died =
before
initialization with status code 0x1
5067125 [main] perl.exe" 1608 sync_with_child: *** child state child lo=
ading
dlls
=C2=A0
Same issue when I add parameters for the local path, trunk, branches, e=
tc.
Moving back to Git 1.9.2 for Windows fixed this issue finally. Meanwhil=
e I heard
from a collegue, that the issue also did not appear with 1.9.4 preview =
20140611.

Hope this helps. Thanks for your great work!
Reiner Nothdurft
=C2=A0
