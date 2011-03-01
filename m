From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/3] Fix unnecessary (mtime) updates of files during
 merge
Date: Tue, 1 Mar 2011 14:36:03 -0500
Message-ID: <20110301193603.GB10082@sigill.intra.peff.net>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
 <20110301193142.GA10082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVMW-0007nt-0P
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420Ab1CATfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:35:54 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45366 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244Ab1CATfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:35:54 -0500
Received: (qmail 9436 invoked by uid 111); 1 Mar 2011 19:35:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 19:35:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 14:36:03 -0500
Content-Disposition: inline
In-Reply-To: <20110301193142.GA10082@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168241>

On Tue, Mar 01, 2011 at 02:31:42PM -0500, Jeff King wrote:

> I think the fix you have for the first testcase is reasonable. It feels
> a little like a band-aid, as we are throwing away stat information early
> on and then pulling it again from the filesyste at the end. But from
> your description, the real fix to that would probably involve some
> changes to the way unpack_trees works, and that's probably complex
> enough that the band-aid is a good fix for now.

Oh, and I confirmed that it does fix Stephen's testcase, as well. With
the exception of some portability issues in the test case that JSixt
already pointed out:

Acked-by: Jeff King <peff@peff.net>

For what that's worth. This is the first time I've had to look at the
merge-recursive code in any depth. :)

-Peff
