From: Nicolas Pitre <nico@cam.org>
Subject: Re: suggested feature: someone mails me a blob,
 git please tell me what it is
Date: Fri, 16 Feb 2007 11:48:46 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702161136460.18370@xanadu.home>
References: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 17:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI6GU-0005Rw-4J
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 17:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbXBPQsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 11:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbXBPQsr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 11:48:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38418 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869AbXBPQsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 11:48:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDK00DHVEPANJ50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Feb 2007 11:48:46 -0500 (EST)
In-reply-to: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39929>

On Fri, 16 Feb 2007, Mike Coleman wrote:

> Here's a suggestion for a git feature, if git doesn't already have it.
> Since git generally doesn't use RCS-style keyword cookies (like
> "$Id$"), it'd be nice to have some other way to identify an installed
> file.  Perhaps you'd want to know exactly what rev a user is running,
> for example.
> 
> It seems like it should be fairly easy, given a blob (the file), for
> git to describe what it knows about it.  For example, it could provide
> a list of commits that it's a part of, etc.  

That is possible, but would be expensive similar to git-fsck-objects.  
All objects for each commit would need to be searched for the matching 
sha1.

> It'd be *really* nice if only the output of the sha1sum command on the 
> blob were needed.  (I can't recall exactly how git's blob SHA1's are 
> computed--maybe this isn't feasible.)

GIT adds a header of its own before object data.  You therefore need to 
use git-hash-object not sha1sum to get the right sha1 value.


Nicolas
