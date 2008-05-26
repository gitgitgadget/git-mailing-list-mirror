From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reset the signal being handled
Date: Mon, 26 May 2008 10:34:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261031480.30431@racer>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org> <20080523221723.GA4366@localhost> <20080525182650.GA17806@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon May 26 11:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Z6c-0003pr-SA
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 11:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbYEZJeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 05:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYEZJeK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 05:34:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:40702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbYEZJeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 05:34:09 -0400
Received: (qmail invoked by alias); 26 May 2008 09:34:05 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp027) with SMTP; 26 May 2008 11:34:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2G0ZDEBG2q4odhr5q8K87Q9OtRMVIrvTCxvg9iB
	e/LIKGnRfiF8b7
X-X-Sender: gene099@racer
In-Reply-To: <20080525182650.GA17806@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82911>

Hi,

On Sun, 25 May 2008, Clemens Buchacher wrote:

> This did not cause any problems, because remove_lock_file_on_signal is
> only registered for SIGINT.

Only from the patch did I understand that you actually meant:

	lockfile: reset the correct signal

	In the function remove_lock_file_on_signal(), the signal handler
	for SIGINT was reset, ignoring the parameter signo.

	This did not pose a problem yet, as remove_lock_file_on_signal()
	was only registered as a SIGINT handler.

Hth,
Dscho
