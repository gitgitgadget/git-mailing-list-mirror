From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] On error, do not list all commands, but point to
	--help option.
Date: Sun, 21 Oct 2007 15:13:51 +0200
Message-ID: <20071021131351.GE8887@efreet.light.src>
References: <bqaujirk.fsf@blue.sea.net> <Pine.LNX.4.64.0710202126430.25221@racer.site> <odetifoh.fsf@blue.sea.net> <Pine.LNX.4.64.0710210001390.25221@racer.site> <20071021020653.GA14735@spearce.org> <ED3FFB7A-861F-47E4-97EA-D7A05552FC2C@wincent.com> <471B4931.5040102@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Cc: Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 21 15:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjadA-0006M4-Hr
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 15:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbXJUNN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbXJUNN7
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 09:13:59 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:34062 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbXJUNN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 09:13:58 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 110D35739D;
	Sun, 21 Oct 2007 15:13:57 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id OR4t+orjLfuJ; Sun, 21 Oct 2007 15:13:54 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 94D5E57242;
	Sun, 21 Oct 2007 15:13:53 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Ijacp-0008LY-7C; Sun, 21 Oct 2007 15:13:51 +0200
Content-Disposition: inline
In-Reply-To: <471B4931.5040102@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61902>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2007 at 14:42:25 +0200, Andreas Ericsson wrote:
> Wincent Colaiuta wrote:
>> El 21/10/2007, a las 4:06, Shawn O. Pearce escribi=C3=B3:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>>>> On Sat, 20 Oct 2007, Jari Aalto wrote:
>>>>>>
>>>>>>> - commented out call to list_common_cmds_help()
>>>>
>>>> Well, I'm almost sure of the opposite.  One of the big results of the=
=20
>>>> Git
>>>> Survey was that git is still not user-friendly enough.  Your patch wou=
ld
>>>> only make this issue worse.
>>>
>>> Actually I think Jari's patch helps for the reason originally
>>> stated in the message (less output when you make a small typo).
>>> Though I agree that the commented out code should just be removed.
>>>
>>> I actually had to do `git config alias.upsh push` just to keep
>>> myself from screaming every time I made a small typo and Git gave
>>> me a screenful of "helpful reminders".
>> If you want to go really user friendly, how about a check against the li=
st=20
>> of known commands using a shortest-edit distance algorithm?
>
> http://en.wikipedia.org/wiki/Levenshtein_distance
>
> Implementing the algorithm doesn't seem terribly difficult.

That's not the correct algorithm (you need to consider transpozitions, so y=
ou
need at least http://en.wikipedia.org/wiki/Damerau-Levenshtein_distance, but
I would not think that's the easier, or faster, way to do it. Though this
would have to be benchmarked -- calculating the edit distance is quadratic,
while generating the list of possibilities (and seeing whether they exist) =
is
linear, but with large constant. So the question is, whether we have few
enough commands that the quadratic calculation might be faster.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHG1CPRel1vVwhjGURAtIeAJ4pdw684y6jpNaGrdzR0KBsMQVumACg0M5L
kw0lZGWtgX47xxSOK3Zn59Q=
=zsS6
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
