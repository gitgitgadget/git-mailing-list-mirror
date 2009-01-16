From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Fri, 16 Jan 2009 14:17:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161415230.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>  <496EE559.3060901@viscovery.net>  <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>  <200901151500.01876.trast@student.ethz.ch>  <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
  <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>  <7vhc40s50t.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de> <adf1fd3d0901160512i2de8f473gd471cc1dcb72afa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-18814924-1232111877=:3586"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNoam-00085b-Rc
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762632AbZAPNRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 08:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762615AbZAPNRF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:17:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:38521 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762564AbZAPNRD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:17:03 -0500
Received: (qmail invoked by alias); 16 Jan 2009 13:17:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 16 Jan 2009 14:17:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kJGQi0GwkhASfW2Pe5l3qbv5HDp5wECiiANi3rB
	lOLzDYRayR4Q1t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <adf1fd3d0901160512i2de8f473gd471cc1dcb72afa4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105954>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-18814924-1232111877=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, Santi Béjar wrote:

> 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > Note that this affects creating bundles with --all; I contend that it 
> > is a good change to add the HEAD, so that cloning from such a bundle 
> > will give you a current branch.  However, I had to fix t5701 as it 
> > assumed that --all does not imply HEAD.
> 
> From the description I understand that it only affects when the HEAD is 
> detached, but in t5701 the HEAD is not detached so nothing should be 
> fixed.

The error in t5701 was that it _wanted_ to test a bundle without a HEAD, 
but it actually created it with --all.  That was implying that --all does 
not mean HEAD, and I disagree with that.

> For gc for sure it is a good thing, but I'm not convinced of the others, 
> as a detached HEAD is a very special thing (temporary and unnamed 
> branch).

So?  What does "--all" mean?  All branches or what? :-)

Seriously, I think that --all should imply HEAD at all times, as the only 
time when it makes a difference is when you have that unnamed _branch_ 
that is a detached HEAD.

Maybe I would be more amenable to your criticism if you could come up with 
a scenario where implying HEAD with --all is _wrong_.

Ciao,
Dscho

--8323328-18814924-1232111877=:3586--
