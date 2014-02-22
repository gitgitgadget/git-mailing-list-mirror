From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: support --sort=version
Date: Sat, 22 Feb 2014 02:59:35 -0500
Message-ID: <20140222075935.GA1576@sigill.intra.peff.net>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <20140219140909.GA20128@sigill.intra.peff.net>
 <CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
 <20140220204345.GA3374@sigill.intra.peff.net>
 <CACsJy8BrfKckHzgwRnW_UMTjipuYWGVcumvCmQC9EG1Eq-MScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH7VK-0001VM-6F
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbaBVH7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 02:59:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:54918 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbaBVH7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 02:59:37 -0500
Received: (qmail 15072 invoked by uid 102); 22 Feb 2014 07:59:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 01:59:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 02:59:35 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BrfKckHzgwRnW_UMTjipuYWGVcumvCmQC9EG1Eq-MScA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242503>

On Fri, Feb 21, 2014 at 06:58:16PM +0700, Duy Nguyen wrote:

> >   --sort=[-][comparison:]field
> [...]
> Why not reversed order? So its syntax could be
> 
> [ "-" ] FIELD [ ":" [ "version" | "v" ] ]
> 
> It fits better to current f-e-r syntax where modifiers are after the
> colon. And it avoids the possibility that someone adds field "version"
> and we can't tell what "version" is what.

I find my version a bit more obvious, for two reasons:

  1. "version" here is not a modifier of the field name, it is a
     modifier of the sort. You cannot use it in non-sort contexts (like
     --format), and you cannot order it like other modifiers (you cannot
     say "refname:version:short", only "refname:short:version").

  2. There are actually two sort-modifiers: "-" for ordering, and then a
     comparator. In your proposal, they are split, whereas in mine, they
     are next to each other.

-Peff
