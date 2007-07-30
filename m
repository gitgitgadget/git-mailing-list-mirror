From: David Kastrup <dak@gnu.org>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 11:57:00 +0200
Message-ID: <863az6uscz.fsf@lola.quinscape.zz>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 11:57:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFS04-0002s3-Ag
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 11:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbXG3J5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 05:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbXG3J5K
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 05:57:10 -0400
Received: from main.gmane.org ([80.91.229.2]:57537 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbXG3J5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 05:57:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFRzw-0001iM-3o
	for git@vger.kernel.org; Mon, 30 Jul 2007 11:57:08 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 11:57:08 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 11:57:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:RLEB+mfHVfLz2b4uNURxl0aln7M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54215>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> One has to use git-stash rather than "git stash".  Oversight?
>
> This looks like an incorrect installation, with git-stash in your
> $PATH, but not in the place git looks for its commands (I don't
> remember the exact mechanism).

I don't think so: in git.c we have at lines 362ff

                { "show-branch", cmd_show_branch, RUN_SETUP },
                { "show", cmd_show, RUN_SETUP | USE_PAGER },
                { "stripspace", cmd_stripspace },
                { "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },

So it really seems like stash is not known to git.c.  Of course, I
have no real clue about git.c's operation (or I'd have proferred a
patch) and not right now the time to look further.

-- 
David Kastrup
