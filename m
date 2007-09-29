From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Big performance regression with --no-color option in git-log
Date: Sat, 29 Sep 2007 13:01:30 +0200
Message-ID: <20070929110130.GC4216@artemis.corp>
References: <e5bfff550709290302h6016c6e8mf9d5dfddce07d985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qtZFehHsKgwS5rPz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 13:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iba4q-0001Y9-4l
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 13:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbXI2LBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 07:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXI2LBd
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 07:01:33 -0400
Received: from pan.madism.org ([88.191.52.104]:57413 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbXI2LBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 07:01:32 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BFD6522159;
	Sat, 29 Sep 2007 13:01:30 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 512AB343BDD; Sat, 29 Sep 2007 13:01:30 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e5bfff550709290302h6016c6e8mf9d5dfddce07d985@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59459>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 10:02:23AM +0000, Marco Costalba wrote:
> On today git tree

hmmm interesting... Here is what happens with --no-color:

    38708    33.2920  diff_tree
    23908    20.5628  base_name_compare
    18478    15.8926  decode_tree_entry
    8310      7.1473  find_pack_entry_one
    5654      4.8629  update_tree_entry
    2748      2.3635  pretty_print_commit
    1838      1.5808  get_one_line
    1460      1.2557  .plt

and wihtout it:

    2594     18.0893  pretty_print_commit
    1887     13.1590  get_one_line
    1574     10.9763  find_pack_entry_one
    967       6.7434  get_short_sha1
    892       6.2204  parse_commit_buffer
    863       6.0181  lookup_object
    595       4.1492  strbuf_grow
    440       3.0683  insert_obj_hash

Why on earth does --no-color has such a different code path ...
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/jCKvGr7W6HudhwRAl3eAJ9JjcoyxiuXbT2qjc7VLc8UyvLcYgCgps1y
hIUfm9prhKbos/uv3LLX6o8=
=Dgvt
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
