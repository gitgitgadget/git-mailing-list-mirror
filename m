From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 08:28:27 +0200
Message-ID: <45FCDC0B.1090506@qumranet.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 07:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSp0k-0001wN-2n
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 07:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbXCRGg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 02:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbXCRGg4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 02:36:56 -0400
Received: from mtaout1.012.net.il ([84.95.2.1]:19200 "EHLO mtaout1.012.net.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084AbXCRGgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 02:36:55 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Mar 2007 02:36:55 EDT
Received: from firebolt.argo.co.il ([80.178.182.138])
 by i_mtaout1.012.net.il (HyperSendmail v2004.12)
 with ESMTP id <0JF30063G6D1ANK0@i_mtaout1.012.net.il> for git@vger.kernel.org;
 Sun, 18 Mar 2007 08:36:38 +0200 (IST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by firebolt.argo.co.il (Postfix) with ESMTP id 086F6C02A6; Sun,
 18 Mar 2007 08:28:28 +0200 (IST)
In-reply-to: <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
X-Greylist: Sender IP whitelisted,
 not delayed by milter-greylist-2.1.12 (firebolt.argo.co.il [0.0.0.0]); Sun,
 18 Mar 2007 08:28:28 +0200 (IST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42477>

Morten Welinder wrote:
>>         samples  %        app name                 symbol name
>>         41527    15.6550  git                      strlen
>
> Almost 16% in strlen?  Ugh!
>
> That's a lot of strings, or perhaps very long strings.  Or a profiling 
> bug.
>

Or maybe strlen() is the first function to touch the page/cacheline.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
