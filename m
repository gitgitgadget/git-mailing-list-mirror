From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 4/9] Make setup_work_tree() return new prefix
Date: Thu, 28 Feb 2008 20:02:58 +0700
Message-ID: <fcaeb9bf0802280502m2cfc967bt792be98d81a2996@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com>
	 <20080227163902.GA28058@laptop>
	 <alpine.LSU.1.00.0802281130140.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 14:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUiQG-00016e-11
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 14:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbYB1NDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 08:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbYB1NDC
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 08:03:02 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:14948 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbYB1NDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 08:03:00 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2707800fga.17
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 05:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ssBxQqXCcDAhUgCw9zSkN3l7E/ih0z2MqOCe0a5IvuY=;
        b=EeyaidIm03Oc8x2wcyCkyLeVrr+nH2CNvAAhyU882DhjEKOwBaEZIxzLOf8ZY7il/ZIKh+6zdwww8L5jgJgqQiZP7+SyJbMjo6eglWFddr/Aw//5kicRW0iEi1JDda9Y2OC35B19cxATWcJ2HYnuUAO2dUJTkPSuRGiKrU/QBBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Motierh5/MB+lwxxqeFPqooKrmCj8zK0saY//+Xn0Uwi+aWsCPWvyZW9iJuF6GQecKdCKdFXummjft9TPp/uQ09KPfAmzyd2gCjOwBtyLCsiyKCPP+Gdc/9WGPKlopJpk3+CFE4L/8YxcpROdnd0srs4cds313k17UfJMnKLHiY=
Received: by 10.86.97.7 with SMTP id u7mr8144115fgb.39.1204203778886;
        Thu, 28 Feb 2008 05:02:58 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Thu, 28 Feb 2008 05:02:58 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802281130140.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75397>

