From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] pager: config variable pager.color
Date: Sun, 30 Jul 2006 02:43:47 +0200
Message-ID: <E1G6zPH-00062L-Je@moooo.ath.cx>
References: <E1G6xHb-0008Rw-G2@moooo.ath.cx> <Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 02:43:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6zPN-0002d7-Uq
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 02:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWG3Anu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 20:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWG3Anu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 20:43:50 -0400
Received: from moooo.ath.cx ([85.116.203.178]:10891 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750900AbWG3Anu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 20:43:50 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24442>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Why? The three users of cmd_log_walk() need to call setup_pager() 
> explicitely, when cmd_log_walk() can do it for them?

The explanation is below the commit message:
"setup_pager has to be called before git_diff_ui_config because the
latter uses pager_use_color initialized by setup_pager."

> Oh, and I do not really understand why you would enable color _at all_ if 
> you want to disable it when paging. Do you have many instances when you 
> want a color diff which is short enough not to be paged?
When I use a pager that escapes the escape character or highlights the
content itself the output of git diff without the pager should have
colors but not with the pager.  For example using git diff with a
pathspec is quite short most of the time.  For git diff I have to
enable paging manually and run git diff | $PAGER usually but git log
uses the pager automatically and should not use colors with it.
