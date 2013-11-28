From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Thu, 28 Nov 2013 05:38:38 -0500
Message-ID: <20131128103838.GB14615@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124432.GJ10757@sigill.intra.peff.net>
 <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
 <5295B6A8.70303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 11:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlyzd-0001VZ-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 11:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab3K1Kil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 05:38:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:47133 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140Ab3K1Kik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 05:38:40 -0500
Received: (qmail 25227 invoked by uid 102); 28 Nov 2013 10:38:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Nov 2013 04:38:41 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Nov 2013 05:38:38 -0500
Content-Disposition: inline
In-Reply-To: <5295B6A8.70303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238491>

On Wed, Nov 27, 2013 at 10:08:56AM +0100, Karsten Blees wrote:

> Khash is OK for sha1 keys, but I don't think it should be advertised
> as a second general purpose hash table implementation. Its far too
> easy to shoot yourself in the foot by using 'straightforward' hash-
> and comparison functions. Khash doesn't store the hash codes of the
> keys, so you have to take care of that yourself or live with the
> performance penalties (see [1]).
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/237876

Yes. I wonder if we should improve it in that respect. I haven't looked
carefully at the hash code you posted elsewhere, but I feel like many
uses will want a macro implementation to let them store arbitrary types
smaller or larger than a pointer.

-Peff
