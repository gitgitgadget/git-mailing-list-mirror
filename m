From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/4] Some cleanups
Date: Wed, 30 Mar 2016 13:38:37 -0400
Message-ID: <20160330173837.GA20706@sigill.intra.peff.net>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
 <20160330172538.GC19675@sigill.intra.peff.net>
 <CAGZ79kYwpj+NSn4yZK0tqASQ7CghAMgE6L9thVhTwuBNmFY6PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:38:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alK4r-0006OG-5r
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbcC3Ril (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:38:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:41012 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753142AbcC3Rik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:38:40 -0400
Received: (qmail 11678 invoked by uid 102); 30 Mar 2016 17:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:38:39 -0400
Received: (qmail 5055 invoked by uid 107); 30 Mar 2016 17:38:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:38:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 13:38:37 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYwpj+NSn4yZK0tqASQ7CghAMgE6L9thVhTwuBNmFY6PA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290330>

On Wed, Mar 30, 2016 at 10:32:40AM -0700, Stefan Beller wrote:

> > I'm OK with all of these as-is, though I did mention a nit in the third
> > one. I also like Junio's rewrite instead of using strbuf_list_free.
> 
> I'm fine using the rewritten version instead of using strbuf_list_free. :)
> On the third one, there is one case, where we have
> 
>   if (..)
>     return error(_(text));
> 
> and that is an exit(128); eventually.

In the caller perhaps, but isn't that equivalent to:

  error(_(text));
  return -1;

?

I think it is OK to make assumptions about error()'s return value; that
is what it is there for.

-Peff
