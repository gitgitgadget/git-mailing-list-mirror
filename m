From: tboegi@web.de
Subject: [PATCH v9 0/6] convert-eol-autocrlf, old 5..10 now 1..6
Date: Sat,  7 May 2016 08:10:56 +0200
Message-ID: <1462601456-23439-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvNV-0003Rf-Sk
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbcEGGGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 02:06:05 -0400
Received: from mout.web.de ([212.227.17.12]:50462 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbcEGGGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:06:03 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LnS4I-1bZeq61dKo-00hbBq; Sat, 07 May 2016 08:06:00
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:KVcNbspapE+1lraq4hM2K7O5tCvIwkwFkaINe+gne8rXuQF8J//
 TrkOVLredm/TvUezp40kaMJ5grivuWxZ5T+82Yp/7k/BfdkVq0I2Z1nURfFlw9la9P4Gh/5
 XPbN95QZccW+l2O3qf4aIKNfApOAwC9OVDbZ5tnxUdeFFVF+aaZhw2Z1TvL77Ip6bJEM67s
 fSVnbOZvo1i25Er4OqMUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FUtWSHSO9mo=:HxnScVvZG2i1O41tdGXUCq
 NYqAc0bntBA4UbYdZUX0EOvfMK+12vVF0TsASRXCzix+nsYvFCyEyNeMcaF7K+O0irnli6fcu
 N6hQldRXAz2oDOlFV11WwWl7u0lfCUAdkdA0+KAmFibLhduHkmTrvrCFlwuaFSYdpIPiRLb49
 HBkHeB+JEweIHe68ojJ6UPI7+IkJQd4DEe1ghUT1AAiGuPJQxZxQ3cyVu9VwPqqUsTx5qd92g
 MphjfMSBye4VBeX7AhiSVjU+PgztkbpSCa0mWOKL9sOIgfKJ1ICo3sK8FiHRwaBSwoEZqb8eF
 SV4AainucCcmuRtVLR0gjkjfGcuBks8C08anu3TGaeuVpcZ7UUFDBZaUkX4tyBR8HUqou/bft
 ho2g/fX2vMLUfkeS+WWxxmKIyckPNIsCA2WdWe3Mn7PW5aPaf47EBB4/c2XwNtenfCy70plty
 3kxmO76Dd8aRK+DMDjXapP8HXlR77amxMTJZGlc2VcbkDGFYlTz2f7pIVVrwvaIDUGcK2ijnE
 otlFnn4Nr3ja4zkxR2UfOEHvTMnXU+6GXLIcSiDKxljhdxtcxjfXcnqTy0nyKwTvqhKzftWfy
 vjbEbXWAZTIP6NjrXhHKR1ISOnO1Wdq+LyWtufHIfNK0A+pX82g7gElFNy+7HEF0OhMJsWLnU
 3Ezx9rI12fDh+F3sALZzMmfwULKU8Vtr83prwT3dkTB1a6D9O3T/96b7aebolrMZ6D71A0d8q
 9an6lLW669GuEA7UeB8z++lvRc7YbMgDfu4r84bZlOWN8MX0nt5yyLMiFSexMyPElWO/fW/A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293875>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Changes since v8:
  As discussed earlier,  1..4 should be broken out into=20
  tb/autocrlf-fix or so.
  1..4 are not part of this series any more.

  The old 10/10 is now 6/6.
  It is replaced by "ce_compare_data() checks for a sha1 of a path"
    It now checks for "What would git add change in the index",
    and not "is the working tree clean after checkout" -=20
    thats how it should be.
    Basically an old limititation of "has_crlf_in_index()" has been fou=
nd and
    fixed.
    The commit message may need some tweaking, and
    even the implementation, so feedback is welcome.
    Beside that, I haven't run the tests under Windows yet.

Torsten B=C3=B6gershausen (6):
  read-cache: factor out get_sha1_from_index() helper
  convert.c: stream and early out
  convert: unify the "auto" handling of CRLF
  convert.c: more safer crlf handling with text attribute
  t6038; use crlf on all platforms
  convert: ce_compare_data() checks for a sha1 of a path

 Documentation/config.txt        |  14 +-
 Documentation/gitattributes.txt |  24 ++-
 cache.h                         |   4 +
 convert.c                       | 362 +++++++++++++++++++++++++++-----=
--------
 convert.h                       |  26 ++-
 read-cache.c                    |  33 ++--
 sha1_file.c                     |  17 +-
 t/t0025-crlf-auto.sh            |  12 +-
 t/t0027-auto-crlf.sh            |  98 +++++------
 t/t6038-merge-text-auto.sh      |  60 +++----
 10 files changed, 407 insertions(+), 243 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
