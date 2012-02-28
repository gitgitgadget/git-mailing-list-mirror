From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 02/11] Add git-column and column mode parsing
Date: Tue, 28 Feb 2012 18:00:08 +0700
Message-ID: <CACsJy8AAi7N39a1zrKpTGoFJbySxUZvh2JZRyhyE-0tXk3-sGA@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330170078-29353-3-git-send-email-pclouds@gmail.com> <4F4BE300.2060302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 28 12:00:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2KnW-0006kE-BR
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab2B1LAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 06:00:40 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:33126 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab2B1LAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:00:39 -0500
Received: by wejx9 with SMTP id x9so882020wej.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 03:00:38 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.107.6 as permitted sender) client-ip=10.180.107.6;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.107.6 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.107.6])
        by 10.180.107.6 with SMTP id gy6mr19464565wib.16.1330426838425 (num_hops = 1);
        Tue, 28 Feb 2012 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zpN2qWN9m05dtj9OeRBiFADaEwl1MvX1XvXoqWjFsm8=;
        b=rLQctiBAS00ZsU2nsgDG3xWFYctTNIKyzpr8J1gKZtc50WAzCHrl/dSrtKB3EclQ2A
         P52EAMt8NOVoGWXeq1V1AsSs+oGYTU6Cp4LWDiM0BOYh2nlglJLvAIVArWblaiGk+CMf
         iofHR0j5JMU3orfQootiAjYO4DKflhhceWTkg=
Received: by 10.180.107.6 with SMTP id gy6mr15271484wib.16.1330426838330; Tue,
 28 Feb 2012 03:00:38 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 28 Feb 2012 03:00:08 -0800 (PST)
In-Reply-To: <4F4BE300.2060302@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191710>

MjAxMi8yLzI4IFJhbXNheSBKb25lcyA8cmFtc2F5QHJhbXNheTEuZGVtb24uY28udWs+Ogo+IE5n
dXnhu4VuIFRow6FpIE5n4buNYyBEdXkgd3JvdGU6Cj4gWy4uLl0KPj4gK3N0YXRpYyBpbnQgcGFy
c2Vfb3B0aW9uKGNvbnN0IGNoYXIgKmFyZywgaW50IGxlbiwKPj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB1bnNpZ25lZCBpbnQgKm1vZGUsIGludCBzdGRvdXRfaXNfdHR5KQo+PiAr
ewo+PiArIMKgIMKgIHN0cnVjdCBjb2xvcHQgb3B0c1tdID0gewo+PiArIMKgIMKgIMKgIMKgIMKg
IMKgIHsgRU5BQkxFLCAiYWx3YXlzIiwgwqAxIH0sCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgeyBF
TkFCTEUsICJuZXZlciIsIMKgIDAgfSwKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCB7IEVOQUJMRSwg
ImF1dG8iLCDCoCAtMSB9LAo+PiArIMKgIMKgIH07Cj4KPiBIbW0sIEkgZG9uJ3QgcmVjb2duaXNl
IHRoaXMgdGFibGUgZnJvbSBsYXN0IHRpbWUgLi4uCj4KPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB9Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgfQo+PiArCj4+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgbmFtZV9sZW4gPSBzdHJsZW4ob3B0c1tpXS5uYW1lKTsKPj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCBpZiAoYXJnX2xlbiAhPSBuYW1lX2xlbiB8fAo+PiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHN0cm5jbXAoYXJnX3N0ciwgb3B0c1tpXS5uYW1lLCBuYW1lX2xlbikpCj4+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7Cj4+ICsKPj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCBzd2l0Y2ggKG9wdHNbaV0udHlwZSkgewo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIGNh
c2UgRU5BQkxFOgo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBzZXRf
ZW5hYmxlX2JpdChtb2RlLCBvcHRzW2ldLnZhbHVlLAo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0ZG91dF9pc190dHkp
Owo+Cj4gZ2l2ZW4gdGhlIGFib3ZlIHRhYmxlLCBjYW4gdGhlIGZvbGxvd2luZyBjYXNlIGxpbWJz
IGV2ZXIgYmUgcmVhY2hlZD8KPiAodGhlICJubyIgcHJlZml4IGlzIG9ubHkgYXBwbGllZCB0byB0
aGUgT1BUSU9OIHR5cGUsIHNvIG1vc3Qgb2YgdGhlCj4gYWJvdmUgY29kZSBzZWVtcyB0byBiZSB1
c2VsZXNzIG5vdyAuLi4pCgpOb3QgaW4gdGhpcyBwYXRjaCwgbm8uIFRoZSB0YWJsZSBpcyBleHRl
bmRlZCBsYXRlciBvbiB3aXRoIG1vcmUgbW9kZXMKYW5kIG9wdGlvbnMuCgo+Cj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgY2FzZSBNT0RFOgo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJldHVybiBzZXRfbW9kZShtb2RlLCBvcHRzW2ldLnZhbHVlKTsKPj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCBjYXNlIE9QVElPTjoKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gc2V0X29wdGlvbihtb2RlLCBvcHRzW2ldLnZhbHVlLCBzZXQpOwo+PiArIMKgIMKgIMKgIMKg
IMKgIMKgIGRlZmF1bHQ6Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJC
VUc6IFVua25vd24gb3B0aW9uIHR5cGUgJWQiLCBvcHRzW2ldLnR5cGUpOwo+PiArIMKgIMKgIMKg
IMKgIMKgIMKgIH0KPj4gKyDCoCDCoCB9Cj4+ICsKPj4gKyDCoCDCoCByZXR1cm4gZXJyb3IoInVu
c3VwcG9ydGVkIHN0eWxlICclcyciLCBhcmcpOwo+PiArfQo+PiArCgotLSAKRHV5Cg==
