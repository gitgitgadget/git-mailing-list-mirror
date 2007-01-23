From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 12:25:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian MICHON <christian.michon@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 12:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9JmY-0004mI-Qs
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 12:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbXAWLZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 06:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXAWLZj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 06:25:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:40737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932902AbXAWLZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 06:25:39 -0500
Received: (qmail invoked by alias); 23 Jan 2007 11:25:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 23 Jan 2007 12:25:37 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37500>

Hi,

On Mon, 22 Jan 2007, Linus Torvalds wrote:

>    Maybe getenv() under MinGW always returns a real string, and it's just 
>    empty?

No. It is not Oracle: it _does_ return NULL if it is not set, and an empty 
string iff it is set to an empty string.

>  - datestamp() uses "time()" to get the number of seconds since the epoch. 
>    HOWEVER, it does it by actually doing
> 
> 	time_t now;
> 
> 	time(&now);
> 
>    which is proper, but maybe a bit unusual.

MinGW does that quite fine (actually, it just calls the MS C Runtime 
library; maybe they still had a clue bat back when they wrote that?).

>    Alternatively, if "time()" just doesn't work in MinGW, just use 
>    gettimeofday() instead, [...]

Funnily enough, MinGW does not have gettimeofday(). Actually, for purposes 
of getting git to compile, I had to

	int gettimeofday(struct timeval *tv, void *tz)
	{
	        return -1;
	}

;-)

> Anyway. I have no idea of Windows or MinGW, or what you did to make it 
> all compile, so..

Lucky you! Fortunately, I don't have any Windows at home (but I still have 
windows, thank God!). So I cannot even be tempted to work on this thing in 
my free time.

Ciao,
Dscho
