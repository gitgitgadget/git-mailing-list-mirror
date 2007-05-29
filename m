From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC] super indexes to span multiple packfiles
Date: Tue, 29 May 2007 19:20:35 +0300
Message-ID: <465C52D3.3010605@qumranet.com>
References: <20070529071622.GA8905@spearce.org> <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 18:41:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht4l2-0005gC-LE
	for gcvg-git@gmane.org; Tue, 29 May 2007 18:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbXE2QlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbXE2QlL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 12:41:11 -0400
Received: from il.qumranet.com ([82.166.9.18]:59081 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbXE2QlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 12:41:10 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 May 2007 12:41:09 EDT
Received: from [10.0.0.1] (cleopatra [10.0.0.1])
	by il.qumranet.com (Postfix) with ESMTP id 701FA250037;
	Tue, 29 May 2007 19:20:35 +0300 (IDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <9e4733910705290905m66dd3081ubda9b92a707fc903@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48702>

Jon Smirl wrote:
>
> My work with databases leads me to believe that figuring out how to
> pack everything into a smaller space always beats efforts put into
> incrementally improving the indexing scheme. Packing into a smaller
> space reduces the total IO needs and that's always a winner.
>

Another way to achieve that is to place objects that are accessed 
together nearby, and issue a larger read so as to bring them into 
cache.  I imagine that placing commit objects and associated tree and 
blobs in history order should help here (but maybe git already does 
that, I'm not familiar with the internals).

-- 
error compiling committee.c: too many arguments to function
