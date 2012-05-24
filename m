From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v5 2/2] submodule: fix handling of relative superproject
 origin URLs
Date: Fri, 25 May 2012 09:07:11 +1000
Message-ID: <CAH3AnrqBtzALZjk_sRDbCfHrPmnGbdstUuKWaHiaJJayfCw9=Q@mail.gmail.com>
References: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
	<1337830657-16400-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 01:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXh7o-0004iQ-5G
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab2EXXHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:07:13 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35773 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930Ab2EXXHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:07:12 -0400
Received: by weyu7 with SMTP id u7so197016wey.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 16:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jXDPfF42RFFJ/W2IATDWpzkNN8p3LsEQ2GeoHSlb3U0=;
        b=Uas0AZaev7UjEvJpPNVgVMlGzoGlbgzyCwKCJylTCjRKITQ/UJ8jEnLL4pWWw8rzxl
         uX+bmG9j2lxFiXxnXoTAgXB4mk5C8Aokg86bB75eeNjeewHznzUcZ0MmGT4HB6Kr0342
         5HUF9t2gjKm2tUq9B+kMuWTBJzdC4ZlvdzxgBoPHCMbM8u1/3xqqz256fSSRPa3EhD95
         15fwaAhJsyi+/VakLOyg3zH78lWLcqaTa6ScNEqr8owsddn54nrHXPkIGwz8pGmV/oJw
         L7wR6SYF6VP9h9+ESbt818eQ0J7W2V7FQmZka2t8u1TbkC82esLkhDGGP6YaxQr0O8p5
         UcCQ==
Received: by 10.180.86.197 with SMTP id r5mr2305878wiz.21.1337900831059; Thu,
 24 May 2012 16:07:11 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Thu, 24 May 2012 16:07:11 -0700 (PDT)
In-Reply-To: <1337830657-16400-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198442>

T24gVGh1LCBNYXkgMjQsIDIwMTIgYXQgMTozNyBQTSwgSm9uIFNleW1vdXIgPGpvbi5zZXltb3Vy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gwqAgwqAgwqAgwqBzZXA9Lwo+IMKgIMKgIMKgIMKgd2hpbGUg
dGVzdCAtbiAiJHVybCIKPiBAQCAtNDUsNiArNjcsMTYgQEAgcmVzb2x2ZV9yZWxhdGl2ZV91cmwg
KCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC4uLyopCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB1cmw9IiR7dXJsIy4uL30iCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjYXNlICIkcmVtb3RldXJsIiBpbgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLiovKikKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICMgcmVtb3ZlIGxhc3QgcGFydAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVtb3RldXJsPSIke3JlbW90ZXVybCUvKn0iCj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAjIHJlbW92ZSByZWR1bmRh
bnQgbGVhZGluZyAuLwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmVtb3RldXJsPSIke3JlbW90ZXVybCMuL30iCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAjIHByZWZpeCBwYXRoIGZyb20gc3VibW9kdWxlIHdv
cmsgdHJlZSB0byBzdXBlcnByb2plY3Qgd29yayB0cmVlCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZW1vdGV1cmw9IiR7dXBfcGF0aH0ke3JlbW90ZXVy
bH0iCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAjIHJl
bW92ZSB0cmFpbGluZyAvLgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmVtb3RldXJsPSIke3JlbW90ZXVybCUvLn0iCj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA7OwoKTW1tbS4gUHJvYmFibHkgc2hvdWxkbid0
IGJlIGRvaW5nIHRoZXNlIF9hbGxfIG9mIHRoZXNlIGVkaXRzIG9uIGVhY2gKaXRlcmF0aW9uIG9m
IHRoZSB3aGlsZSBsb29wLCBtZXRoaW5rcy4KCkknbGwgd3JpdGUgYSB0ZXN0LCBhbmQgZml4LgoK
am9uLgo=
