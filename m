From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] api-credentials.txt: mention credential.helper
 explicitly
Date: Mon, 4 Jun 2012 07:54:42 -0400
Message-ID: <20120604115442.GB27676@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 13:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbVs1-0001mg-TA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 13:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab2FDLyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 07:54:46 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:42452
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112Ab2FDLyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 07:54:45 -0400
Received: (qmail 2115 invoked by uid 107); 4 Jun 2012 11:54:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Jun 2012 07:54:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2012 07:54:42 -0400
Content-Disposition: inline
In-Reply-To: <1338739804-32167-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199131>

On Sun, Jun 03, 2012 at 06:10:03PM +0200, Matthieu Moy wrote:

> The name of the configuration variable was mentioned only at the very
> end of the explanation, in a place specific to a specific rule, hence it
> was not very clear what the specification was about.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/technical/api-credentials.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> index 8804c42..4561469 100644
> --- a/Documentation/technical/api-credentials.txt
> +++ b/Documentation/technical/api-credentials.txt
> @@ -179,7 +179,8 @@ credentials from and to long-term storage (where "long-term" is simply
>  longer than a single git process; e.g., credentials may be stored
>  in-memory for a few minutes, or indefinitely on disk).
>  
> -Each helper is specified by a single string. The string is transformed
> +Each helper is specified by a single string in the configuration
> +variable credential.helper. The string is transformed
>  by git into a command to be executed using these rules:

They may be in other variables, too (like credential.*.helper). I don't
know if it is worth making that distinction.

Originally, helpers could also use these specification strings to chain
to each other, but in the current implementation, there is no chaining
(it was more important when prompting wasn't automatic, so storage
helpers would chain to prompting helpers). So I think we can disregard
that for now, and they really do just appear in config.

-Peff
