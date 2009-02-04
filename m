From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 09:53:17 -0500
Message-ID: <20090204145317.GA5712@sigill.intra.peff.net>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUj9N-0001Or-Si
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZBDOxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbZBDOxW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:53:22 -0500
Received: from peff.net ([208.65.91.99]:55288 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbZBDOxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:53:22 -0500
Received: (qmail 29323 invoked by uid 107); 4 Feb 2009 14:53:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 09:53:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 09:53:17 -0500
Content-Disposition: inline
In-Reply-To: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108372>

On Wed, Feb 04, 2009 at 12:40:26AM +0200, Felipe Contreras wrote:

> +		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
> +			char *config_filename;
> +			if (config_exclusive_filename)
> +				config_filename = xstrdup(config_exclusive_filename);
> +			else
> +				config_filename = git_pathdup("config");
> +			launch_editor(config_filename, NULL, NULL);
> +			free(config_filename);
> +			return 0;
>  		} else

With this patch, won't I get different behavior from:

  git config -e --global

versus

  git config --global -e

?

Other than that, I like the concept of this patch.

-Peff
