From: Stephen Bash <bash@genarts.com>
Subject: Re: Git blame only current branch
Date: Mon, 12 Dec 2011 12:05:25 -0500 (EST)
Message-ID: <5e2440c1-8d11-4d92-b42f-14169a62ced1@mail>
References: <20111212165542.GA4802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 18:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra9Jq-0004BL-HA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 18:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1LLRFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 12:05:34 -0500
Received: from hq.genarts.com ([173.9.65.1]:60636 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751959Ab1LLRFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 12:05:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 97E4ABE1283;
	Mon, 12 Dec 2011 12:05:32 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMNEEaq7u3EE; Mon, 12 Dec 2011 12:05:25 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 46288BE1270;
	Mon, 12 Dec 2011 12:05:25 -0500 (EST)
In-Reply-To: <20111212165542.GA4802@sigill.intra.peff.net>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC15 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186917>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Monday, December 12, 2011 11:55:42 AM
> Subject: Re: Git blame only current branch
> 
> On Mon, Dec 12, 2011 at 10:24:47AM -0500, Stephen Bash wrote:
> 
> > I'm curious if there's a method to make git blame merge commits
> > that introduce code to the given branch rather than commits on 
> > the original (topic) branch?  For example:
> 
> Usually when you are interested in seeing merges like this in
> git-log, you would use one of "--first-parent" or "--merges". 
> However, though "git blame" takes revision arguments, it does
> its own traversal of the graph that does not respect those 
> options.

My first thought was --first-parent, and was disappointed when I didn't find it in the blame documentation :)  I think for my purposes --first-parent is better than --merges because there are non-merge commits on the branch(es) of interest (and thus I think the problem would become ill-posed in the --merges case).

> Modifying it to do --first-parent is pretty easy:
> ... snip ...

That's pretty simple...  I'll try to do a little testing this afternoon.

Thanks!
Stephen
