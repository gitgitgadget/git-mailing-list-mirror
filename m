From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] builtin/am: make sure state files are text
Date: Mon, 24 Aug 2015 19:55:47 -0400
Message-ID: <20150824235547.GB13261@sigill.intra.peff.net>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
 <1440449890-29490-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 01:56:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU1ar-0006X2-1I
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 01:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbHXXzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 19:55:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:49418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751060AbbHXXzu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 19:55:50 -0400
Received: (qmail 7035 invoked by uid 102); 24 Aug 2015 23:55:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 18:55:49 -0500
Received: (qmail 29855 invoked by uid 107); 24 Aug 2015 23:55:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 19:55:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 19:55:47 -0400
Content-Disposition: inline
In-Reply-To: <1440449890-29490-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276498>

On Mon, Aug 24, 2015 at 01:58:06PM -0700, Junio C Hamano wrote:

> We forgot to terminate the payload given to write_file() with LF,
> resulting in files that end with an incomplete line.  Teach the
> wrappers builtin/am uses to make sure it adds LF at the end as
> necessary.

Is it even worth doing this step? It's completely reverted later in the
series. I understand that we do not want to hold the fix to git-am
hostage to write_file refactoring, but I don't see any reason these
cannot all graduate as part of the same topic.

Ignore me if you really are planning on doing the first two to "maint"
and holding the others back for "master".

-Peff
