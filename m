From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Add new option in the right click menu in git gui
Date: Fri, 26 Mar 2010 14:53:49 +0100
Message-ID: <20100326135346.GB22339@book.hvoigt.net>
References: <7fce93be1002181511v1c671f82u7f3d7cc6e3512bab@mail.gmail.com> <20100301171222.GA35830@book.hvoigt.net> <1267478971.4400.5.camel@kheops> <36ca99e91003011345n43aad0c5m5c02eaf692d54efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sylvain@abstraction.fr, git <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 14:54:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv9z5-0007rc-I3
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 14:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab0CZNxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 09:53:54 -0400
Received: from darksea.de ([83.133.111.250]:34427 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510Ab0CZNxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 09:53:53 -0400
Received: (qmail 4829 invoked from network); 26 Mar 2010 14:53:50 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 26 Mar 2010 14:53:50 +0100
Content-Disposition: inline
In-Reply-To: <36ca99e91003011345n43aad0c5m5c02eaf692d54efd@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143230>

Hi,

this email has been lying in my mailbox for while ...

On Mon, Mar 01, 2010 at 10:45:10PM +0100, Bert Wesarg wrote:
> Actually, I would like to be able to have a right click menu for the
> path too and have access to the guitool entries in the Tools menu
> which require a path (ie. needsfile=true). That would reduce by mouse
> movements drastically.
> 
> I have looked into this issue by myself, but I'm not that familiar with tcl/tk.

Just try it. The "Tcl Introduction" sample chapter from this book[1]
explains the tcl language in 17 pages quite nicely.

I thought of this myself but never had the time to do it. If you are
still interested in implementing it take a look at the 'bind' command.
It lets you bind procedures to events that occur on widgets or the
application. For the diff view this is done in git-gui.sh on around line
3465 with this command:

  bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg $ctxmsm %x %y %X %Y]

bind_button3 is just a wrapper so bind is platform independent. So you
probably want to implement a method similar to popup_diff_menu which
popups the right menu for the selected file.

BTW, the widgets for the files are of the same type (text) as $ui_diff
and are stored in the variables: $ui_index and $ui_workdir for the index
and working directory respectively.

Hope that helps.

cheers Heiko

[1] http://www.beedub.com/book/
