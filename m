From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 09 Apr 2006 14:08:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604091401560.2215@localhost.localdomain>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk>
 <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
 <Pine.LNX.4.64.0604091333140.2215@localhost.localdomain>
 <20060409175316.GA21455@erlang.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 20:08:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSeL5-0008Bi-5t
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 20:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDISIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWDISIk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 14:08:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38098 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750835AbWDISIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 14:08:39 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXG00FJYVQEWXH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Apr 2006 14:08:38 -0400 (EDT)
In-reply-to: <20060409175316.GA21455@erlang.gbar.dtu.dk>
X-X-Sender: nico@localhost.localdomain
To: Peter Eriksen <s022018@student.dtu.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18556>

On Sun, 9 Apr 2006, Peter Eriksen wrote:

> On Sun, Apr 09, 2006 at 01:40:14PM -0400, Nicolas Pitre wrote:
> ...
> > It also has lots of compilation warnings.
> 
> Hm, I don't get any warnings.  Would you mind pasting them, so I
> can see what it's about?

gcc -o diff-delta.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  diff-delta.c
diff-delta.c: In function 'diff_delta':
diff-delta.c:123: warning: pointer targets in passing argument 1 of 'init_hash' differ in signedness
diff-delta.c:124: warning: pointer targets in passing argument 1 of 'init_hash' differ in signedness
diff-delta.c:170: warning: pointer targets in passing argument 1 of 'hash' differ in signedness
diff-delta.c:171: warning: pointer targets in passing argument 1 of 'hash' differ in signedness
diff-delta.c:203: warning: pointer targets in passing argument 1 of 'init_hash' differ in signedness
diff-delta.c:204: warning: pointer targets in passing argument 1 of 'init_hash' differ in signedness

Also you should avoid declaring new variables after code in the same 
scope, like you do with version_offset for example.  This is a feature 
that many C compilers don't support.


Nicolas
