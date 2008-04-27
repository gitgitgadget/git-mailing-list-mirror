From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Sun, 27 Apr 2008 15:48:06 +0800
Message-ID: <46dff0320804270048h6938b8c9scdc1f3e922e41231@mail.gmail.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
	 <1207590845.17329.98.camel@gandalf.cobite.com>
	 <47FC2190.3070303@alum.mit.edu>
	 <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
	 <48141379.9030306@alum.mit.edu>
	 <46dff0320804262251g3a0f12b2rb9197fc07ea57c51@mail.gmail.com>
	 <46dff0320804270038t651d94d4t3c63fe0cb5240e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "David Mansfield" <david@cobite.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:48:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq1d2-0004Vw-S8
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 09:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYD0HsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 03:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYD0HsJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 03:48:09 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:3820 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbYD0HsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 03:48:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so1102142and.103
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2wT6oyxkH/l3UmKE/hWNrpkPbbY0SgC/bEDpYsp+iVI=;
        b=aqexhgyi6liKIVPtAXi7+YGZb7Q03mfjnBlQAX2vvVZyBxYDAXKKYS4Nt3v0X3JxN0hN3RvNyjzx1aRsXMqjf7+5AkavNDeBx2Opbzr8ny+bq/R9FWe5W/Epf6grt+XvOJIJXiyLCAzc3UhGL3EjJFTv5o/nRhn0EDADE0A+e7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UJHC+dx5YFy/eUuiCIIzf+zS6CchFpL93nhd09HYWyRB2oLsVKxJgK3k0skKN1zH7mYqTUnaYMDHLUYe5wZDg9oa8MskPK3+VH8LTzLr+ZCq3+xQIQdM5GK6USP1pLq0ZG5d73kI1ktFVq9iREUH34EAHybLayDbbGVUVEPW6C4=
Received: by 10.100.249.9 with SMTP id w9mr4260412anh.63.1209282487267;
        Sun, 27 Apr 2008 00:48:07 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 27 Apr 2008 00:48:06 -0700 (PDT)
In-Reply-To: <46dff0320804270038t651d94d4t3c63fe0cb5240e0d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80432>

