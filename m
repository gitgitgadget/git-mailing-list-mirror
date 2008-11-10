From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Tue, 11 Nov 2008 00:37:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811110031510.30769@pacific.mpi-cbg.de>
References: <200811101522.13558.fg@one2team.net> <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Francis Galiegue <fg@one2team.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgDV-0001rP-5J
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYKJX3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYKJX3b
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:29:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:59752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbYKJX3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:29:30 -0500
Received: (qmail invoked by alias); 10 Nov 2008 23:29:28 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 11 Nov 2008 00:29:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/REX5Elz/RJfZ81miRjwni0KLnsvqEdeSIgqmHuH
	ZJRrn8i8lIhSPj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100589>

Hi,

On Mon, 10 Nov 2008, Junio C Hamano wrote:

> Francis Galiegue <fg@one2team.net> writes:
> 
> > A very nice git feature, without even going as far as merges, is the 
> > cherry pick feature.
> 
> I thought cherry-picking needs to be done in terms of 3-way merge, not 
> diff piped to patch, for correctness's sake.

I haven't checked how RCS merge does it, but I know how xdiff/xmerge.c 
does it ;-)

Basically, it takes the two diffs relative to the base file and works on 
the overlapping hunks (i.e. on hunks where the ranges in the base file 
overlap).

So we need a diff algorithm very much if we were to imitate that code in 
JGit, which I very much plan to do.

Ciao,
Dscho
