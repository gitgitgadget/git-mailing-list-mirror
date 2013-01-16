From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 08:04:10 -0800
Message-ID: <20130116160410.GC22400@sigill.intra.peff.net>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvW8e-00047z-I5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758328Ab3APQES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:04:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35265 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758331Ab3APQEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 11:04:14 -0500
Received: (qmail 12490 invoked by uid 107); 16 Jan 2013 16:05:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 11:05:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 08:04:10 -0800
Content-Disposition: inline
In-Reply-To: <1358348003-11130-1-git-send-email-max@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213767>

On Wed, Jan 16, 2013 at 03:53:23PM +0100, Max Horn wrote:

> -#ifdef __GNUC__
> +#if defined(__GNUC__) && ! defined(__clang__)
>  #define config_error_nonbool(s) (config_error_nonbool(s), -1)
>  #endif

You don't say what the warning is, but I'm guessing it's complaining
about throwing away the return value from config_error_nonbool?

-Peff
