From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] repack: propagate pack-objects options as strings
Date: Wed, 22 Jan 2014 20:38:47 -0500
Message-ID: <20140123013847.GD17254@sigill.intra.peff.net>
References: <20140123012656.GC17254@sigill.intra.peff.net>
 <20140123013008.GC19472@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 02:39:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W69Fx-0003J0-RX
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 02:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbaAWBiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 20:38:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:37250 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753143AbaAWBit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 20:38:49 -0500
Received: (qmail 6386 invoked by uid 102); 23 Jan 2014 01:38:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Jan 2014 19:38:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jan 2014 20:38:47 -0500
Content-Disposition: inline
In-Reply-To: <20140123013008.GC19472@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240892>

On Wed, Jan 22, 2014 at 08:30:13PM -0500, Jeff King wrote:

> -		OPT_INTEGER(0, "window", &window,
> +		OPT_STRING(0, "window", &window, N_("n"),
>  				N_("size of the window used for delta compression")),

By the way, the old code with OPT_INTEGER would always say "n" here, so
there is no change to "git repack -h" output here...

> -             OPT_INTEGER(0, "max-pack-size", &max_pack_size,
> +             OPT_STRING(0, "max-pack-size", &max_pack_size, N_("bytes"),
>                               N_("maximum size of each packfile")),

...but this one will now say:

    --max-pack-size <bytes>
                          maximum size of each packfile

I think that is more descriptive, but pack-objects does just say "n".  I
am OK with it either way.

-Peff
