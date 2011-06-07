From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/4] Add infrastructure for ref namespaces
Date: Tue, 7 Jun 2011 15:25:21 -0700
Message-ID: <20110607222520.GA1761@leaf>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
 <1307470885-4018-3-git-send-email-jamey@minilop.net>
 <BANLkTika2C9iw7E6Z-HRW=4KNstYqMbxrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU4iQ-0001JF-7b
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 00:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861Ab1FGWZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 18:25:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39910 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026Ab1FGWZb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 18:25:31 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id B5DA3A8075;
	Wed,  8 Jun 2011 00:25:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id TX9o0N63QRDa; Wed,  8 Jun 2011 00:25:28 +0200 (CEST)
X-Originating-IP: 131.252.246.221
Received: from leaf (host-246-221.pubnet.pdx.edu [131.252.246.221])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 883D7A8072;
	Wed,  8 Jun 2011 00:25:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTika2C9iw7E6Z-HRW=4KNstYqMbxrw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175274>

On Tue, Jun 07, 2011 at 09:12:09PM +0200, Bert Wesarg wrote:
> On Tue, Jun 7, 2011 at 20:21, Jamey Sharp <jamey@minilop.net> wrote:
> > diff --git a/git.c b/git.c
> > index 89721d4..98cbf7b 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -126,6 +126,20 @@ static int handle_options(const char ***argv, =
int *argc, int *envchanged)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setenv(GIT_DIR_ENVIR=
ONMENT, cmd + 10, 1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (envchanged)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*env=
changed =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (!strcmp(cmd, "--namespace"=
)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*argc < 2) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprin=
tf(stderr, "No directory given for --namespace.\n" );
>=20
> This 'directory' is probably misnamed here.

Thanks, will fix.

- Josh Triplett
