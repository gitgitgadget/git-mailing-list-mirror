From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Mon, 8 Jan 2007 13:18:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701081316110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 13:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3tSP-0003AT-MC
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 13:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbXAHMS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 07:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXAHMS1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 07:18:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:49772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751490AbXAHMS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 07:18:26 -0500
Received: (qmail invoked by alias); 08 Jan 2007 12:18:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 08 Jan 2007 13:18:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36247>

Hi,

On Sun, 7 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Further, it makes no sense to force the parsing upon the helper
> > functions; for_each_reflog_ent() now calls the helper function with
> > old and new sha1, the email, the timestamp & timezone, and the message.
> 
> Perhaps.  I did it that way deliberately because all existing
> users did not have to pay overhead of parsing.

My reasoning is that invalid entries should rather be ignored than be 
taken into account. So, to verify that you are not walking invalid data, 
you have to parse it anyway.

Ciao,
Dscho
