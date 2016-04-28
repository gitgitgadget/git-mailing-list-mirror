From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 18:51:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604281840350.9313@virtualbox>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133744.GC25319@sigill.intra.peff.net> <CAGZ79karNW3+xiZQuoh5v-nRabs+h-5pyHDfjHS4vTVBkAyv_Q@mail.gmail.com> <20160428152811.GC31063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:54:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpCY-0008GL-HS
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbcD1Qx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:53:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:56418 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbcD1Qx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:53:58 -0400
Received: from virtualbox ([89.204.138.106]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MMXVC-1b2wSS1qQA-008GbG; Thu, 28 Apr 2016 18:53:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160428152811.GC31063@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/kJEdHbeUGusiSXmCojlyK925MVsNK5pnkJmXhdxYtBotLLwO7f
 EkN2E4WR7T3NIpgKHXIvR+qb1zn+PRRnajF97jg5+GQksFxEgF+n+BBCjYVRDK1ongjogtf
 PIgf3mgcksQ41k99q3WZ3jj2DCd+6BVKbhIyACZPYH4hMNam9QzEAmGpYb0jI6r4xq2mFkv
 OR/OoANqMN+tlah3T2ODQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xSyQDnZrUTs=:pWOHpJYz67HC78+3ERCGuV
 JXqgo0J90xZ138JPCjhX7Xdx7p3TUUnlPViaOI/OLIUIsa/ecnu3eA6fbvOYv/Pp52deg+NbP
 jgBSp+FzC4CSEGBFH5xPhecfYtZ4xCxVoovEifPiU3TbFJ19QP+JRugt1FggHptCqHet5VZ3a
 OBhosd3GJhsJr/ccZgWaKAer0c+LU9nSrs6kgmVG4r7poAyp9YgelPa8jNoJ57znjaDLuTEKn
 TiweEOSi1NwXXjxyADFllOEYGNNEwbHXuOJoTE6SHdfAlV7sbW7hU4VrkujHCzfUh8s1iCwDF
 O2lQqZUObpbe5fgPFp/iJ2cjOKzryk4iya5jf6wGl2/D2cLDouCStfj8ySllHS5Su50jxwb/V
 VZNVHgBQNY5U9MmIYhxxmlYejuUDc8z6sUxQhJ/sJWz78OrzIQoXpvySktAMnGXOtjcQ2m6bR
 DsjxIno2CfUElNYHaK/hQkY9HwywID1lQLZ9cfHORP0DNs4Td4EE1wbOeKlrPp+r1ruzDSEs0
 PlKvUvfJ3JyORxuW2MasQxiEtYeSsmw1aot6vFkFWoplivXVNw78B2Ma7FrZ7NiizcL987RfL
 NF5yIBIsnZxmO/v53+8LwTrTNo5qLr6eqd73KQqNAewhr/+6xXcON5DEzZYjtUNyzspr7+6Nl
 P9GqzSu8Lkt/nnXTHwIFWPdE53onhBvIOZ57FB4UDw+PFwc9whKqS+yf4wQWu0gjz9l3Ch8V2
 B+xC0AVarLLaP6Jpx3F3aaQpaMm4FKxr5zKAqlJNi7WHlWlTJqJZdviHIjdzovIxbi9U5zP/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292920>

Hi,

On Thu, 28 Apr 2016, Jeff King wrote:

> On Thu, Apr 28, 2016 at 08:25:29AM -0700, Stefan Beller wrote:
> 
> > > +test_expect_success 'cmdline credential config passes submodule update' '
> > > +       # advance the submodule HEAD so that a fetch is required
> > > +       git commit --allow-empty -m foo &&
> > > +       git push "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git" HEAD &&
> > > +       sha1=$(git rev-parse HEAD) &&
> > > +       git -C super-clone update-index --cacheinfo 160000,$sha1,sub &&
> > 
> > The use of update-index seems elegant to me, though different than
> > any submodule test I wrote so far. :)
> 
> Yeah, I actually wrestled with finding the shortest recipe to convince
> git-submodule to actually call git-fetch. Suggestions welcome if there's
> something more canonical.

FWIW that's exactly how I did things in
https://github.com/dscho/git/commit/89d0024450b0e6e9997ad9e3d681248bde1bafc0

:-)

Ciao,
Dscho
