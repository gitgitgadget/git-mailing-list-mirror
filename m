From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git
 segfaults
Date: Mon, 17 Aug 2009 16:17:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171616340.4991@intel-tinevez-2-302>
References: <20090817135651.GA4570@harikalardiyari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ali Polatel <polatel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:18:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md325-0004GE-FG
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbZHQOR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZHQOR2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:17:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:34262 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752666AbZHQOR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 10:17:27 -0400
Received: (qmail invoked by alias); 17 Aug 2009 14:17:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 17 Aug 2009 16:17:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DoTwMAv6DyRHGDPKJPLFgpKeaarKBBtp+y0UehO
	ybTIDhdGcFV1Xj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090817135651.GA4570@harikalardiyari>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126183>

Hi,

On Mon, 17 Aug 2009, Ali Polatel wrote:

> Here's what gdb has to say about it:
>
> [...]

Here's what valgrind has to say about it (with a current 'next' + 
patches):

==25434== Invalid read of size 8
==25434==    at 0x407433: process_object_response (http-walker.c:91)
==25434==    by 0x405713: finish_active_slot (http.c:657)
==25434==    by 0x40448F: process_curl_messages (http.c:119)
==25434==    by 0x40546A: step_active_slots (http.c:571)
==25434==    by 0x4080E8: fetch_object (http-walker.c:476)
==25434==    by 0x408316: fetch (http-walker.c:526)
==25434==    by 0x42876C: loop (walker.c:176)
==25434==    by 0x428C65: walker_fetch (walker.c:287)
==25434==    by 0x40401F: main (remote-curl.c:111)

Ciao,
Dscho
