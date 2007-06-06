From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-mergetool: Make default smarter by considering user's desktop environment and editor
Date: Wed, 06 Jun 2007 10:52:59 +0200
Message-ID: <86tztljwgk.fsf@lola.quinscape.zz>
References: <466637E2.5040303@freedesktop.org> <7vabvd7bfg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 10:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvrH7-0007Eo-QK
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbXFFIxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbXFFIxn
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:53:43 -0400
Received: from main.gmane.org ([80.91.229.2]:59979 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbXFFIxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:53:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvrGn-0004nC-Ey
	for git@vger.kernel.org; Wed, 06 Jun 2007 10:53:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 10:53:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 10:53:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:dO5QMqro1ZQQm3PzfF6edyHBHrE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49270>

Junio C Hamano <junkio@cox.net> writes:

> Josh Triplett <josh@freedesktop.org> writes:
>
>> Make git-mergetool prefer meld under GNOME, and kdiff3 under KDE.  When
>> considering emerge and vimdiff, check $VISUAL and $EDITOR to see which the
>> user might prefer.
>>
>> Signed-off-by: Josh Triplett <josh@freedesktop.org>
>
> The basic idea is sound.  However...
>
>  (1) I wonder if we can get rid of the horribly long if .. elif
>      chain by using shell function and then iterate a list of them;
>
>  (2) echo "${VISUAL-$EDITOR}" | grep '^emacs'???
>
>      Some people may have explicit path (/home/me/bin/emacs),
>      and/or runs a variant of emacs called 'xemacs'.  Same for
>      vim.

Actually, a lot of people run as editor a program called "emacsclient"
or "gnuclient": this one connects to an existing Emacs session and
passes its arguments to it.  And of course, this is what git-mergetool
should then also do.

-- 
David Kastrup
