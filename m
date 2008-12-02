From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: Grafting mis-aligned trees.
Date: Tue, 2 Dec 2008 11:19:46 -0600
Message-ID: <200812021119.51857.bss03@volumehost.net>
References: <200811171645.12869.bss03@volumehost.net> <200811281701.46778.bss03@volumehost.net> <4935606A.8050906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1594197.taJu0SC7X7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 18:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YwU-0007NX-6i
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 18:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYLBRUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 12:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYLBRUZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 12:20:25 -0500
Received: from eastrmmtao102.cox.net ([68.230.240.8]:48797 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbYLBRUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 12:20:24 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081202172023.MPEY11203.eastrmmtao102.cox.net@eastrmimpo03.cox.net>;
          Tue, 2 Dec 2008 12:20:23 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id mHLN1a0062i4SyG02HLNkv; Tue, 02 Dec 2008 12:20:23 -0500
X-Authority-Analysis: v=1.0 c=1 a=rsX2rq0AEOEA:10 a=nEQGfrJnAAAA:8
 a=iyr-rTlo5x9_LDfx9rUA:9 a=eIdLO0MTOqbJxwPUbDT2Ic8Z3r8A:4 a=B7iFY6Z7H_gA:10
 a=LY0hPdMaydYA:10 a=LA7uISSrv9x2G8VzRRgA:9 a=yKcWqDADtfnpNF9feTESgZr6IrkA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1L7Yui-0005M3-Vz; Tue, 02 Dec 2008 11:19:57 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <4935606A.8050906@drmicha.warpmail.net>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102160>

--nextPart1594197.taJu0SC7X7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 02 December 2008, Michael J Gruber <git@drmicha.warpmail.net>=20
wrote about 'Re: Grafting mis-aligned trees.':
>Boyd Stephen Smith Jr. venit, vidit, dixit 29.11.2008 00:01:
>> On Tuesday 2008 November 18 03:24, Michael J Gruber wrote:
>>> Boyd Stephen Smith Jr. venit, vidit, dixit 17.11.2008 23:45:
>>>> Trees look something like this right now.
>>>>
>>>> <some history> -> FT
>>>>
>>>> TI -> <non-linear history> -> A -> <non-linear history> -> C
>>>>    \                            \                           \
>>>>     -> PI ------------------------> B ------------------------> D
>>>>
>>>> I'd like to have it look something like:
>>>>
>>>> <some history> -> FT -> <non-linear history> -> A' -> <non-linear
>>>> history> -> C' \                            \                       =20
>>>>   \ -> PI' ----------------------> B' -----------------------> D'
>>>>
>>>> A', B', C', and D' are different commits, but the diff (and history)
>>>> between FT and A' is the same as the diff (and history) between TI
>>>> and A.
>>>
>>> So, your base directory for TI and FT is different, right? I.e.: In
>>> the TI repo, your project sits at the root, whereas in the FT repo it
>>> sits in project/web?
>>
>> Yes.
>>
>>> Has FT advanced since you took the initial subdir
>>> snapshot for TI?
>>
>> No.
>
>OK, here's a possibly primitive solution, but it works with my little
>toy model of your layout:

That sounds like it will work fine.  Thank you very much.

It does feel a bit "hacky", I was hoping git would have better support=20
this, through the subtree merge or something else.  It seems like=20
something that might happen to others, perhaps as a side-effect of a=20
failed attempt at using submodules.

I can't help thinking that rebase -ip might have helped.  I wasn't aware=20
of -p when I was initially working on this problem.  (It doesn't help that=
=20
I generally use Debian stable, and git 1.4 did not have -p.)

>- filter-branch your TI branches so that they are in the proper subdir
>(you did that already)

If I need to "undo" this, it's really easy.

>- take a snapshot (say ftstuff.tar) of everything in FT's head (assuming
>this is where TI branched off, or else take that point) *but exclude
>project/web*
>
>- using filter-branch again, rewrite your TI branches to contain those
>missing FT files:
>git filter-branch --tree-filter 'tar -xf /tmp/ftstuff.tar && git add .'
>-f -- ti/master ti/whatever

I probably don't need the -f.  If there are files that should be ignored=20
(and thus shouldn't be in the repo), I'll filter-branch to cut them out of=
=20
the history at some point.

Now is as good a time as any.

>Now your TI branches produce the same diffs as before, but are based on
>the full tree. You can happily graft FT's head onto TI's root as a
> parent. In fact those two should produce no diff in between them, so you
> might as well get rid of one of them.

Makes sense.

>[cleaning out refs/original and repack -adf might be in order afterwards]

I generally do these after a successful filter-branch.

>The tree-filter part feels hacky but does the job (probably with -f). I
>don't think a subtree merge can do what you want.

What *exactly* is the subtree merge.  The documentation I've read sounds=20
like this case, sort of, but it's rather unclear to me.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart1594197.taJu0SC7X7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk1bjIACgkQ55pqL7G1QFl/GQCeLr7iy/vS/MAUg+UOeKvw04bo
Uv0AoIQjM53OCtWBKkghAs7POJWi8Pq+
=S5F0
-----END PGP SIGNATURE-----

--nextPart1594197.taJu0SC7X7--
