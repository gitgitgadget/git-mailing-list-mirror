From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Thu, 20 Jan 2011 21:34:41 +0100
Message-ID: <201101202134.41911.trast@student.ethz.ch>
References: <vpq62ziv788.fsf@bauges.imag.fr> <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>,
	<gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jan 20 21:35:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg1Dn-0007IF-1n
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 21:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab1ATUeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 15:34:46 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:22594 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201Ab1ATUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 15:34:44 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 20 Jan
 2011 21:34:35 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 20 Jan
 2011 21:34:42 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110120200827.GB14184@vidovic>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165333>

Nicolas Sebrecht wrote:
> The 20/01/11, Jonathan Nieder wrote:
> 
> > if you
> > have a single "noop" instruction, that means "I have discarded all the
> > commits, but please rebase anyway".
> 
> Ok, I think I get it now. What about adding
> 
>   Use "noop" with no other instruction to fallback to a non-interactive
>   rebase. If other instructions are present, "noop" has no effect.
> 
> ?

No, that's quite wrong.

The TODO list is the list of all commits that need to be rebased.  It
does not contain commits that (according to patch-id) are already
contained in the upstream (i.e., the base you are rebasing on).  If
the list is empty after filtering out such commits, rebase puts 'noop'
as the only command since "empty TODO" is already taken to mean
"abort"

If you then accept this 'noop' rebase, this effectively makes the
rebased branch the same as the base branch, sort of like resetting.

(I for one have never accepted such a rebase; if the TODO only
consists of noop, that means I made a mistake.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
