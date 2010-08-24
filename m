From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/1] do not pass "git -c foo=bar" params to transport
 helpers
Date: Tue, 24 Aug 2010 10:14:16 -0400
Message-ID: <20100824141416.GC6457@coredump.intra.peff.net>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
 <20100823183857.GA22386@coredump.intra.peff.net>
 <20100823191600.GA2523@coredump.intra.peff.net>
 <20100824064114.GA20724@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 16:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnuGg-0003SB-H6
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 16:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab0HXOOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 10:14:22 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35421 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883Ab0HXOOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 10:14:20 -0400
Received: (qmail 17718 invoked by uid 111); 24 Aug 2010 14:14:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 24 Aug 2010 14:14:20 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Aug 2010 10:14:16 -0400
Content-Disposition: inline
In-Reply-To: <20100824064114.GA20724@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154315>

On Tue, Aug 24, 2010 at 01:41:14AM -0500, Jonathan Nieder wrote:

> Like $GIT_CONFIG, $GIT_CONFIG_PARAMETERS needs to be suppressed by
> "git push" and its cousins when running local transport helpers to
> imitate remote transport well.

Thanks, this looks good to me.

Though arguably these bits:

> +#define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
> [...]
> -	const char *old = getenv("GIT_CONFIG_PARAMETERS");
> +	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);

Should be squashed into the original patch. :)

-Peff
