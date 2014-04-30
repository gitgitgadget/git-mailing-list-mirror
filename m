From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] strbuf: Use _rtrim and _ltrim in strbuf_trim
Date: Wed, 30 Apr 2014 13:11:06 -0400
Message-ID: <20140430171105.GA8518@sigill.intra.peff.net>
References: <1398848287-77109-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfY2L-0000iN-F7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 19:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931AbaD3RLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 13:11:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:42251 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752135AbaD3RLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 13:11:08 -0400
Received: (qmail 28540 invoked by uid 102); 30 Apr 2014 17:11:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Apr 2014 12:11:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2014 13:11:06 -0400
Content-Disposition: inline
In-Reply-To: <1398848287-77109-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247746>

On Wed, Apr 30, 2014 at 05:58:06PM +0900, Brian Gesiak wrote:

> strbuf_trim strips whitespace from the end, then the beginning of a
> strbuf. Those operations are duplicated in strbuf_rtrim and
> strbuf_ltrim.
> 
> Replace strbuf_trim implementation with calls to strbuf_rtrim,
> then strbuf_ltrim.

Thanks, this looks good. I wondered if perhaps doing them together
inline might have been more efficient, but there really is no overlap in
what they compute.

The documentation patch looks good to me, too.

-Peff
