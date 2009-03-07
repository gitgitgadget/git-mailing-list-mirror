From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Brown paper bag fix for MinGW 64-bit stat
Date: Sat, 7 Mar 2009 22:02:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903072159500.10279@pacific.mpi-cbg.de>
References: <cover.1236436185u.git.johannes.schindelin@gmx.de> <03fcab37c921f5728deded11c07bdf32a263b79b.1236436185u.git.johannes.schindelin@gmx.de> <7vzlfxnlx2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3fQ-0004dm-Jm
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbZCGVBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 16:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbZCGVBG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:01:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:58390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755205AbZCGVBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:01:03 -0500
Received: (qmail invoked by alias); 07 Mar 2009 21:01:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 07 Mar 2009 22:01:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/m8cd27q/w8slgUNekdul6cSMpfyJf6H7mqG+8Y
	LFUdrijCDS/gou
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vzlfxnlx2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112582>

Hi,

On Sat, 7 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When overriding the identifier "stat" so that "struct stat" will be
> > substituted with "struct _stati64" everywhere, I tried to fix the calls
> > to the _function_ stat(), too, but I forgot to change the earlier
> > attempt "stat64" to "_stati64" there.
> >
> > So, the stat() calls were overridden by calls to _stati64() instead.
> >
> > Unfortunately, there is a function _stati64() so that I missed that
> > calls to stat() were not actually overridden by calls to mingw_lstat(),
> > but t4200-rerere.sh showed the error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Since this is a fix-up to a new on 'master', I've applied the patch
> myself, but how would we want to handle MinGW related patches in general?
> 
> My preference is to have somebody I can rely on receiving Acked forwards
> from (or pulling from).

My preference is to keep the tried and tested mingw.git maintainer... ;-)

Note: IMHO Windows support is really at most beta quality; I would prefer 
only those using it who can fix bugs themselves, or have the means to make 
others fix the bugs.

So technically, we do not need such a strict and rigid process as for 
git.git itself, which is blessed with hundreds of contributors, due to 
which is really is ready for the end-user.

Ciao,
Dscho
