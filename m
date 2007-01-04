From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Thu, 4 Jan 2007 13:33:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 13:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Rmm-0002ME-4V
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 13:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbXADMd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 07:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbXADMd3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 07:33:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:53842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964811AbXADMd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 07:33:28 -0500
Received: (qmail invoked by alias); 04 Jan 2007 12:33:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 04 Jan 2007 13:33:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35928>

Hi,

On Thu, 4 Jan 2007, Alex Riesen wrote:

> Johannes, I remember suggesting to do index flush for all
> entries instead for every entry. It is already quite time ago,
> but ... was there any reasons for not doing this?

I wanted to be on the safe side, and eventually look through the code 
again for possible problems.

I think what you did is safe, since you moved the call from 
process_entry() to its sole caller, merge_trees().

However, I was wondering if the index has to be written at all. 
I expect the written index (except the last one, of course) to have no 
user...

Ciao,
Dscho
