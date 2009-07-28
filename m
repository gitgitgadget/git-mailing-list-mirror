From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3 v2] Add support for external programs for handling 
	native fetches
Date: Tue, 28 Jul 2009 10:07:18 +0200
Message-ID: <36ca99e90907280107i7afb7c64tf0c49bdf82e1e7cb@mail.gmail.com>
References: <alpine.LNX.2.00.0907280155390.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mariano Ortega <mgo1977@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:15:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVhqc-0000iS-Ie
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbZG1IPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbZG1IPi
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:15:38 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:33427 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZG1IPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:15:36 -0400
Received: by bwz21 with SMTP id 21so729089bwz.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4PcRiFG9tpMU+1LlS3/cNeNn8H4tgrjBTmIxarWiI+o=;
        b=YXkgvc8yqjeyHDwtwAgljtLT8ts+5O21UpsdIh9fKg/B4/KX9OIgsd+Nx4aKgNHojY
         35mh/g0GyycaJKKPSVyh+h10J/UTFVdc+TYSGZM1Zpvqb2gOi7HGdvvhLdXZfVAWXxa7
         Hib9+a2VHIn267MMYpA9eYYTuXcrtfvIK/HGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MoRIMH4FwHIK+tEkax8vpTs8bl3e3xZotxn/ZxDi7vcV2lO7kfTPNH4/GfStLNBThA
         T23tCR9/t8w1qEY6dP9iaqlhlV3Pr5d/0omPlnUXVOKV9ofC0y7uxaaYO/Hr9oT1er7P
         dd39U1HnFoZLekYBV2Z+D83EbH4QDSOWWqYT4=
Received: by 10.223.107.68 with SMTP id a4mr3161597fap.104.1248768438914; Tue, 
	28 Jul 2009 01:07:18 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0907280155390.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124221>

T24gVHVlLCBKdWwgMjgsIDIwMDkgYXQgMDg6MDgsIERhbmllbCBCYXJrYWxvdzxiYXJrYWxvd0Bp
YWJlcnZvbi5vcmc+IHdyb3RlOgo+ICtzdGF0aWMgc3RydWN0IGNoaWxkX3Byb2Nlc3MgKmdldF9z
aGltKHN0cnVjdCB0cmFuc3BvcnQgKnRyYW5zcG9ydCkKPiArewo+ICsgwqAgwqAgwqAgc3RydWN0
IHNoaW1fZGF0YSAqZGF0YSA9IHRyYW5zcG9ydC0+ZGF0YTsKPiArIMKgIMKgIMKgIGlmICghZGF0
YS0+c2hpbSkgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IHN0cmJ1ZiBidWYgPSBT
VFJCVUZfSU5JVDsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBjaGlsZF9wcm9jZXNz
ICpzaGltID0geGNhbGxvYygxLCBzaXplb2YoKnNoaW0pKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHNoaW0tPmluID0gLTE7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzaGltLT5vdXQgPSAt
MTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNoaW0tPmVyciA9IDA7Cj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzaGltLT5hcmd2ID0geGNhbGxvYyg0LCBzaXplb2YoKnNoaW0tPmFyZ3YpKTsK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cmJ1Zl9hZGRmKCZidWYsICJzaGltLSVzIiwgZGF0
YS0+bmFtZSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzaGltLT5hcmd2WzBdID0gYnVmLmJ1
ZjsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNoaW0tPmFyZ3ZbMV0gPSB0cmFuc3BvcnQtPnJl
bW90ZS0+bmFtZTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNoaW0tPmFyZ3ZbMl0gPSB0cmFu
c3BvcnQtPnVybDsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNoaW0tPmdpdF9jbWQgPSAxOwo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RhcnRfY29tbWFuZChzaGltKTsKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGRhdGEtPnNoaW0gPSBzaGltOwo+ICsgwqAgwqAgwqAgfQo+ICsgwqAgwqAg
wqAgcmV0dXJuIGRhdGEtPnNoaW07Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgZGlzY29ubmVjdF9z
aGltKHN0cnVjdCB0cmFuc3BvcnQgKnRyYW5zcG9ydCkKPiArewo+ICsgwqAgwqAgwqAgc3RydWN0
IHNoaW1fZGF0YSAqZGF0YSA9IHRyYW5zcG9ydC0+ZGF0YTsKPiArIMKgIMKgIMKgIGlmIChkYXRh
LT5zaGltKSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3cml0ZShkYXRhLT5zaGltLT5pbiwg
IlxuIiwgMSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbG9zZShkYXRhLT5zaGltLT5pbik7
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaW5pc2hfY29tbWFuZChkYXRhLT5zaGltKTsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZyZWUoZGF0YS0+c2hpbS0+YXJndik7CkRvZXMgdGhpcyBs
ZWFrIGRhdGEtPnNoaW0tPmFyZ3ZbMF0gKEllICJzaGltLSVzIik/CgpCZXJ0Cj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmcmVlKGRhdGEtPnNoaW0pOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
dHJhbnNwb3J0LT5kYXRhID0gTlVMTDsKPiArIMKgIMKgIMKgIH0KPiArIMKgIMKgIMKgIHJldHVy
biAwOwo+ICt9Cg==
