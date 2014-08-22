From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: avoid quadratic list insertion in
 handle_one_ref
Date: Fri, 22 Aug 2014 00:04:46 -0400
Message-ID: <20140822040446.GB27992@peff.net>
References: <53F63AC5.80901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 06:04:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKg5s-0003zZ-94
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 06:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbaHVEEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2014 00:04:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:56562 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750770AbaHVEEs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 00:04:48 -0400
Received: (qmail 487 invoked by uid 102); 22 Aug 2014 04:04:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 23:04:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2014 00:04:46 -0400
Content-Disposition: inline
In-Reply-To: <53F63AC5.80901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255654>

On Thu, Aug 21, 2014 at 08:30:29PM +0200, Ren=C3=A9 Scharfe wrote:

> Similar to 16445242 (fetch-pack: avoid quadratic list insertion in
> mark_complete), sort only after all refs are collected instead of whi=
le
> inserting.  The result is the same, but it's more efficient that way.
> The difference will only be measurable in repositories with a large
> number of refs.

Looks good, thanks.

I was hoping one of these would be fixing the quadratic http-push
behavior I mentioned yesterday, but alas. We seem to have a lot of
quadratic spots to fix. :)

-Peff
