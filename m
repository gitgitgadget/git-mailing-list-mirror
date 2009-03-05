From: Matt Enright <awickedshimmy@gmail.com>
Subject: Re: just curious: what influences a commit hash?
Date: Thu, 05 Mar 2009 02:25:39 -0500
Message-ID: <1236237939.2421.38.camel@virgil>
References: <20090305063632.42880@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uZDhKV65f2KQ3KCFt166"
Cc: git@vger.kernel.org
To: stoecher@gmx.at
X-From: git-owner@vger.kernel.org Thu Mar 05 08:28:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf800-0000GT-2o
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 08:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbZCEH0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 02:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZCEH0d
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 02:26:33 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:47042 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbZCEH0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 02:26:32 -0500
Received: by bwz26 with SMTP id 26so3119460bwz.37
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 23:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer;
        bh=l7rCEYlnPAQpqiaoYkZQsWq1OPAvFsHRuNlTcd0eyTo=;
        b=puCBkmzvRm0QBEz8xQhIIPJJo0bcOl4BxwhS07TxLc3sgyuA0wIOVMyn2MWYUmFOS3
         Z+J6hP+T1hUS6vLpqgIxQKjh72NtCHYjvZ2+j8FeBXOTdHf9r5E8c8MrwPpUBnnzdeeD
         7l/RQutIccqgs/eTEIW78o3GTVhRgIEDFf0XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer;
        b=jR8XAhx3uFtJfwUtvnu87rHz4ChZeD9qNNNEvs3Nq8ZvD9hta2PsFCouzV7Z2aUNjQ
         jF6l175q137AIgiYN6Zkt7nRazU4vqRS40y7OWynypxtcicJFceYXWNyC7LKBfhaRaMn
         BoNrdcpsA2U3V7G+SlZALmGKzBfrnlvy1zLH8=
Received: by 10.103.214.8 with SMTP id r8mr400189muq.6.1236237988907;
        Wed, 04 Mar 2009 23:26:28 -0800 (PST)
Received: from ?192.168.1.33? (koln-4d0b1f93.pool.mediaWays.net [77.11.31.147])
        by mx.google.com with ESMTPS id y2sm4397241mug.45.2009.03.04.23.26.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 23:26:28 -0800 (PST)
In-Reply-To: <20090305063632.42880@gmx.net>
X-Mailer: Evolution 2.24.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112260>


--=-uZDhKV65f2KQ3KCFt166
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-03-05 at 07:36 +0100, stoecher@gmx.at wrote:
> Hi,
>=20
> being new to git I did some experiments with commits looking at the hashe=
s. What I observed:
> * The same commit (same file, same committer, same message) into differen=
t empty repositories (git init) gives different hashes. So I assume that al=
so the time of the commit influences the hash. Is this intended? For what r=
eason?
> * Having created two repositories exactly the same way (the history is th=
e same except for the commit times and hashes) I applied the same patch (us=
ing git am) and again I got different hashes for these commits. So in some =
way also the repository/branch influences the hash of a commit!?

This should be expected if the initial hashes in the history are
different. The hash of a commit is based also on the hashes of all
parent commits - in this way git 'protects' the repository history by
guaranteeing that if two objects have the same hash, they will come from
the same history.
So the second issue is a consequence of the first, though I am not
certain why the first occurs (if the file contents and size are the
same, I would expect the hash for the blob/tree to be the same - maybe
due to git's special handling of initial commits?)

> From reading the Git user's manual, chapter 10, object storage format, I =
was not expecting this. Can someone explain or give a link to a more detail=
ed description?
>=20
> thank you,
>=20
> Wolfgang
>=20

--=-uZDhKV65f2KQ3KCFt166
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkmvfnMACgkQzHRqhKBz5O/yGQCcDng9NaZFY1T4Ib7psEA2bb9a
E6sAoJasnk5zokNnUBl8H1FmowEUQyTP
=8crx
-----END PGP SIGNATURE-----

--=-uZDhKV65f2KQ3KCFt166--
