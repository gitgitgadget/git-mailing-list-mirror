From: tboegi@web.de
Subject: [PATCH v2 0/3] unified auto CRLF handling, V2
Date: Tue,  7 Jun 2016 17:20:46 +0200
Message-ID: <1465312846-4791-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 17:14:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAIi1-0004Gn-DU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 17:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464AbcFGPOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 11:14:16 -0400
Received: from mout.web.de ([212.227.17.12]:58248 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411AbcFGPON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 11:14:13 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MEVYz-1bHATY3kN7-00FhFL; Tue, 07 Jun 2016 17:14:10
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:oo/KNZK9iCZXuvHHZVwFfB42rf8vt1muJqxoZ4UrNikYCqZvnjA
 wxfmH45s9fazvP7NgrprKFCtqTJ5VPXZ2P4pCeNnScxMfoXTE4Z7lDz0JEUiNWYdZOFbx8o
 odZ7HTk2dW01Zr4dmK6NbZdn/qQzLstqmChbHu/phiJnB+20usFoVNigTsKZVPsAuTKdXj+
 MZlBst6i0T1jNrrm1TMbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1BDdy8luh24=:6MroBAYCd2xSnK1Rb0iynA
 7LDPuVnBXELO73SsDCSTEMo5rMRa22odE3ig3jh9SNmQa3f+6EUga1j1bBT5Sf4Y8qVzfhGb7
 WKtRqz41zwVNlf31jibiuR+zx6NNXb98pONSut57cHWvlIxK8g5WVSUUFKyAkoaqQPloE7iw4
 urPmbX5RGD9mbQefMVx8qbK+Tup5hkrRqDvG+yvdDjVJ1U4Is5HvO2Fn66nMimacua8zfxr/o
 i2Acu+l6uCN9zC9KL7aBwWeXPUmaFuJeCVbeBf5Weq6jaKlyjiR4kex+mpwL8HYs1UVLmic09
 aF9IYrlHPV2rbXFzewcEz4540Py/2qnL0IJ1rBXBFdwiuKd9oxbwFbNBq0aWXOJsjYKT9to31
 lymhV0ei92fTuODxByUzT4zoz/muSJZHGPL9Mgo5sRURRk7r4eP8PX9UihaxrTs5ow7gbgtr0
 HWYdN3sS0F2FmOf+p3SLuIglk5fhXODxi9+OZasCZd8zqCDnnpP5OUD9/6/RnwOojG+L6ncd7
 UQ1cIJiSNENQ4zZ8MOyDj35BDMC/3xeZ5mDdxYK8g0lgrv+LPxLKmxSBi4451D8+BiiKpsegj
 k/IB3SQ3OZABNeU6zuvemyNGln97e3/YvdQmYOD60mc3m9nj1D2e27UUmTqo0zV51n/hVca31
 U5LZUshj3oqo5Xz/rUtHAw109/Jy6scuHN1WlE5mcy9tm3rdLNZ0SydLiCEDXNHIRiUxaOsEz
 XvqVmCHORNQD0kba2nvgwsyAuaS4shRFsGrqTnxkzOEjgaqnOAHy5I1jAU3X3czbnsBy9T+i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296689>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

unified auto CRLF handling, V2
  1/3 is 7/10 of the old 10/10 series
  2/3 and=20
  3/3 is a replacement for tb/convert-peek-in-index:
      Better commit message, added test case

All in all we are getting closer.
Most of the patches had been send & reviewed earlier,
but a critical review won't hurt.

Torsten B=C3=B6gershausen (3):
  convert: unify the "auto" handling of CRLF
  read-cache: factor out get_sha1_from_index() helper
  Correct ce_compare_data() in a middle of a merge

 Documentation/config.txt        | 12 +++----
 Documentation/gitattributes.txt | 15 +++++----
 builtin/apply.c                 |  3 +-
 builtin/blame.c                 |  2 +-
 cache.h                         |  4 +++
 combine-diff.c                  |  3 +-
 convert.c                       | 65 +++++++++++++++++++++++----------=
---
 convert.h                       | 18 +++++++---
 diff.c                          |  3 +-
 dir.c                           |  2 +-
 read-cache.c                    | 33 +++++++++++-------
 sha1_file.c                     | 12 +++++--
 t/t0025-crlf-auto.sh            |  4 +--
 t/t0027-auto-crlf.sh            | 32 +++++++++---------
 t/t6038-merge-text-auto.sh      | 74 ++++++++++++++++++++++++---------=
--------
 15 files changed, 172 insertions(+), 110 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
