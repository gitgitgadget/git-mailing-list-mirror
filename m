Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02084C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A0920882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766809AbgJYDGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:06:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56298 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731804AbgJYDGm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Oct 2020 23:06:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 495E06042C;
        Sun, 25 Oct 2020 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1603595171;
        bh=k6sQ5tF4bJltpNTswaWL85wvviv/8Bq9L4cbK3RWpT0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=H4wrGfhoCIe4OEtlon/Me8R9/qv6DfCtgIMCdD6inLxKCvqknZxRS2ITvnQ5l7bAb
         h8Ba1y7JSi811JMA6mxXQ9Wun4ch1qoNE/MhjYWTM6eU/qr9tLpwtFwvHYZOolX+m0
         qSjXFInhMMrMwSOTJP1eUhOWhyGhlZr7ZOwGlsn4slQj3uoqVHLKKgRg+Q1jjCTo85
         0YlWTJ93k6ZsKARzp2dxyK0b+V/auI1KwXGDSdvhj6jDrDIsRHv8uUVGpxp3RByTU4
         OJuMYLnII4va5nIKT24TV3V/jTs74nRNGZ+nMkpuS19/EItNM58GFyWD1blIypa5Tc
         9HkhgyCiRkboU8i7gVpzI0xKA1GjNKPOQnKU+6QVMigvt3QidIQkXhAq4O/hoTfL6g
         xvtM7s5GCskhJvTGMeZqQNlowZrF1x2bOOjd46MXKP3xrsWE+2LtnvpMXEMsI0VufR
         six9mvVImEFmM6jbFu97mtP+kxMqKrgP3q7sBTMsv04J7Lu+1V8
Date:   Sun, 25 Oct 2020 03:06:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     hv@crypt.org, git@vger.kernel.org
Subject: Re: safer git?
Message-ID: <20201025030606.GF860779@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, hv@crypt.org,
        git@vger.kernel.org
References: <202010242019.09OKJTP13180@crypt.org>
 <016001d6aa52$b1cbc510$15634f30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <016001d6aa52$b1cbc510$15634f30$@nexbridge.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[I somehow didn't get the original message, so replying inline below.]

On 2020-10-24 at 22:11:54, Randall S. Becker wrote:
> On October 24, 2020 4:19 PM, hv@crypt.org wrote:
> > Q: Is there a mode in which I can run git that would make it a bit
> > more robust
> > against crashes, at the cost of being a bit slower?
> >=20
> >=20
> > The primary symptom is that files modified shortly before a crash
> > show up existing but zero-length after the crash. For source files I
> > mostly know what to do in that situation, but `git fsck` shows a lot
> > of files under '.git/objects' that are empty, which seems to make
> > things hard to recover:
> >=20
> > % git fsck
> > error: object file
> > .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533 is empty
> > error: unable to mmap
> > .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533: No such file
> > or directory
> > error: 0ef31631726cea2e9bf89d7bbe7b924b5282d533: object corrupt or
> > missing: .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533
> > [... a dozen similar entries ...]
> > error: object file
> > .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5 is empty
> > error: unable to mmap
> > .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: No such file or
> > directory
> > error: f5a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: object corrupt or
> > missing: .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5
> > Checking object directories: 100% (256/256), done.
> > Checking objects: 100% (1577/1577), done.
> > error: refs/stash: invalid sha1 pointer
> > 0000000000000000000000000000000000000000
> > error: bad ref for .git/logs/refs/stash
> > dangling commit 1c0ea4e6159952501957012d2b9db7d68b52d107
> > %

You can try setting core.fsyncObjectFiles to true.  That's the only knob
that Git has for that at the moment, although there was some discussion
about adding a new feature for other files[0].

I suspect a lot of the zero-byte files and any files that end up as
all-zeros are due to your file system.  The default file system on
Ubuntu is ext4, IIRC, and if that's what you're using, you can set
data=3Djournal instead of data=3Dordered as a mount option.  For the root
file system, you'll need to pass rootflags=3Ddata=3Djournal as a kernel
boot option.

That may be significantly slower, but until you get your hardware
problem sorted out, it may very well be worth it for you.  I'd try this
option before the one below because it'll have less of an impact on
performance and may solve most or all of your problems.

> > Last time I checked out the previous state from github in a new directo=
ry
> and
> > was able to find and copy over most of my work before continuing. On th=
is
> > occasion I did a `git stash save` shortly before the crash, and I'm not
> sure
> > how to get that back. I see Ren=C3=83=C2=A9 Scharfe's suggestion of:
> >   git fsck --unreachable |
> >   grep commit | cut -d\  -f3 |
> >   xargs git log --merges --no-walk --grep=3DWIP from a recent message, =
but
> > that is only showing me an older stash item.
>=20
> I would suggest turning off write-through buffering on your disk. Let wri=
tes
> complete immediately instead of being deferred to sync. Also, this does f=
eel
> like a disk issue, so fsck or chkdsk /f (or whatever) on your disk urgent=
ly.

Turning off buffering and caching for your disk drive may make things
_really_ slow, but it will definitely improve data integrity.

I know hardware problems are always a hassle, so I hope you get things
figured out and fixed soon.

[0] I admit I am not running the very latest version and the new feature
may have already landed; if so, I apologize for the out-of-date
information and for not keeping up with the list.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX5TrnQAKCRB8DEliiIei
gcH2AP4zD6ERPxOMNgt5+v5o5D3RTPv49h50LVoaqcI8grmiiwEA0J813Ij3XTX+
xXlc9+u7fWlASSOTUMOdH51OhFUnvw0=
=gsaP
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
