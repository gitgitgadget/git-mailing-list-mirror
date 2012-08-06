From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] implement metadata cache subsystem
Date: Mon, 6 Aug 2012 16:38:26 -0400
Message-ID: <20120806203826.GA12073@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
 <20120804171146.GF19378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 22:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyU4S-0008QN-WC
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 22:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669Ab2HFUia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 16:38:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53691 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756458Ab2HFUi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 16:38:29 -0400
Received: (qmail 19332 invoked by uid 107); 6 Aug 2012 20:38:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 16:38:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 16:38:26 -0400
Content-Disposition: inline
In-Reply-To: <20120804171146.GF19378@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202986>

On Sat, Aug 04, 2012 at 01:11:46PM -0400, Jeff King wrote:

> +#define IMPLEMENT_CACHE(name, maptype, ktype, vtype) \
> +static struct map_persist_sha1pair_uint32 name##_map; \

A minor fixup, but this should obviously be "map_persist_##maptype". It
doesn't matter for this series (since we only instantiate one cache, and
it uses a sha1pair_uint32 map), but obviously this was meant to be
generic...

-Peff
