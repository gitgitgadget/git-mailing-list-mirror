From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sat, 13 Jan 2007 21:42:57 -0300
Message-ID: <200701140042.l0E0gvMT005024@laptop13.inf.utfsm.cl>
References: <20070113110238.GA2795@steel.home>
Cc: Junio C Hamano <junkio@cox.net>,
	David =?iso-8859-15?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 01:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5tSp-0007ig-Gj
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 01:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbXANAnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 19:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXANAnI
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 19:43:08 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42663 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbXANAnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 19:43:07 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0E0h0g5000832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 13 Jan 2007 21:43:01 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0E0gvMT005024;
	Sat, 13 Jan 2007 21:42:58 -0300
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: Message from fork0@t-online.de (Alex Riesen) 
   of "Sat, 13 Jan 2007 12:02:38 BST." <20070113110238.GA2795@steel.home> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:44:27 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 13 Jan 2007 21:43:02 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2439/Sat Jan 13 17:33:25 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36785>

Alex Riesen <fork0@t-online.de> wrote:
> Junio C Hamano, Sat, Jan 13, 2007 02:31:35 +0100:
> > +/* High bit set, or ISO-2022-INT */
> > +static int non_ascii(int ch)
> > +{
> > +	ch = (ch & 0xff);
> > +	return ((ch & 0x80) || (ch == 0x1b));
> > +}
> > +
> 
> "return (ch & 0x0x80) || (ch & 0xff) == 0x1b;" :)
                ^^

Is the same, if ch == 0x9b, it will match the first part anyway.

The outer parentesis can (should?) go.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
