From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/8] wt-status: move many global settings to
 wt_status structure
Date: Mon, 10 Aug 2009 05:10:10 -0400
Message-ID: <20090810091010.GA7513@coredump.intra.peff.net>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
 <1249894465-11018-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:10:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQtk-0005Aw-PO
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 11:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbZHJJKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 05:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZHJJKQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 05:10:16 -0400
Received: from peff.net ([208.65.91.99]:48851 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbZHJJKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 05:10:13 -0400
Received: (qmail 13238 invoked by uid 107); 10 Aug 2009 09:10:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 Aug 2009 05:10:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2009 05:10:10 -0400
Content-Disposition: inline
In-Reply-To: <1249894465-11018-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125424>

On Mon, Aug 10, 2009 at 01:54:19AM -0700, Junio C Hamano wrote:

> --- a/wt-status.h
> +++ b/wt-status.h
> [...]
> @@ -33,8 +32,12 @@ struct wt_status {
>  	const char *reference;
>  	int verbose;
>  	int amend;
> -	int untracked;
>  	int nowarn;
> +	int wt_status_use_color;
> +	int wt_status_relative_paths;
> +	int wt_status_submodule_summary;
> +	enum untracked_status_type show_untracked_files;
> +

Is there a particular reason to use such enormous struct member names?
IOW, inside wt_status, why not just "use_color"?

Other than that, I think this is a very positive change (and in fact, I
like the way this whole series is shaping up).

-Peff