T24gU3VuLCBBcHIgMjcsIDIwMDggYXQgMzozOCBQTSwgUGluZyBZaW4gPHBrdWZyYW5reUBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCBBcHIgMjcsIDIwMDggYXQgMTo1MSBQTSwgUGluZyBZ
aW4gPHBrdWZyYW5reUBnbWFpbC5jb20+IHdyb3RlOgo+ICA+IE9uIFN1biwgQXByIDI3LCAyMDA4
IGF0IDE6NDcgUE0sIE1pY2hhZWwgSGFnZ2VydHkgPG1oYWdnZXJAYWx1bS5taXQuZWR1PiB3cm90
ZToKPiAgPiAgPiBQaW5nIFlpbiB3cm90ZToKPiAgPiAgPiAgPiBUaGVzZSBkYXlzIGkgdHJpZWQg
dG8gY29udmVydCB0aGUgY3ZzIHJlcG9zaXRvcnkgaW50byBnaXQuIEkgcmVhbGx5Cj4gID4gID4g
ID4gd2FudCB0aGUgY29udmVyc2lvbiB0byBiZSBhcyBhY2N1cmF0ZSBhcyBwb3NzaWJsZS4gSG93
ZXZlciwgdGhlIGN2cwo+ICA+ICA+ICA+IHJlcG9zaXRvcnkgaGFzIGJlZW4gdGFnZ2VkIGluIGEg
dmVyeSBiYWQgc3R5bGUgd2hpY2ggbWFrZXMKPiAgPiAgPiAgPiBnaXQtY3ZzaW1wb3J0IG9yIGN2
c3BzIG5vdCB3b3JrIHdlbGwuCj4gID4gID4gID4KPiAgPiAgPiAgPiBjdnMyZ2l0IHNvdW5kcyB0
byBiZSB0aGUgcmlnaHQgdG9vbCBpIHNob3VsZCB0cnkuIFVuZm9ydHVhbGVseSwgaQo+ICA+ICA+
ICA+IGNhbid0IHRvdWNoIHRoZSBjdnMgcmVwb3NpdG9yeSBkaXJlY3RseS4gU28gaXMgaXQgcG9z
c2libGUgdG8gdXNlCj4gID4gID4gID4gY3ZzMmdpdCBpbiB0aGUgcmVtb3RlIGhvc3QgaW5zdGVh
ZCBvZiB0aGUgaG9zdCBvZiB0aGUgY3ZzIHJlcG9zaXRvcnkKPiAgPiAgPiAgPiBqdXN0IGFzIGdp
dC1jdnNpbXBvcnQgZG9lcz8gWWVzLCBpIGtub3cgaXQgY2FuJ3Qgbm93LiBJIGp1c3Qgd29uZGVy
Cj4gID4gID4gID4gd2hldGhlciBpdCBpcyBwb3NzaWJsZSB0byBpbXBsZW1lbnQuCj4gID4gID4K
PiAgPiAgPiAgY3ZzMnN2bi9jdnMyZ2l0IGl0c2VsZiBjYW4ndCB3b3JrIHdpdGggcmVtb3RlIHJl
cG9zaXRvcmllcy4gIEl0IHdvdWxkIGJlCj4gID4gID4gIGVub3VnaCBpZiB5b3UgY291bGQganVz
dCBnZXQgYSBjb3B5IG9mIHRoZSByZXBvc2l0b3J5OyBvYnZpb3VzbHkgeW91Cj4gID4gID4gIGRv
bid0IG5lZWQgdG8gdXNlIHRoZSBvcmlnaW5hbC4KPiAgPiAgPgo+ICA+ICA+ICBJZiB5b3UgY2Fu
J3QgZ2V0IGEgY29weSBvZiB0aGUgQ1ZTIHJlcG9zaXRvcnkgZGlyZWN0bHksIHlvdSBtaWdodCBi
ZQo+ICA+ICA+ICBhYmxlIHRvIHJlY3JlYXRlIGl0IGluZGlyZWN0bHkgdmlhIGluZm9ybWF0aW9u
IHJlYWQgb3ZlciB0aGUgQ1ZTCj4gID4gID4gIHByb3RvY29sIHVzaW5nIGEgdG9vbCBsaWtlIENW
U3N1Y2sgWzEsMl0uICBJIGhhdmUgbm8gZXhwZXJpZW5jZSB3aXRoCj4gID4gID4gIENWU3N1Y2ss
IHNvIGlmIHlvdSB0cnkgaXQgb3V0LCBwbGVhc2UgbGV0IHVzIGtub3cgd2hldGhlciB5b3Ugd2Vy
ZQo+ICA+ICA+ICBzdWNjZXNzZnVsLgo+ICA+ICA+Cj4gID4KPiAgPiAgVEhYLiBJZiBpIHRyeSBv
dXQgY3Zzc3VjaywgaSB3aWxsIGxldCB5b3Uga25vdy4KPiAgPgo+Cj4gIEdyZWF0LCBpIHN1Y2Nl
ZWQuIEFuZCB0aGUgcmVzdWx0IGlzIGV4YWN0bHkgd2hhdCBpIHdhbnQhCj4KCk5vdCBleGFjdGx5
LCBmb3IgbXkgYW5vdGhlciBjb252ZXJzaW9uLgoKJCBnaXQgbG9nIC0tcHJldHR5PW9ubGluZSAg
LS1uYW1lLXN0YXR1cyB4NjRfVUlfMDcxMjA0CjcyNGViNDcgXApUaGlzIGNvbW1pdCB3YXMgbWFu
dWZhY3R1cmVkIGJ5IGN2czJzdm4gdG8gY3JlYXRlIHRhZyAneDY0X1VJXzA3MTIwNCcuCjkzNjI5
ODcgYWRkIHN1cHBvcnQgb2Ygd3JpdGluZyBjb29raWVzIG9mICdmcm9taWQnOwpNICAgICAgIGxv
Z3F1ZXVlLmMKTSAgICAgICB1aS5jCk0gICAgICAgdWkuaAoKU2hvdWxkIHdlIGF2b2lkIHJlY29y
ZGluZyB0aGUgY29tbWl0IDcyNGViNDcgc2luY2UgaXQgaXMgdGhlIHNhbWUgd2l0aApjb21taXQg
OTM2Mjk4NyAobm8gY29udGVudCBjaGFuZ2Up77yfCgotLSAKUGluZyBZaW4K
