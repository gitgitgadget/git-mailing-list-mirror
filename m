From: Jeff King <peff@peff.net>
Subject: Re: git undo # last command
Date: Fri, 16 Aug 2013 09:26:12 -0400
Message-ID: <20130816132612.GF20138@sigill.intra.peff.net>
References: <CAAUyY9ADW2iHVWhTGcTF8j0hrdumpBcLv_mLo0y8VDAyBpftJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?U2HFoWEgVG9tacSH?= <tomic80@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAK2p-000304-Hw
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab3HPN0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 09:26:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:56554 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab3HPN0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:26:15 -0400
Received: (qmail 28007 invoked by uid 102); 16 Aug 2013 13:26:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 08:26:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 09:26:12 -0400
Content-Disposition: inline
In-Reply-To: <CAAUyY9ADW2iHVWhTGcTF8j0hrdumpBcLv_mLo0y8VDAyBpftJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232428>

On Fri, Aug 16, 2013 at 10:55:06AM +0200, Sa=C5=A1a Tomi=C4=87 wrote:

> it just occurred to me -- the command that I would REALLY like to hav=
e
> is simple:
>=20
>   git undo
>=20
> which 'undo'es the last action that has not been pushed yet --
> whichever the action is. Similarly to the 'back' button in the
> browser.

One problem with such simplicity is that you need to define what an
"action" is. If I make a commit, the undo is probably "reset HEAD@{1}".
If I fetch a ref, would undo move backwards? What if I fetch multiple
refs with one command; do we undo all of them? How about during a
multiple-command operation, like a rebase? Does an undo affect the last
commit, or the whole rebase?

I think these questions can be answered (though I am not sure of the
best answer for most of them, nor even if there is a single answer that
covers all situations), but I think a starting point for any "undo"
command would be coming up with a list of what constitutes an action,
how we record the list of actions, and then an appropriate "undo"
reaction for each action.

-Peff
