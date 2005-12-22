From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] off-by-one bugs found by valgrind
Date: Wed, 21 Dec 2005 21:27:40 -0300
Message-ID: <200512220027.jBM0RetQ003481@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 14:59:23 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpQyV-0000g2-TD
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 14:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVLVN7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 08:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVLVN7Q
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 08:59:16 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62695 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964831AbVLVN7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 08:59:16 -0500
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id jBMDvp27012064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Dec 2005 10:57:52 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.5) with ESMTP id jBM0RetQ003481;
	Wed, 21 Dec 2005 21:27:40 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Wed, 21 Dec 2005 12:59:14 -0800." <7vr7865fq5.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 22 Dec 2005 10:57:52 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13946>

Junio C Hamano <junkio@cox.net> wrote:
> Pavel Roskin <proski@gnu.org> writes:

[...]

> > quote_c_style_counted() in quote.c uses a dangerous construct, when a
> > variable is incremented once and used twice in the same expression.
> 
> Sorry, I do not follow you.  Isn't && a sequence point?
> 
> > -	for (sp = name; (ch = *sp++) && (sp - name) <= namelen; ) {
> > -
> > +	for (sp = name; sp < name + namelen; sp++) {

Yes, it is, so it doesn't fix any bugs; but Pavel's version is definitely
more readable.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
