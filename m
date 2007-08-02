From: David Kastrup <dak@gnu.org>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Thu, 02 Aug 2007 12:31:25 +0200
Message-ID: <86fy32kz2a.fsf@lola.quinscape.zz>
References: <86abtbnzpr.fsf@lola.quinscape.zz>
	<7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
	<85r6mnrs1z.fsf@lola.goethe.zz> <20070802101056.GA31182@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 12:35:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGY1V-0004NQ-Q5
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbXHBKfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXHBKfO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:35:14 -0400
Received: from main.gmane.org ([80.91.229.2]:45930 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbXHBKfM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:35:12 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IGY1G-0007nz-Ez
	for git@vger.kernel.org; Thu, 02 Aug 2007 12:35:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 12:35:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 12:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:O81A7bknVniR1qfsqYv2KGwFYD8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54538>

Matthias Lederhofer <matled@gmx.net> writes:

> David Kastrup <dak@gnu.org> wrote:
>> a) Using system and shell-quoting the filename.  Advantage: one can
>> set EDITOR='"/home/dak/My Programs/editor"' and have it work.
>> Disadvantage: shell-quoting a file name seems shell- and
>> system-dependent.

Actually I was talking C here, and the editor is never called from C
in git but rather from the shell.  So this problem is a non-problem
for us.

> What about this instead of quoting the argument?
>
>     sh -c '$EDITOR "$1" "$2"' editor +5 /path/to/file
>
> (i.e. for C execvp("/bin/sh", "-c", "$EDITOR \"$1\" \"$2\"", "editor",
>     "+5", "/path/to/file"))

It suffers from the fault that it does not work as far as I can see.
-c does not set the positional parameters.

-- 
David Kastrup
