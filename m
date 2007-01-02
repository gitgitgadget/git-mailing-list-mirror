From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: 1.5.0.rc0.gf4bf2: "git --bare gc" in bare repo deletes all!
Date: Tue, 02 Jan 2007 12:17:13 -0300
Message-ID: <200701021517.l02FHDxr009615@laptop13.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Tue Jan 02 16:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1lOD-0000UD-2N
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 16:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbXABPRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 10:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbXABPRR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 10:17:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:40775 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298AbXABPRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 10:17:16 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l02FHDos029336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 2 Jan 2007 12:17:13 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l02FHDxr009615
	for <git@vger.kernel.org>; Tue, 2 Jan 2007 12:17:13 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 02 Jan 2007 12:17:13 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35790>

I did:

  mkdir M
  cd M
  git --bare init-db
  git --bare fetch git+ssh://localhost/SomeRepo

This got the (correct) 21 (loose) objects. OK, cleanup:

  git --bare gc

this gives:

  Generating pack...
  Done counting 0 objects.
  Nothing new to pack.

and the objects are gone, no pack there.

Same thing happens with plain "git gc". Not very nice...


Besides, you can "git --bare pull ...", and get a mishmash of repo +
checked out files, this should be forbidden. Also, "git status" reports a
bunch of repo files as untracked, "git ls-files" shows nothing at all.
I.e., handling of bare repos needs a workover.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
