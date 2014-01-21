From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] Propagating flags carefully from the command line
Date: Tue, 21 Jan 2014 00:27:09 -0500
Message-ID: <20140121052708.GB5878@sigill.intra.peff.net>
References: <1389830384-22851-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 06:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Trq-0003Xi-2o
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 06:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbaAUF1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 00:27:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:36061 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbaAUF1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 00:27:10 -0500
Received: (qmail 6103 invoked by uid 102); 21 Jan 2014 05:27:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 23:27:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jan 2014 00:27:09 -0500
Content-Disposition: inline
In-Reply-To: <1389830384-22851-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240743>

On Wed, Jan 15, 2014 at 03:59:42PM -0800, Junio C Hamano wrote:

> So this is my second try.  The second one now gets rid of the call
> to mark_blob_uninteresting() as Peff suggested, because the first
> patch makes the function very well aware that it only should mark
> the objects that are reachable from the object, and by definition
> blobs do not reach anything.
> 
> Junio C Hamano (2):
>   revision: mark contents of an uninteresting tree uninteresting
>   revision: propagate flag bits from tags to pointees

Sorry for a slow review, but I just read through your earlier comments
and this series. I agree there was definitely a bug in what we were
discussing earlier, and this looks like the right way to fix it. The end
result splits the flag-setting responsibility much more sensibly.

Thanks.

-Peff
