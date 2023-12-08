Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MsTHR1MP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+lmScc+"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4AAB5
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 00:19:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 24FD53200A66;
	Fri,  8 Dec 2023 03:19:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 03:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702023569; x=1702109969; bh=X0
	qcS/yGWeM8bueo/R2W41rwcqIIPldamtnPa8P+ojs=; b=MsTHR1MPagUHVWnqZs
	I70v55V6jGYyWak74ABKx8sLU5uCHzjQJ3JnKo+ToAbSO3zFIDm4eLmiBtk2kHiX
	ImU8ovlrK42IiCLFTiKk2cX4JyT1LsovMIUNt+9BmL8k11xFCOfxbQy5IGC+07ZS
	oeO8fo8GQJGX8+o/YTmOPwN1hesAe2eGDxRu8ch6MW2Mu6LAn3TrL2e2Oo4NsJpi
	BbX28Z+3F7zSbxg9gIqkBjslXTtZPnONUAdyChRug4Z0RY0JZdH1pOeoVjZIyiYd
	dmPpoMeGraWjRwMiY+2pkIG+zabsHcLRzIkpj7kc2oIdFHBBKNhJCKpdY/eiyP7e
	tpQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702023569; x=1702109969; bh=X0qcS/yGWeM8b
	ueo/R2W41rwcqIIPldamtnPa8P+ojs=; b=D+lmScc+Pt+nrVeNdTJbPFLF3kbU3
	HEWt5q9Pj2SFYKLeKS9nfUTPdoAP27ZGzuYzCmstCmfhLp0FRDjnnIEnW97N9w0+
	OjI9BIDYly2HGgazNFoZ1Cqk2i7hOx6zVb6jWwHVLeQpXlGAuekVQYCy2aL/rU09
	6MH0PSJJg4PMoxCTjA8nJGhDp7xcN126B/5yCUb9jf5KE+MUfcPs0Li80feheLXy
	Hs/OqPCoyWINQdG3ieEC8iOuJukMdzGYqenLOJrGVqhEEgFky3lz1W9ThFWeQH+G
	61pIfC69UUpAdeNp9jd4EVPOdgPa0T9AOQmkZR1iaVzGuQrlhpbWuIwNQ==
X-ME-Sender: <xms:kdFyZc97H0xrOYiSrWnT-i7xyY1FnwtBREbKXPjmJnMp20Rv3vW67Q>
    <xme:kdFyZUvNbZ9t6p-Z332Plj2Ctvps-J3ERiJMXrBFs8y2ypSTrwn-CSGSHWp9So9d1
    jNPtFCftIzQZ6nRWg>
X-ME-Received: <xmr:kdFyZSAjtsoGOianMcphGsFlqNqUOMjgPTvNo-GM111Jj3Ntp_gnkfH1dajxfj8w1HCHXvxyl_525jHHLYqpOSsikzDHFyIoCQmLz3lkGiD6yEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kdFyZccgf1lGwDXCe1fGywSmutyKjcYQjc1vlXtTKnyyngpdAXJn1w>
    <xmx:kdFyZRODS1jjfN_BdL2ny4_pqBqJubkU76Jgtb2ODXKufHZCORG_Tw>
    <xmx:kdFyZWl9VEDyIvL6EqLZIaK2MJIHl-xF8BxRBuppuh5MzlSCE1yBbg>
    <xmx:kdFyZaa_rsNG0xbNhvtwWoaQFh-LeHxQSI3wMrQlIERp8JZhXs8-AA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 03:19:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4251f80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 08:17:57 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:19:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <ZXLRjeu66qE6J1K1@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
 <ZXHE5Lce_6CAWKFT@tanuki>
 <ZXIq4mjDUoqlGvgW@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G8J558BXH5WWiIa7"
Content-Disposition: inline
In-Reply-To: <ZXIq4mjDUoqlGvgW@nand.local>


--G8J558BXH5WWiIa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 03:28:18PM -0500, Taylor Blau wrote:
> On Thu, Dec 07, 2023 at 02:13:08PM +0100, Patrick Steinhardt wrote:
> > >   - cruft packs (which may necessarily need to include an object from=
 a
> > >     disjoint pack in order to freshen it in certain circumstances)
> >
> > This one took me a while to figure out. If we'd mark crufts as disjoint,
> > then it would mean that new packfiles cannot be marked as disjoint if
> > objects which were previously unreachable do become reachable again.
> > So we'd be pessimizing packfiles for live objects in favor of others
> > which aren't.
>=20
> Yeah, that's right, too. There are a couple of cases where more than one
> cruft pack may contain the same object, one of them being the
> flip-flopping between reachable and unreachable as you suggest above.
> Another is that you have a non-prunable unreachable object which is
> already in a cruft pack. If the object's mtime gets updated (and still
> cannot be pruned), we'll end up freshening the object loose, and then
> packing it again (with the more recent mtime) into a new cruft pack.
>=20
> That aside, I actually think that there are ways to mark cruft packs
> disjoint. But they're complicated, and moreover, I don't think you'd
> ever *want* to mark a cruft pack as disjoint. Cruft packs usually
> contain garbage, which is unlikely to be useful to any fetches/clones.
>=20
> If we did mark them as disjoint, it would mean that we could reuse
> verbatim sections of the cruft pack in our output, but we would likely
> end up with very few such sections.

