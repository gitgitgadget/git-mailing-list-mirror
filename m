From: Jeff King <peff@peff.net>
Subject: Re: [DRY HUMOR PATCH] Add a few more values for
	receive.denyCurrentBranch
Date: Mon, 16 Feb 2009 19:58:24 -0500
Message-ID: <20090217005824.GA23892@coredump.intra.peff.net>
References: <cover.1234820890u.git.johannes.schindelin@gmx.de> <bfeaa5d164c9dc2d1080545e4bb9480920762ff2.1234820890u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:59:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEJV-0000jq-LF
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbZBQA60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbZBQA60
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:58:26 -0500
Received: from peff.net ([208.65.91.99]:41012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbZBQA60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:58:26 -0500
Received: (qmail 24478 invoked by uid 107); 17 Feb 2009 00:58:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 19:58:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 19:58:24 -0500
Content-Disposition: inline
In-Reply-To: <bfeaa5d164c9dc2d1080545e4bb9480920762ff2.1234820890u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110285>

On Mon, Feb 16, 2009 at 10:52:05PM +0100, Johannes Schindelin wrote:

> @@ -75,7 +77,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "receive.denycurrentbranch")) {
> -		deny_current_branch = parse_deny_action(var, value);
> +		if (value && !strcasecmp(value, "updateinstead"))
> +			deny_current_branch = DENY_UPDATE_INSTEAD;
> +		else if (value && !strcasecmp(value, "detachinstead"))

Config variables are already lower-cased. ;P

-Peff
