From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 15:43:08 +1000
Message-ID: <17951.6252.457936.428919@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 07:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcEZp-0001uL-Sx
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 07:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXDMFnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 01:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbXDMFnv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 01:43:51 -0400
Received: from ozlabs.org ([203.10.76.45]:47798 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbXDMFnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 01:43:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 483DBDDF41; Fri, 13 Apr 2007 15:43:49 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44388>

Linus Torvalds writes:

>  - bug Paul about alternate diff viewing capabilities in gitk. He's cc'd 
>    here. A way to make the "diff" pane show just the new one, the old one, 
>    or even both side-by-side with some mousy interface?

Showing just the old lines, or just the new lines, would be dead easy,
since the Tk text widget has an "elide" option on tagged ranges of
text that effectively removes them from the display.  So I don't even
have to change the contents of the text widget, merely the display
options associated with the tags that I already have attached to the
old and new lines (that's how they get their color).

Side-by-side would be more challenging.

Alternatively I could provide a field where you can put in a filter
command to be put between the diff generator and the display parser.

Have you seen what dirdiff can do with displaying diffs?  You can
expose more context, move old and new lines up and down (but not in a
manner which changes the meaning of the diff), and split context lines
into old/new pairs, all with the mouse.  This lets me rearrange a diff
to make it more visually meaningful and understandable.  I could
import that stuff into gitk, since dirdiff is also written in Tcl/Tk.

Paul.
