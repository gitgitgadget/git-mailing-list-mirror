From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 19:00:34 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031856110.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
 <20070403210319.GH27706@spearce.org>
 <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
 <20070403211709.GJ27706@spearce.org>
 <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
 <56b7f5510704031540i4df918e6g5a82389b6759c50b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrzV-0007eE-Aw
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992481AbXDCXAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992482AbXDCXAh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:00:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14933 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992481AbXDCXAg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:00:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFY00ITZ2KYWM90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 19:00:35 -0400 (EDT)
In-reply-to: <56b7f5510704031540i4df918e6g5a82389b6759c50b@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43690>

On Tue, 3 Apr 2007, Dana How wrote:

> Do you get what you want if you move to fewer larger INDEX files
> but not pack files -- in the extreme, one large index file?

No that doesn't solve the clone/fetch of large amount of data cleanly.

> A "super index" could be built from multiple .idx files.
> This would be a new file (format) unencumbered by the past,
> so it could be tried out more quickly.
> Just like objects are pruned when packed,
> .idx files could be pruned when the super index is built.

This is an idea to consider independently of any other issues.

> Perhaps a number of (<2GB) packfiles and a large index
> file could work out.
> 
> Larger and larger pack files make me nervous.
> They are expensive to manipulate,
> and >2GB requires a file format change.

No.  Larger pack files are not more expensive than the same set of 
objects spread into multiple packs.  In fact I'd say it's quite the 
opposite.  And larger pack files do not require a pack format change -- 
it's just the index that has to change and the index is a local matter.


Nicolas
