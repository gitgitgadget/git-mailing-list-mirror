From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Wed, 9 May 2007 01:05:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705090056231.18541@iabervon.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 09 07:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HleN3-0003hi-2P
	for gcvg-git@gmane.org; Wed, 09 May 2007 07:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968850AbXEIFFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 01:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968845AbXEIFFj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 01:05:39 -0400
Received: from iabervon.org ([66.92.72.58]:4318 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654AbXEIFFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 01:05:38 -0400
Received: (qmail 18638 invoked by uid 1000); 9 May 2007 05:05:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2007 05:05:37 -0000
In-Reply-To: <11786309071033-git-send-email-tytso@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46663>

On Tue, 8 May 2007, Theodore Ts'o wrote:

> This allows the user to regenerate the deltas in packs while doing
> a git-gc.  The user could just run git-repack -a -d -f -l after
> running git-gc, but then the first git-repack run by git-gc is
> a bit of waste.

Maybe git-gc should have an option for "compress hard"? It seems to me 
like a two-sizes-fit-all solution would be good here; "git gc" for daily 
use, and "git gc --squeeze" for when you want to make the result as small 
as possible, with compute time not being a major factor. If all you know 
is that you're going to burn this repository onto a stack of CDs and mail 
it to somebody (but don't know about delta reuse, window sizes, and 
depths, let alone good values for these), it would be good to have an 
option where it picks an appropriate different set of defaults for you.

	-Daniel
*This .sig left intentionally blank*
