From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 19:42:40 -0400
Message-ID: <20140715234240.GB5572@peff.net>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
 <1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:43:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CN9-0006FC-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbaGOXmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:42:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:34494 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934132AbaGOXms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:42:48 -0400
Received: (qmail 27369 invoked by uid 102); 15 Jul 2014 23:42:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (208.181.190.99)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jul 2014 18:42:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jul 2014 19:42:40 -0400
Content-Disposition: inline
In-Reply-To: <1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253648>

On Tue, Jul 15, 2014 at 04:32:59PM -0700, Jacob Keller wrote:

> +static void error_bad_sort_config(const char *err, va_list params)
> +{
> +	vreportf("warning: tag.sort has ", err, params);
> +}

This feels a little like an abuse of the "prefix" field of vreportf, but
as you probably saw in my "for fun" patch, doing it right means
formatting into a buffer and then reformatting that (which we're
already doing again in vreportf, but less flexibly). I dunno.

At any rate, this should be marked for translation, no?

-Peff
