From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Mon, 5 Oct 2009 18:00:32 -0400
Message-ID: <20091005220032.GA29113@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
 <7vljjpacax.fsf@alter.siamese.dyndns.org>
 <20091005191257.GA24305@coredump.intra.peff.net>
 <7vd451ab16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:08:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuvjA-0003XD-8C
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 00:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZJEWBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbZJEWBT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 18:01:19 -0400
Received: from peff.net ([208.65.91.99]:37021 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849AbZJEWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 18:01:18 -0400
Received: (qmail 20669 invoked by uid 107); 5 Oct 2009 22:04:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 18:04:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 18:00:32 -0400
Content-Disposition: inline
In-Reply-To: <7vd451ab16.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129598>

On Mon, Oct 05, 2009 at 12:36:05PM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] git-pull: dead code removal
> 
> Back when a74b170 (git-pull: disallow implicit merging to detached HEAD,
> 2007-01-15) added this check, $? referred to the error status of reading
> HEAD as a symbolic-ref; but cd67e4d (Teach 'git pull' about --rebase,
> 2007-11-28) moved the command away from where the check is, and nobody
> noticed the breakage.  Ever since, $? has always been 0 (tr at the end of
> the pipe to find merge_head never fails) and other case arms were never
> reached.
> 
> These days, error_on_no_merge_candidates function is prepared to handle a
> detached HEAD case, which was what the code this patch removes used to
> handle.

Looks good to me.

Acked-by: Jeff King <peff@peff.net>

-Peff
