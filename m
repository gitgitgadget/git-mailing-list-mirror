From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Workaround for ai_canonname sometimes coming back as null
Date: Thu, 30 Apr 2009 00:01:28 +0200
Message-ID: <81b0412b0904291501w501eecd4y18927018d57bdbdc@mail.gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
	 <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
	 <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Augie Fackler <durin42@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHqu-0007Oh-Pw
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbZD2WBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZD2WBa
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:01:30 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50125 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZD2WB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:01:29 -0400
Received: by fxm2 with SMTP id 2so1469121fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+6ianKU0uFOMAq0PIZj/mYU4WG+qzLE4/72sLHdw3cU=;
        b=JKYdCVzKWu0Lj/PGo5OxF5b/fDWWjah7FjVDu95V3kFkVYq3XWu9XjtmSnFtA3P7i7
         1KZH3v5ua5wAxrKbXqO9dEdkq0CghtUPERQ4zkMVddz8Zqb248vjz5Vj9c/OLA4BvzCT
         xmMHj5hqA+YMzpKrExUfQOfYACwDWsYTC1YQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vnz3GLdX4xEEc5+df2fnwB4z8SFXbM5ErIqchCMjtq4pDoerd5FHlNWwAJiRhBVGi0
         BX5VucX/JqQVIhpz4FK+x+1KCVldV6tqITz5J+yZ3hw7ntHopvxfwd0IETMs2+DBAkpW
         VyXErqPTdJ1N5KNamEi8tZnVmpIiYGBTr/uLk=
Received: by 10.204.63.20 with SMTP id z20mr736143bkh.200.1241042488602; Wed, 
	29 Apr 2009 15:01:28 -0700 (PDT)
In-Reply-To: <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117962>

MjAwOS80LzI5IEF1Z2llIEZhY2tsZXIgPGR1cmluNDJAZ21haWwuY29tPjoKPiBPbiBBcHIgMjks
IDIwMDksIGF0IDQ6NTUgUE0sIEFsZXggUmllc2VuIHdyb3RlOgo+PiAyMDA5LzQvMjkgQXVnaWUg
RmFja2xlciA8ZHVyaW40MkBnbWFpbC5jb20+Ogo+Pj4KPj4+IEBAIC00NTksNyArNDU5LDEwIEBA
IHN0YXRpYyB2b2lkIHBhcnNlX2V4dHJhX2FyZ3MoY2hhciAqZXh0cmFfYXJncywgaW50Cj4+PiBi
dWZsZW4pCj4+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBp
bmV0X250b3AoQUZfSU5FVCwgJnNpbl9hZGRyLT5zaW5fYWRkciwKPj4+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFkZHJidWYsIHNp
emVvZihhZGRyYnVmKSk7Cj4+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBmcmVlKGNhbm9uX2hvc3RuYW1lKTsKPj4+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2Fub25faG9zdG5hbWUgPQo+Pj4geHN0cmR1cChhaS0+
YWlfY2Fub25uYW1lKTsKPj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKGFpLT5haV9jYW5vbm5hbWUpCj4+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhbm9uX2hvc3RuYW1lID0KPj4+
IHhzdHJkdXAoYWktPmFpX2Nhbm9ubmFtZSk7Cj4+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVsc2UKPj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2Fub25faG9zdG5hbWUgPSAidW5rbm93
biI7Cj4+Cj4+IFRoaXMgbGFzdCBsaW5lIHdpbGwgY3Jhc2ggc29tZSBsaW5lcyBkb3duLCB3aGVu
IGNhbm9uX2hvc3RuYW1lIGlzIGZyZWUnZDoKPj4KPgo+IE9kZCwgYmVjYXVzZSBJJ20gcnVubmlu
ZyB3aXRoIHRoYXQgZXhhY3QgY29kZSBhbmQgbm90IHNlZWluZyB0aGUgcHJvYmxlbS4KPiBTaG91
bGQgSSByZXN1Ym1pdCBhbiB1cGRhdGVkIHBhdGNoIHRoYXQgeHN0cmR1cCdzIHVua25vd24gaW50
bwo+IGNhbm9uX2hvc3RuYW1lPwo+CgpJIHRoaW5rIHlvdSBjYW4ganVzdCBsZXQgY2Fub25faG9z
dG5hbWUgYmUgTlVMTCAoaS5lLiBkb24ndCBzdHJkdXAgaXQsCmlmIGFpX2Nhbm9ubmFtZSBpcyBO
VUxMKS4gTlVMTCB2YWx1ZXMgb2YgY2Fub25faG9zdG5hbWUgc2VlbQp0byBiZSBoYW5kbGVkIGp1
c3QgZmluZTogc2VlIHBhdGhfb2sgYW5kIHN0cmJ1Zl9leHBhbmRfZGljdF9jYiAoc3RyYnVmLmMp
Cg==
