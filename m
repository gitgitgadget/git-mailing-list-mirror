From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: MinGW port usable
Date: Mon, 29 Jan 2007 19:50:36 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701291944290.20138@iabervon.org>
References: <200701292320.43888.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jan 30 01:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBhCr-0003qn-0h
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 01:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbXA3Aui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 19:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965389AbXA3Aui
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 19:50:38 -0500
Received: from iabervon.org ([66.92.72.58]:1382 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965384AbXA3Auh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 19:50:37 -0500
Received: (qmail 14437 invoked by uid 1000); 29 Jan 2007 19:50:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2007 19:50:36 -0500
In-Reply-To: <200701292320.43888.johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38118>

On Mon, 29 Jan 2007, Johannes Sixt wrote:

> (*) The reason is that on Windows read() and write() cannot operate on 
> descriptors created by socket(). A work-around is to implement a (threaded) 
> proxy, but that's almost the same as if netcat were used as 
> GIT_PROXY_COMMAND.

Can you do

#define read(fd, buffer, len) recv(fd, buffer, len, 0)
#define write(fd, buffer, len) send(fd, buffer, len, 0)

in the appropriate file?

	-Daniel
*This .sig left intentionally blank*
