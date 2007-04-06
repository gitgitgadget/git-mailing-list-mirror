From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 10/13] update delta handling in write_object() for
 --pack-limit
Date: Thu, 05 Apr 2007 20:43:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704052040170.28181@xanadu.home>
References: <56b7f5510704051538na4393d7k5e51ed2a511cc86e@mail.gmail.com>
 <7v3b3emmv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:43:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZcYK-0008TG-Ur
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 02:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767337AbXDFAnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 20:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767338AbXDFAnl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 20:43:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63048 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767337AbXDFAnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 20:43:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG100J85WOS5RC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 20:43:40 -0400 (EDT)
In-reply-to: <7v3b3emmv6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43889>

On Thu, 5 Apr 2007, Junio C Hamano wrote:

> (3) makes me wonder if we can still allow it in the thin-pack
> case by just loosening the condition here.

I don't think thin packs apply in the sliced pack usage scenario anyway.



> 
> Also I need explanation to understand why (4) is needed --
> doesn't write_one() always write base object out before writing
> a deltified object that depends on it?

Yes it does.  This is a requirement for OBJ_OFS_DELTA.


Nicolas
