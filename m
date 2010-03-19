From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 12:08:18 -0700
Message-ID: <d411cc4a1003191208m38b7baf2mbb8f1ea288f90819@mail.gmail.com>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
	 <20100319143205.GB16211@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 20:08:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshYY-00054s-BC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab0CSTIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:08:21 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56813 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0CSTIU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 15:08:20 -0400
Received: by wwe15 with SMTP id 15so2035216wwe.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xsL/SYvm97Laku0WSkt73I+mbpqkjjdzDvv1YW/GRPg=;
        b=vX65PXbOuN+v0kKNqz8iKYyzEkVexVWeV2I2rMKKRPM8y7Qq3DSjOprzUt5qkJrbCu
         X6fxD1/enqTjZL123DyND3cFcRftj66KXFjxM6MN5p0vRJpBS5GRFGokmrdJxbg8pnwa
         geedtVixgB/QpbdnQf12P3GkcI2H08ZgTWcY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DEnabVDj4oxx/SBdwyK4MLLyiHUur5+1Eh0EXTRXn+LU89l0xkQXWibIV83P0asec6
         pPKWa/Gtq5gUj5p0wW2AccQX/if1boUTkCjUwY7scAriPmhz0+5B53sGuN3EsIgq5r67
         0QtSStXi7M21MH84DcQf7wefV0+EdhbUC+Z8U=
Received: by 10.216.89.84 with SMTP id b62mr64578wef.226.1269025698985; Fri, 
	19 Mar 2010 12:08:18 -0700 (PDT)
In-Reply-To: <20100319143205.GB16211@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142634>

SGV5LAoKT24gRnJpLCBNYXIgMTksIDIwMTAgYXQgNzozMiBBTSwgU2hhd24gTy4gUGVhcmNlIDxz
cGVhcmNlQHNwZWFyY2Uub3JnPiB3cm90ZToKPiBTY290dCBDaGFjb24gPHNjaGFjb25AZ21haWwu
Y29tPiB3cm90ZToKPj4gQEAgLTgxNSw3ICs4MTUsMTggQEAgc3RhdGljIGludCBodHRwX3JlcXVl
c3QoY29uc3QgY2hhciAqdXJsLCB2b2lkCj4+ICpyZXN1bHQsIGludCB0YXJnZXQsIGludCBvcHRp
b25zKQo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXQgPSBIVFRQX09LOwo+
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbHNlIGlmIChtaXNzaW5nX3RhcmdldCgmcmVzdWx0cykp
Cj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9IEhUVFBfTUlTU0lOR19U
QVJHRVQ7Cj4+IC0gwqAgwqAgwqAgwqAgwqAgwqAgZWxzZQo+PiArIMKgIMKgIMKgIMKgIMKgIMKg
IGVsc2UgaWYgKHJlc3VsdHMuaHR0cF9jb2RlID09IDQwMSkgewo+PiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmICh1c2VyX25hbWUpIHsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXQgPSBIVFRQX05PQVVUSDsKPj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2Ugewo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC8vIGl0IGlzIG5lY2Nlc2FyeSB0byB1c2UgZ2V0cGFzcyBoZXJl
IGJlY2F1c2UKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAv
LyB0aGVyZSBhcHBlYXJzIHRvIGJlIG5vIG90aGVyIGNsZWFuIHdheSB0bwo+PiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8vIHJlYWQvd3JpdGUgc3Rkb3V0L3N0
ZGluCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXNlcl9u
YW1lID0geHN0cmR1cChnZXRwYXNzKCJVc2VybmFtZTogIikpOwo+Cj4gTm8sIGdldHBhc3MgaXMg
bmVlZGVkIGhlcmUgYmVjYXVzZSBpdHMgdmVyeSBsaWtlbHkgc3RkaW4vc3Rkb3V0IGFyZQo+IHBp
cGVzIHRvIG91ciBwYXJlbnQgcHJvY2Vzcy4gwqBTbyB3ZSBpbnN0ZWFkIG5lZWQgdG8gdXNlIC9k
ZXYvdHR5LAo+IGJ1dCB0aGF0IGlzIG5vbi1wb3J0YWJsZS4gwqBVc2luZyBnZXRwYXNzKCkgY2Fu
IGF0IGxlYXN0IGJlIHN0dWJiZWQKPiBvbiBvdGhlciBwbGF0Zm9ybXMgd2l0aCBhIGRpZmZlcmVu
dCBpbXBsZW1lbnRhdGlvbiBpZi93aGVuIG5lY2Vzc2FyeS4KClNob3VsZCBJIHJvbGwgYSBuZXcg
cGF0Y2ggZm9yIHRoaXM/CgpTY290dAo=
