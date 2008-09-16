From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 11/16] unpack_trees(): add support for narrow checkout
Date: Tue, 16 Sep 2008 18:45:55 +0700
Message-ID: <fcaeb9bf0809160445i29e109d7q2e29964ad3e542fa@mail.gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
	 <7vsks1b3tq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 13:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfZ1P-0008PD-KQ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 13:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYIPLp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 07:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYIPLp6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 07:45:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9738 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYIPLp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 07:45:57 -0400
Received: by ug-out-1314.google.com with SMTP id k3so65884ugf.37
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lSPZtR9837K7Y+OhBLwtg14BXbGQQ772u6Oda+M3N+8=;
        b=d3GMfW6KW9CFvjGNCaHlc1iFbKMAtinJwVlns5RMTx5+LZLF/tVxyD8+XFLtKLD4wy
         +czN6HOSjMxwquWVP8HN3Rh10aA0xCS3zW5RlLDr3eJkWs9C4gai0tS8S546joml0dyJ
         V6ky5/Aoedyf1YFQux7PCP62MBlmEYxWasD2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dmr5XS/idYApnUkPUsYtM9SL0z4PsfXKbtNjAesWaiHLm9ohhnSvur9hGN76AjG9YR
         WrYk5lnq36+6wc1jYuHVoHkWTPy+ErcfJv0WKI0NhDHHirlQJA8N6M0ZVDYfoDjnOMMX
         /i2LuVBkpF1EHmzduWwc6b15/zda1ZXUsIGnE=
Received: by 10.86.97.7 with SMTP id u7mr670974fgb.29.1221565555180;
        Tue, 16 Sep 2008 04:45:55 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Tue, 16 Sep 2008 04:45:55 -0700 (PDT)
In-Reply-To: <7vsks1b3tq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95994>

