From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is given
Date: Mon, 31 Aug 2009 21:39:06 +0200
Message-ID: <4A9C26DA.9010701@hartwork.org>
References: <20090805201937.GB9004@coredump.intra.peff.net> <20090805202326.GC23226@coredump.intra.peff.net> <7vhbwm0zcs.fsf@alter.siamese.dyndns.org> <20090805204835.GA24539@coredump.intra.peff.net> <7vws5ix9dz.fsf@alter.siamese.dyndns.org> <20090805211700.GA24697@coredump.intra.peff.net> <4A9C175E.6020905@hartwork.org> <20090831192834.GC4876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:47:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiCqu-00013X-Of
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 21:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbZHaTrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZHaTrQ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 15:47:16 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:41717 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZHaTrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 15:47:15 -0400
Received: from [85.179.29.7] (helo=[192.168.0.3])
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1MiCiY-0007co-Md; Mon, 31 Aug 2009 21:39:07 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090820)
In-Reply-To: <20090831192834.GC4876@sigill.intra.peff.net>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127496>

Jeff King wrote:
> Junio applied the series, and it is in 'master' right now (and so should
> be part of the upcoming 1.6.5).
> 
> Using "git push -q" will do what you want,

That's great news.  Thanks for the quick reply.


> but playing with it a bit, I
> think there is one bit missing from the original series:
> 
> -- >8 --
> Subject: [PATCH] push: teach --quiet to suppress "Everything up-to-date"
> 
> This should have been part of 481c7a6, whose goal was to
> make "git push -q" silent unless there is an error.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  transport.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/transport.c b/transport.c
> index ce91387..f2bd998 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -908,7 +908,7 @@ int transport_push(struct transport *transport,
>  				update_tracking_ref(transport->remote, ref, verbose);
>  		}
>  
> -		if (!ret && !refs_pushed(remote_refs))
> +		if (!quiet && !ret && !refs_pushed(remote_refs))
>  			fprintf(stderr, "Everything up-to-date\n");
>  		return ret;
>  	}

Would be great to have that patch in too.



Sebastian
