From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 01:58:53 -0400
Message-ID: <20140522055852.GA16587@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521102742.GB30464@sigill.intra.peff.net>
 <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 07:59:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnM1r-0003TG-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 07:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbaEVF6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 01:58:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:57105 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751016AbaEVF6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 01:58:55 -0400
Received: (qmail 758 invoked by uid 102); 22 May 2014 05:58:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 00:58:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 01:58:53 -0400
Content-Disposition: inline
In-Reply-To: <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249874>

On Wed, May 21, 2014 at 05:07:36PM -0700, Kyle J. McKay wrote:

> >+void strbuf_tolower(struct strbuf *sb)
> >+{
> >+	size_t i;
> >+	for (i = 0; i < sb->len; i++)
> >+		sb->buf[i] = tolower(sb->buf[i]);
> >+}
> >+
> 
> Wouldn't a direct transfer of the lowercase function be something more like:
> 
> 
> void strbuf_tolower(struct strbuf *sb)
> {
> 	char *p = sb->buf;
> 	for (; *p; p++)
> 		*p = tolower(*p);
> }
> 
> That seems to me to be a bit more efficient.  According to the comments in
> strbuf.c, "people can always assume buf is non NULL and ->buf is NUL
> terminated even for a freshly initialized strbuf."

Yes, and that would be fine with me (I actually wrote strbuf_tolower for
my own use, and _then_ realized that we already had such a thing that
could be replaced).

-Peff
