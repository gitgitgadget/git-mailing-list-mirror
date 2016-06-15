From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 09:23:52 +0100
Organization: eudaptics software gmbh
Message-ID: <45BF0098.8FF978CE@eudaptics.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291944290.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 09:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBoGQ-0004z4-Uo
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965430AbXA3IWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965431AbXA3IWs
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:22:48 -0500
Received: from main.gmane.org ([80.91.229.2]:40765 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965430AbXA3IWr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:22:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBoGB-0007Fn-Qj
	for git@vger.kernel.org; Tue, 30 Jan 2007 09:22:35 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 09:22:35 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 09:22:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38135>

Daniel Barkalow wrote:
> 
> On Mon, 29 Jan 2007, Johannes Sixt wrote:
> 
> > (*) The reason is that on Windows read() and write() cannot operate on
> > descriptors created by socket(). A work-around is to implement a (threaded)
> > proxy, but that's almost the same as if netcat were used as
> > GIT_PROXY_COMMAND.
> 
> Can you do
> 
> #define read(fd, buffer, len) recv(fd, buffer, len, 0)
> #define write(fd, buffer, len) send(fd, buffer, len, 0)
> 
> in the appropriate file?

I doubt that recv and send can operate on regular file descriptors, as
opened by _pipe(), open(), can they?

-- Hannes
