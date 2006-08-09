From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH and RFC] gitweb: Remove --full-history from git_history
Date: Wed, 9 Aug 2006 22:08:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608092205410.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200608091257.19461.jnareb@gmail.com> <20060809192815.GA7954@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 22:08:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAuLk-0006kF-7J
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 22:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWHIUIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWHIUIP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 16:08:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:21897 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751342AbWHIUIO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 16:08:14 -0400
Received: (qmail invoked by alias); 09 Aug 2006 20:08:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 09 Aug 2006 22:08:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060809192815.GA7954@c165.ib.student.liu.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25140>

Hi,

your struct path_list and find_renames() is so similar to what is already 
in merge-recursive.c that it is not even funny.

Furthermore, the struct path_list from path-list.[ch] implements a sorted 
list, so that lookups are way cheaper than with linked lists.

IMHO this whole renaming stuff should go into a new file, renames.c, and 
be reused as often as possible.

Ciao,
Dscho
