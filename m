From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Tue, 30 Sep 2008 03:09:38 -0400
Message-ID: <20080930070938.GA14757@sigill.intra.peff.net>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 09:11:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkZNp-0001Cf-Ng
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbYI3HJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 03:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYI3HJo
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 03:09:44 -0400
Received: from peff.net ([208.65.91.99]:4715 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYI3HJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 03:09:44 -0400
Received: (qmail 29770 invoked by uid 111); 30 Sep 2008 07:09:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Sep 2008 03:09:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 03:09:38 -0400
Content-Disposition: inline
In-Reply-To: <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97070>

On Tue, Sep 30, 2008 at 08:37:00AM +0200, Wincent Colaiuta wrote:

>> "commit" is just noise.
>
> Excellent point on the noise. Independently of whether the branch info  
> gets added the word "commit" should probably be dropped.

The branch info has already been added, if you count it being in next
(in the form of "on $branch: ").

> As far as long-line-wrapping goes, I don't really think this is a problem 
> for Git to solve (by truncation or any other means); it's more of a user 
> behaviour thing where one would hope that users would get into the habit 
> of using concise subject lines and branch names.

How concise must we be? I wrap my commit messages at 60 characters,
which I consider quite conservative. But

  Created commit abcd1234 on jk/my-topic-branch:

takes up over half of an 80-column terminal. Is that a long branch name?
Browsing "git log --grep=Merge.branch --pretty=format:%s origin/next"
suggests it's not terribly out of line (at least by Junio's standards).

Dropping "commit " will help some. But given how much width is still
used, and the fact that this message is really just to say "yes, I
confirm that we just created the commit you asked for", I think
truncating (with dots) to keep it within 80 characters is reasonable.

-Peff
