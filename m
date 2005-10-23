From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Merge failure problem with cogito: How to fixup?
Date: Sun, 23 Oct 2005 12:57:51 -0300
Message-ID: <200510231557.j9NFvptA020919@inti.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sun Oct 23 20:48:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETktB-000066-Gc
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 20:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVJWSsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVJWSsH
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 14:48:07 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50060 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750841AbVJWSsG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 14:48:06 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9NFvptA020919
	for <git@vger.kernel.org>; Sun, 23 Oct 2005 12:57:52 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10497>

When doing the following:

   mkdir /tmp/tst1
   cd /tmp/tst1
   echo "Initial" | cg-init 
      
   cd /tmp
   cg-clone tst1 tst2
   
   cd /tmp/tst1
   echo 'Hi there!' > greet
   cg-add greet
   cg-commit -m "Add greet"
   
   cd /tmp/tst2
   echo 'Hello!' > greet
   cg-add greet
   cg-commit -m "Add greet"

   cg-update

I get a message to the end that the merge doesn't work, and that I have to
fix up by hand. The resulting greet file has no merge markers, plain
"cg-diff" is useless. How am I supposed to find out what the problem is?

Yes, "cg-diff -r origin:HEAD" does the trick, but...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
