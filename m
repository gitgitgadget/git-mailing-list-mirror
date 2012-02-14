From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2012, #05; Mon, 13)
Date: Tue, 14 Feb 2012 17:09:53 -0500
Message-ID: <20120214220953.GC24802@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:10:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQZX-0005oX-9R
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab2BNWJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:09:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35967
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab2BNWJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:09:57 -0500
Received: (qmail 12747 invoked by uid 107); 14 Feb 2012 22:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:17:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 17:09:53 -0500
Content-Disposition: inline
In-Reply-To: <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190775>

On Tue, Feb 14, 2012 at 02:05:16PM -0800, Junio C Hamano wrote:

> > Yikes. I was planning to re-roll this, but got sidetracked discussing
> > David's git-cola case. Besides a few minor tweaks in the documentation
> > patch, the actual include patch is buggy, and accidentally turns on
> > includes for "git config --list".
> 
> Hmm, I thought t1305 covered "config --list", and ... oops, it makes sure
> the output contains the inclusion.

Yes. It should include it (and does correctly) when not using any
per-file options, but does not correctly turn it off for the per-file
case (because we bail to regular git_config instead of custom lookup
code).

> > Do you want to revert and re-do to make master pretty, or should I just
> > build on top?
> 
> Do you mean 'next'?

I meant "revert from next and re-reroll, so that when the re-roll gets
merged to master, the result there will look pretty".

-Peff
