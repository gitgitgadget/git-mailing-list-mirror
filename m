From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: use themed tk widgets
Date: Fri, 17 Apr 2009 23:01:32 +1000
Message-ID: <18920.32172.162401.593355@cargo.ozlabs.ibm.com>
References: <873ac8m8jg.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 15:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luniu-00031z-91
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 15:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbZDQNBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 09:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbZDQNBm
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 09:01:42 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:50806 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbZDQNBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 09:01:42 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 95D4AB7079; Fri, 17 Apr 2009 23:01:40 +1000 (EST)
In-Reply-To: <873ac8m8jg.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116737>

Pat Thoyts writes:

>   With Tk 8.5+ use the themed widgets to improve the appearence
>   on Windows and MacOSX. On X11 less difference is apparent but
>   users can select alternate themes by setting *TkTheme in the
>   resource database (eg: *TkTheme: clam)

Looks nice, but the geometry restoration code doesn't seem to work
when using the themed widgets.  I normally have gitk set so that the
top pane is about half the height of the bottom pane, but when I start
gitk with this patch both panes always come up about the same height,
no matter what sizes they had last time gitk ran.

I notice that the code that restores the height and width of the top
pane is now inside if {!$use_ttk}.  Is there no way to restore the
pane layout with the themed widgets?

Paul.
