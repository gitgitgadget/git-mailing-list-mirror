From: "Springer, Stephan" <springer@sloman-neptun.com>
Subject: BUG in http-backend.c  > http.receivepack
Date: Mon, 24 Nov 2014 09:18:52 +0100
Message-ID: <F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8@Hermes.sns.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8Hermessnsloca_"
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 09:22:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsov3-0000ze-RV
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 09:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbaKXIWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 03:22:46 -0500
Received: from hermes.sloman-neptun.com ([82.198.223.162]:54925 "EHLO
	hermes.sloman-neptun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbaKXIWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 03:22:45 -0500
X-AuditID: 0a650303-f79536d000004db5-85-5472ead4a90c
Received: from hermes.sloman-neptun.com (hermes.sns.local [10.101.1.30])
	by hermes.sloman-neptun.com (hermes mail gateway) with SMTP id 2D.DD.19893.4DAE2745; Mon, 24 Nov 2014 09:22:44 +0100 (CET)
Thread-Topic: BUG in http-backend.c  > http.receivepack
Thread-Index: AdAHuHeTB4gHhSbMQSCZfdcs/QTeWQ==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE, en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LhSmWU073yqijE4NUHQYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGVMWHiTqaBJoeLqrI+sDYzbZbsYOTkkBEwkpk67zQxhi0lcuLee
	DcQWEjjKKLFiKiuIzSZgJrFz1xwmEFtEwFBi98N/YHEWAVWJd9d3g9ULCxhJ/D32AKrGXOLl
	xGWsELaeRG/rAbA4r4CnRMO/xYwgNqOArMSGDefB9jILiEtsevadFeIGEYmHF0+zQdiiEi8f
	Q+xiFJCRWLOpEcjmAKrPlFi5QwRipKDEyZlPWCYwCs5CMmkWQtUsJFUQJXoSN6ZOYYOwtSWW
	LXzNDGFrSEya0AxVIyOx49NvIJsLyF7CKLGy7TI7REJRYkr3Q/YFjJyrGCUyUotyU4v1inPy
	cxPzdPNSC0pK8/SS83M3MYJjhZl5B+O1nfaHGAU4GJV4eH/sKAoRYk0sK67MPcSoAjTq0YbV
	FxilWPLy81KVRHjP/isMEeJNSaysSi3Kjy8qzUktPsQozcGiJM771Kk7SEggPbEkNTs1tSC1
	CCbLxMEp1cDIGyPYpsATYXNdavWTDo+3vAyJdT3tT68cY718kqN248pHka48Fue/7su5+PqC
	9c4I/nWMiiXXmp0CP+0SbBZmfH55kvTXBJY5u2UNkmu7ZwjOEesv2L0x9LRsprJpULnXotS5
	c4Ok5yyeq5z/JfC4/rO1xQvuvdgo+t1ejCWIgS9ctP1SkocSS3FGoqEWc1FxIgAQdptenQIA
	AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260118>

--_002_F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8Hermessnsloca_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,

I found bug in http-backend.c with config-flag "http.receivepack" =A0You de=
scribe in our documentation: "This serves git send-pack clients, allowing p=
ush. It is disabled by default for anonymous users, and enabled by default =
for users authenticated by the web server. It can be disabled by setting th=
is item to false, or enabled for all users, including anonymous users, by s=
etting it to true."
That cannot work, while svc-enable less than 0. See attachment=20

I tested with Centos 6.x, =A0Nginx 1.0.15 and Git 2.2.0-rc3 and Git 2.1.3

I hope you understand me and I don=B4t talk nonsense. My English a little r=
usty and this is my first bug report for open source project :-) =A0

Best regards
Stephan Springer
__________________________________________

SLOMAN NEPTUN Schiffahrts-Aktiengesellschaft
Langenstr. 44, 28195 Bremen / Germany
Telephone: ++49 (0) 421 1763 - 291
Telefax:=A0=A0 ++49 (0) 421 1763 - 400
E-Mail: springer@sloman-neptun.com
Page: www.sloman-neptun.com

Registergericht/Registered office: Amtsgericht Bremen (HRB 4046)
Vorsitzender des Aufsichtsrats/Chairman of the Supervisory Board: Fritz L=
=FCtke-Uhlenbrock
Vorstand / Board of Managing Directors: Sven-Michael Edye, Dirk Lohmann=A0=
=20
__________________________________________


--_002_F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8Hermessnsloca_
Content-Type: text/plain; name="bug.txt"
Content-Description: bug.txt
Content-Disposition: attachment; filename="bug.txt"; size=1613;
	creation-date="Mon, 24 Nov 2014 07:52:36 GMT";
	modification-date="Mon, 24 Nov 2014 08:04:49 GMT"
