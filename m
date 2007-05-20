From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 22:44:47 +0200
Message-ID: <20070520204447.GG13197@ferdyx.org>
References: <20070520181447.GA10638@ferdyx.org> <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net> <20070520184959.GA25462@steel.home> <20070520190024.GE13197@ferdyx.org> <20070520203534.GB25462@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 22:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsH2-0007Mn-5C
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbXETUo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 16:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbXETUo5
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:44:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:23396 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260AbXETUo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:44:56 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1003442uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 13:44:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=k5D3JOEXUvREf3Q462wWnpv+/VQkkhaXjWHbhY9UXSsEsEKC846tUCMUCtfglNOSY6ojTQKgy+fyf2pHI1y/4m24zZrdPchRcCMpp5EEZM492fBT85mdhxlJaMDIeGI0BuRsCOy3bmSL4thAGl/l3fSA441eP9RDkx7IUez1348=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=RQvkfF4v0GS+VZhS+EtEBfi59erHw4AzKHLVEoV9bzE7fxB/FJnlR1Q6O8rHbfCMjzquYV0t3lWCurehe6egNv1/Y6qXt/g4eaobbmVZMMv1yurfPmHrRiI6u/c9JmmlzIIKL2/PanDuJDWgWpPU49nJ+TLufBFQAodT+mYiz0o=
Received: by 10.67.117.18 with SMTP id u18mr2881689ugm.1179693893904;
        Sun, 20 May 2007 13:44:53 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id b35sm6371451ugd.2007.05.20.13.44.49;
        Sun, 20 May 2007 13:44:52 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@ferdyx.org; Sun, 20 May 2007 22:44:50 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070520203534.GB25462@steel.home>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47911>

On Sun, May 20, 2007 at 10:35:34PM +0200, Alex Riesen wrote:
> Fernando J. Pereda, Sun, May 20, 2007 21:00:24 +0200:
> > On Sun, May 20, 2007 at 08:49:59PM +0200, Alex Riesen wrote:
> > > Junio C Hamano, Sun, May 20, 2007 20:36:25 +0200:
> > > > > +IMPORTANT: Maildir splitting relies upon filenames being sor=
ted to output
> > > > > +patches in the correct order.
> > > >=20
> > > > I am sure there are many users who uses Maildir layout on this
> > > > list.  Happy with this patch?  Please speak out.
> > >=20
> > > I do use maildirs, but I have a suggestion: --maildir or somethin=
g, to
> > > create a non-existing maildir and split into it, so that the user=
 does
> > > not have to pre-create it.
> >=20
> > I can't think of a use case for this...
> >=20
>=20
> You actually enjoy typing "mkdir tmp && git mailsplit tmp"?

Well, my mail client creates Maildirs for me... so I still don't see wh=
y
would you do that. I copy mails with patches to a new maildir and run
git am there...

As I said I can't think of a use case for your suggestion.


- ferdy

--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
