From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Tue, 06 Mar 2007 08:48:09 +0100
Message-ID: <45ED1CB9.7060508@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org>	<7vejo2uaxs.fsf@assigned-by-dhcp.cox.net> <45ED179B.90500@lu.unisi.ch> <7vlkiastu8.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOUP9-0006Xh-Ff
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933985AbXCFHsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933987AbXCFHsN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:48:13 -0500
Received: from server.usilu.net ([195.176.178.200]:24237 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933985AbXCFHsM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:48:12 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Mar 2007 08:48:11 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vlkiastu8.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 06 Mar 2007 07:48:11.0231 (UTC) FILETIME=[C9CDAEF0:01C75FC3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41556>


> Do you mean you would agree that it is overkill?

It means I don't have much interest in trying to convince you your way.  I will try just once, and I have two arguments to make:

1) I added it in the first place because it made the design of patch 2/3 obvious.  If the shared configuration variable wins, I would withdraw patch 2/3 completely and just let the user use git-config (or "vi"...) to modify the default.

2) Also, I liked per-remote configuration because it gives you a quick view of which remotes you have just because you sometimes cherrypick from them, and which remotes you have because you are basing your work on them.

If you're convinced, I'll send the updated (final?) patch later today (which means you'll get it tomorrow morning in your timezone).  If you're not, I'm not sure I can update the patch today to use the shared configuration variable, but I'll get to that too.

> Also I agree with many points Dscho made.  I understand you
> agreed to avoid asprintf() from portability worries, which I
> think is a sensible thing to do.

Sure, I was somehow convinced that git was already providing a portable version of it.

> While I do not think we should avoid sscanf("%n"), I suspect
> that the code in your patch is not helped by using it that much.

No, it's not.  But it's helped a lot by using sscanf itself, and "%n" is the only way I know to reliably test the return code of sscanf and, in the process, save one strchr and one strlen.

Paolo
