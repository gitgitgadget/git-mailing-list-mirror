From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] option-strings: use OPT_PATH
Date: Mon, 23 Feb 2015 13:26:53 -0500
Message-ID: <20150223182653.GB19904@peff.net>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
 <9030a1bb1e7a03eedfd65432fabf385f457419d6.1424707497.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPxif-0006yl-3a
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbbBWS04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 13:26:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:52394 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752072AbbBWS04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:26:56 -0500
Received: (qmail 23302 invoked by uid 102); 23 Feb 2015 18:26:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 12:26:56 -0600
Received: (qmail 26319 invoked by uid 107); 23 Feb 2015 18:26:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 13:26:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2015 13:26:53 -0500
Content-Disposition: inline
In-Reply-To: <9030a1bb1e7a03eedfd65432fabf385f457419d6.1424707497.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264279>

On Mon, Feb 23, 2015 at 05:17:45PM +0100, Michael J Gruber wrote:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index a9af3f2..15941c5 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -80,7 +80,7 @@ static struct option builtin_clone_options[] = {
>  		    N_("initialize submodules in the clone")),
>  	OPT_BOOL(0, "recurse-submodules", &option_recursive,
>  		    N_("initialize submodules in the clone")),
> -	OPT_STRING(0, "template", &option_template, N_("template-directory"),
> +	OPT_PATH(0, "template", &option_template, N_("template-directory"),
>  		   N_("directory from which templates will be used")),
>  	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
>  		     N_("reference repository"), &opt_parse_reference),

I'm not sure if this one is doing anything. Clone cannot use SETUP_GIT
for obvious reasons, so we should have a NULL prefix here. But that also
means we should be doing the right thing already.

I think the same goes for the rest of the instances in this patch.

-Peff
