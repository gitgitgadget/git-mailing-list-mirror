From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit: fix "git add x y && git commit y"
 committing x, too
Date: Thu, 15 Nov 2007 16:37:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711151635580.30886@racer.site>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
 <1195138198-24511-1-git-send-email-krh@redhat.com> <Pine.LNX.4.64.0711151611090.30886@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:38:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ishjf-0002BK-7o
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275AbXKOQiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757953AbXKOQiQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:38:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:36185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757160AbXKOQiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:38:15 -0500
Received: (qmail invoked by alias); 15 Nov 2007 16:38:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 15 Nov 2007 17:38:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EnNYSGHoEhP6xm/tOUVibMggs5EcofaMgG8o6IM
	U04dP0YOypoI/F
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711151611090.30886@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65136>

Hi,

On Thu, 15 Nov 2007, Johannes Schindelin wrote:

> 
> Earlier, builtin commit would implicitly commit also the staged
> changes.
> 
> This patch fixes that.

This was only lightly tested.  Alas, there is still a subtle bug... the 
generated "Untracked/Staged/ToBeCommitted" list seems off.  I guess we'd 
have to reread the index after resetting it to HEAD and adding the files, 
but before generating that commit message.

Ciao,
Dscho
