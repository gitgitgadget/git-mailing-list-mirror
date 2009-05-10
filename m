From: Peter Cordes <peter@cordes.ca>
Subject: cosmetic bug in gitk cherry-pick
Date: Sun, 10 May 2009 00:36:59 -0300
Message-ID: <20090510033659.GC7193@cordes.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 06:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M30K4-0000rO-Ie
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 06:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbZEJEHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 00:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZEJEHX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 00:07:23 -0400
Received: from smtpout.eastlink.ca ([24.222.0.30]:31380 "EHLO
	smtpout.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbZEJEHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 00:07:18 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2009 00:07:18 EDT
Received: from ip03.eastlink.ca ([24.222.39.36])
 by mta02.eastlink.ca (Sun Java System Messaging Server 6.2-4.03 (built Sep 22
 2005)) with ESMTP id <0KJE0084DSPRJP51@mta02.eastlink.ca> for
 git@vger.kernel.org; Sun, 10 May 2009 00:37:03 -0300 (ADT)
Received: from blk-11-22-45.eastlink.ca (HELO llama.cordes.ca) ([76.11.22.45])
 by ip03.eastlink.ca with ESMTP; Sun, 10 May 2009 00:37:03 -0300
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1M2zqV-0001BO-00	for <git@vger.kernel.org>; Sun, 10 May 2009 00:36:59 -0300
Content-disposition: inline
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah8GALroBUpMCxYt/2dsb2JhbACBUMsIg34F
X-IronPort-AV: E=Sophos;i="4.40,322,1238986800";   d="scan'208";a="338945707"
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118699>

 If a cherry-pick requires conflict resolution, gitk does:
if {[confirm_popup [mc "Cherry-pick failed because of merge\
                        conflict.\nDo you wish to run git citool to\
                        resolve it?"]]} {

 That gives the user a Yes/Cancel dialog, but in this case Cancel
really means "No, don't run anything", _not_ cancel the cherry-pick.
So IMHO, it would be better if the dialog options were Yes/No.

 If you added the button text as parameters to the confirm_popup
function, you'd have to pass it the default strings everywhere, and
the extra visual noise of all that would probably make this bug not
worth fixing.

 Unless tcl supports functions with default arguments, like C++'s
int foo(int i, int j=42);  Unfortunately I don't know tcl.

 git (with gitk and git gui) is the best thing since emacs.  Happy
hacking!

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
