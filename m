From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] Allow explicit ANSI codes for colors
Date: Sat, 27 Feb 2010 03:51:45 -0500
Message-ID: <20100227085144.GD27191@coredump.intra.peff.net>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
 <1267246670-19118-2-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 09:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlIOw-00029e-0K
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 09:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967992Ab0B0Ivs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 03:51:48 -0500
Received: from peff.net ([208.65.91.99]:34203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967989Ab0B0Ivs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 03:51:48 -0500
Received: (qmail 12060 invoked by uid 107); 27 Feb 2010 08:52:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 27 Feb 2010 03:52:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2010 03:51:45 -0500
Content-Disposition: inline
In-Reply-To: <1267246670-19118-2-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141192>

On Fri, Feb 26, 2010 at 11:57:46PM -0500, Mark Lodato wrote:

> Allow explicit ANSI codes to be used in configuration options expecting
> a color.  The form is "[...m", where "..." are characters in the ASCII
> range 0x30 to 0x3f.  This allows users to specify more complex colors
> (generically, SGR attributes) than our color language allows.  For
> example, to get blinking, bold, underlined, italic, red text,
> use "[5;1;4;3;31m".

I am not against this patch if it gets us some flexibility that is not
otherwise easy to attain, but wouldn't it be more user friendly for us
to support "red blink bold ul italic"? AFAICT, the only things standing
the way of that are:

  - we don't support the italic attribute yet (are there are a lot of
    others that we are missing?)

  - the parser in color_parse_mem already understands how to parse
    multiple attributes, but it just complains after the first one

-Peff
