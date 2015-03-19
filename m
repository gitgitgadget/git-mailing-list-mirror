From: Sam Bishop <Sam.Bishop@blackboard.com>
Subject: [PATCH] git=p4.py rebase now honor's client spec
Date: Thu, 19 Mar 2015 12:28:09 +0000
Message-ID: <D1303946.5CED%Sam.Bishop@blackboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_D13039465CEDSamBishopblackboardcom_"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 13:28:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYZYf-0000wN-Si
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 13:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbbCSM2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 08:28:13 -0400
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:22452
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754946AbbCSM2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 08:28:11 -0400
X-Greylist: delayed 59913 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2015 08:28:11 EDT
Received: from DM2PR03MB366.namprd03.prod.outlook.com (10.141.55.18) by
 DM2PR03MB367.namprd03.prod.outlook.com (10.141.55.21) with Microsoft SMTP
 Server (TLS) id 15.1.118.15; Thu, 19 Mar 2015 12:28:09 +0000
Received: from DM2PR03MB366.namprd03.prod.outlook.com ([10.141.55.18]) by
 DM2PR03MB366.namprd03.prod.outlook.com ([10.141.55.18]) with mapi id
 15.01.0118.009; Thu, 19 Mar 2015 12:28:09 +0000
Thread-Topic: [PATCH] git=p4.py rebase now honor's client spec
Thread-Index: AQHQYkAo7S08JjZ/nkCSsL7TNUiR5w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.4.8.150116
x-originating-ip: [69.196.244.10]
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB367;
x-microsoft-antispam-prvs: <DM2PR03MB367EC79E8782A15146BE79AF6010@DM2PR03MB367.namprd03.prod.outlook.com>
x-forefront-antispam-report: BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(36304003)(36756003)(77096005)(77156002)(62966003)(122556002)(110136001)(99286002)(40100003)(92566002)(102836002)(19580395003)(450100001)(5890100001)(106116001)(86362001)(87936001)(83506001)(2656002)(50986999)(107886001)(99936001)(2351001)(46102003)(2501003)(2900100001)(229853001)(54356999)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB367;H:DM2PR03MB366.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(5002010);SRVR:DM2PR03MB367;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB367;
x-forefront-prvs: 052017CAF1
X-OriginatorOrg: blackboard.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2015 12:28:09.4400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf0b29a2-5e5c-4aaa-ba4d-ac988df15ea6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB367
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265799>

--_002_D13039465CEDSamBishopblackboardcom_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A09C36577A6C954AAFFE09FA1EC4C6FC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

When using the git-p4.py script, I found that if I used a client spec when
cloning out a perforce repository, and then using a git-p4.py rebase, that
the rebase command would be using the current perforce client spec,
instead of the one used when doing the initial clone. My proposed patch
causes the rebase command to switch to the perforce client spec used when
doing the initial git-p4.py clone.

This email and any attachments may contain confidential and proprietary inf=
ormation of Blackboard that is for the sole use of the intended recipient. =
If you are not the intended recipient, disclosure, copying, re-distribution=
 or other use of any of this information is strictly prohibited. Please imm=
ediately notify the sender and delete this transmission if you received thi=
s email in error.

--_002_D13039465CEDSamBishopblackboardcom_
Content-Type: application/octet-stream; name="fix_git_p4_rebase.patch"
Content-Description: fix_git_p4_rebase.patch
Content-Disposition: attachment; filename="fix_git_p4_rebase.patch";
	size=1642; creation-date="Thu, 19 Mar 2015 12:28:09 GMT";
	modification-date="Thu, 19 Mar 2015 12:28:09 GMT"
