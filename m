From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: specify charset for commits
Date: Fri, 22 Dec 2006 13:07:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 13:07:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjBQ-0004H6-Vz
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWLVMH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWLVMH0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:07:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:47027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964956AbWLVMHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:07:25 -0500
Received: (qmail invoked by alias); 22 Dec 2006 12:07:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 22 Dec 2006 13:07:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35164>

Hi,

On Thu, 21 Dec 2006, Junio C Hamano wrote:

>  (2) update commit-tree to reject non utf-8 log messages and
>      author/committer names when i18n.commitEncoding is _NOT_
>      set, or set to utf-8.

The problem is: you cannot easily recognize if it is UTF8 or not, 
programatically. There is a good indicator _against_ UTF8, namely the 
first byte can _only_ be 0xxxxxxx, 110xxxxx, 1110xxxx, 11110xxx. But there 
is no _positive_ sign that it is UTF8. For example, many umlauts and other 
special modifications to letters, stay in the range 0x7f-0xff.

Ciao,
Dscho
