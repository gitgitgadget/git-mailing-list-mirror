From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: support configuring --sort via .gitconfig
Date: Wed, 9 Jul 2014 18:15:06 -0400
Message-ID: <20140709221506.GA27388@sigill.intra.peff.net>
References: <1404940860-4004-1-git-send-email-jacob.e.keller@intel.com>
 <20140709215816.GE25854@sigill.intra.peff.net>
 <1404943640.23510.40.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds@gmail.com" <pclouds@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 00:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X508y-0007B4-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 00:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbaGIWPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 18:15:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:59031 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751226AbaGIWPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 18:15:09 -0400
Received: (qmail 12572 invoked by uid 102); 9 Jul 2014 22:15:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 17:15:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 18:15:06 -0400
Content-Disposition: inline
In-Reply-To: <1404943640.23510.40.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253164>

On Wed, Jul 09, 2014 at 10:07:20PM +0000, Keller, Jacob E wrote:

> I only noticed the sort recently, and I first tried to add an alias like
> "tag = tag --sort=v:refname" but git didn't pick up the alias of the
> name already.

It was only added recently (v2.0.0). :)

As you noticed, we do not allow aliases of actual git commands. I think
it would be nice to notice and complain rather than silently ignoring
them, though.

> I use a lot of version-style tags so I wanted this to be default. I
> did notice that the format of the sort parameter was actually pretty
> complex, so it seemed that more was intended to be added to it.

Yeah, the complexity is in preparation for becoming more flexible. I
think we'd consider short options for commonly-used sorts, but were
waiting for them to prove their value in the field.

> The only main issue would be the location of the sort-configure code,
> but that is actually easy to move so I don't think it's a big deal. The
> configuration interface should remain similar.

Agreed. It's not a problem moving code around. But once a user-facing
feature is released, we try to keep compatibility with it. So as long as
the config option's format stays the same (or strictly increases in
features), that is fine.

> > Your link to git-tag[5] should be to git-tag[1], I think. The final
> > number is the manpage section.
> 
> Which I thought was 5 for the commands? Or is it always [1]?

Commands are 1. File formats are 5 (so there are some things in section
5 in git). "man man" has more.

> > I was going to complain that this is duplicating the sort documentation
> > from git-tag, but I see you actually moved it from the --sort option to
> > here, and refer back from there to here.
> 
> I actually didn't remove anything from git-tag, I only added the
> reference to git-config. But I can keep from duplicating the
> documentation in there. I like the idea of using an included file
> though.

Oh, sorry, I just misread the patch. Then I'll fall back to my original
complaint. :) We should not duplicate, but just refer back to
git-tag(1).

> Alright that makes sense. I will send a v2 soon. Thanks for the
> comments.

You're welcome. Thanks for working on git (and welcome to the list, I
think).

-Peff
