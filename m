From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-cvsserver doesn't respect core.sharedrepository
Date: Tue, 13 Feb 2007 11:48:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702131139490.1757@xanadu.home>
References: <200702131438.30291.andyparkins@gmail.com>
 <Pine.LNX.4.63.0702131611010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702131605.29088.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 17:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH0q7-00076V-KI
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 17:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXBMQtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 11:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbXBMQtI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 11:49:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22349 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXBMQtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 11:49:07 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDE00AXAUPH9K40@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Feb 2007 11:48:54 -0500 (EST)
In-reply-to: <200702131605.29088.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39541>

On Tue, 13 Feb 2007, Andy Parkins wrote:

> That perhaps might be the explanation for the bad behaviour.  The ref is being 
> updated in git-cvsserver by writing the new head hash into the lockfile then 
> doing
> 
>     unlink($reffile);
>     rename($lockfile, $reffile);

Wouldn't it be much better if it used git-update-ref instead?  This 
manual ref updating looks like it has a potential for races to me.

Also git-update-ref should probably be used with -m to create reflog 
entries.


Nicolas
