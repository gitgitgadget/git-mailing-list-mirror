From: Daniel Barkalow <barkalow@iabervon.org>
Subject: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 03:12:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 09:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Xss-00006D-7H
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 09:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbXFSHMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 03:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbXFSHMI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 03:12:08 -0400
Received: from iabervon.org ([66.92.72.58]:4380 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489AbXFSHMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 03:12:05 -0400
Received: (qmail 10537 invoked by uid 1000); 19 Jun 2007 07:12:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2007 07:12:04 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50449>

In my branch at: git://iabervon.org/~barkalow/git builtin-fetch

I have a bunch of not-for-merging history leading up to a C version of 
fetch which passes all of the tests except that:

 * it might be fetching too much with --depth.
 * bundle isn't implemented.
 * when a branch config file section refers to a branches/* remote, the 
   merge setting is used (if one is given), even though this isn't useful 
   either way.
 * branch.<name>.merge is treated like the source side of a refspec 
   (although it cannot be a wildcard), and it fetched refs are marked for 
   merging if they name the same ref, even if they are not character-wise 
   identical to the source side of the refspec used to fetch them.

I've got more work to do on it (such as actually using my parser for 
parsing the refspecs and making the logic less convoluted), but I thought 
I'd report my progress.

I'll give a sign-off to anyone who extracts patches that can be applied, 
if anybody wants to.

	-Daniel
*This .sig left intentionally blank*
