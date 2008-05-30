From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Fri, 30 May 2008 14:21:44 +0200
Message-ID: <200805301421.46162.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 14:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K23cj-0006zg-2l
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 14:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbYE3MV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 08:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYE3MV2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 08:21:28 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6027 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbYE3MV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 08:21:28 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 May 2008 14:21:26 +0200
Received: from vpn-global-dhcp3-055.ethz.ch ([129.132.210.55]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 May 2008 14:21:26 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080529185808.GA2140@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 30 May 2008 12:21:26.0547 (UTC) FILETIME=[AE799E30:01C8C24F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83290>

Jeff King wrote:
> But I find the interface a bit clunky. I would much rather get dumped in
> my favorite editor, which happens to be quite fast at removing a subset
> of lines. After editing, any lines remaining would be staged.
> 
> We would have to figure out what happens if lines are added or edited,
> of course. It may be right to signal an error, or maybe there is some
> other useful functionality that can come of that. I think other systems
> have some diff-editing functionality (IIRC, cogito did). It is probably
> worth looking at that for ideas.

We could just see if the hunk applies to the unchanged index (still
assuming we're inside 'add -p'), and if not, reject the edit.

Unfortunately git-apply does not seem to have a --dry-run option.
(Even stranger, when given the option --dry-run it tries to open a
patch of that name.)  What is the recommended way to do such things?
Make a backup copy of the index and apply --cached anyway?

- Thomas

-- 
Thomas Rast
trast@student.ethz.ch
