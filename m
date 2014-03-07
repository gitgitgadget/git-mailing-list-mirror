From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] replace: add --edit option
Date: Fri, 7 Mar 2014 12:17:14 -0500
Message-ID: <20140307171714.GB23587@sigill.intra.peff.net>
References: <20140306174803.GA30486@sigill.intra.peff.net>
 <20140306175117.GD30691@sigill.intra.peff.net>
 <CAPig+cQi+7md4P2OXJDDcs7VMkMEsUHaEz5wsaDOyu4ppk2uAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLyOq-00053w-2S
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 18:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbaCGRRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 12:17:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:34844 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753439AbaCGRRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 12:17:16 -0500
Received: (qmail 27699 invoked by uid 102); 7 Mar 2014 17:17:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Mar 2014 11:17:16 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Mar 2014 12:17:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQi+7md4P2OXJDDcs7VMkMEsUHaEz5wsaDOyu4ppk2uAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243618>

On Thu, Mar 06, 2014 at 08:57:58PM -0500, Eric Sunshine wrote:

> > +               if (strbuf_read(&result, cmd.out, 41) < 0)
> > +                       die_errno("unable to read from mktree");
> > +               close(cmd.out);
> > +
> > +               if (finish_command(&cmd))
> > +                       die("mktree reported failure");
> > +               if (get_sha1_hex(result.buf, sha1) < 0)
> > +                       die("mktree did not return an object name");
> 
> strbuf_release(&result);

Thanks for catching. I'll include it in any re-roll.

-Peff
