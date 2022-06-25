Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C8C43334
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 09:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiFYJBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiFYJBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 05:01:09 -0400
X-Greylist: delayed 1935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Jun 2022 02:01:06 PDT
Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38422CE1A
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ethgen.ch;
         s=mail; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hwqyL4Bpw1CdqjO4EuCgOiC2Yn9vwnp1gnqiD+GGAEg=; b=FJO3/IfD/Ec7I+AVIigxdufYfi
        Ee7r+pLzNe1ynalU/KPw6qLrPe1dyHUGAjB7UutVuMX77veBzgHhI5NXwbH7rm4+VdgCNRsrqv9r0
        /J4nJLjNdYjYjpnP1n/DcDFJGjc6/DH67ZJYdsXaCUKV0sjFdRqd6srvJvrMjjcIetUadi0KbIgNC
        VhWr3thqkEiIQhnfpaZrwjaX/QZVurqsrHF1xrNt1gC3pghiMrdczJpENjO0htr91/k4tlO4l8LNO
        lMSlf3YZb/1WVcu6KQq+42U4xpS8iCFWK/ieTLXWGyLLz3D9sf+h+dFIWgqCrZ03Ol3aCTeZ/zsUh
        QKGQzHXwlfSR2DM2G/X2cK5RrOBGSOTB7G4b1el922QBXd/MXmwjoHQRiCN2y/pdgAsb3qnEAjr9z
        iUmpoo0jdtnEecGCm2XRbIXsI4sWV3733o2Q4l3L/H5HwOv9FmC4ljRMqCsLx4fQQjwFajCeYwAjc
        3IFShX7JAZoldKoL2jYEM7fZ09yuOPQlYQkSYGzINxLk7GKqtnwf/qImiQXV5++YN8lA0HPLR3Ovq
        maUyI+AdJkHZ3s1uSA/0xgH2bc5VxxXIDHB+4ZuNWek/HxeYiQs4LWTlFjIu+wVBoPLIDnkhyTn75
        m8YYp8SB/r9PuAuMr4OQCH3D/fm5BLdtLihQmayPs=;
Received: from [192.168.17.4] (helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <Klaus@ethgen.ch>)
        id 1o519r-00035h-55
        for git@vger.kernel.org; Sat, 25 Jun 2022 08:28:47 +0000
Received: from klaus by ikki.ket with local (Exim 4.95)
        (envelope-from <Klaus@ethgen.ch>)
        id 1o519q-0004Lf-Rd
        for git@vger.kernel.org;
        Sat, 25 Jun 2022 10:28:46 +0200
Date:   Sat, 25 Jun 2022 09:28:46 +0100
From:   Klaus Ethgen <Klaus@ethgen.ch>
To:     git@vger.kernel.org
Subject: Git-Bug
Message-ID: <YrbHPlJy/EW/Y+ON@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P86+cjiTyaSoBWDd"
Content-Disposition: inline
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P86+cjiTyaSoBWDd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

since some versions I have the following troubles with git:

I use vcsh to manage my vim config files and pull/push them from one
machine to others. That was working great but now the push refuses to
work as it state the working tree is unclean even if it is clean:

   # on the server:
   ~> vcsh vim config receive.denyCurrentBranch
   updateInstead
   ~> vcsh vim config core.excludesfile
   .gitignore.d/vim
   ~> vcsh vim status
   Auf Branch master
   Ihr Branch ist auf demselben Stand wie 'origin/master'.

   nichts zu committen, Arbeitsverzeichnis unver=E4ndert

   # on the client:
   ~> vcsh vim status
   Auf Branch master
   Ihr Branch ist 3 Commits vor 'xxxx/master'.
     (benutzen Sie "git push", um lokale Commits zu publizieren)

   nichts zu committen, Arbeitsverzeichnis unver=E4ndert
   ~> vcsh vim push
   Objekte aufz=E4hlen: 10, fertig.
   Z=E4hle Objekte: 100% (9/9), fertig.
   Delta-Kompression verwendet bis zu 2 Threads.
   Komprimiere Objekte: 100% (6/6), fertig.
   Schreibe Objekte: 100% (6/6), 821 Bytes | 821.00 KiB/s, fertig.
   Gesamt 6 (Delta 4), Wiederverwendet 0 (Delta 0), Pack wiederverwendet 0
   To xxxx:.config/vcsh/repo.d/vim.git
    ! [remote rejected] master -> master (Working directory has unstaged ch=
anges)
   error: Fehler beim Versenden einiger Referenzen nach 'xxxx:.config/vcsh/=
repo.d/vim.git'

`vcsh ... command` does the same ad `vcsh ... && git command`... vcsh is
a simple script that sets GIT_DIR to ~/.config/vcsh/repo.d/....git. vcsh
is used to manage config files in $HOME but not the full directory. In
this example, it manages .vimrc, .gvimrc, .vim/ and .exrc.

As you can see, there is no unstaged changes but git tell me there are.

I tried different things but failed to tell git that everything is clean
and that there are no unstaged changes.

Other vcsh trees are working well. I see no pattern why this one is not
working.

Regards
   Klaus

Ps. Please keep me in Cc as I am not subscribed to this list.
--=20
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--P86+cjiTyaSoBWDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAmK2xz4ACgkQpnwKsYAZ
9qxD5Qv/fAXEBcIxP4AATGMhihe+uK40Nc+Z7ccxvXK2qScg6nUVgnJjt4RZCJh9
HVFqVlheY3Bt/GZA/FUfHgA+9oDFmCU91j3Qa9BVUE2LgLEQoFrWWcmle+ChIVW7
TeqwZtRKtGMzcRjbzRO12/Ke5ReiSCsfXOMCx2nH/i24Lc4+Z2Yo5zzKFbL2AJUC
3Iasxf1AQG5n1fG+/M/Bus3pn6WQpkvyHsaCWB5fsWmOhdDsZzVsY/U7vb5uN2fD
8MykT3TyN+aDeLHaHdmOClvUgq31HcQtQGvR0eZKRZ51vWF0a0RAzQqighbZ2Q57
W01AVeRP+I6m6SHND+BvTcifOB3G4SB7pFWkO0/0itA6dMQyc/5wwMPdeZ/D9OeO
K5lXRzLYIcVswDjqfkgJpjjroysBdWe9phAV9Uh+KLtCExw4zuFkZBRHDAhJ1uI2
OYJ2Sr5VhR9L8MfuUjCiLp5Kq+GLPg0HYYz7Zy4P8HpeN8zPryO+kb8a1rc5YvPH
XfbO8w4O
=/KcU
-----END PGP SIGNATURE-----

--P86+cjiTyaSoBWDd--
