From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] UTF8 BOM follow-up
Date: Thu, 16 Apr 2015 15:26:30 -0400
Message-ID: <20150416192629.GA13601@peff.net>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429209548-32297-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 21:26:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YipQs-0001FK-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 21:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbbDPT0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 15:26:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:46432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752101AbbDPT0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 15:26:33 -0400
Received: (qmail 16335 invoked by uid 102); 16 Apr 2015 19:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 14:26:32 -0500
Received: (qmail 28210 invoked by uid 107); 16 Apr 2015 19:26:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 15:26:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 15:26:30 -0400
Content-Disposition: inline
In-Reply-To: <1429209548-32297-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267329>

On Thu, Apr 16, 2015 at 11:39:04AM -0700, Junio C Hamano wrote:

> This is on top of the ".gitignore can start with UTF8 BOM" patch
> from Carlos.
> 
> Second try; the first patch is new to clarify the logic in the
> codeflow after Carlos's patch, and the second one has been adjusted
> accordingly.
> 
> Junio C Hamano (4):
>   add_excludes_from_file: clarify the bom skipping logic
>   utf8-bom: introduce skip_utf8_bom() helper
>   config: use utf8_bom[] from utf.[ch] in git_parse_source()
>   attr: skip UTF8 BOM at the beginning of the input file

This one looks OK to me. The manual adjustment of "size" in the second
one is a little funny, but I guess avoiding a pointer for that size
parameter makes the final one (that uses strlen) a lot easier.

-Peff
