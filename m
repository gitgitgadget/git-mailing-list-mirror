From: Hans Brigman <hbrigman@openspan.com>
Subject: [PATCH] log: make "show --show-signature" use gpg.program setting
Date: Mon, 25 Mar 2013 13:03:52 -0500
Message-ID: <8C726954D36902459248B0627BF2E66F45D7029930@AUSP01VMBX10.collaborationhost.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8C726954D36902459248B0627BF2E66F45D7029930AUSP01VMBX10c_"
Cc: "gitster@pobox.com" <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBs7-0007VI-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab3CYSLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:11:24 -0400
Received: from mail1.bemta7.messagelabs.com ([216.82.254.110]:60786 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932333Ab3CYSLX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 14:11:23 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2013 14:11:23 EDT
Received: from [216.82.255.3:48103] by server-14.bemta-7.messagelabs.com id B5/E5-00330-EA190515; Mon, 25 Mar 2013 18:04:30 +0000
X-Env-Sender: hbrigman@openspan.com
X-Msg-Ref: server-7.tower-209.messagelabs.com!1364234653!6146844!34
X-Originating-IP: [216.166.12.97]
X-StarScan-Received: 
X-StarScan-Version: 6.8.6.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11203 invoked from network); 25 Mar 2013 18:04:29 -0000
Received: from out001.collaborationhost.net (HELO out001.collaborationhost.net) (216.166.12.97)
  by server-7.tower-209.messagelabs.com with RC4-SHA encrypted SMTP; 25 Mar 2013 18:04:29 -0000
Received: from AUSP01VMBX10.collaborationhost.net ([10.2.8.162]) by
 AUSP01MHUB06.collaborationhost.net ([10.2.8.241]) with mapi; Mon, 25 Mar 2013
 13:04:26 -0500
Thread-Topic: [PATCH] log: make "show --show-signature" use gpg.program
 setting
Thread-Index: Ac4nP8jrUBjTr+5aTa2AsL+eoASzqQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219058>

--_002_8C726954D36902459248B0627BF2E66F45D7029930AUSP01VMBX10c_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

"show --show-signature" doesn't currently use the gpg.program setting.  Com=
mit signing, tag signing, and tag verification currently use this setting p=
roperly, so the logic has been added to handle it here as well.

Signed-off-by: Hans Brigman <hbrigman@openspan.com>
---
 builtin/log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..a6c5576 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -23,6 +23,7 @@
 #include "streaming.h"
 #include "version.h"
 #include "mailmap.h"
+#include "gpg-interface.h"
=20
 /* Set a default date-time format for git log ("log.date" config variable)=
 */
 static const char *default_date_mode =3D NULL;
@@ -364,7 +365,8 @@ static int git_log_config(const char *var, const char *=
value, void *cb)
 		use_mailmap_config =3D git_config_bool(var, value);
 		return 0;
 	}
-
+	if (!prefixcmp(var, "gpg."))
+		return git_gpg_config(var, value, NULL);=20
 	if (grep_config(var, value, cb) < 0)
 		return -1;
 	return git_diff_ui_config(var, value, cb);
--=20
1.7.11.msysgit.0


--_002_8C726954D36902459248B0627BF2E66F45D7029930AUSP01VMBX10c_
Content-Type: application/octet-stream;
	name="0001-log-make-show-show-signature-use-gpg.program-setting.patch"
Content-Description: 0001-log-make-show-show-signature-use-gpg.program-setting.patch
Content-Disposition: attachment;
	filename="0001-log-make-show-show-signature-use-gpg.program-setting.patch";
	size=1286; creation-date="Fri, 22 Mar 2013 20:48:46 GMT";
	modification-date="Fri, 22 Mar 2013 20:48:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZTBiM2RlOTNlOTA3NTBlYThkM2Y1Yzg5Nzg2MTg4NjY0NzY3MmI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIEJyaWdtYW4gPGRhdHllZHllZ3V5QGdtYWlsLmNvbT4K
RGF0ZTogRnJpLCAyMiBNYXIgMjAxMyAxNjo0MTowNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGxv
ZzogbWFrZSAic2hvdyAtLXNob3ctc2lnbmF0dXJlIiB1c2UgZ3BnLnByb2dyYW0gc2V0dGluZwoK
InNob3cgLS1zaG93LXNpZ25hdHVyZSIgZG9lc24ndCBjdXJyZW50bHkgdXNlIHRoZSBncGcucHJv
Z3JhbSBzZXR0aW5nLiAgQ29tbWl0IHNpZ25pbmcsIHRhZyBzaWduaW5nLCBhbmQgdGFnIHZlcmlm
aWNhdGlvbiBjdXJyZW50bHkgdXNlIHRoaXMgc2V0dGluZyBwcm9wZXJseSwgc28gdGhlIGxvZ2lj
IGhhcyBiZWVuIGFkZGVkIHRvIGhhbmRsZSBpdCBoZXJlIGFzIHdlbGwuCgpTaWduZWQtb2ZmLWJ5
OiBIYW5zIEJyaWdtYW4gPGRhdHllZHllZ3V5QGdtYWlsLmNvbT4KLS0tCiBidWlsdGluL2xvZy5j
IHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9sb2cuYyBiL2J1aWx0aW4vbG9nLmMKaW5kZXggOGYwYjJl
OC4uYTZjNTU3NiAxMDA2NDQKLS0tIGEvYnVpbHRpbi9sb2cuYworKysgYi9idWlsdGluL2xvZy5j
CkBAIC0yMyw2ICsyMyw3IEBACiAjaW5jbHVkZSAic3RyZWFtaW5nLmgiCiAjaW5jbHVkZSAidmVy
c2lvbi5oIgogI2luY2x1ZGUgIm1haWxtYXAuaCIKKyNpbmNsdWRlICJncGctaW50ZXJmYWNlLmgi
CiAKIC8qIFNldCBhIGRlZmF1bHQgZGF0ZS10aW1lIGZvcm1hdCBmb3IgZ2l0IGxvZyAoImxvZy5k
YXRlIiBjb25maWcgdmFyaWFibGUpICovCiBzdGF0aWMgY29uc3QgY2hhciAqZGVmYXVsdF9kYXRl
X21vZGUgPSBOVUxMOwpAQCAtMzY0LDcgKzM2NSw4IEBAIHN0YXRpYyBpbnQgZ2l0X2xvZ19jb25m
aWcoY29uc3QgY2hhciAqdmFyLCBjb25zdCBjaGFyICp2YWx1ZSwgdm9pZCAqY2IpCiAJCXVzZV9t
YWlsbWFwX2NvbmZpZyA9IGdpdF9jb25maWdfYm9vbCh2YXIsIHZhbHVlKTsKIAkJcmV0dXJuIDA7
CiAJfQotCisJaWYgKCFwcmVmaXhjbXAodmFyLCAiZ3BnLiIpKQorCQlyZXR1cm4gZ2l0X2dwZ19j
b25maWcodmFyLCB2YWx1ZSwgTlVMTCk7IAogCWlmIChncmVwX2NvbmZpZyh2YXIsIHZhbHVlLCBj
YikgPCAwKQogCQlyZXR1cm4gLTE7CiAJcmV0dXJuIGdpdF9kaWZmX3VpX2NvbmZpZyh2YXIsIHZh
bHVlLCBjYik7Ci0tIAoxLjcuMTEubXN5c2dpdC4wCgo=

--_002_8C726954D36902459248B0627BF2E66F45D7029930AUSP01VMBX10c_--
