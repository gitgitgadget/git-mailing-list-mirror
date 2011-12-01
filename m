From: Jeff King <peff@peff.net>
Subject: Re: log: option "--follow" not the default for a single file?
Date: Thu, 1 Dec 2011 13:52:30 -0500
Message-ID: <20111201185230.GB2873@sigill.intra.peff.net>
References: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
 <20111130063743.GB5317@sigill.intra.peff.net>
 <CAN0XMOJGm1frOi7FEke7LfHCSBt2DRn_npkdKe0m3qZ=hQPNHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBkL-0007iA-Td
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab1LASwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 13:52:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59226
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728Ab1LASwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 13:52:32 -0500
Received: (qmail 18888 invoked by uid 107); 1 Dec 2011 18:59:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 13:59:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 13:52:30 -0500
Content-Disposition: inline
In-Reply-To: <CAN0XMOJGm1frOi7FEke7LfHCSBt2DRn_npkdKe0m3qZ=hQPNHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186184>

On Wed, Nov 30, 2011 at 07:38:23PM +0100, Ralf Thielow wrote:

> > =C2=A0 =C2=A0 pathspec. That may happen to match a single file in t=
he current
> > =C2=A0 =C2=A0 revision, but to git it is actually a prefix-limiting=
 pattern, and
> Is it possible to detect the case of a single file in the current
> revisionand use "--follow" by default for exactly that?

It's possible, but it is changing the meaning of "git log foo". With
the current code, even if "foo" is currently a file, it will match
"foo/bar" in a prior revision. Switching this to "--follow" will not.

-Peff
