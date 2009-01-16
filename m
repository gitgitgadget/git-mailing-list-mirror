From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 21:55:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901162150550.3586@pacific.mpi-cbg.de>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de> <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de> <4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net> <7vr63386rc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 21:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNvj3-0001m6-10
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 21:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZAPUyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 15:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbZAPUyK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 15:54:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:42682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753713AbZAPUyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 15:54:09 -0500
Received: (qmail invoked by alias); 16 Jan 2009 20:54:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 16 Jan 2009 21:54:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3rkQU2iO3IsU+RUz+AIE3bGU2OO16JCVLzjwtOu
	gh9r4C0lQ1IXoA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr63386rc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105993>

Hi,

On Fri, 16 Jan 2009, Junio C Hamano wrote:

> Dscho, what performance issues do you have in mind, by the way?

Back when I tried to fix the worktree issue (still the subject of some of 
my nightmares), I set the GIT_DIR (IIRC) to the absolute path, just to 
make sure that it works in all cases, even when the work tree is far away 
from the GIT_DIR (think DOS drives, blech).

I could be mistaken, but I think it was there that somebody did some 
timing and found that lstats on hundreds of absolute paths were 
substantially slower than on relative paths.

Now, think of git-gc in a large number of bare repositories, such as 
repo.or.cz.  It does matter there.

Ciao,
Dscho
