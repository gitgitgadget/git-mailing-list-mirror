From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] worktree: provide better prefix to go back to
 original cwd
Date: Thu, 7 Oct 2010 12:53:33 +0700
Message-ID: <AANLkTikQJDBsSg96DBohqGjgg+E4LUXU-F1a5DEyz0JU@mail.gmail.com>
References: <4cad50da.0e958e0a.40e3.5efd@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Jens.Lehmann@web.de, Junio C Hamano <gitster@pobox.com>,
	jrnieder@gmail.com,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, judge.packham@gmail.co
X-From: git-owner@vger.kernel.org Thu Oct 07 07:54:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jQX-00082W-1F
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 07:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0JGFxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 01:53:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35213 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab0JGFxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 01:53:55 -0400
Received: by wyb28 with SMTP id 28so328836wyb.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YeQ1fdjt8vvexehNyPI74JqB63P8vx7NcUUdZ5L8MV4=;
        b=JddfMtQgNURm+P7uAMTMbI8a0+IIBUajpIDtYvsPetZfhS9eKLgM9M7Nf/WnnGJBl3
         2SWPUgp2dQIQ3WneciLlDIunemzzjq9RHFlUFZJ+VYYyqzpNl+I8neWLAuIk6ohocPpq
         lERhXSiQSG7WoqKkvti0k0AZ1JAyOIG6O7orY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OTjHUMV6zzLrx5Tb4a+R5dz3dOoROaCedb4YYwtneeXBhk2BzcGO1BhNBs/FYwJuVv
         QXUqPldNK8hpClZnAELSe+XaS+v197DRpyOF/ek1ELMv8dnEIUD8ngNN0GSxM9T7Bth4
         2GaA4Xc+iAO9euThUCvvCUxE7BnsCKOpEhdoc=
Received: by 10.227.155.4 with SMTP id q4mr255876wbw.159.1286430833743; Wed,
 06 Oct 2010 22:53:53 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Wed, 6 Oct 2010 22:53:33 -0700 (PDT)
In-Reply-To: <4cad50da.0e958e0a.40e3.5efd@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158372>

T24gVGh1LCBPY3QgNywgMjAxMCBhdCAxMTo0NiBBTSwgIDxwY2xvdWRzQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBXb3JrdHJlZSBhbmQgY3dkIGFyZSBvbiBk
aWZmZXJlbnQgZHJpdmVzPyAqLwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGxlbiA9PSAz
ICYmIGhhc19kb3NfZHJpdmVfcHJlZml4KGN3ZCkpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmIChzdGFydHVwX2luZm8pIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIG1ha2VfcGF0aF90b19wYXRoIHdpbGwgYWRkIHRo
ZSB0cmFpbGluZyBzbGFzaCAqLwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RhcnR1cF9pbmZvLT5jd2RfdG9fd29ya3RyZWUgPSBtYWtlX3BhdGhfdG9f
cGF0aChOVUxMLCB3b3JrdHJlZSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzdGFydHVwX2luZm8tPndvcmt0cmVlX3RvX2N3ZCA9IG1ha2VfcGF0aF90
b19wYXRoKE5VTEwsIGN3ZCk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gTlVMTDsKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIH0KCldlbnQgZm9yIGx1bmNoIGFuZCByZWFsaXplZCB0aGlzIGNv
ZGUgaXMganVzdCB3cm9uZy4gR2FhaGguLgotLSAKRHV5Cg==
