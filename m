From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] Removing -n option from git-diff-files documentation
Date: Sun, 29 Apr 2007 00:05:17 -0700
Message-ID: <7vtzuzek42.fsf@assigned-by-dhcp.cox.net>
References: <20070427050550.GA9594@bowser.ruder>
	<20070427180523.GB4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ruder <andy@aeruder.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 29 09:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi3TL-0008CX-JX
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 09:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXD2HFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 03:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbXD2HFY
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 03:05:24 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65305 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbXD2HFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 03:05:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429070516.SSQP1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 03:05:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id sv5H1W0071kojtg0000000; Sun, 29 Apr 2007 03:05:17 -0400
In-Reply-To: <20070427180523.GB4489@pasky.or.cz> (Petr Baudis's message of
	"Fri, 27 Apr 2007 20:05:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45820>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Apr 27, 2007 at 07:05:50AM CEST, Andrew Ruder wrote:
>> -n is not a short form of --no-index as the documentation
>> suggests.  Removing it from the documentation and command
>> usage string.
>
> Nevertheless, git-diff-files does accept -n, apparently to limit the
> number of outputted entries or something. Where is it documented?

It is not "accept" but more like "absorb and ignore".  We
(ab)use the option parser from revision traversal machinery when
parsing "git-diff" options, but obviously options such as
max-count that relate to commit limiting do not have any meaning
to "git-diff-files" or "git-diff".
