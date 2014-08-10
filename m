From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixing unclear messages
Date: Sun, 10 Aug 2014 15:37:00 -0400
Message-ID: <20140810193659.GB9886@peff.net>
References: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
 <1407683607-4143-2-git-send-email-ash@kambanaria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, avarab@gmail.com, jn.avila@free.fr,
	worldhello.net@gmail.com, marcopaolone@gmail.com,
	marcomsousa@gmail.com, peter@softwolves.pp.se,
	ralf.thielow@gmail.com, gitster@pobox.com
To: Alexander Shopov <ash@kambanaria.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGYvd-0002IX-SK
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 21:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaHJThL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 15:37:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:49822 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751122AbaHJThK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 15:37:10 -0400
Received: (qmail 32729 invoked by uid 102); 10 Aug 2014 19:37:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (204.237.18.137)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Aug 2014 14:37:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Aug 2014 15:37:00 -0400
Content-Disposition: inline
In-Reply-To: <1407683607-4143-2-git-send-email-ash@kambanaria.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255101>

On Sun, Aug 10, 2014 at 06:13:27PM +0300, Alexander Shopov wrote:

> Signed-off-by: Alexander Shopov <ash@kambanaria.org>

It would probably make sense to put the discussion from your cover
letter into the commit message.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 5568a5b..d9c5911 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1064,7 +1064,7 @@ static void parse_pack_objects(unsigned char *sha1)
>  		nr_delays--;
>  	}
>  	if (nr_delays)
> -		die(_("confusion beyond insanity in parse_pack_objects()"));
> +		die(_("fatal error in function \"parse_pack_objects\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));
>  }

We usually just say:

  die("BUG: ...");

here (and hopefully the "..." actually describes the situation a bit
better). I have wondered if we should actually introduce a

  BUG("...");

function. Then it would make it simple to be more verbose (e.g.,
pointing the user to the mailing list as you do here) without having to
repeat the text in each place.

-Peff
