Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D99207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbcJLOzX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 10:55:23 -0400
Received: from prod2.absolight.net ([79.143.243.136]:58487 "EHLO
        prod2.absolight.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933553AbcJLOzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 10:55:21 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Oct 2016 10:55:21 EDT
Received: from prod2.absolight.net (localhost [127.0.0.1])
        by prod2.absolight.net (Postfix) with ESMTP id 7F82EBDCBA
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 16:45:30 +0200 (CEST)
Received: from ogg.in.absolight.net (ogg.in.absolight.net [79.143.241.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by prod2.absolight.net (Postfix) with ESMTPSA id 5D4C0BDC86
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 16:45:30 +0200 (CEST)
To:     git@vger.kernel.org
From:   Mathieu Arnold <mat@FreeBSD.org>
Subject: problem with git worktree and git svn
Organization: Absolight / The FreeBSD Foundation
Message-ID: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
Date:   Wed, 12 Oct 2016 16:45:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DEl9AxKIhrTtEGNRV3Do9Bru8IwGUQM5u"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DEl9AxKIhrTtEGNRV3Do9Bru8IwGUQM5u
Content-Type: multipart/mixed; boundary="Tj9dHGI78IEBBqssKkM4NcSRnNrFchHRO";
 protected-headers="v1"
From: Mathieu Arnold <mat@FreeBSD.org>
To: git@vger.kernel.org
Message-ID: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
Subject: problem with git worktree and git svn

--Tj9dHGI78IEBBqssKkM4NcSRnNrFchHRO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a FreeBSD ports developer, and while our main repository is in
Subversion, some of us use git-svn a lot for development.

I discovered git worktree earlier this week, and I found it a great
asset to be able to have more than one branch of my worktree accessible
at the same time...

Anyway, back to my problem, the way git-svn works, is that it looks for
a directory named "svn" in its gitdir and if it is not present, decide
the repository is using git-svn version 1 (whatever that is) and goes to
parse all the revisions to recreate the svn directory.
So I can only use git svn commands in my main worktree, the one with the
real gitdir.
To fix that, all I had to do is to add a symlink named svn in each
worktree's gitdir and pointing to ../../svn.

I think all that needs to happen is that when adding a new worktree, if
the main git directory has a "svn" directory, add a symlink to it in the
worktree's gitdir.

--=20
Mathieu Arnold



--Tj9dHGI78IEBBqssKkM4NcSRnNrFchHRO--

--DEl9AxKIhrTtEGNRV3Do9Bru8IwGUQM5u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQJ8BAEBCgBmBQJX/kyJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQzQUI2OTc4OUQyRUQxMjEwNjQ0MEJBNUIz
QTQ1MTZGMzUxODNDRTQ4AAoJEDpFFvNRg85ISw0QAKvbX4wUh1eIl4sClP9l22j6
j5LkBZa0JAe8QomfXL2fnfyIVDL8vYVGNDNRgCXU3hqlPXQZvBPFaFVA0WeyA1BV
KnCrqt5CoPsUWDHBfeO1Z7EILC+rLFQiXs2MA1/bZwvm5zvK2ZZCbWVphnpQynrI
5CBFrfBaS1ua2CbkDAcYhRXrd4r8IUZGIxlL80k9wSEd1iLQOzm3/jCKx1Tns94F
VrvfwcxxOg0g7baYJRUstx0p8AK9XJzTtYLXYmkymrmcAfwOEIBS03k474UYhlr9
1E0HH1Z5XgTc/Sb5oAWS9aznPzu9Esn6MYuP2NeC3/Cj6HEDZAfpt3xdI5oi9e+G
XGZFg7Y81dMK2ovdsYfQdVJTFMzQcT8tEmxMuBPoBxVcH2h/RAyT/lJKTOerI8it
zpSScGVPX/RGhIAvn1yY8j0JITgcGJh0ZE6MRIDmcj1bduR1Asn8ECJ4F4+h+PMa
jSeweoFU8jo7aHKa/llMZTyF6AN+oFhI40coj+A2qjeUavRykqFJiHFRECtCQZIB
5IjE+eGrRvPGRMoZ1tqZ7gEHh1xa45/WJIjTMEaFTSKzOrl4H9TeD7RvkfBH/GnJ
aJamUDNudSt8P/U7VKx0XiseOA2R2NWZPAD5mT/72kRC3z4lRfEmvnkGLTTDS0PU
j3rJq46u29M7/4g2zpRf
=BdCk
-----END PGP SIGNATURE-----

--DEl9AxKIhrTtEGNRV3Do9Bru8IwGUQM5u--
