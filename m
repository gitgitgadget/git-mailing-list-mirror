From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: Supply the right commit hash to post-checkout
 when -b is used
Date: Tue, 13 Oct 2009 20:06:19 -0400
Message-ID: <20091014000619.GA20496@coredump.intra.peff.net>
References: <20091013221109.GA30972@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ranguvar@archlinux.us
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 02:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxrUh-0004q0-3q
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 02:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760930AbZJNAG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 20:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760514AbZJNAG4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 20:06:56 -0400
Received: from peff.net ([208.65.91.99]:42936 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbZJNAGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 20:06:55 -0400
Received: (qmail 22307 invoked by uid 107); 14 Oct 2009 00:09:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Oct 2009 20:09:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Oct 2009 20:06:19 -0400
Content-Disposition: inline
In-Reply-To: <20091013221109.GA30972@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130232>

On Wed, Oct 14, 2009 at 12:11:09AM +0200, Bj=C3=B6rn Steinbrink wrote:

> When we use -b <branch>, we may checkout something else than what the
> remote's HEAD references, but we still used remote_head to supply the
> new ref value to the post-checkout hook, which is wrong.
>=20
> So instead of using remote_head to find the value to be passed to the
> post-checkout hook, we have to use our_head_points_at, which is alway=
s
> correctly setup, even if -b is not used.
>=20
> This also fixes a segfault when "clone -b <branch>" is used with a
> remote repo that doesn't have a valid HEAD, as in such a case
> remote_head is NULL, but we still tried to access it.
>=20
> Reported-by: Devin Cofer <ranguvar@archlinux.us>
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>

Acked-by: Jeff King <peff@peff.net>

Thanks.

When splitting remote_head versus our_head, I tried to find every use o=
f
the remote head and pick the appropriate variable, but I think I just
missed this one. I gave the code another once-over and didn't see any
other spots that needed fixing.

-Peff
