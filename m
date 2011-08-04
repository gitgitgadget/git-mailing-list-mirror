From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Thu, 4 Aug 2011 15:32:16 +0530
Message-ID: <CALkWK0=19kc3tT3+kMDdmc-eXJwPhGwy6=dwJ4HS65UUA33FiQ@mail.gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
 <201108020436.42148.chriscool@tuxfamily.org> <201108020447.02545.chriscool@tuxfamily.org>
 <201108020451.36617.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:02:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoulG-0004to-D5
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab1HDKCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:02:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39410 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab1HDKCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:02:37 -0400
Received: by wwe5 with SMTP id 5so1730625wwe.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hfSdFdugsPiBxnqo9gIRhmPhdEEY7jekj7GNupcmBGI=;
        b=QVe0VUK/rkRDySqYKKAdaL9WkKxKJY6KLKYh85z5Jp1B3Oqg+JLksXbm/cw3RXIEuk
         NII3azRKmVxnYrLnIcdXqoZWUyOUSkc/bDjSBrw22tfNN7rmimNOWOjDmQGNGKbbUQka
         ZxxO/uDCvukmvJkOo9F8vWBW8Myhoc5nvdPDM=
Received: by 10.216.188.207 with SMTP id a57mr519916wen.94.1312452156188; Thu,
 04 Aug 2011 03:02:36 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 03:02:16 -0700 (PDT)
In-Reply-To: <201108020451.36617.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178714>

SGkgQ2hyaXN0aWFuLAoKQ2hyaXN0aWFuIENvdWRlciB3cml0ZXM6Cj4gT29vcHMsIHNvcnJ5IEkg
bWVhbiBsaWtlIHRoaXM6Cj4KPiDCoCDCoCDCoCDCoGZvciAoaSA9IDE7ICpwOyBpKyspIHsKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBjb21taXQgKmNvbW1pdCA9IHBhcnNlX2luc25f
bGluZShwLCBvcHRzKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghY29tbWl0KQo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGVycm9yKF8oIkNvdWxkIG5v
dCBwYXJzZSBsaW5lICVkLiIpLCBpKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5leHQgPSBj
b21taXRfbGlzdF9hcHBlbmQoY29tbWl0LCBuZXh0KTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHAgPSBzdHJjaHJudWwocCwgJ1xuJyk7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoKnAp
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwKys7Cj4gwqAgwqAgwqAgwqB9
CgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMgYnVnLCBhbmQgc2hvd2luZyBtZSBob3cgdG8gaGFu
ZGxlIGl0IGNvcnJlY3RseSEgOikKV2hpbGUgZml4aW5nIHRoaXMsIEkgdG9vayB0aGUgb3Bwb3J0
dW5pdHkgdG8gaW5jb3Jwb3JhdGUgYWxsIHlvdXIKb3RoZXIgc3VnZ2VzdGlvbnMgaW4gbXkgbmV3
IHNlcmllcy4gIFdpbGwgcG9zdCB0aGUgbmV3IHNlcmllcyBzaG9ydGx5LgoKW0l0IGJyb2tlIG15
IG5ldyBzZXJpZXMsIGJ1dCB0aGlzIHdhcyBkZWZpbml0ZWx5IHdvcnRoIGZpeGluZ10KCi0tIFJh
bQo=
