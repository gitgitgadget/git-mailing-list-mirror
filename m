From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF 
	line-endings
Date: Wed, 5 Aug 2009 00:03:08 +0200
Message-ID: <81b0412b0908041503o21f6347ewe60e92a4cb277fd9@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
	 <20090804172638.GA15136@blimp.localdomain>
	 <20090804210327.GA23747@blimp.localdomain>
	 <H9KDJzU0XgndJHC8J4OETn7kxYhGP3gl0YJPR0low0hfIHjZOUsoxw@cipher.nrlssc.navy.mil>
	 <81b0412b0908041458w7e76854bn96c4cb71a5e91e74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYS6N-0001iK-19
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933391AbZHDWDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933352AbZHDWDK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:03:10 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53507 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933313AbZHDWDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 18:03:09 -0400
Received: by bwz19 with SMTP id 19so3351543bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f/gQKG5CHZ9uDqcn5aJu+Ft5BflKpoIeJuLu3T6EzIE=;
        b=DDttzpWeb6Rv1o5LxHGZITqsS0zxvoLIT90y3W1UltqY22uM8n0rkrKR2BvuvILt2n
         y6RoyFlPp0MEWw/GGK1zz/7467hOr3oGRoY50qVTIdGem5ym+Kh5jrr8l8ELEEJuotU0
         5rGDrp/RiNXvBXbYyyI/pd7mL/q482IDqcTaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=omniAgFgAr8uwNyczjRRojv/DxIpiCC0Aaxm0Vpm6SJJg3Kshytvo3hnLwg3x897/p
         IPQo3KHObrJ/ysnmNSMF+5e8U+pmFatkum5Oi/x4eaRIeBqHGoeTe3Yb2bCad6by40+1
         bAvaUv4wHVwI33+fOOlCyQN6WVnSDpQM9O/Uo=
Received: by 10.204.113.208 with SMTP id b16mr140649bkq.179.1249423388794; 
	Tue, 04 Aug 2009 15:03:08 -0700 (PDT)
In-Reply-To: <81b0412b0908041458w7e76854bn96c4cb71a5e91e74@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124823>

T24gVHVlLCBBdWcgNCwgMjAwOSBhdCAyMzo1OCwgQWxleCBSaWVzZW48cmFhLmxrbWxAZ21haWwu
Y29tPiB3cm90ZToKPiBpbnQgcmVhZF9saW5lX3dpdGhfbnVsKGNoYXIgKmJ1ZiwgaW50IHNpemUs
IEZJTEUgKmluKQo+IHsKPiDCoCDCoCDCoCDCoGludCBsZW4gPSAwLCBjOwo+Cj4gwqAgwqAgwqAg
wqB3aGlsZSAobGVuIDwgc2l6ZSkgewoKImZvciAoOzspIiwgb2YgY291cnNlLiBMZWZ0b3ZlciBm
cm9tIGRldmVsb3BtZW50IHByb2Nlc3MKCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjID0gZ2V0
Yyhpbik7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYyA9PSBFT0YpCj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJ1ZltsZW4rK10gPSBjOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGMgPT0gJ1xuJykK
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOwo+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZWxzZSBpZiAobGVuID09IHNpemUpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjID0gMDsKPiDCoCDCoCDCoCDCoH0KPiDCoCDCoCDCoCDCoGlmIChjID09
ICdcbicgJiYgbGVuID4gMSAmJiBidWZbbGVuIC0gMl0gPT0gJ1xyJykKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGJ1ZlstLWxlbiAtIDFdID0gJ1xuJzsKPiDCoCDCoCDCoCDCoGJ1ZltsZW5dID0g
J1wwJzsKPgo+IMKgIMKgIMKgIMKgcmV0dXJuIGxlbjsKPiB9Cj4K
