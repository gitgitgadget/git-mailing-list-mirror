From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Workaround for ai_canonname sometimes coming back as null
Date: Wed, 29 Apr 2009 23:56:09 +0200
Message-ID: <81b0412b0904291456h6e6fa2f0h840e7b3569573be0@mail.gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
	 <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Augie Fackler <durin42@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHlR-0004JO-6Y
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbZD2V4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZD2V4M
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:56:12 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:32818 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbZD2V4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:56:11 -0400
Received: by fxm2 with SMTP id 2so1466760fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aB7vFC2VvgcEVuBvJYPSCUQU6tgao9pWn83dw6fXiKo=;
        b=xNhe4m0KXW1zmRf9QQN1iJZEadjy/4wDAl2jg2zxysfBVU8fdOjMfWvrxsWbrFJKfZ
         SbI7Jc8ulcyhBksG2eYuaK07iK/iyOx6gJM5pbVAoHUNISHcPTmWaL5+68yxiMEQURxF
         /CCx94btQX8SHaR9C9fZ4H0JtVyZxCARfF5Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B7xGc+9rOnxDPMV/QU7s4/oe6Mx2P5OXVbdvzlu2OvAAoiX3JUHfx0Lw2Y12mfEnno
         UZqU/UlGfu+kYBbclmiNBCOS3nwMNVMlZ2/RQ9mZ+8R59a0d1rKsdPTk6xVB0BukkAgC
         z+hTh0d06QaQdBRFC/3ZAIp6ypneXBc17TyZU=
Received: by 10.204.62.135 with SMTP id x7mr756383bkh.95.1241042169687; Wed, 
	29 Apr 2009 14:56:09 -0700 (PDT)
In-Reply-To: <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117960>

MjAwOS80LzI5IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ogo+IDIwMDkvNC8yOSBB
dWdpZSBGYWNrbGVyIDxkdXJpbjQyQGdtYWlsLmNvbT46Cj4+IEBAIC00NTksNyArNDU5LDEwIEBA
IHN0YXRpYyB2b2lkIHBhcnNlX2V4dHJhX2FyZ3MoY2hhciAqZXh0cmFfYXJncywgaW50Cj4+IGJ1
ZmxlbikKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
bmV0X250b3AoQUZfSU5FVCwgJnNpbl9hZGRyLT5zaW5fYWRkciwKPj4gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhZGRyYnVmLCBz
aXplb2YoYWRkcmJ1ZikpOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZyZWUoY2Fub25faG9zdG5hbWUpOwo+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhbm9uX2hvc3RuYW1lID0geHN0cmR1cChhaS0+YWlf
Y2Fub25uYW1lKTsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoYWktPmFpX2Nhbm9ubmFtZSkKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYW5vbl9ob3N0bmFtZSA9Cj4+IHhzdHJk
dXAoYWktPmFpX2Nhbm9ubmFtZSk7Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZWxzZQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhbm9uX2hvc3RuYW1lID0gInVua25vd24iOwo+Cj4g
VGhpcyBsYXN0IGxpbmUgd2lsbCBjcmFzaCBzb21lIGxpbmVzIGRvd24sIHdoZW4gY2Fub25faG9z
dG5hbWUgaXMgZnJlZSdkOgo+CgpBY3R1YWxseSwgaXQgd2lsbCBjcmFzaCBpbiB0aGUgbGluZSBq
dXN0IGFib3ZlLiBPbiB0aGUgc2FtZSByZWFzb25zLgo=