Content-ID: <316F52AE4E085F498CE6FD79DAB19C20@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjNjZmYmQ1MDE5YTJiOGI2NDUyMTY2ODY4YjMzY2U0MjZmOTNkOTZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW0gQmlzaG9wIDxTYW0uQmlzaG9wQGJsYWNrYm9hcmQuY29t
PgpEYXRlOiBXZWQsIDE4IE1hciAyMDE1IDE1OjI2OjQ4IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0g
R2l0LXA0IHJlYmFzZSBjb21tYW5kIHdpbGwgbm93IGhvbm9yIHBlcmZvcmNlIGNsaWVudCBzcGVj
LgoKV2hlbiBzcGVjaWZpeWluZyBhIGNsaWVudCBzcGVjIHdoaWxlIGNsb25pbmcgYSBwZXJmb3Jj
ZSByZXBvCnRoZSBuYW1lIG9mIHRoZSBjbGllbnQgc3BlYyB3aWxsIG5vdyBiZSBzYXZlZCBpbiB0
aGUgLmdpdC9jb25maWcKZmlsZSwgc28gdGhhdCBpdCBtYXkgYmUgcmVmZXJlbmNlZCBsYXRlciB3
aGVuIGRvaW5nIGEgZ2l0IHA0IHJlYmFzZS4KLS0tCiBnaXQtcDQucHkgfCAzICsrKwogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2dpdC1wNC5weSBiL2dpdC1w
NC5weQppbmRleCBmZjEzMmIyLi5mNGYyNDJhIDEwMDc1NQotLS0gYS9naXQtcDQucHkKKysrIGIv
Z2l0LXA0LnB5CkBAIC0xODA3LDYgKzE4MDcsNyBAQCBjbGFzcyBWaWV3KG9iamVjdCk6CiAgICAg
ICAgIHNlbGYuY2xpZW50X3ByZWZpeCA9ICIvLyVzLyIgJSBjbGllbnRfbmFtZQogICAgICAgICAj
IGNhY2hlIHJlc3VsdHMgb2YgInA0IHdoZXJlIiB0byBsb29rdXAgY2xpZW50IGZpbGUgbG9jYXRp
b25zCiAgICAgICAgIHNlbGYuY2xpZW50X3NwZWNfcGF0aF9jYWNoZSA9IHt9CisgICAgICAgIHNl
bGYuY2xpZW50X25hbWUgPSBjbGllbnRfbmFtZQogCiAgICAgZGVmIGFwcGVuZChzZWxmLCB2aWV3
X2xpbmUpOgogICAgICAgICAiIiJQYXJzZSBhIHZpZXcgbGluZSwgc3BsaXR0aW5nIGl0IGludG8g
ZGVwb3QgYW5kIGNsaWVudApAQCAtMjc4Nyw2ICsyNzg4LDcgQEAgY2xhc3MgUDRTeW5jKENvbW1h
bmQsIFA0VXNlck1hcCk6CiAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICBpZiBnaXRDb25maWdC
b29sKCJnaXQtcDQudXNlY2xpZW50c3BlYyIpOgogICAgICAgICAgICAgICAgIHNlbGYudXNlQ2xp
ZW50U3BlYyA9IFRydWUKKyAgICAgICAgICAgICAgICBvcy5lbnZpcm9uWydQNENMSUVOVCddID0g
Z2l0Q29uZmlnKCJnaXQtcDQuY2xpZW50U3BlY05hbWUiKQogICAgICAgICBpZiBzZWxmLnVzZUNs
aWVudFNwZWM6CiAgICAgICAgICAgICBzZWxmLmNsaWVudFNwZWNEaXJzID0gZ2V0Q2xpZW50U3Bl
YygpCiAKQEAgLTMxNzcsNiArMzE3OSw3IEBAIGNsYXNzIFA0Q2xvbmUoUDRTeW5jKToKICAgICAg
ICAgIyBhdXRvLXNldCB0aGlzIHZhcmlhYmxlIGlmIGludm9rZWQgd2l0aCAtLXVzZS1jbGllbnQt
c3BlYwogICAgICAgICBpZiBzZWxmLnVzZUNsaWVudFNwZWNfZnJvbV9vcHRpb25zOgogICAgICAg
ICAgICAgc3lzdGVtKCJnaXQgY29uZmlnIC0tYm9vbCBnaXQtcDQudXNlY2xpZW50c3BlYyB0cnVl
IikKKyAgICAgICAgICAgIHN5c3RlbShbImdpdCIsICJjb25maWciLCAiLS1hZGQiLCAiZ2l0LXA0
LmNsaWVudFNwZWNOYW1lIiwgc2VsZi5jbGllbnRTcGVjRGlycy5jbGllbnRfbmFtZV0pCiAKICAg
ICAgICAgcmV0dXJuIFRydWUKIAotLSAKMS45LjMgKEFwcGxlIEdpdC01MCkKCg==

--_002_D13039465CEDSamBishopblackboardcom_--
