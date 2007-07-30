From: David Kastrup <dak@gnu.org>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 21:30:34 +0200
Message-ID: <85ir81u1t1.fsf@lola.goethe.zz>
References: <86bqduutz4.fsf@lola.quinscape.zz>
	<vpqwswi2pkw.fsf@bauges.imag.fr> <863az6uscz.fsf@lola.quinscape.zz>
	<20070730100609.GB8829@coredump.intra.peff.net>
	<86lkcytci4.fsf@lola.quinscape.zz>
	<20070730103720.GA11309@coredump.intra.peff.net>
	<86bqdutb7r.fsf@lola.quinscape.zz>
	<20070730110354.GA11676@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFaxa-0003aj-WF
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934214AbXG3TbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764485AbXG3TbO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:31:14 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:43162 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765055AbXG3TbM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 15:31:12 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 0619B1E570C;
	Mon, 30 Jul 2007 21:31:11 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id E708728EE28;
	Mon, 30 Jul 2007 21:31:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-066-191.pools.arcor-ip.net [84.61.66.191])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 99ED6225132;
	Mon, 30 Jul 2007 21:31:10 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0F4711C3952E; Mon, 30 Jul 2007 21:30:34 +0200 (CEST)
In-Reply-To: <20070730110354.GA11676@coredump.intra.peff.net> (Jeff King's message of "Mon\, 30 Jul 2007 07\:03\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3820/Mon Jul 30 14:13:24 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54256>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 30, 2007 at 12:52:40PM +0200, David Kastrup wrote:
>
>> How does it calculate its exec path?  It would appear that it would
>> not contain _either_ /usr/local/bin _or_ /opt/git/bin in my
>> installation if it can't find git-stash (which should be statable in
>> both places).
>
> See exec_cmd.c:execv_git_cmd. It checks in order:
>   1. --exec-path= on command line
>   2. $GIT_EXEC_PATH from environment
>   3. GIT_EXEC_PATH defined at compile-time (set by Makefile from
>       $(gitexecdir), which is generally the same as $(bindir))
>
> So it should have /opt/git/bin in your case, but it's possible since
> that is a Makefile variable that you failed to recompile correctly after
> changing its value.
>
>> Have a command handy for checking the exec path?
>
> git --exec-path

dak@lola:/home/tmp/git$ git --exec-path
/opt/git/bin
dak@lola:/home/tmp/git$ git stash --help
Reformatting git-stash(1), please wait...
WARNING: terminal is not fully functional
-  (press RETURN)q
dak@lola:/home/tmp/git$ git-stash --help
dak@lola:/home/tmp/git$ Usage: /usr/local/bin/git-stash [ | list | show | apply | clear]

I think I'll just soak my head in a bucket.  Don't ask me _what_ I
imagined to be experiencing here.

Maybe missing out shell completion when not typing the hyphen or
similar nonsense.  Sorry for the noise.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
