From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: merge, keeping the remote as a new file?
Date: Mon, 2 Mar 2009 07:59:49 +0100
Message-ID: <20090302065949.GD6289@atjola.homenet>
References: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com> <20090302041113.GA3094@coredump.intra.peff.net> <20090302063604.GA17245@hashpling.org> <20090302064519.GA5635@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <charles@hashpling.org>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 08:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2A0-0006ex-Qs
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbZCBG74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 01:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZCBG7z
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 01:59:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:38660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754259AbZCBG7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 01:59:54 -0500
Received: (qmail invoked by alias); 02 Mar 2009 06:59:51 -0000
Received: from i577B8BC7.versanet.de (EHLO atjola.local) [87.123.139.199]
  by mail.gmx.net (mp025) with SMTP; 02 Mar 2009 07:59:51 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/x8Ro+Mg7xmQXFDUSWc6e76UN/iwea1udHbnCgKi
	OFlWX5pJuIJFl+
Content-Disposition: inline
In-Reply-To: <20090302064519.GA5635@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111905>

On 2009.03.02 01:45:19 -0500, Jeff King wrote:
> On Mon, Mar 02, 2009 at 06:36:04AM +0000, Charles Bailey wrote:
>=20
> > You can use git checkout-index --temp --stage=3D3 and then move it =
from
> > the auto-generated temporary name into its new place.
>=20
> Hmm. I was hoping there was something that would use the name "--thei=
rs"
> instead of the mysterious "stage level 3". But it's still nicer than =
the
> "git show" I gave because of:
>=20
> > Using a checkout variant instead of a show or a cat-file might be
> > important if you are doing autocrlf or some other smudging.
>=20
> Right. For some reason I was thinking that cat-file did not handle th=
is
> but "git show" did, but I just tested and it clearly doesn't. So yes,
> you should definitely use checkout-index if you care about conversion=
s.

Hm, how about this?
git checkout --theirs file
git mv file newname
git checkout HEAD file # Can't use --ours here due to the mv

Should work with the CRLF stuff, uses no plumbing, no stage numbers,
there's no messing with random temp file names and it's still just thre=
e
commands.

Bj=F6rn
