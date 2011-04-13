From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 13 Apr 2011 20:12:40 +0700
Message-ID: <BANLkTimubmaV437LvdG8QcmFFjyWujQRzw@mail.gmail.com>
References: <4DA59B27.50506@ge.infn.it> <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Matej Batic <matej.batic@ge.infn.it>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9zsj-00008k-2D
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab1DMNNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 09:13:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51983 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1DMNNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 09:13:11 -0400
Received: by fxm17 with SMTP id 17so427838fxm.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=4p1a/FoFnNLVLSfK/pGmC8tvLgPwlExoGYuIgi+3kKI=;
        b=OWO7aKRAq/AotPFFbaVBZs5/SZAq3kapIRGNTDFMAB4yx3ta6SxqgN3luDVVdsgHFA
         9pxXEO78tIeo9yZpj471XRRp2NKhd2RkNRluI/zWDGdmx1Jv4JQuOQ1eN2rR+Wl9dUQO
         PzPOybkVJ1453EZ1Uns+TpcDdwiAItBBLfCEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GZ2QdrbEYBH6enfltAnUTtnjvgybUrZNU1arzhmHLS94m8x2n7tqUIBzch4Uc+Y8VE
         ZUyu0MIY6UGJFTR2iLLLyEYv4iQLJG9akmpY5GLxY4MRkgpHAAG4qN7W4EidrXO0QBKm
         +i5c3xTJVbIE870LfvorQ+xu4g3QWxXsSaQRY=
Received: by 10.223.76.147 with SMTP id c19mr1648966fak.55.1302700390184; Wed,
 13 Apr 2011 06:13:10 -0700 (PDT)
Received: by 10.223.113.13 with HTTP; Wed, 13 Apr 2011 06:12:40 -0700 (PDT)
In-Reply-To: <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171453>

T24gV2VkLCBBcHIgMTMsIDIwMTEgYXQgODowNSBQTSwgTWljaGFlbCBKIEdydWJlcgo8Z2l0QGRy
bWljaGEud2FycG1haWwubmV0PiB3cm90ZToKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldCA9IHJ1bl9jb21tYW5kX3Zfb3B0KGFsaWFzX2FyZ3YsIFJVTl9VU0lOR19TSEVM
TCk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJidWZfYWRkc3RyKCZz
YiwgIkdJVF9DV0Q9Iik7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
c3ViZGlyKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c3RyYnVmX2FkZHN0cigmc2IsIHN1YmRpcik7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBlbnZbMF0gPSBzYi5idWY7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBlbnZbMV0gPSBOVUxMOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmV0ID0gcnVuX2NvbW1hbmRfdl9vcHRfY2RfZW52KGFsaWFzX2FyZ3YsIFJVTl9VU0lOR19TSEVM
TCwgTlVMTCwgZW52KTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cmJ1
Zl9yZWxlYXNlKCZzYik7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
cmV0ID49IDApIMKgIC8qIG5vcm1hbCBleGl0ICovCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0KHJldCk7CgpzdWJkaXIgY2FuIGJlIE5VTEwuIEkn
bSBub3Qgc3VyZSBpZiBpdCBjYW4gYmUgZW1wdHkgc3RyaW5nIHRob3VnaC4gTWF5Cm5lZWQgYSBj
aGVjayBhbmQgc2V0IGl0IHRvICcuJyBzbyAiY2QgJEdJVF9DV0QiIGRvZXMgbm90IGdvIGJhY2sg
dG8KJEhPTUUuCi0tIApEdXkK
