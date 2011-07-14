From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 14:55:39 -0400
Message-ID: <20110714185539.GA27141@sigill.intra.peff.net>
References: <20110714173454.GA21657@sigill.intra.peff.net>
 <20110714175105.GA21771@sigill.intra.peff.net>
 <CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
 <CAKPyHN3G41iMGmGgp6jTcWN=Rxt=RTUS7ktgVDhZEXPBRXvTDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:55:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhR4d-0004N2-3U
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab1GNSzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:55:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46852
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab1GNSzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:55:42 -0400
Received: (qmail 9948 invoked by uid 107); 14 Jul 2011 18:56:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 14:56:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 14:55:39 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN3G41iMGmGgp6jTcWN=Rxt=RTUS7ktgVDhZEXPBRXvTDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177155>

On Thu, Jul 14, 2011 at 08:54:07PM +0200, Bert Wesarg wrote:

> On Thu, Jul 14, 2011 at 20:52, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > On Thu, Jul 14, 2011 at 19:51, Jeff King <peff@peff.net> wrote:
> >> +#define MAP_IMPLEMENT(name, ktype, vtype, cmp_fun, hash_fun) \
> >
> > This define should probably in the header too. Else this is completely useless.
> 
> Ahh. One have to read patch 2/3, to see how to use this. Please feel
> free to ignore this than.

Yeah, you could treat this like a C++ template and assume random bits of
code will instantiate a map of whatever types they need. But this is C,
and we only want to instantiate once. So I just figured to keep the
static list of whatever maps git needs in the map.[ch] files.

-Peff
