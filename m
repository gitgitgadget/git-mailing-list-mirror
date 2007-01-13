From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: 1.5.0.rc1.gb60d: fetch in another branch works strangely
Date: Sat, 13 Jan 2007 18:06:11 -0300
Message-ID: <200701132106.l0DL6BPH008314@laptop13.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jan 13 22:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5q50-00010i-L2
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 22:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbXAMVGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 16:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbXAMVGQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 16:06:16 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38655 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422796AbXAMVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 16:06:15 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0DL6Dkd021002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 13 Jan 2007 18:06:14 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0DL6BPH008314
	for <git@vger.kernel.org>; Sat, 13 Jan 2007 18:06:12 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 13 Jan 2007 18:06:14 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2438/Sat Jan 13 08:34:05 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36771>

I created a new branch in the kernel to carry a not yet official patch, to
keep this up to date I do:

   $ git fetch git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
   $ git pull . origin

The kernel repository is quite old, so it has the old-fashoned setup. I
see:

  $ less .git/refs/heads/bz-7795 
  d132ed980aee1bdcc6fa02b91da95a357902eb3c
  $ less .git/refs/heads/origin  
  d39c9400ae0d60aaaf534b1ad860a9bc1413d8af

And this last ref doesn't change when fetching.

Strangely, each time I fetch it gets 7 new objects (I haven't pulled, I do
that once I'm sure I've got all). As I tend to doubt that we are /that/
syncronized with Linus, something fishy is going on here...

First noticed this with 1.5.0.rc1.g4494.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
