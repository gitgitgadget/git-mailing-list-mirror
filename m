From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: AW: Problem with git-http-backend.exe as iis cgi
Date: Tue, 29 Mar 2016 06:01:38 +0000
Message-ID: <F0F5A56A22F20D4CB4A03BB8D6658797E261A10C@SERVER2011.CS-SOFTWARE.local>
References: <F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local>
 <20160310155522.1dee53cf95fead8cfd4e178a@domain007.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F0F5A56A22F20D4CB4A03BB8D6658797E261A10CSERVER2011CSSOF_"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:01:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akmir-0002bI-D6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 08:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbcC2GBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 02:01:45 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:35326 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbcC2GBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 02:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1459231299; l=5634;
	s=domk; d=cs-software-gmbh.de;
	h=MIME-Version:Content-Type:Content-Language:In-Reply-To:References:
	Date:Subject:CC:To:From;
	bh=4oCRL4lWCDrZiwL7SAK95WHVeLc9MrXoIPLliOiQcRo=;
	b=LAFUulGLDJqLNcfAPeYmHrspwmSB/NDsn9uyKZ46iha/9DBHR9V+ffS7NeTT1lxy882
	52AGBpUDbkYuVIo20PFDZVET/dqFgIhtWwy127l1TVD7AGpnutM21bz42qkgyPxkbwGqT
	W6s0ZqTm4epkSy5zw81QqtgMZryrPDOa6Mg=
X-RZG-AUTH: :LWABbUmIevNaG8tCOliF7QMkyOk5UulSewxf/wy7hQxPYOHO9hm9iyo=
X-RZG-CLASS-ID: mo00
Received: from remote.CS-SOFTWARE.local (business-213-023-161-242.static.arcor-ip.net [213.23.161.242])
	by post.strato.de (RZmta 37.22 AUTH)
	with ESMTPA id z03bb4s2T61Zt8Y;
	Tue, 29 Mar 2016 08:01:35 +0200 (CEST)
Received: from SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565]) by
 SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565%11]) with mapi id
 14.01.0438.000; Tue, 29 Mar 2016 08:01:39 +0200
Thread-Topic: Problem with git-http-backend.exe as iis cgi
Thread-Index: AdF6EInS/Y9CWnY1SWul92/hV1n+2QAsy+wAA68bAOA=
In-Reply-To: <20160310155522.1dee53cf95fead8cfd4e178a@domain007.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.1.154]
x-pmwin-version: 3.1.2.0, Antivirus-Engine: 3.63.0, Antivirus-Data: 5.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290104>

--_002_F0F5A56A22F20D4CB4A03BB8D6658797E261A10CSERVER2011CSSOF_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I put together a first patch for the issue.

Mit freundlichen Gr=FC=DFen / With kind regards
Florian Manschwetus

E-Mail: manschwetus@cs-software-gmbh.de
Tel.: +49-(0)611-8908534
=A0
CS Software Concepts and Solutions GmbH
Gesch=E4ftsf=FChrer / Managing director: Dr. Werner Alexi=20
Amtsgericht Wiesbaden HRB 10004 (Commercial registry)
Schiersteiner Stra=DFe 31
D-65187 Wiesbaden
Germany
Tel.: 0611/8908555


-----Urspr=FCngliche Nachricht-----
Von: Konstantin Khomoutov [mailto:kostix+git@007spb.ru]=20
Gesendet: Donnerstag, 10. M=E4rz 2016 13:55
An: Florian Manschwetus
Cc: git@vger.kernel.org
Betreff: Re: Problem with git-http-backend.exe as iis cgi

On Thu, 10 Mar 2016 07:28:50 +0000
Florian Manschwetus <manschwetus@cs-software-gmbh.de> wrote:

> I tried to setup git-http-backend with iis, as iis provides proper=20
> impersonation for cgi under windows, which leads to have the=20
> filesystem access performed with the logon user, therefore the=20
> webserver doesn't need generic access to the files. I stumbled across=20
> a problem, ending up with post requests hanging forever. After some=20
> investigation I managed to get it work by wrapping the http-backend=20
> into a bash script, giving a lot of control about the environmental=20
> things, I was unable to solve within IIS configuration. The=20
> workaround, I use currently, is to use "/bin/head -c ${CONTENT_LENGTH}=20
> | ./git-http-backend.exe", which directly shows the issue. Git=20
> http-backend should check if CONTENT_LENGTH is set to something=20
> reasonable (e.g. >0) and should in this case read only CONTENT_LENGTH=20
> bytes from stdin, instead of reading till EOF what I suspect it is=20
> doing currently.

The rfc [1] states in its section 4.2:

| A request-body is supplied with the request if the CONTENT_LENGTH is=20
| not NULL.  The server MUST make at least that many bytes available for=20
| the script to read.  The server MAY signal an end-of-file condition=20
| after CONTENT_LENGTH bytes have been read or it MAY supply extension=20
| data.  Therefore, the script MUST NOT attempt to read more than=20
| CONTENT_LENGTH bytes, even if more data is available.  However, it is=20
| not obliged to read any of the data.

So yes, if Git currently reads until EOF, it's an error.
The correct way would be:

1) Check to see if the CONTENT_LENGTH variable is available in the
   environment.  If no, read nothing.

2) Otherwise read as many bytes it specifies, and no more.

1. https://www.ietf.org/rfc/rfc3875

--_002_F0F5A56A22F20D4CB4A03BB8D6658797E261A10CSERVER2011CSSOF_
Content-Type: application/octet-stream;
	name="http-backend-content-length.patch"
Content-Description: http-backend-content-length.patch
Content-Disposition: attachment;
	filename="http-backend-content-length.patch"; size=1755;
	creation-date="Tue, 29 Mar 2016 06:01:27 GMT";
	modification-date="Tue, 29 Mar 2016 05:58:56 GMT"
Content-Transfer-Encoding: base64