Content-Transfer-Encoding: base64

aHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQvYmxvYi9tYXN0ZXIvaHR0cC1iYWNrZW5kLmMNCg0K
c3RhdGljIHZvaWQgaHR0cF9jb25maWcodm9pZCkNCnsNCiAgICAgICAgaW50IGksIHZhbHVlID0g
MDsNCiAgICAgICAgc3RydWN0IHN0cmJ1ZiB2YXIgPSBTVFJCVUZfSU5JVDsNCg0KICAgICAgICBn
aXRfY29uZmlnX2dldF9ib29sKCJodHRwLmdldGFueWZpbGUiLCAmZ2V0YW55ZmlsZSk7DQoNCiAg
ICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocnBjX3NlcnZpY2UpOyBpKyspIHsNCiAg
ICAgICAgICAgICAgIHN0cnVjdCBycGNfc2VydmljZSAqc3ZjID0gJnJwY19zZXJ2aWNlW2ldOw0K
ICAgICAgICAgICAgICAgc3RyYnVmX2FkZGYoJnZhciwgImh0dHAuJXMiLCBzdmMtPmNvbmZpZ19u
YW1lKTsNCiAgICAgICAgICAgICAgIGlmICghZ2l0X2NvbmZpZ19nZXRfYm9vbCh2YXIuYnVmLCAm
dmFsdWUpKQ0KICAgICAgICAgICAgICAgICAgICAgICBzdmMtPmVuYWJsZWQgPSB2YWx1ZTsgIDwj
IyMjIDEgb3IgMCANCiAgICAgICAgICAgICAgIHN0cmJ1Zl9yZXNldCgmdmFyKTsNCiAgICAgICAg
fQ0KDQogICAgICAgIHN0cmJ1Zl9yZWxlYXNlKCZ2YXIpOw0KfQ0KDQpzdGF0aWMgc3RydWN0IHJw
Y19zZXJ2aWNlICpzZWxlY3Rfc2VydmljZShjb25zdCBjaGFyICpuYW1lKQ0Kew0KICAgICAgICBj
b25zdCBjaGFyICpzdmNfbmFtZTsNCiAgICAgICAgc3RydWN0IHJwY19zZXJ2aWNlICpzdmMgPSBO
VUxMOw0KICAgICAgICBpbnQgaTsNCg0KICAgICAgICBpZiAoIXNraXBfcHJlZml4KG5hbWUsICJn
aXQtIiwgJnN2Y19uYW1lKSkNCiAgICAgICAgICAgICAgIGZvcmJpZGRlbigiVW5zdXBwb3J0ZWQg
c2VydmljZTogJyVzJyIsIG5hbWUpOw0KDQogICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKHJwY19zZXJ2aWNlKTsgaSsrKSB7DQogICAgICAgICAgICAgICBzdHJ1Y3QgcnBjX3NlcnZp
Y2UgKnMgPSAmcnBjX3NlcnZpY2VbaV07DQogICAgICAgICAgICAgICBpZiAoIXN0cmNtcChzLT5u
YW1lLCBzdmNfbmFtZSkpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgc3ZjID0gczsNCiAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICB9DQogICAgICAgIH0NCg0K
ICAgICAgICBpZiAoIXN2YykNCiAgICAgICAgICAgICAgIGZvcmJpZGRlbigiVW5zdXBwb3J0ZWQg
c2VydmljZTogJyVzJyIsIG5hbWUpOw0KDQogICAgICAgICMNCiAgICAgICAgIyBiZXR0ZXIgKHN2
Yy0+ZW5hYmxlZCA8PSAwKSB0aGFuIGNhbiCTUkVNT1RFX1VTRVKUIGVuYWJsZSBwdXNoIGZ1bmN0
aW9uIA0KICAgICAgICAjDQogICAgICAgIGlmIChzdmMtPmVuYWJsZWQgPCAwKSB7ICAgICAgICAN
CiAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnVzZXIgPSBnZXRlbnYoIlJFTU9URV9VU0VSIik7
DQogICAgICAgICAgICAgICBzdmMtPmVuYWJsZWQgPSAodXNlciAmJiAqdXNlcikgPyAxIDogMDsN
CiAgICAgICAgfQ0KICAgICAgICBpZiAoIXN2Yy0+ZW5hYmxlZCkNCiAgICAgICAgICAgICAgIGZv
cmJpZGRlbigiU2VydmljZSBub3QgZW5hYmxlZDogJyVzJyIsIHN2Yy0+bmFtZSk7DQogICAgICAg
IHJldHVybiBzdmM7DQp9DQo=

--_002_F9AF62ADACFFBA47BEEADC5C12509F3401226EE8F8Hermessnsloca_--
