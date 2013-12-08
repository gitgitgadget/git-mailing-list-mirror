From: Rick Burgstaler <rburgstaler@yahoo.com>
Subject: [PATCH v1] Pull, Fetch, and Push hang for 2 minutes over https when connecting to localhost.
Date: Sun, 8 Dec 2013 13:53:04 -0800 (PST)
Message-ID: <1386539584.64970.YahooMailNeo@web141201.mail.bf1.yahoo.com>
Reply-To: Rick Burgstaler <rburgstaler@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "szager@google.com" <szager@google.com>,
	"mika.fischer@zoopnet.de" <mika.fischer@zoopnet.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 08 22:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpmNH-000790-Br
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 22:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759910Ab3LHV6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Dec 2013 16:58:47 -0500
Received: from nm36-vm0.bullet.mail.bf1.yahoo.com ([72.30.238.136]:36565 "HELO
	nm36-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755384Ab3LHV6q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 Dec 2013 16:58:46 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2013 16:58:46 EST
Received: from [98.139.212.151] by nm36.bullet.mail.bf1.yahoo.com with NNFMP; 08 Dec 2013 21:53:05 -0000
Received: from [98.139.212.226] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 08 Dec 2013 21:53:05 -0000
Received: from [127.0.0.1] by omp1035.mail.bf1.yahoo.com with NNFMP; 08 Dec 2013 21:53:05 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 18213.61581.bm@omp1035.mail.bf1.yahoo.com
Received: (qmail 95145 invoked by uid 60001); 8 Dec 2013 21:53:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1386539584; bh=Wezz6MhFSMo3EBssBb6+r0HzqjtXXsddrGNDD/a8m9Q=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=4o8+Wv+4ITnpppEZVJLmRvrKpao6S0jG0NEJXb+rxDjVIv/5rCbuMwTxW8H6nHMLTN7tirt+TYRGM330lcokwlriFm6EQTfdi/nu+43Dml7ISie1ikVkLthrQnt5RD068blFAzgFn+z8RLkM2xEqAYqGkVBuXnU3AS/D6dRjmdY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=U/gTPOzzZrph+8Di6+1LW5ngX16JYcbkOLStUaOKuRKEuKKoPOUrx01DjUGoJhSEYjXc5j4DHcHLvqxRp2MZuIaMvVOFDDvWOKxo90xNsPysRYtXNMhs+QSXdBoecyNFcbHxlHJfLpyJ0ZdG+npcsuMupUiZ9zFm+s3h4PmIhrw=;
X-YMail-OSG: ipYw7C8VM1mOZ1BtYPiGwwKCfUQa9UkCu3Vl4_8xwik6.5_
 hg9qNvktD1IXiVFBRBvRqdpJPQs8.vzOcGSLGTCfjMq1hLF3CYRXrE_ATzMj
 ZS6yxo.XdGBndjvclh3ixk9B7oJVp5Hg5Zh1aCTBKExvUoq0PY88R_8H3g_F
 sPdFwOrVKIoqZrYF_D1RKkrUBxGMAEDojYiJ_S82d6izxFjM0Xxkrpkzy.SX
 6xLwF6mORPCK9BHTCBEyK3Bo.Qk9R.ynyFaWtDhNFp2QYXPbAVipqpO4h.Qe
 I6qRiAGbEJQLLWxiJdQ1ht_iWPXAb0niUm.kCN79LB7v3pu2FxlqmDRCy0gi
 WBxDaLANnoHBwkUJ0QYQ4RrmS89OYR1SAXahy_0_2dZGIMU_VQxGk3Mh5L8g
 6dqpWt8yxysYzwsUKDy1uqGTjDT7ZCejd6weAAG0QP7BspTGguGZVp5v4awM
 3HyuETBXqELCPbNpWg1kjK0aoKd8RA7MpoRA8ipeZ1zHvZj4k7hcvxEr3ysT
 gOoLiUzzNFde3wE7oSu.r6zJ3Wypwl0js5bhn3YVydjmGzGoseO6B7b9N8_E
 nUrtXcJIyduJW5WIgkVCZpLRxfReuiGlKqCSxcmKiA3OYSnAwHBIl13dudc5
 6e6M3nBaXPbfy6f__Bq.wTyUkEE2ArJs-
Received: from [96.42.105.141] by web141201.mail.bf1.yahoo.com via HTTP; Sun, 08 Dec 2013 13:53:04 PST
X-Rocket-MIMEInfo: 002.001,QnVnIGRlc2NyaXB0aW9uOiBPbiBXaW5kb3dzLCB3aGVuIHRoZSBnaXQgY2xpZW50IGlzIGF0dGVtcHRpbmcgdG8gY29tbXVuaWNhdGUgdmlhIGh0dHBzIHRvIGFuIGFwYWNoZSBzZXJ2ZXIgdGhhdCBoYXBwZW5zIHRvIGJlIG9uIHRoZSBzYW1lIG1hY2hpbmUgKGxvY2FsaG9zdCksIHRoZSBjbGllbnQgY29ubmVjdGlvbiB3aWxsIGhhbmcgZm9yIGFib3V0IDIgbWludXRlcyBiZWZvcmUgY29tcGxldGluZy4gwqBDb25uZWN0aW5nIHZpYSBodHRwcyB0byBub24tbG9jYWxob3N0IGdpdCBzZXJ2ZXIgcmV0dXJucyABMAEBAQE-
X-Mailer: YahooMailWebService/0.8.169.609
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239051>

Bug description: On Windows, when the git client is attempting to commu=
nicate via https to an apache server that happens to be on the same mac=
hine (localhost), the client connection will hang for about 2 minutes b=
efore completing. =A0Connecting via https to non-localhost git server r=
eturns immediately and works as desired. =A0It is not known as to wheth=
er this is an issue in other environments than Windows.=A0

This behavior was observed starting with msysgit version 1.8.3 and newe=
r and was a result of msysgit updating the curl library from version 7.=
26 to version 7.28 and the problem still exists in curl version 7.33. =A0=
The problem was occurring because curl_multi_timeout() was returning a =
value of 148797 under this circumstance which posed a greater than 2 mi=
nute wait before timing out in the call to select(). =A0Examples (curl\=
docs\examples\fopen.c & curl\docs\examples\multi-app.c) provided with t=
he curl library for how to use curl_multi_timeout() setup the timeout s=
lightly different than how it is being done here. =A0Curl examples basi=
cally clip all timeouts returned from curl_multi_timeout() at one secon=
d. =A0The changes made with this revision change it to follow the same =
clipping logic as used by the curl examples.

It should be noted that this problem appears to be very similar to a pr=
oblem Stefan Zager was having where a large timeout was returned when a=
n invalid file descriptor was returned.

Another thought on how to resolve this issue would have been to track d=
own why the curl_multi_timeout() method is returning such a large value=
 =A0in the curl library and resolve it there, but being as though examp=
les written for how to use curl_multi_timeout() properly do not exhibit=
 this problem in the first place it most likely makes more sense to mod=
ify the calling logic to fix the problem.=A0

Signed-off-by: Rick Burgstaler <rburgstaler@yahoo.com>

---

diff --git a/http.c b/http.c
index 8284837..314d091 100644
--- a/http.c
+++ b/http.c
@@ -640,15 +640,18 @@ void run_active_slot(struct active_request_slot *=
slot)
=A0
=A0if (slot->in_use) {
=A0#if LIBCURL_VERSION_NUM >=3D 0x070f04
-long curl_timeout;
+long curl_timeout =3D -1;
+
+/* set a suitable timeout */
+select_timeout.tv_sec =3D 1;
+select_timeout.tv_usec =3D 0;
+
=A0curl_multi_timeout(curlm, &curl_timeout);
-if (curl_timeout =3D=3D 0) {
-continue;
-} else if (curl_timeout =3D=3D -1) {
-select_timeout.tv_sec =A0=3D 0;
-select_timeout.tv_usec =3D 50000;
-} else {
-select_timeout.tv_sec =A0=3D =A0curl_timeout / 1000;
+if(curl_timeout >=3D 0) {
+ =A0select_timeout.tv_sec =3D curl_timeout / 1000;
+ =A0if(select_timeout.tv_sec > 1)
+select_timeout.tv_sec =3D 1;
+ =A0else
=A0select_timeout.tv_usec =3D (curl_timeout % 1000) * 1000;
=A0}
=A0#else
