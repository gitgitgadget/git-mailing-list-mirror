From: Jeff King <peff@peff.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 16:29:54 -0400
Message-ID: <20090407202954.GA13501@coredump.intra.peff.net>
References: <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com> <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:34:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrHxF-0000lt-Vw
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248AbZDGU35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbZDGU35
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 16:29:57 -0400
Received: from peff.net ([208.65.91.99]:33821 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726AbZDGU34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 16:29:56 -0400
Received: (qmail 8758 invoked by uid 107); 7 Apr 2009 20:29:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 16:29:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 16:29:54 -0400
Content-Disposition: inline
In-Reply-To: <20090407181259.GB4413@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115986>

On Tue, Apr 07, 2009 at 08:12:59PM +0200, Bj=C3=B6rn Steinbrink wrote:

> If so, that doesn't look it it's going to work out as easily as one
> would hope. Robin said that both processes, git-upload-pack (which do=
es
> the rev-list) and pack-objects peaked at ~2GB of RSS (which probably
> includes the mmapped packs). But the above pack-objects with --all pe=
aks

I thought he said this, too, but look at the ps output he posted here:

  http://article.gmane.org/gmane.comp.version-control.git/115739

It clearly shows upload-pack with a tiny RSS, and pack-objects doing al=
l
of the damage.

-Peff
