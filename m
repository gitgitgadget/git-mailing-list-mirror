From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH v3] Add to gitk an --argscmd flag to get the list of
	refs to draw at refresh time.
Date: Sat, 17 Nov 2007 20:56:59 +0100
Message-ID: <20071117195659.GO8855@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20071102222436.23191.91785.stgit@gandelf.nowhere.earth> <18238.54272.198637.788805@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItTnn-000382-9u
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761970AbXKQT5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761713AbXKQT5r
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:57:47 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:36486 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761539AbXKQT5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:57:46 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A46BA17B541;
	Sat, 17 Nov 2007 20:57:44 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8582217B575;
	Sat, 17 Nov 2007 20:57:44 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id DB5311F048; Sat, 17 Nov 2007 20:56:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18238.54272.198637.788805@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65300>

Hi Paul,

I hope I did not introduce other problems while trying to adress those.

On Sat, Nov 17, 2007 at 10:44:00PM +1100, Paul Mackerras wrote:
> What this will do is interpret the output of the program according to
> Tcl list syntax.

I'm not sure of why this interpretation is done, so it may well be that
the updated patch would behave the same.

> use error_popup rather than just writing to stderr.

While testing that, I realized that the current behaviour is not very
friendly.  While it is OK to exit on error here, when the command has
been entered on command-line, it would be rude to exit when the user
makes a typo when editing the view.  It would be more friendly to get
back to the "edit view" dialog instead; I'm not sure we can already
tell in which of the 2 situations we are - would you conisider adding
a global flag for tracking this to be an adequate solution ?

> > +set revtreeargscmd None
> 
> Why the string "None" rather than the empty string?  Is this a
> python-ism that has crept in?

Note completely - since there were already occurences of None in gitk, I
assumed it was a special value in Tcl.  Should I have searched in more
details, I would have noticed the string comparisons.

Best regards,
-- 
Yann
