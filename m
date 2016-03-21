From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Mon, 21 Mar 2016 16:04:51 -0400
Message-ID: <20160321200451.GA32071@sigill.intra.peff.net>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
 <20160321192904.GC20083@spk-laptop>
 <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Laurent Arnoud <laurent@spkdev.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:05:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai64Q-00057b-MN
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618AbcCUUEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:04:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35501 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756203AbcCUUEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:04:53 -0400
Received: (qmail 5012 invoked by uid 102); 21 Mar 2016 20:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 16:04:53 -0400
Received: (qmail 8844 invoked by uid 107); 21 Mar 2016 20:05:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 16:05:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 16:04:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289452>

On Mon, Mar 21, 2016 at 12:43:45PM -0700, Junio C Hamano wrote:

> If so, then the configuration is "when the user gives us a message
> to create a tag without explicitly saying -a/-s, we create an
> annotated tag by default, but create a signed tag instead in such a
> case", I would think.  That is:
> 
>     $ git tag -m 'foo' $tagname
> 
> would create signed tag under such a configuration option, and I
> think such an option may make sense.  And the way to override it
> would be
> 
>     $ git tag -a -m 'foo' $tagname
> 
> So there is no need for --no-sign option.  When the user explicitly
> asks to create an annotated tag with
> 
>     $ git tag -a -m 'foo' $tagname
> 
> it is unreasonable to override that explicit wish with a
> configuration setting.

FWIW, of the schemes discussed in this thread, this one makes the most
sense to me (and is one I might actually use).

I think you could shoe-horn it into my "tag-type" config scheme as a new
mode ("sign-if-message" or something), but I think it is much clearer as
a standalone config variable.

Thanks for a dose of sanity.

-Peff
