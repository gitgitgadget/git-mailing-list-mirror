From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] verify_pack: do not ignore return value of verification
 function
Date: Tue, 1 Dec 2015 18:28:04 -0500
Message-ID: <20151201232804.GC13245@sigill.intra.peff.net>
References: <1448923662-24725-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3uLE-0007Dl-WB
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 00:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbbLAX2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 18:28:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:36010 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932239AbbLAX2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 18:28:07 -0500
Received: (qmail 23100 invoked by uid 102); 1 Dec 2015 23:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 17:28:07 -0600
Received: (qmail 24192 invoked by uid 107); 1 Dec 2015 23:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:28:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 18:28:04 -0500
Content-Disposition: inline
In-Reply-To: <1448923662-24725-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281865>

On Mon, Nov 30, 2015 at 05:47:42PM -0500, David Turner wrote:

> In verify_pack, a caller-supplied verification function is called.
> The function returns an int.  If that return value is non-zero,
> verify_pack should fail.
> 
> The only caller of verify_pack is in builtin/fsck.c, whose verify_fn
> returns a meaningful error code (which was then ignored).  Now, fsck
> might return a different error code (with more detail).  This would
> happen in the unlikely event that a commit or tree that is a valid git
> object but not a valid instance of its type gets into a pack.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  pack-check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this looks good to me.

-Peff
