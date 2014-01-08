From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Wed, 8 Jan 2014 19:00:36 +0000
Message-ID: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_A78374BD-149F-4BF6-BC8A-22A5DEFF8DB6"; protocol="application/pgp-signature"; micalg=pgp-sha512
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 08 20:01:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0yNF-00052w-TZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 20:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbaAHTBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 14:01:01 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38658 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbaAHTAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 14:00:41 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so2130174pdj.17
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 11:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:subject:date:message-id:cc:to
         :mime-version;
        bh=4zgMsvEFix1vOnyk3rmee/+kv12vZWAfXq8os2qU/SI=;
        b=DzkXwNv2w4MXZr+eUNI5GTXUBgLCMxvKlCj5FFbDE3Qq294DNLpUy2thIyHyK+j+Iq
         pgd2P02xWmx4X3R1I/xyqAhVnoZ+1L4W0a8b1vrZyk3WNY0AYQCGQG9JkTOJecsiws9t
         6F6iWyCH5XqRUcn6nahoPhWHpubPBYCQwo4CtQKKfseI91deX2z3ALXvLrLRpo5Nn6+G
         CU6BqOFSJ/Dd1f+gjk8tNdvwZFXJWiL9d1/01O+Gd1KUgQVGC3fdRPRB3GX7gCxltkEr
         qt0hJgaWwofS3SYraS/KJiyir4NOA5/5636++wWkXIfXfEiP6emLb8B6UaT/cUtM/FEh
         cEzg==
X-Gm-Message-State: ALoCoQn61lmSyEI2qaCbl1ngG9mphZc675CddFRzShtIQjobxoSuydgXenlRa0P9Guq8wJXhSPqm
X-Received: by 10.68.227.36 with SMTP id rx4mr24331463pbc.164.1389207640934;
        Wed, 08 Jan 2014 11:00:40 -0800 (PST)
Received: from [10.40.8.139] ([69.164.175.238])
        by mx.google.com with ESMTPSA id da3sm4249313pbc.30.2014.01.08.11.00.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 11:00:38 -0800 (PST)
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240221>


--Apple-Mail=_A78374BD-149F-4BF6-BC8A-22A5DEFF8DB6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

=46rom a1f898fdf560e719d447a544569d5d1457307855 Mon Sep 17 00:00:00 2001
From: Ryan Biesemeyer <ryan@yaauie.com>
Date: Wed, 8 Jan 2014 04:22:12 +0000
Subject: [PATCH 0/2] merge make merge state available to =
prepare-commit-msg hook

Since prepare-commit-msg hook is given 'merge' as an argument when a =
merge is
taking place, it was surprising that the merge state (MERGE_HEAD, etc.) =
was not
present for the hook's execution.

Make sure that the merge state is written before the prepare-commit-msg =
hook is
called.

Ryan Biesemeyer (2):
  merge: make prepare_to_commit responsible for write_merge_state
  merge: drop unused arg from abort_commit method signature

 builtin/merge.c                    | 13 +++++++------
 t/t7505-prepare-commit-msg-hook.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

--=20
1.8.5



--Apple-Mail=_A78374BD-149F-4BF6-BC8A-22A5DEFF8DB6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJSzaBUAAoJENsKO4td9bkLKEkQAIbobHxHM9pISfW1iN06mBQL
UK17anXWsCmPYUzT3mSVOYlqEQy7GYsu+J4USklXFILMNIL6tqviJ0n0RXD3hGo7
TGMEbNaQcD5fyqR0SLgdqZ02ADcScgCwLPELdGYJjn2KKKKNR605jiC1mZgZK7XW
t++io/PrA6RX+Z3rvovktYH62CAChC3qztwCIZnTchFYXC3JACYkbHgmN2lNeqWn
1gXb/v6JX4FTSwiW8UjccdKMHN9G1U3XrqCQwfKTZggpmX+dmjFl0EsC3Imfg/IM
6quL4rMHgnv3J/Hehqvi3Ujh10wmZ8HJRdXvAqb6MO7NpQqZbQIkSVcO9KZdYVP9
c2/J/oY9ma7g4x8nvEyEdST4JfnGr3SFmdK6cwSN2BiiHECsTthynn0G6ximA5IN
tXrx0OT15lAmpzQDmx3oqR94S5xSZ/b/qAri8BqjWl2uQyAeSfcNetfJQqgrCyi+
nk1WIfiNYB9GxPd9fpSdyWSMCh8hRanaGfY0YDxrag7p1/uV2AYwrNJQU/XYj4wo
4EAk7aqkd7kF8/UkfpucTu84xi7dnH6vumkDQIPEu429AQI01igEAwHotkYXmjo0
8A7IWtrPJnaV5PQvtkn+j9PV8d445X85wxmuGNq0BaNlGtv/BaFek3uv1ek4D/k9
Gu2cVfLcN6IvgV6b6T4f
=ej3k
-----END PGP SIGNATURE-----

--Apple-Mail=_A78374BD-149F-4BF6-BC8A-22A5DEFF8DB6--