LS0tIGh0dHAtYmFja2VuZC5jLm9yaWcJMjAxNi0wMy0yOSAwNzoyOTozMi42OTQ3MjI1MDAgKzAy
MDAKKysrIGh0dHAtYmFja2VuZC5jCTIwMTYtMDMtMjkgMDc6NTg6NTAuODAxNDgyNzAwICswMjAw
CkBAIC0yNzcsMTYgKzI3NywzMiBAQAogICovCiBzdGF0aWMgc3NpemVfdCByZWFkX3JlcXVlc3Qo
aW50IGZkLCB1bnNpZ25lZCBjaGFyICoqb3V0KQogewotCXNpemVfdCBsZW4gPSAwLCBhbGxvYyA9
IDgxOTI7Ci0JdW5zaWduZWQgY2hhciAqYnVmID0geG1hbGxvYyhhbGxvYyk7CisJdW5zaWduZWQg
Y2hhciAqYnVmID0gbnVsbDsKKwlzaXplX3QgbGVuID0gMDsKKwkvKiBnZXQgcmVxdWVzdCBzaXpl
ICovCisJc2l6ZV90IHJlcV9sZW4gPSBnaXRfZW52X3Vsb25nKCJDT05URU5UX0xFTkdUSCIsCisJ
CQkJCSAgIDApOworCisJLyogY2hlY2sgcmVxdWVzdCBzaXplICovCisJaWYgKG1heF9yZXF1ZXN0
X2J1ZmZlciA8IHJlcV9sZW4pIHsKKwkJZGllKCJyZXF1ZXN0IHdhcyBsYXJnZXIgdGhhbiBvdXIg
bWF4aW11bSBzaXplICglbHUpOyIKKwkJCSAgICAiIHRyeSBzZXR0aW5nIEdJVF9IVFRQX01BWF9S
RVFVRVNUX0JVRkZFUiIsCisJCQkgICAgbWF4X3JlcXVlc3RfYnVmZmVyKTsKKwl9CisKKwlpZiAo
cmVxX2xlbiA8PSAwKSB7CisJCSpvdXQgPSBudWxsOworCQlyZXR1cm4gMDsKKwl9CisKKwkvKiBh
bGxvY2F0ZSBidWZmZXIgKi8KKwlidWYgPSB4bWFsbG9jKHJlcV9sZW4pCiAKLQlpZiAobWF4X3Jl
cXVlc3RfYnVmZmVyIDwgYWxsb2MpCi0JCW1heF9yZXF1ZXN0X2J1ZmZlciA9IGFsbG9jOwogCiAJ
d2hpbGUgKDEpIHsKIAkJc3NpemVfdCBjbnQ7CiAKLQkJY250ID0gcmVhZF9pbl9mdWxsKGZkLCBi
dWYgKyBsZW4sIGFsbG9jIC0gbGVuKTsKKwkJY250ID0gcmVhZF9pbl9mdWxsKGZkLCBidWYgKyBs
ZW4sIHJlcV9sZW4gLSBsZW4pOwogCQlpZiAoY250IDwgMCkgewogCQkJZnJlZShidWYpOwogCQkJ
cmV0dXJuIC0xOwpAQCAtMjk0LDIxICszMTAsMTggQEAKIAogCQkvKiBwYXJ0aWFsIHJlYWQgZnJv
bSByZWFkX2luX2Z1bGwgbWVhbnMgd2UgaGl0IEVPRiAqLwogCQlsZW4gKz0gY250OwotCQlpZiAo
bGVuIDwgYWxsb2MpIHsKKwkJaWYgKGxlbiA8IHJlcV9sZW4pIHsKKwkJCS8qIFRPRE8gcmVxdWVz
dCBpbmNvbXBsZXRlPz8gKi8KKwkJCS8qIG1heWJlIGp1c3QgcmVtb3ZlIHRoaXMgYmxvY2sgYW5k
IGNvbmRpdGlvbiBhbG9uZyB3aXRoIHRoZSBsb29wLCAqLworCQkJLyogaWYgcmVhZF9pbl9mdWxs
IGlzIHByb292ZW4gcmVsaWFibGUgKi8KIAkJCSpvdXQgPSBidWY7CiAJCQlyZXR1cm4gbGVuOwor
CQl9IGVsc2UgeworCQkJLyogcmVxdWVzdCBjb21wbGV0ZSAqLworCQkJKm91dCA9IGJ1ZjsKKwkJ
CXJldHVybiBsZW47CisJCQkKIAkJfQotCi0JCS8qIG90aGVyd2lzZSwgZ3JvdyBhbmQgdHJ5IGFn
YWluIChpZiB3ZSBjYW4pICovCi0JCWlmIChhbGxvYyA9PSBtYXhfcmVxdWVzdF9idWZmZXIpCi0J
CQlkaWUoInJlcXVlc3Qgd2FzIGxhcmdlciB0aGFuIG91ciBtYXhpbXVtIHNpemUgKCVsdSk7Igot
CQkJICAgICIgdHJ5IHNldHRpbmcgR0lUX0hUVFBfTUFYX1JFUVVFU1RfQlVGRkVSIiwKLQkJCSAg
ICBtYXhfcmVxdWVzdF9idWZmZXIpOwotCi0JCWFsbG9jID0gYWxsb2NfbnIoYWxsb2MpOwotCQlp
ZiAoYWxsb2MgPiBtYXhfcmVxdWVzdF9idWZmZXIpCi0JCQlhbGxvYyA9IG1heF9yZXF1ZXN0X2J1
ZmZlcjsKLQkJUkVBTExPQ19BUlJBWShidWYsIGFsbG9jKTsKIAl9CiB9CiAK

--_002_F0F5A56A22F20D4CB4A03BB8D6658797E261A10CSERVER2011CSSOF_--
