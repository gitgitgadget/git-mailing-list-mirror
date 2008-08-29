From: "=?UTF-8?Q?Eddy_Petri=C8=99or?=" <eddy.petrisor@gmail.com>
Subject: Re: [PATCH 0/3] git-svn-externals PoC (in a sh script)
Date: Fri, 29 Aug 2008 03:16:00 +0300
Message-ID: <60381eeb0808281716l512a4ac5kc7ba41c0d00e6baa@mail.gmail.com>
References: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 02:17:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrfq-0006xP-At
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbYH2AQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbYH2AQD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:16:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:44319 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbYH2AQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:16:01 -0400
Received: by yx-out-2324.google.com with SMTP id 8so350689yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bs+xGsbEXcNhnl1Q0qE64l5w4x98cx0lAZb5TfbxSkI=;
        b=kLPFG0Rc09B2niLcmibC7Uv3qx6UwL1zJbh6sfH6Qt75ySQnmtWWe66xPgF+f8rcv3
         XeWAqcpH9Sahg3qsV9u003fYbZ52sTSweOUOeBLjt6VSYmG64KwvmW/xSTucEW86ztkh
         +qgwj1M/wmcdDN/j9EZhvgE3/5ky7WX3S4TS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h6/BRzQA0+bOQ8YCAcMVdvqM9ON5QnsjqSEKEwKpwYH/edz1rcZJXddL04nBLONsCn
         PPOCqb6Ff253T/Dx3hLHxBW9DIfknpryc+2weMIwysg3qzPIbVnh+9pSFmIeWN5+671R
         hEUHxBnxgv7vSUP/n0sl8n85qAd68f9CcDNYo=
Received: by 10.150.11.6 with SMTP id 6mr3165765ybk.9.1219968960576;
        Thu, 28 Aug 2008 17:16:00 -0700 (PDT)
Received: by 10.151.26.18 with HTTP; Thu, 28 Aug 2008 17:16:00 -0700 (PDT)
In-Reply-To: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94232>

UGxlYXNlIENDIG1lLCBJIGFtIG5vdCBsaXN0ZWQuCgoyMDA4LzgvMjkgRWRkeSBQZXRyaciZb3Ig
PGVkZHkucGV0cmlzb3JAZ21haWwuY29tPjoKPiBIZWxsbywKPgo+IEkgaGF2ZSBzdGFydGVkIGEg
d2hpbGUgYmFjayB3b3JraW5nIG9uIHN1cHBvcnQgZm9yIHN2bjpleHRlcm5hbHMKPiBzdXBwb3J0
IGZvciBnaXQtc3ZuLCBidXQgc2luY2UgSSdtIG5vdCB0aGF0IHNhdGlzZmllZCB3aXRoIHRoZSBj
dXJyZW50Cj4gc3RhdHVzIG9mIHRoZSBwYXRjaCwgSSBoYXZlbid0IG1vZGlmaWVkIGdpdC1zdm4g
aXRzZWxmIGFuZCBqdXN0IGxlZnQKPiB0aGUgc2ggc2NyaXB0IEkgbWFkZSBhcyBhIFBvQyBhcyBp
dCB3YXMuCj4KPiBUaGVyZSdzIHN0aWxsIHdvcmsgdG8gYmUgZG9uZSB0byBpdCwgYnV0IEkgdGhl
IGN1cnJlbnQgdmVyc2lvbiBpcwo+IGZ1bmN0aW9uYWwgZW5vdWdoIHRvIGJlIHByb2JhYmx5IGZv
dW5kIHVzZWZ1bCBieSBtb3JlIHBlb3BsZSB0aGFuCj4gbXlzZWxmLgo+Cj4KPiBDdXJyZW50IHN0
YXR1cyBmb2xsb3dzOgo+Cj4gICAgQ3VycmVudCBmdW5jdGlvbmFsaXR5Ogo+ICAgICAtIGZldGNo
ZXMgYWxsIHRoZSBleHRlcm5hbHMgb2YgYW4gYWxyZWFkeSBzdm4tZmV0Y2hlZCByZXBvCj4gICAg
IC0gc3VwcG9ydCBmb3Igc3ZuOmV4dGVybmFscyByZWZyZXNoCj4gICAgIC0gaWYgdGhlIGxvY2F0
aW9uIG9mIHRoZSBleHRlcm5hbCBoYXMgY2hhbmdlZCwgdGhlIGN1cnJlbnQgd29ya2luZwo+ICAg
ICAgIGNvcHkgd2lsbCBiZSBwbGFjZWQgYXNpZGUgYW5kIGEgbmV3IGRpcmVjdG9yeSB3aWxsIGJl
IGNyZWF0ZWQKPiAgICAgICBpbnN0ZWFkCj4gICAgIC0gaWYgdGhlIHJlbW90ZSBVUkkgaXMgdGhl
IHNhbWUgKG1heWJlIGEgdmVyaXNvbiBidW1wLCB0aGVyZSB3aWxsCj4gICAgICAgYmUgYSAnZ2l0
IHN2biByZWJhc2UnCj4gICAgIC0gcmVtb3ZlIHN1cHBvcnQgKHVzZWZ1bCBmb3IgdGVzdGluZyBw
dXJwb3NlcyBvciBjbGVhbiByZXN0YXJ0cykKPiAgICAgLSBhdm9pZCB6b21iaWUgZXh0ZXJuYWxz
IGF0IGFsbCBjb3N0cyAtIGluIHNvbWUgcmVwb3MgZW1wdHkKPiAgICAgICBzdm46ZXh0ZXJuYWxz
IG1pZ2h0IGV4aXN0OyBzdm4gaWdub3JlcyBzdWNoIGV4dGVybmFscywgc28gZ2l0IHNob3VsZAo+
ICAgICAgIGRvIHRoZSBzYW1lCj4KPiAgICBUT0RPOgo+ICAgICAtIHRha2UgaW50byBhY2NvdW50
IHRoZSByZXZpc2lvbiBvZiBhbiBleHRlcm5hbCwgaWYgaXQgZXhpc3RzCj4gICAgIC0gZG8gbm90
IGRvIGRlZXAgc3ZuIGNsb25pbmcsIHRvIGF2b2lkIGxlZ3RoeSBvcGVyYXRpb25zLCBqdXN0IHB1
bGwgSEVBRAo+ICAgICAgICh0aGlzIGFjdHVhbGx5IG5lZWRzIGNoYW5nZXMgaW4gZ2l0LXN2biBp
dHNlbGYpCj4gICAgIC0gdXNlL2NyZWF0ZSBzaGFsbG93IGNvcGllcyB0byBnaXQgc3ZuIHJlcG9z
IChvbmUgcmV2aXNpb24gc2hvdWxkIGJlIGVub3VnaAo+ICAgICAgIGZvciBtb3N0IGV4dGVybmFs
cykKPiAgICAgLSB1c2Ugc3VibW9kdWxlcyBmb3IgZXh0ZXJuYWxzCj4KPgo+Cj4KPiBBbnkgY29t
bWVudHMgYXJlIHdlbGNvbWUuCj4KPgo+IC0tCj4gUmVnYXJkcywKPiBFZGR5UAo+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ICJJbWFnaW5hdGlvbiBpcyBt
b3JlIGltcG9ydGFudCB0aGFuIGtub3dsZWRnZSIgQS5FaW5zdGVpbgo+CgoKCi0tIApSZWdhcmRz
LApFZGR5UAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIklt
YWdpbmF0aW9uIGlzIG1vcmUgaW1wb3J0YW50IHRoYW4ga25vd2xlZGdlIiBBLkVpbnN0ZWluCg==
