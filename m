From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: git-gui Ctrl-U (unstage) broken
Date: Mon, 6 Feb 2012 17:48:51 +0100
Message-ID: <1kf1ynj.18kgomh1crpruyM%lists@haller-berlin.de>
References: <877h0at7ua.fsf@fox.patthoyts.tk>
Cc: git@vger.kernel.org
To: patthoyts@users.sourceforge.net (Pat Thoyts),
	victor.engmark@gmail.com (Victor Engmark)
X-From: git-owner@vger.kernel.org Mon Feb 06 17:48:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuRjo-00066o-UT
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 17:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab2BFQsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 11:48:16 -0500
Received: from server90.greatnet.de ([83.133.96.186]:46883 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab2BFQsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 11:48:15 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 439642A04AD;
	Mon,  6 Feb 2012 17:46:11 +0100 (CET)
In-Reply-To: <877h0at7ua.fsf@fox.patthoyts.tk>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190078>

Pat Thoyts <patthoyts@users.sourceforge.net> wrote:

> Victor Engmark <victor.engmark@gmail.com> writes:
> 
> >Using the git-gui available with the default Ubuntu 10.10 repos, I'm
> >not able to unstage files with the default keyboard shortcut. To
> >reproduce:
> >1. Change a file in the repository
> >2. Run `git gui`
> >3. Stage the changed file
> >4. Select the changed file in the "Staged Changes (Will Commit)" list
> >5. Click Ctrl-U
> >
> >Expected outcome: The selected file should be unstaged.
> >
> >Actual outcome: Nothing at all changes in the GUI.
> 
> I checked this with the current version (gitgui-0.16.0) and it works ok
> for me (on windows) - ie: ctrl-u unstaged a selected file.

Pat, it depends on where the focus is when you press ctrl-u.  If you
click in the diff pane, and then select the file to unstage, and then
press ctrl-u, then nothing happens. If you click in the commit message
field, then ctrl-u works fine.

The same problem exists with ctrl-j for "Revert Changes". In that case
it is caused by the vi bindings that were introduced by 60aa065f69. It
seems that a binding for <Key-j> is also triggered by ctrl-j (if you
have a long diff you can see the diff pane scroll down by one line).

I'm not sure how to explain why ctrl-u doesn't work though, as I can't
see any binding for <Key-u>, but maybe this gives a clue to someone who
knows more about TCL than I do.

(It's not Windows-specific, btw: the same problem exists on Mac with
Command-U and Command-J.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
