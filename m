From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 19:29:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712141928240.27959@racer.site>
References: <1197660157-24109-1-git-send-email-krh@redhat.com>
 <1197660157-24109-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1647359555-1197660543=:27959"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GFg-00039G-HV
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762911AbXLNT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 14:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759438AbXLNT3Q
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:29:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:42584 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760886AbXLNT3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 14:29:14 -0500
Received: (qmail invoked by alias); 14 Dec 2007 19:29:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 14 Dec 2007 20:29:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PT+koB9UP7/6ZguCP+WwH6AJbsAeimtTq9QEHkQ
	LXZbp3ihKGoZFh
X-X-Sender: gene099@racer.site
In-Reply-To: <1197660157-24109-2-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68330>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1647359555-1197660543=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 14 Dec 2007, Kristian Høgsberg wrote:

> -	struct lock_file *lock = NULL;
> +	struct lock_file lock;

AFAICT this cannot work.  At least not reliably.  An atexit() handler will 
access all (even closed) lockfiles.

Ciao,
Dscho
---1463811741-1647359555-1197660543=:27959--
