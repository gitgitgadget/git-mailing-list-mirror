From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Makefile: introduce SANE_TOOL_PATH for prepending
	required elements to PATH
Date: Mon, 8 Jun 2009 09:50:47 -0400
Message-ID: <20090608135047.GB28101@sigill.intra.peff.net>
References: <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHMfucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@ciph
 er.nrlssc.navy.mil> <20090608114351.GA13775@coredump.intra.peff.net> <nwND53LJ3yJOus0fY2Tjm-DbTAR8lJKtmBZRYJ4EcvNx7qWStwbs9w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDfFX-0004Sa-OG
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 15:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZFHNus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbZFHNur
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 09:50:47 -0400
Received: from peff.net ([208.65.91.99]:44308 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964AbZFHNuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 09:50:46 -0400
Received: (qmail 21646 invoked by uid 107); 8 Jun 2009 13:50:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Jun 2009 09:50:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 09:50:47 -0400
Content-Disposition: inline
In-Reply-To: <nwND53LJ3yJOus0fY2Tjm-DbTAR8lJKtmBZRYJ4EcvNx7qWStwbs9w@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121074>

On Mon, Jun 08, 2009 at 08:39:50AM -0500, Brandon Casey wrote:

> > Am I crazy for not having EDITOR=vim instead of EDITOR=vi? Perhaps. But
> > I wanted to point out that tweaking the PATH behind the user's back does
> > cause surprises in the real world.
> 
> Good points.  I'm fine with dropping this patch, especially when it causes
> problems for a real Solaris user, which I'm not.

Let me point out that I'm also not a real Solaris user. These days all I
use it for is test-compiling git. So you can take my report with a grain
of salt.

> I don't like that git has a dependency on the user's PATH being set
> correctly though.  That's why I liked the patch.  I guess I could modify
> all the uses of sed and friends to look like $SED and then set SED to
> /usr/xpg4/bin/sed on Solaris.  It doesn't sound like that is necessary
> in practice though.

Yeah, I think requiring the user's PATH to be set correctly and tweaking
the PATH behind the user's back are both unsatisfactory solutions. Using
$SED everywhere solves both problems, but would probably be quite
annoying to maintain. So I guess it is a matter of picking our poison.

-Peff
