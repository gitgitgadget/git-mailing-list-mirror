From: Jeff King <peff@peff.net>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Tue, 6 Nov 2007 13:41:14 -0500
Message-ID: <20071106184113.GA28204@sigill.intra.peff.net>
References: <20071105175654.GD6205@artemis.corp> <20071106175627.GB9517@artemis.corp> <20071106180910.GA25934@sigill.intra.peff.net> <7vwssvgrm6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 19:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpTMi-0002rE-7j
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 19:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbXKFSlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 13:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbXKFSlS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 13:41:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4556 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXKFSlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 13:41:17 -0500
Received: (qmail 32382 invoked by uid 111); 6 Nov 2007 18:41:16 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 06 Nov 2007 13:41:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2007 13:41:14 -0500
Content-Disposition: inline
In-Reply-To: <7vwssvgrm6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63701>

On Tue, Nov 06, 2007 at 10:23:45AM -0800, Junio C Hamano wrote:

> >>     $ git push origin :teaser
> >>     To ssh://git.corp/srv/git/mmsx.git
> >>      - [deleting]        teaser
> >>     refs/heads/teaser: 05518bc7df1af680447f58b034b108f66668db03 -> deleted
> >>     Everything up-to-date
> >>     fatal: Invalid revision range 05518bc7df1af680447f58b034b108f66668db03..0000000000000000000000000000000000000000
> >>     fatal: ambiguous argument 'refs/heads/teaser': unknown revision or path not in the working tree.
> >>     Use '--' to separate paths from revisions
> 
> Isn't this coming from a loosely written post-receive hook that
> wants to send mail or something and forgets that a ref could be
> removed?

That would make sense. I was wondering how in the world he managed to
provoke output from git-push that came after the send_pack call. So I
think this is unrelated to the bug we were discussing (although the
'Everything up-to-date' message is easily reproducible and seems a bit
silly given that we did push some changes).

-Peff
