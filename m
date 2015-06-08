From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/13] prune_remote(): use delete_refs()
Date: Mon, 8 Jun 2015 13:12:03 -0400
Message-ID: <20150608171202.GB6863@peff.net>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
 <2ce5b2c64d002ce649c2192bacdf505c4921caa6.1433763494.git.mhagger@alum.mit.edu>
 <CAGZ79kYcO95M6DsPa71uckOcOKs-mkz2P+NtEKx5qYfOcDw99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:12:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20as-0002EN-PB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbFHRMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:12:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:42935 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753349AbbFHRMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:12:06 -0400
Received: (qmail 17638 invoked by uid 102); 8 Jun 2015 17:12:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Jun 2015 12:12:06 -0500
Received: (qmail 6968 invoked by uid 107); 8 Jun 2015 17:12:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Jun 2015 13:12:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2015 13:12:03 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYcO95M6DsPa71uckOcOKs-mkz2P+NtEKx5qYfOcDw99g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271084>

On Mon, Jun 08, 2015 at 09:57:04AM -0700, Stefan Beller wrote:

> On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > This will result in errors being emitted for references that can't be
> > deleted, but that is a good thing.
> 
> This sounds a bit like hand-waving to me. "Trust me, I'm an engineer!".

I think the argument is "we failed to do that the user asked for, but
never reported the reason why".

But I don't see how that is the case. We already complain if
repack_without_refs fail, and AFAICT the original call to delete_ref()
would emit an error, as well.

-Peff
