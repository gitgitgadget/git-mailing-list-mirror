From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Sun, 3 Oct 2010 12:54:22 +0100
Message-ID: <AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 13:54:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2N9b-0000WY-CW
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 13:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab0JCLyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 07:54:39 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41446 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0JCLyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 07:54:38 -0400
Received: by qyk32 with SMTP id 32so916853qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=0Dyg5Ulv5aretXSv3SKl/nt1NkGGkMU3jRZ/pjQzqg0=;
        b=WJe76nrt8KlV6AI7GlTE1AxjWk9eNWuCSJM+STzBP6G/QmE9Je8seF1DsRbzmGnUOT
         ySxG+ocMm7P1R8Cnu+zwP+Txz4HCI4HWfPDUW3grbtmCW+gDicagx55bWlMi3XiP9K1l
         njVgURAlSjtbrwtlBbJjiT5br+7PHeJKnvpHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Mg1HiMdR+PqUXZSjU8j1pBtrL1GyNZC5/R4zO84/ppMY04TaP5z5V+Xcg/1HyzuBNw
         xZcll9kMvxWchjDKTDTeozYda9qz7ZM/3gChBV7UdTa9PfKf1IwCnCHwzDCDf1uYI1ah
         JQMKBknBHzM1XArLI35byB29Y4DdqQcR6+nPM=
Received: by 10.229.10.223 with SMTP id q31mr5713683qcq.280.1286106877239;
 Sun, 03 Oct 2010 04:54:37 -0700 (PDT)
Received: by 10.229.23.13 with HTTP; Sun, 3 Oct 2010 04:54:22 -0700 (PDT)
In-Reply-To: <1286099806-25774-7-git-send-email-avarab@gmail.com>
X-Google-Sender-Auth: oXsOrMGmgRKVgELpURjwLInrP3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157862>

SGkgLS0KCk9uIDMgT2N0b2JlciAyMDEwIDEwOjU2LCDDhnZhciBBcm5masO2csOwIEJqYXJtYXNv
biA8YXZhcmFiQGdtYWlsLmNvbT4gd3JvdGU6Cj4gKyDCoCDCoCDCoCBpZiAoaWdub3JlX2Nhc2Up
IHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoOzspIHsKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHVuc2lnbmVkIGNoYXIgYzEgPSB0b2xvd2VyKCptYXRjaCk7Cj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1bnNpZ25lZCBjaGFyIGMyID0gdG9s
b3dlcigqbmFtZSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoYzEg
PT0gJ1wwJyB8fCBpc19nbG9iX3NwZWNpYWwoYzEpKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAoYzEgIT0gYzIpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gMDsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIG1hdGNoKys7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuYW1l
Kys7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuYW1lbGVuLS07Cj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9Cj4gKyDCoCDCoCDCoCB9IGVsc2Ugewo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZm9yICg7Oykgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgdW5zaWduZWQgY2hhciBjMSA9ICptYXRjaDsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHVuc2lnbmVkIGNoYXIgYzIgPSAqbmFtZTsKPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChjMSA9PSAnXDAnIHx8IGlzX2dsb2Jfc3BlY2lhbChjMSkpCj4g
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjMSAhPSBjMikKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAwOwo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWF0Y2grKzsKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIG5hbWUrKzsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIG5hbWVsZW4tLTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPiDCoCDCoCDCoCDC
oH0KCkl0J3MgYSByZWFsIHNoYW1lIGFib3V0IHRoZSBjb2RlIGR1cGxpY2F0aW9uIGhlcmUuICBD
YW4gd2Ugbm90IGF2b2lkCml0IGp1c3QgYnkgZG9pbmc6Cgp1bnNpZ25lZCBjaGFyIGMxID0gKGln
bm9yZV9jYXNlKSA/IHRvbG93ZXIoKm1hdGNoKSA6ICptYXRjaDsKdW5pc2duZWQgY2hhciBjMiA9
IChpZ25vcmVfY2FzZSkgPyB0b2xvd2VyKCpuYW1lKSA6ICpuYW1lOwoKSSBhcHByZWNpYXRlIHRo
YXQgdG8gc29tZSBpdCBtaWdodCBsb29rIGxpa2UgcGVybCBnb2xmLCBidXQuLi4KCi0tIFRob21h
cyBBZGFtCg==
