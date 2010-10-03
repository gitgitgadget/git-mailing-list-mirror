From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Sun, 3 Oct 2010 22:59:10 +0100
Message-ID: <AANLkTimRa09+nBFTV9OtzKngAb=QrAP550a22S73cW_y@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com>
 <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com> <201010032019.09244.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Waj-0000pC-E2
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0JCV72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:59:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53421 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0JCV71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:59:27 -0400
Received: by qwh6 with SMTP id 6so2686327qwh.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=oiGzsm6iR495uTSVWYI82vEOSGVhx8R3xWGGNKi6OjY=;
        b=XdQccwbXlzTJYpPH/ANjSvfBjveJIYiVdmXt80y3D89VvLDfpy3c/q5eUoyPWQgTL/
         n2k4Xid7NxiHp5LgUmsGU7QNrvmBLYbAkDD8JX+eDxW2Cr7j49eG5+yf+V8UNHQl3+Pr
         22QsF8/9XFN7s9w5Iiul1Wkcbxj13m0f8erdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=AMLX1pqeggBrXnEnK4A+8Ko5ymM+eWwLLZIjqIhpYuMYwLsPU+9pu3Cus6VWYNlAi1
         +GjhEDDfNV7GWyucxPQo3VMNjch1EXnbCewMIz/Y9crdwuRRaKLBMX5XcDE/RtY2ReHi
         ZgbNUOJTyrf/eYebwKeCTG5inUZfg+c5U4RrI=
Received: by 10.229.73.142 with SMTP id q14mr6333053qcj.26.1286143166375; Sun,
 03 Oct 2010 14:59:26 -0700 (PDT)
Received: by 10.229.23.13 with HTTP; Sun, 3 Oct 2010 14:59:10 -0700 (PDT)
In-Reply-To: <201010032019.09244.j6t@kdbg.org>
X-Google-Sender-Auth: fCl1eHtg_1roZYepMq-dhkvmmRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157936>

SGkgLS0KCk9uIDMgT2N0b2JlciAyMDEwIDE5OjE5LCBKb2hhbm5lcyBTaXh0IDxqNnRAa2RiZy5v
cmc+IHdyb3RlOgo+IE9uIFNvbm50YWcsIDMuIE9rdG9iZXIgMjAxMCwgVGhvbWFzIEFkYW0gd3Jv
dGU6Cj4+IEhpIC0tCj4+Cj4+IE9uIDMgT2N0b2JlciAyMDEwIDEwOjU2LCDDhnZhciBBcm5masO2
csOwIEJqYXJtYXNvbiA8YXZhcmFiQGdtYWlsLmNvbT4gd3JvdGU6Cj4+ID4gKyDCoCDCoCDCoCBp
ZiAoaWdub3JlX2Nhc2UpIHsKPj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoOzspIHsK
Pj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVuc2lnbmVkIGNoYXIgYzEg
PSB0b2xvd2VyKCptYXRjaCk7Cj4+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB1bnNpZ25lZCBjaGFyIGMyID0gdG9sb3dlcigqbmFtZSk7Cj4+ID4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoYzEgPT0gJ1wwJyB8fCBpc19nbG9iX3NwZWNpYWwoYzEp
KQo+PiA+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJl
YWs7Cj4+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoYzEgIT0gYzIp
Cj4+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gMDsKPj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1hdGNoKys7Cj4+
ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuYW1lKys7Cj4+ID4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuYW1lbGVuLS07Cj4+ID4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB9Cj4+ID4gKyDCoCDCoCDCoCB9IGVsc2Ugewo+PiA+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZm9yICg7Oykgewo+PiA+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgdW5zaWduZWQgY2hhciBjMSA9ICptYXRjaDsKPj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHVuc2lnbmVkIGNoYXIgYzIgPSAqbmFtZTsKPj4gPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjMSA9PSAnXDAnIHx8IGlzX2dsb2Jfc3BlY2lhbChj
MSkpCj4+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBi
cmVhazsKPj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjMSAhPSBj
MikKPj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJl
dHVybiAwOwo+PiA+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWF0Y2grKzsK
Pj4gPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5hbWUrKzsKPj4gPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5hbWVsZW4tLTsKPj4gPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIH0KPj4gPiDCoCDCoCDCoCDCoH0KPj4KPj4gSXQncyBhIHJlYWwgc2hhbWUg
YWJvdXQgdGhlIGNvZGUgZHVwbGljYXRpb24gaGVyZS4gwqBDYW4gd2Ugbm90IGF2b2lkCj4+IGl0
IGp1c3QgYnkgZG9pbmc6Cj4+Cj4+IHVuc2lnbmVkIGNoYXIgYzEgPSAoaWdub3JlX2Nhc2UpID8g
dG9sb3dlcigqbWF0Y2gpIDogKm1hdGNoOwo+PiB1bmlzZ25lZCBjaGFyIGMyID0gKGlnbm9yZV9j
YXNlKSA/IHRvbG93ZXIoKm5hbWUpIDogKm5hbWU7Cj4+Cj4+IEkgYXBwcmVjaWF0ZSB0aGF0IHRv
IHNvbWUgaXQgbWlnaHQgbG9vayBsaWtlIHBlcmwgZ29sZiwgYnV0Li4uCj4KPiBJdCBoYXMgYmVl
biBkaXNjdXNzZWQsIGFuZCBJSVJDLCB0aGUgY29uY2Vuc3VzIHdhcyB0byBrZWVwIHRoZSBjb2Rl
Cj4gZHVwbGljYXRpb24gYmVjYXVzZSB0aGlzIGlzIGFuIGlubmVyIGxvb3AuCgpJIG11c3QgaGF2
ZSBtaXNzZWQgdGhlIGRpc2N1c3Npb24gLS0gYnV0IHdoeS9ob3cgZG9lcyBtYWtpbmcgaXQgYW4K
aW5uZXItbG9vcCBzb21laG93IHByZXZlbnQgaXQgZnJvbSBzdWNoIGFuIG9idmlvdXMgKGFuZCBy
ZWFkYWJsZSkKb3B0aW1pc2F0aW9uLCB3aGljaCB3b3VsZCBoYXZlIGZpdHRlZCBpbiB3ZWxsIGlu
IG90aGVyIGFyZWFzLgoKLS0gVGhvbWFzIEFkYW0K
