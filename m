From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Shell script cleanups/style changes?
Date: Sat, 04 Aug 2007 09:10:00 +0200
Message-ID: <873ayzojw7.fsf@mid.deneb.enyo.de>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 09:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHDm5-0005F7-GY
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbXHDHKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbXHDHKG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:10:06 -0400
Received: from mail.enyo.de ([212.9.189.167]:4051 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbXHDHKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 03:10:04 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IHDlx-0000HP-VB
	for git@vger.kernel.org; Sat, 04 Aug 2007 09:10:02 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IHDlw-0001y9-Io
	for git@vger.kernel.org; Sat, 04 Aug 2007 09:10:00 +0200
In-Reply-To: <20070802214103.GT29424@schiele.dyndns.org> (Robert Schiele's
	message of "Thu, 2 Aug 2007 23:41:03 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54804>

* Robert Schiele:

>> Sure.  What about the git-rebase line using $(($end - $msgnum)) ?
>
> Bad on Solaris:
>
> $ uname -a
> SunOS solaris10-x64 5.10 Generic i86pc i386 i86pc
> $ end=1
> $ msgnum=5
> $ echo $(($end - $msgnum))
> syntax error: `(' unexpected
> $ 

Is this with /usr/xpg4/bin/sh or /bin/sh?  The latter is not POSIX and
should not be used by GIT, IMHO, otherwise there will be endless
issues in less-well-tested code paths.  Is rewriting the shebang lines
to use the POSIX shell an option for GIT?