T24gOS8xNi8wOCwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToKPiBO
Z3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5ICA8cGNsb3Vkc0BnbWFpbC5jb20+IHdyaXRlczoKPgo+
ICA+IGRpZmYgLS1naXQgYS9jYWNoZS5oIGIvY2FjaGUuaAo+ICA+IGluZGV4IDJiMmM5MGYuLjFm
YzBmODMgMTAwNjQ0Cj4gID4gLS0tIGEvY2FjaGUuaAo+ICA+ICsrKyBiL2NhY2hlLmgKPiAgPiBA
QCAtMTY3LDYgKzE2Nyw5IEBAIHN0cnVjdCBjYWNoZV9lbnRyeSB7Cj4gID4gICNkZWZpbmUgQ0Vf
SEFTSEVEICAgICgweDEwMDAwMCkKPiAgPiAgI2RlZmluZSBDRV9VTkhBU0hFRCAgKDB4MjAwMDAw
KQo+ICA+Cj4gID4gKy8qIE9ubHkgcmVtb3ZlIGluIHdvcmsgZGlyZWN0b3J5LCBub3QgaW5kZXgg
Ki8KPiAgPiArI2RlZmluZSBDRV9XRF9SRU1PVkUgKDB4NDAwMDAwKQo+ICA+ICsKPiAgPiAgLyoK
PiAgPiAgICogRXh0ZW5kZWQgb24tZGlzayBmbGFncwo+ICA+ICAgKi8KPiAgPiBkaWZmIC0tZ2l0
IGEvdW5wYWNrLXRyZWVzLmMgYi91bnBhY2stdHJlZXMuYwo+ICA+IGluZGV4IGU1OWQxNDQuLjk2
OGNjOTggMTAwNjQ0Cj4gID4gLS0tIGEvdW5wYWNrLXRyZWVzLmMKPiAgPiArKysgYi91bnBhY2st
dHJlZXMuYwo+ICA+IEBAIC05Niw2ICs5NiwxNSBAQCBzdGF0aWMgaW50IGNoZWNrX3VwZGF0ZXMo
c3RydWN0IHVucGFja190cmVlc19vcHRpb25zICpvKQo+ICA+ICAgICAgIGlmIChvLT51cGRhdGUg
JiYgby0+dmVyYm9zZV91cGRhdGUpIHsKPiAgPiAgICAgICAgICAgICAgIGZvciAodG90YWwgPSBj
bnQgPSAwOyBjbnQgPCBpbmRleC0+Y2FjaGVfbnI7IGNudCsrKSB7Cj4gID4gICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBjYWNoZV9lbnRyeSAqY2UgPSBpbmRleC0+Y2FjaGVbY250XTsKPiAg
PiArCj4gID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChjZS0+Y2VfZmxhZ3MgJiBDRV9XRF9S
RU1PVkUpIHsKPiAgPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0b3RhbCsrOwo+ICA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ICA+ICsgICAgICAgICAg
ICAgICAgICAgICB9Cj4gID4gKwo+ICA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoY2Vfbm9f
Y2hlY2tvdXQoY2UpKQo+ICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Owo+ICA+ICsKPiAgPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNlLT5jZV9mbGFncyAmIChD
RV9VUERBVEUgfCBDRV9SRU1PVkUpKQo+ICA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHRvdGFsKys7Cj4gID4gICAgICAgICAgICAgICB9Cj4KPgo+IFRoaXMgY2hlY2sgZm9yIGNlX25v
X2NoZWNrb3V0KCkgYmVmb3JlIHRoZSBleGlzdGluZyBjaGVjayB0byBzZWUgaWYKPiAgQ0VfVVBE
QVRFIGFuZC9vciBDRV9SRU1PVkUgYXJlIG9uIHB1enpsZXMgbWUgKHlvdSBoYXZlIHRoZSBzYW1l
IGNoZWNrCj4gIHNlcXVlbmNlIGluIGxhdGVyIGxvb3AgdGhhdCBkb2VzIHRoZSBhY3R1YWx5IHdv
cmt0cmVlIHVwZGF0ZXMpLiAgSWYKPiAgYXBwbHlfbmFycm93X2NoZWNrb3V0KCkgY2hlY2sgaXMg
d29ya2luZyBjb3JyZWN0bHksIHdvdWxkIHdlIGV2ZXIgZ2l2ZQo+ICBDRV9VUERBVEUgYW5kL29y
IENFX1JFTU9WRSBiaXRzIHRvIGEgY2FjaGUgZW50cnkgd2l0aCBDRV9OT19DSEVDS09VVCBzZXQ/
Cj4KPiAgSU9XLCBJIHRoaW5rIHRoaXMgZXh0cmEgY2hlY2sgaXMgT2sgYXMgaXQgaXMgZXhwZWN0
ZWQgdG8gYmUgbm8tb3Agd2hlbgo+ICBjb21iaW5lZCB3aXRoIHRoZSBleGlzdGluZyBjaGVjaywg
YnV0IGl0IGxlYXZlcyBtZSB3b25kZXJpbmcgaWYgaXQgaXMKPiAgaGlkaW5nIHNvbWUgY29kZXBh
dGggdGhhdCBpbmNvcnJlY3RseSBzZXRzIENFX1VQREFURS9DRV9SRU1PVkUgdG8gYW4gZW50cnkK
PiAgb3V0c2lkZSB0aGUgbmFycm93IGNoZWNrb3V0IGFyZWEuCgpHYWFhaC4uIEkgd2FzIGNvbmZ1
c2VkIHdpdGggb2xkZXIgc2VyaWVzIHdoZXJlIHZlcmlmeV91cHRvZGF0ZSgpIHdhcwpwYXRjaGVk
IHRvIGlnbm9yZSBtaXNzaW5nIGZpbGVzLiBZb3UgYXJlIHJpZ2h0LCB0aGUgY2hlY2sgaXMgbm90
Cm5lY2Vzc2FyeSwgd2lsbCBuZWVkIG1vcmUgdGVzdCBmb3IgdGhpcy4gV2l0aCB0aGUgY3VycmVu
dCBwYXRjaCwgaXQKd2lsbCBmYWlsIHRvIG1lcmdlIGFzIHNvb24gYXMgc29tZSBmaWxlcyBuZWVk
IHRvIGJlIHVwZGF0ZWQgb3V0c2lkZQpuYXJyb3cgYXJlYS4KLS0gCkR1eQo=
