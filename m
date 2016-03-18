From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2/GSoC 4/4] t0301: test credential-cache support of
 XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 01:01:24 -0400
Message-ID: <20160318050124.GB22327@sigill.intra.peff.net>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
 <1458233326-7735-4-git-send-email-huiyiqun@gmail.com>
 <20160317180811.GA23669@sigill.intra.peff.net>
 <CAKqreuy0jU7WOi8_iGXR2hzYJE0kG8855hQuaeaW9OTKm3yF_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:01:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmXV-0006Bb-9M
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbcCRFB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 01:01:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:33870 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752293AbcCRFB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:01:27 -0400
Received: (qmail 14074 invoked by uid 102); 18 Mar 2016 05:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:01:27 -0400
Received: (qmail 8488 invoked by uid 107); 18 Mar 2016 05:01:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:01:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2016 01:01:24 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuy0jU7WOi8_iGXR2hzYJE0kG8855hQuaeaW9OTKm3yF_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289187>

On Fri, Mar 18, 2016 at 12:38:16PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> >> +test_expect_success 'when $XDG_RUNTIME_DIR is set, `$XDG_RUNTIME_=
DIR/git` are used' '
> >> +     test_path_is_missing "/tmp/git-$(id -u)/git/credential-cache=
=2Esock" &&
> >> +     test -S "$HOME/xdg_runtime/git/credential-cache.sock"
> >> +'
> >
> > This test fails for me, probably because XDG_RUNTIME_DIR is not
> > exported.
> >
> > -Peff
>=20
> Could you please give a try to the patch set v2, test of which is
> definitely passed on my computer.

Yes, that was what I tried earlier (and I just re-tested to make sure).
It still fails. I suspect it has to do with whether XDG_RUNTIME_DIR is
set in our environments (outside of the test suite). If I run:

  XDG_RUNTIME_DIR=3D/tmp/foo ./t0301-credential-cache.sh

it passes.

-Peff
