From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 08:25:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806120822140.1783@racer>
References: <20080611182501.GA3344@steel.home> <556d90580806112332s25f76caajaaafa8e16e895922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:27:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6hDI-0002A5-In
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbYFLH0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYFLH0W
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:26:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:51931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753142AbYFLH0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:26:21 -0400
Received: (qmail invoked by alias); 12 Jun 2008 07:26:19 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 12 Jun 2008 09:26:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L679odsRL/3EG5a+4kutuVSz7x8SkWXfJpcddb/
	4m0x4R1XGnAhIG
X-X-Sender: gene099@racer
In-Reply-To: <556d90580806112332s25f76caajaaafa8e16e895922@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84731>

Hi,

On Thu, 12 Jun 2008, Alf Clement wrote:

> > +static unsigned char *unquote(const char *s, unsigned *len) +{
> > +       unsigned char *result = malloc(strlen(s)), *r = result;
> 
> are you sure that the buffer is big enough?? Nomally you do a
> malloc(strlen(s)+1).

AFAIU a "tr" really only ever replaces single characters by single 
characters.  So, not even looking at the code -- just like you -- I would 
expect it to get the exact number of bytes read, and to write the same 
number of bytes.

I certainly would not expect it to do something string based, introducing 
a silly expectation of NUL-terminations (which tr(1) does not expect 
either).

Ciao,
Dscho
