From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] Documentation: rename docbook-xsl-172 attribute to
	git-asciidoc-no-roff
Date: Tue, 24 Mar 2009 05:04:40 -0400
Message-ID: <20090324090440.GC1799@coredump.intra.peff.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2aT-0007HU-61
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbZCXJEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbZCXJEu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:04:50 -0400
Received: from peff.net ([208.65.91.99]:42876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbZCXJEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:04:49 -0400
Received: (qmail 28298 invoked by uid 107); 24 Mar 2009 09:04:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 05:04:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 05:04:40 -0400
Content-Disposition: inline
In-Reply-To: <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114434>

On Tue, Mar 24, 2009 at 03:04:21AM -0500, Chris Johnsen wrote:

> It seems that the ability to use raw roff codes in asciidoc.conf
> was eliminated by docbook-xsl 1.72.0 _and later_. Unlike the
> 1.72.0-specific XSLT problem, this behavior was not reverted in
> later releases.
> 
> This patch aims to make it clear that the affected asciidoc
> attribute (flag) can be reasonably used with docbook-xsl versions
> other than 1.72.0.

Great, this looks like a definite improvement. Should we be respecting
more DOCBOOK_XSL_* variables than just 172, then? I.e.,:

> +# For docbook-xsl ...
> +#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
> +#	1.69.0-1.71.1,	no extra settings are needed?
> +#	1.72.0,		set DOCBOOK_XSL_172.
> +#	1.73.0-,	set ASCIIDOC_NO_ROFF

DOCBOOK_XSL_173, etc?

I don't know that we need to cover _every_ version, but if we can have
specific knobs for individual features (like ASCIIDOC_NO_ROFF), then
maybe it makes sense to aggregate the settings for those knobs for a few
common versions.

-Peff
