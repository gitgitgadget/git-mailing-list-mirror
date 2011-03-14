From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Mon, 14 Mar 2011 16:02:45 -0400
Message-ID: <20110314200245.GB22602@sigill.intra.peff.net>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDyh-0003bx-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 21:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab1CNUCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 16:02:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38165
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789Ab1CNUCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 16:02:47 -0400
Received: (qmail 13267 invoked by uid 107); 14 Mar 2011 20:03:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 16:03:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 16:02:45 -0400
Content-Disposition: inline
In-Reply-To: <1300130318-11279-2-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169021>

On Mon, Mar 14, 2011 at 08:18:36PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> Sometimes (at least in t-0001-init.sh test 12), the return value of
> make_absolute_path() is passed to it as an argument, making the first
> and second arguments to strlcpy() the same, making the test fail when
> run under valgrind.

Thanks, I can reproduce here and your fix looks good. I used to
periodically run valgrind on the whole suite, but I haven't for quite a
while. I should probably start doing it again.

-Peff
