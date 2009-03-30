From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Rename push.default to push.style
Date: Mon, 30 Mar 2009 06:29:30 -0400
Message-ID: <20090330102739.GA5163@sigill.intra.peff.net>
References: <1238281804-30290-1-git-send-email-santi@agolina.net> <1238281804-30290-5-git-send-email-santi@agolina.net> <20090330080115.GA19142@pvv.org> <alpine.DEB.1.00.0903301021540.7534@intel-tinevez-2-302> <adf1fd3d0903300200v65393b1bif0050392aa44652e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 12:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoElo-0003hM-L9
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbZC3K3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 06:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbZC3K3f
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:29:35 -0400
Received: from peff.net ([208.65.91.99]:47762 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbZC3K3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:29:35 -0400
Received: (qmail 3574 invoked by uid 107); 30 Mar 2009 10:29:48 -0000
Received: from 97-81-110-133.dhcp.athn.ga.charter.com (HELO sigill.intra.peff.net) (97.81.110.133)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 30 Mar 2009 06:29:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2009 06:29:30 -0400
Content-Disposition: inline
In-Reply-To: <adf1fd3d0903300200v65393b1bif0050392aa44652e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115132>

On Mon, Mar 30, 2009 at 11:00:03AM +0200, Santi B=C3=A9jar wrote:

> >> This configuration variable says what push should do
> >> when no refspec is given and none are configured, so the word "def=
ault"
> >> should be in there at least. Maybe "defaultref" would have been be=
tter?
>=20
> I don't see the point of the word default, a lot of configuration is
> to set the default value. Git has branch.name.remote, not
> branch.name.defaultremote, or user.email, not user.defaultemail,...

The usual case is two layers of options: command line and config
options. Thus "git push <remote>" overrides "branch.*.remote".

But in this case there are actually _three_ layers: command line,
branch.*.push, and now push.default. I think a name like "push.mode"
doesn't make clear the fact that it will never be looked at if you have
"branch.*.push" set up.

I think you have a point that "default" is vague, but "defaultMode"
would be better than simply "mode".

-Peff
