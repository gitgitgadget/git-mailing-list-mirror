From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Fri, 06 Apr 2007 16:12:57 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704061604160.28181@xanadu.home>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
 <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
 <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
 <alpine.LFD.0.98.0704052257200.28181@xanadu.home>
 <Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org>
 <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZunt-0004YB-Rd
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 22:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbXDFUM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbXDFUM7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 16:12:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9603 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbXDFUM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 16:12:58 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG300N2METL2G70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Apr 2007 16:12:57 -0400 (EDT)
In-reply-to: <56b7f5510704061109n2878a221p391b7c3edba89c63@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43919>

On Fri, 6 Apr 2007, Dana How wrote:

> * Avoiding (e.g.) 2GB+ files when none already exist in the repository --
>  either the filesystem doesn't support anything beyond the limit,
>  or we don't want to use a >31b off_t with mmap.  (Perhaps
>  the latter case is completely avoided by some glibc 64b trickery,
>  but is that always true?)  Only the write rollback approach can address this.

If the filesystem doesn't support anything beyond the limit, you cannot 
perform any rollback either.  Because if you roll back that's because 
you crossed the limit already.  But you're not supposed to even be able 
to cross that limit in the first place if the filesystem is limited.


Nicolas
