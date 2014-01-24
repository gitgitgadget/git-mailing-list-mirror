From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] read-cache: use get_be32 instead of hand-rolled
 ntoh_l
Date: Thu, 23 Jan 2014 21:22:28 -0500
Message-ID: <20140124022228.GA4521@sigill.intra.peff.net>
References: <20140123212036.GA21299@sigill.intra.peff.net>
 <20140123212642.GB21705@sigill.intra.peff.net>
 <20140123233416.GE18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 03:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6WPj-0004zz-9P
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 03:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbaAXCWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 21:22:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:37964 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750969AbaAXCWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 21:22:30 -0500
Received: (qmail 16927 invoked by uid 102); 24 Jan 2014 02:22:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 20:22:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 21:22:28 -0500
Content-Disposition: inline
In-Reply-To: <20140123233416.GE18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240992>

On Thu, Jan 23, 2014 at 03:34:16PM -0800, Jonathan Nieder wrote:

> Line 1484 looks more problematic:
> 
> 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> 
> In v4 indexes, src_offset doesn't have any particular alignment so
> this conversion has undefined behavior.
> 
> Do you know if any tests exercise this code with paths that don't
> have convenient length?

My impression was that we are not testing v4 index at all (and grepping
for `--index-version`, which I think is the only way to write it,
supports that).

-Peff
