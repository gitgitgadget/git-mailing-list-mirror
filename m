From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] Switch git_mmap to use pread.
Date: Sun, 24 Dec 2006 14:09:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
 <20061224054547.GB8146@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 14:09:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyT6e-00065e-Ii
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 14:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWLXNJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 08:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWLXNJ0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 08:09:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:42718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751347AbWLXNJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 08:09:26 -0500
Received: (qmail invoked by alias); 24 Dec 2006 13:09:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 24 Dec 2006 14:09:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061224054547.GB8146@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35355>

Hi,

On Sun, 24 Dec 2006, Shawn O. Pearce wrote:

> Now that Git depends on pread in index-pack its safe to say we can
> also depend on it within the git_mmap emulation we activate when
> NO_MMAP is set.  On most systems pread should be slightly faster
> than an lseek/read/lseek sequence as its one system call vs. three
> system calls.

I don't think it matters much. The _only_ platform we really use NO_MMAP 
(other than for testing) is Windows, and AFAICT it does not have pread(), 
so it is emulated by lseek/read/lseek anyway.

But it's a cleanup, and it deletes more lines than it adds, so Ack from 
me.

Ciao,
Dscho
