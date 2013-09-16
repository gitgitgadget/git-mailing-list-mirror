From: Jeff King <peff@peff.net>
Subject: Re: .gitattributes and defaulting to binary
Date: Mon, 16 Sep 2013 18:09:08 -0400
Message-ID: <20130916220908.GC5477@sigill.intra.peff.net>
References: <CAOTvmonjWtUM42ATpEu+s6GVcpTO10BT0izXVB_aqK2npgRfWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Vachon <matthieu.o.vachon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 00:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLgys-00039B-HT
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 00:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab3IPWJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 18:09:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:38956 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab3IPWJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 18:09:14 -0400
Received: (qmail 23386 invoked by uid 102); 16 Sep 2013 22:09:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Sep 2013 17:09:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Sep 2013 18:09:08 -0400
Content-Disposition: inline
In-Reply-To: <CAOTvmonjWtUM42ATpEu+s6GVcpTO10BT0izXVB_aqK2npgRfWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234847>

On Mon, Sep 16, 2013 at 05:35:24PM -0400, Matthieu Vachon wrote:

> But I was not able to achieve it right now. When having this in my
> `.gitattributes`, git treats all files as binary, even the one
> explicitly specified like `*.txt`:
> 
>     *.txt text
>     * binary

>From "git help attributes":

  When more than one pattern matches the path, a later line overrides an
  earlier line. This overriding is done per attribute.

Reversing the two lines should do what you want.

You may also want to use "-text" instead of "binary"; the latter also
implies "-diff", which means you will never see diffs of those files,
even if they are actually text.

-Peff
