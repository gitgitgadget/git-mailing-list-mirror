From: Jeff King <peff@peff.net>
Subject: Re: Is there a debug mode for git-clone https traffic?
Date: Wed, 18 May 2011 04:59:32 -0400
Message-ID: <20110518085932.GI27482@sigill.intra.peff.net>
References: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 10:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMcbT-0004Rs-1s
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1ERI7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 04:59:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48012
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595Ab1ERI7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:59:34 -0400
Received: (qmail 3338 invoked by uid 107); 18 May 2011 09:01:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 05:01:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 04:59:32 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173865>

On Wed, May 18, 2011 at 01:08:06AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I''m trying to debug a problem where over a https proxy I have
> "warning: remote HEAD refers to nonexistent ref, unable to checkout."
> when doing git-clone.
>=20
> I suspect that it might be an overzealous security scanner sitting in
> the middle.
>=20
> Is there some debugging mode for git-clone where it'll dump the
> traffic being sent over the wire that I could use to confirm this?

Others have mentioned ways to dump data from clone. But you can more or
less see what's going on with "git ls-remote <remote>". The sha1 for
"HEAD" will try to match with the sha1 for some other ref. If it
doesn't, then we give up.

-Peff
