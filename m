From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: consistency problem on ZFS
Date: Sun, 28 Apr 2013 21:33:21 +0200
Message-ID: <87k3nme9ha.fsf@hexa.v.cablecom.net>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Yann Hodique <yann.hodique@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 21:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXLn-0001yg-HY
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 21:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473Ab3D1Td0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 15:33:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:7716 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab3D1Td0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 15:33:26 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 28 Apr
 2013 21:33:11 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 28 Apr
 2013 21:33:23 +0200
In-Reply-To: <m2bo8yxyg2.fsf@jarvis.hodique.info> (Yann Hodique's message of
	"Sun, 28 Apr 2013 20:11:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222748>

Yann Hodique <yann.hodique@gmail.com> writes:

> I have a weird problem that seems to manifest itself only on ZFS
> (actually the Zevo distribution, on OSX). With git 1.8.2.1 by the way.
> I just switched to ZFS, so I can't blame that particular version of git.
>
> "Sometimes" (I'd say something like 10-15% of the time, fairly
> reproducible anyway), "git diff-files" will see changes that don't exist
> for some time, then will catch up with the actual state of the file:
>
> $ git checkout next; git diff-files; git checkout next; git diff-files
> Already on 'next'
> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M	magit.el
> Already on 'next'
> $

git-diff-files doesn't refresh the index.  Why are you using it?  It's
the plumbing version of 'git diff' (without args), which does the same
but *does* refresh the index.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
