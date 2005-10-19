From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Errors from http-fetch
Date: Wed, 19 Oct 2005 15:46:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510191536350.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 19 21:47:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESJtn-0002Vd-VT
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 21:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVJSTqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 15:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVJSTqx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 15:46:53 -0400
Received: from iabervon.org ([66.92.72.58]:51216 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751241AbVJSTqw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 15:46:52 -0400
Received: (qmail 8373 invoked by uid 1000); 19 Oct 2005 15:46:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Oct 2005 15:46:10 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10299>

I've now started getting errors from http-fetch; my guess for the output 
is that it has problems if an object is not available loose, and is only 
available in a pack file which is already being downloaded for a different 
object, possibly only if the first request to be made for the loose 
object is not the first one to fail.

On the other hand, it looks like just trying again works fine (or, at 
least, makes progress), so there's no need to fall back to rsync or such.

But that also means that, in order to try to make a repeatable test, you 
need to copy your state before you run it and get the error; I'll probably 
try this evening to work it out.

	-Daniel
*This .sig left intentionally blank*
