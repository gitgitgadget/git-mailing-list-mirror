From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] Allow mailsplit (and hence git-am) to handle mails 
	with CRLF line-endings
Date: Wed, 5 Aug 2009 07:49:10 +0200
Message-ID: <81b0412b0908042249g23f7487eo5bf1b9c9027024c@mail.gmail.com>
References: <7vmy6fdxst.fsf@alter.siamese.dyndns.org>
	 <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil>
	 <r3l_p2g-BpVHWKE-kMWIRydJaW0FHLKBpE497REXzOgqPjLUFjPkJ-YKp1tkrIs3CwcppURiH8o@cipher.nrlssc.navy.mil>
	 <r3l_p2g-BpVHWKE-kMWIR9UKBn9dqjBL2asOE11gruEtEyCyQOOh37zkh5F2bJkihtkN8WUp4d0@cipher.nrlssc.navy.mil>
	 <r3l_p2g-BpVHWKE-kMWIR-hbNfTwGmUrXhM-lhoS9dZKPidslwcauSWyJW7X27JpF_HWaZz1tHI@cipher.nrlssc.navy.mil>
	 <r3l_p2g-BpVHWKE-kMWIRydBBfOVeq5L9RbpHa_iUxak9BjwONJobsuScOrzURDhi2RTa-0nDQY@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: gitster@pobox.com, nanako3@lavabit.com, hpa@zytor.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYZNH-00026Y-Vf
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933468AbZHEFtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933461AbZHEFtM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:49:12 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:47056 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933452AbZHEFtL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:49:11 -0400
Received: by fxm17 with SMTP id 17so3682490fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OejzlGsaZWhwbtal0U8V4o0LFLTyYHgj4VUkGDQs2+o=;
        b=GkGYTlp4/oHk7ScgNz+x8NcdZYZVn3Bvq6sytRM2hrBhEICJE/RsttAttNaD8nbb5S
         ObFuNSd0OkvebgcuEda6LnMiJWtJGcfLRQ1I1sFsA5VNirlSGk28CkJiuaRUrUbps6Yw
         je/DXS29w1ckZh1NZIMBD3jnmN8q/ZBUr7j5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iRAr+KflQPQfFc7UkQ1+jxGaYZY6mqhLJixeH+9otEPm4pNzJYNBSDz+DITyvQ3EAG
         uHmz7jFdonvNLS8OwAQd4OKkbcO1U8xcawk0q5Y2o9H2fNz6IwGlnxHd/zP8MToA/VNH
         CNNNWM20K2RsYCyQ4VJYhNvdelA3+k/iUw0NM=
Received: by 10.204.76.199 with SMTP id d7mr522456bkk.84.1249451350616; Tue, 
	04 Aug 2009 22:49:10 -0700 (PDT)
In-Reply-To: <r3l_p2g-BpVHWKE-kMWIRydBBfOVeq5L9RbpHa_iUxak9BjwONJobsuScOrzURDhi2RTa-0nDQY@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124869>

T24gV2VkLCBBdWcgNSwgMjAwOSBhdCAwNTozMSwgQnJhbmRvbiBDYXNleTxjYXNleUBucmxzc2Mu
bmF2eS5taWw+IHdyb3RlOgo+IEBAIC02OSw2ICs3MCwxMiBAQCBzdGF0aWMgaW50IHNwbGl0X29u
ZShGSUxFICptYm94LCBjb25zdCBjaGFyICpuYW1lLCBpbnQgYWxsb3dfYmFyZSkKPiDCoCDCoCDC
oCDCoCAqICJGcm9tICIgYW5kIGhhdmluZyBzb21ldGhpbmcgdGhhdCBsb29rcyBsaWtlIGEgZGF0
ZSBmb3JtYXQuCj4gwqAgwqAgwqAgwqAgKi8KPiDCoCDCoCDCoCDCoGZvciAoOzspIHsKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmICgha2VlcF9jciAmJiBidWYubGVuID4gMSAmJiBidWYuYnVm
W2J1Zi5sZW4tMV0gPT0gJ1xuJyAmJgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYnVmLmJ1ZltidWYubGVuLTJdID09ICdccicpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHN0cmJ1Zl9zZXRsZW4oJmJ1ZiwgYnVmLmxlbi0yKTsKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cmJ1Zl9hZGRjaCgmYnVmLCAnXG4nKTsKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIH0KPiArCgpUaGF0J3MgbXVjaCBiZXR0ZXIgdGhlbiBhbnkgb24t
dGhlLWZseSBjb3JyZWN0aW9ucyA6KQo=