T24gVGh1LCBGZWIgMjgsIDIwMDggYXQgNjozMCBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPgo+ICBPbiBXZWQsIDI3
IEZlYiAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+Cj4gID4gQEAgLTMz
NiwyNCArMzIxLDIxIEBAIGNvbnN0IGNoYXIgKnNldHVwX2dpdF9kaXJlY3RvcnlfZ2VudGx5KGlu
dCAqbm9uZ2l0X29rKQo+ICA+ICAgICAgICAgICAgICAgICAgICAgICBzdGF0aWMgY2hhciBidWZm
ZXJbMTAyNCArIDFdOwo+ICA+ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpyZXR2
YWw7Cj4gID4KPiAgPiArICAgICAgICAgICAgICAgICAgICAgLyoKPiAgPiArICAgICAgICAgICAg
ICAgICAgICAgICogVGhlIG9sZCBiZWhhdmlvdXIgKHdoaWNoIHdlIHJldGFpbiBoZXJlKSBpcyB0
byBzZXQKPiAgPiArICAgICAgICAgICAgICAgICAgICAgICogdGhlIHdvcmsgdHJlZSByb290IHRv
IHRoZSBjd2QsIHVubGVzcyBvdmVycmlkZGVuIGJ5Cj4gID4gKyAgICAgICAgICAgICAgICAgICAg
ICAqIHRoZSBjb25maWcsIHRoZSBjb21tYW5kIGxpbmUsIG9yIEdJVF9XT1JLX1RSRUUuCj4gID4g
KyAgICAgICAgICAgICAgICAgICAgICAqLwo+ICA+ICAgICAgICAgICAgICAgICAgICAgICBpZiAo
IXdvcmtfdHJlZV9lbnYpIHsKPiAgPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR2
YWwgPSBzZXRfd29ya190cmVlKGdpdGRpcmVudik7Cj4gID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLyogY29uZmlnIG1heSBvdmVycmlkZSB3b3JrdHJlZSAqLwo+ICA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChjaGVja19yZXBvc2l0b3J5X2Zvcm1hdF9nZW50bHko
bm9uZ2l0X29rKSkKPiAgPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBOVUxMOwo+ICA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXR2
YWw7Cj4gID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhciBidWZmZXJbUEFUSF9N
QVggKyAxXTsKPiAgPiArCj4gID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFn
ZXRjd2QoYnVmZmVyLCBzaXplb2YoYnVmZmVyKSkpCj4gID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkaWUgKCJDb3VsZCBub3QgZ2V0IHRoZSBjdXJyZW50IHdvcmtpbmcg
ZGlyZWN0b3J5Iik7Cj4gID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2l0X3dvcmtf
dHJlZV9jZmcgPSB4c3RyZHVwKGJ1ZmZlcik7Cj4gID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW5zaWRlX3dvcmtfdHJlZSA9IDE7Cj4gID4gICAgICAgICAgICAgICAgICAgICAgIH0K
PiAgPiAtICAgICAgICAgICAgICAgICAgICAgaWYgKGNoZWNrX3JlcG9zaXRvcnlfZm9ybWF0X2dl
bnRseShub25naXRfb2spKQo+ICA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBOVUxMOwo+ICA+IC0gICAgICAgICAgICAgICAgICAgICByZXR2YWwgPSBnZXRfcmVsYXRpdmVf
Y3dkKGJ1ZmZlciwgc2l6ZW9mKGJ1ZmZlcikgLSAxLAo+ICA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ2V0X2dpdF93b3JrX3RyZWUoKSk7Cj4gID4gLSAgICAgICAgICAg
ICAgICAgICAgIGlmICghcmV0dmFsIHx8ICEqcmV0dmFsKQo+ICA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ICA+IC0gICAgICAgICAgICAgICAgICAgICBzZXRf
Z2l0X2RpcihtYWtlX2Fic29sdXRlX3BhdGgoZ2l0ZGlyZW52KSk7Cj4gID4gLSAgICAgICAgICAg
ICAgICAgICAgIGlmIChjaGRpcih3b3JrX3RyZWVfZW52KSA8IDApCj4gID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGllICgiQ291bGQgbm90IGNoZGlyIHRvICVzIiwgd29ya190cmVl
X2Vudik7Cj4gID4gLSAgICAgICAgICAgICAgICAgICAgIHN0cmNhdChidWZmZXIsICIvIik7Cj4g
ID4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXR2YWw7Cj4gID4gKyAgICAgICAgICAg
ICAgICAgICAgIGNoZWNrX3JlcG9zaXRvcnlfZm9ybWF0X2dlbnRseShub25naXRfb2spOwo+ICA+
ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPgo+ICBXaGF0IGFib3V0IHRoZSBz
aXR1YXRpb24gd2hlcmUgeW91IGFyZSBpbiBhIHN1YmRpcmVjdG9yeSBvZiBjb3JlLndvcmt0cmVl
Pwo+ICBZb3UgcmV0dXJuIHByZWZpeCBOVUxMPyAgVGhhdCdzIHdyb25nLgoKVGhpcyBpcyBhbiBp
bnRlcm1lZGlhdGUgcGF0Y2guIEF0IHRoZSBlbmQgb2YgdGhlIHNlcmllcywgeW91IHdpbGwgc2Vl
CnRoYXQgX2dlbnRseSgpIGRvZXMgbm90IHJldHVybiBwcmVmaXguIEkgc3BsaXQgaXQgZm9yIGVh
c2llciByZXZpZXcuCgo+ICBJIGFtIHNvcnJ5LCBidXQgd2l0aCBhbGwgdGhlc2UgaW50cnVzaXZl
IGNoYW5nZXMsIEkgZ2V0IGEgdmVyeSB1bmVhc3kKPiAgZmVlbGluZy4gIEFzIHVuZWFzeSBhcyB3
aXRoIHRoZSBvcmlnaW5hbCBzZXJpZXMsIHdoaWNoIEkgdHJpZWQgdG8gZml4IHVwLAo+ICBub3Qg
cmVhbGx5IHN1Y2NlZWRpbmcuCgpJbiBjb25zdHJhc3QgSSBmZWVsIGdvb2QgOikgVG8gbWUgc2V0
dXBfZ2l0X2RpcmVjdG9yeSooKSBhdCB0aGUgZW5kCmxvb2sgcmVhbGx5IG5pY2UuIE5vIGNoZGly
KCkgYWxsIG92ZXIgdGhlIHBsYWNlCih0ZW1wb3JhcnkgY2hkaXIoKSBmb3IgZGV0ZWN0aW5nIC5n
aXQgZG9lcyBub3QgY291bnQpLiBJdCBhbHNvIGdpdmVzIGEKY2hhbmNlIHRvIGdldCByaWQgb2Yg
d29ya3RyZWUgdG8gY29tbWFuZHMgdGhhdCBkbyBub3QgY2FyZSBhYm91dAp3b3JrdHJlZSBhdCBh
bGwuCgo+ICBDaWFvLAo+ICBEc2Nobwo+CgoKCi0tIApEdXkK