Makes sense. It also doesn't feel worth it to introduce additional
complexity for objects that for most of the part wouldn't ever be served
on a fetch anyway.

[snip]
> > Okay. I had a bit of trouble to sift through the various different
> > flags like "--retain-disjoint", "--extend-disjoint", "--ignore-disjoint"
> > and so on. But well, they do different things and it's been a few days
> > since I've reviewed the preceding patches, so this is probably fine.
>=20
> Yeah, I am definitely open to better naming conventions here? I figured
> that:
>=20
>   - --retain-disjoint was a good name for the MIDX option, since it is
>     retaining existing disjoint packs in the new MIDX
>   - --extend-disjoint was a good name for the repack option, since it is
>     extending the set of disjoint packs
>   - --ignore-disjoint was a good name for the pack-objects option, since
>     it is ignoring objects in disjoint packs
>=20
> Writing this out, I think that you could make an argument that
> `--exclude-disjoint` is a better name for the last option. So I'm
> definitely open to suggestions here, but I don't want to get too bogged
> down on command-line option naming (so long as we're all reasonably
> happy with the result).

Yeah, as said, I don't mind it too much. It's a complex area and the
flags all do different things, so it's expected that you may have to do
some research on what exactly they do. That being said, I do like your
proposed `--exclude-disjoint` a lot more than `--ignore-disjoint`.

> > One thing I wondered: do we need to consider the `-l` flag? When using
> > an alternate object directory it is totally feasible that the alternate
> > may be creating new disjoint packages without us knowing, and thus we
> > may not be able to guarantee the disjoint property anymore.
>=20
> I don't think so. We'd only care about one direction of this (that
> alternates do not create disjoint packs which overlap with ours, instead
> of the other way around), but since we don't put non-local packs in the
> MIDX, I think we're OK.
>=20
> I suppose that you might run into trouble if you use the chained MIDX
> thing (via its `->next` pointer). I haven't used that feature myself, so
> I'd have to play around with it.

We do use this feature at GitLab for forks, where forks connect to a
common alternate object directory to deduplicate objects. As both the
fork repository and the alternate object directory use an MIDX I think
they would be set up exactly like that.

I guess the only really viable solution here is to ignore disjoint packs
in the main repo that connects to the alternate in the case where the
alternate has any disjoint packs itself.

Patrick

--G8J558BXH5WWiIa7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVy0YcACgkQVbJhu7ck
PpRNMxAAm5sdmk9zVeoLLhTU++1ZxKZGwAfbGAiES65WUnno3KAXuOCktCKR70d3
hrj359P57GM92/eOoPBVdoCHMHdhWRmpVYbYJyj/D2dIrSdK3SaPB1p8bswVtNuS
9CSR9ueIIYUDh1GtumNODimsDobSo/KRHnc1BUubsfYXvptuckKXnGEMRP3PyxnO
jdLpYPH9srkTRpLcURklRjgl9/bMW6A85cKdE8+FsVFSBQTZ89KxlRwr6rW4DKMc
lBn0kA1BZE+mUlKrnDOFN/YhK7xhBDKr8PvV1qtZ68zDWPNox9zgefovdQnAtIn6
z3ZtKiC/twK0QgeSF/NJ4csBzUy7TcwwwwfYTj/5Aduf+exRNqQwGqEeqsecTiji
iLzOwxBCP9jD18+T9sthH4UbWacZE675v0D+Q3M7982vWdXqch4lLN7ezx2yu4YD
0qGvd952z246vJUOJ9FzO1HeFF2UVNBm1eXt8ADdVtx/JGcQv7y/nBB8H1zItBLP
oIarOdMqnSHK2v0TdBUouNoEFZlq436xmQhgADfvMOkjGlDKLZxIJg3OzdwrwzOf
VmxcC+TPRXBVtvWPOYeLNPRLzho7Gt5RridPN16xYsgH85c/ZiBeaumqGdl+yaFq
A+fRJROMvS8XYmiJ4VuGevaTJG0/H1l+jFytTGP8ccKyn82hMok=
=bPpA
-----END PGP SIGNATURE-----

--G8J558BXH5WWiIa7--
