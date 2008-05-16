From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 16:07:32 +0200
Message-ID: <a537dd660805160707y3830b164td0605a15e6ae05a5@mail.gmail.com>
References: <482BE5F7.2050108@thorn.ws>
	 <alpine.DEB.1.00.0805161148010.30431@racer>
	 <alpine.DEB.1.00.0805161403130.30431@racer>
	 <200805161539.29259.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Tommy Thorn" <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Fri May 16 16:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0bg-0000xa-CV
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYEPOHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYEPOHe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:07:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:13992 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbYEPOHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:07:33 -0400
Received: by rv-out-0506.google.com with SMTP id l9so201433rvb.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=zd0L8/28MvYtMZXGgMVc5KBxEJSws8rIbOwT29k2LPE=;
        b=mZXKe1y9sxXZRmpVR6lPMLj1ymbEYhptUJt29EA1SAwoDNssZ0drpP+QdlBqJCOXAeimwnLVMEAQFjZPA869k39Qmbu8IgQHcaVOJEro7xnzBLSkQtXLwveUtDNpbL4a0jS+63zetsglUKvXhsLu5xH36bIdzLbSKzMcxDGAj7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Eet8obB/sJISQX+t7/GEA/Umn41/yNZ1V8yJQUa3M4mni2soxw7+CDcAQBFPCI1umnadNxWerysNtqPZDX99JgXHm2nx8sUuMfePQf5YMmMJE5CePowjnPPU6QYlXHh41A/yZR7MVFF6z6nGsvrXmWEMRLY32GoxwgYGKFBkkiU=
Received: by 10.140.157.1 with SMTP id f1mr1805768rve.220.1210946852982;
        Fri, 16 May 2008 07:07:32 -0700 (PDT)
Received: by 10.140.202.2 with HTTP; Fri, 16 May 2008 07:07:32 -0700 (PDT)
In-Reply-To: <200805161539.29259.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: cc2f32be0e4d7c76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82291>

dHdvIHF1aWJibGVzIG9mIG5vIGdyZWF0IGltcG9ydGFuY2UgLi4uCgpKb2hhbm5lcyBTY2hpbmRl
bGluIHN1Z2dlc3RlZDoKPiBUaGUgZnVuY3Rpb24gZmdldHMoKSBoYXMgYSBiaWcgcHJvYmxlbSB3
aXRoIE5VTCBjaGFyYWN0ZXJzOiBpdCByZWFkcwo+IHRoZW0sIGJ1dCBub2JvZHkgd2lsbCBrbm93
IGlmIHRoZSBOVUwgY29tZXMgZnJvbSB0aGUgZmlsZSBzdHJlYW0sIG9yCj4gd2FzIGFwcGVuZGVk
IGF0IHRoZSBlbmQgb2YgdGhlIGxpbmUuCj4KPiBTbyBpbXBsZW1lbnQgYSBjdXN0b20gcmVhZF9s
aW5lKCkgZnVuY3Rpb24uCiAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eCiAgICAg
ICAgICAgICAgICAgICAgICAgIHJlYWRfbGluZV93aXRoX251bCgpCm1lYW5pbmcgcmVhZCBwYXJ0
IG9yIGFsbCBvZiBvbmUgbGluZSB3aGljaCBtYXkgY29udGFpbiBOVUxzLgoKPlsgLi4uIF0KPiBk
aWZmIC0tZ2l0IGEvYnVpbHRpbi1tYWlsc3BsaXQuYyBiL2J1aWx0aW4tbWFpbHNwbGl0LmMKPiBp
bmRleCA0NmIyN2NkLi4wMjFkYzE2IDEwMDY0NAo+IC0tLSBhL2J1aWx0aW4tbWFpbHNwbGl0LmMK
PiArKysgYi9idWlsdGluLW1haWxzcGxpdC5jCj4gQEAgLTQ1LDYgKzQ1LDI1IEBAIHN0YXRpYyBp
bnQgaXNfZnJvbV9saW5lKGNvbnN0IGNoYXIgKmxpbmUsIGludCBsZW4pCj4gIC8qIENvdWxkIGJl
IGFzIHNtYWxsIGFzIDY0LCBlbm91Z2ggdG8gaG9sZCBhIFVuaXggIkZyb20gIiBsaW5lLiAqLwo+
ICBzdGF0aWMgY2hhciBidWZbNDA5Nl07Cj4KPiArLyogV2UgY2Fubm90IHVzZSBmZ2V0cygpIGJl
Y2F1c2Ugb3VyIGxpbmVzIGNhbiBjb250YWluIE5VTHMgKi8KPiAraW50IHJlYWRfbGluZV93aXRo
X251bChjaGFyICpidWYsIGludCBzaXplLCBGSUxFICppbikKPiArewo+ICsgICAgIGludCBsZW4g
PSAwLCBjOwo+ICsKPiArICAgICBmb3IgKDs7KSB7Cj4gKyAgICAgICAgICAgICBjID0gZmdldGMo
aW4pOwo+ICsgICAgICAgICAgICAgYnVmW2xlbisrXSA9IGM7Cj4gKyAgICAgICAgICAgICBpZiAo
YyA9PSBFT0YgfHwgYyA9PSAnXG4nIHx8IGxlbiArIDEgPj0gc2l6ZSkKPiArICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gKyAgICAgfQo+ICsKPiArICAgICBpZiAoYyA9PSBFT0YpCj4gKyAg
ICAgICAgICAgICBsZW4tLTsKPiArICAgICBidWZbbGVuXSA9ICdcMCc7Cj4gKwo+ICsgICAgIHJl
dHVybiBsZW47Cgogd2hlbiBmZ2V0YygzKSDigJQgd2h5IG5vdCB1c2UgZ2V0YygzKT8g4oCUIHJl
dHVybnMgRU9GCiBpdCBpcyBwb2ludGxlc3NseSBzdG9yZWQgaW4gYnVmW10gKGFzIGEgJ2NoYXIn
ISksCiBsZW4ncyBhZHZhbmNlZCwgYW5kIHRoZW4gdGhlIHN0b3JhZ2UgYW5kIGFkdmFuY2luZwog
YXJlIHVuZG9uZS4gIGlzbid0IHRoYXQgYSBiaXQgc2lsbHk/ICAgdW50ZXN0ZWQ6CgoJYXNzZXJ0
KDIgPD0gc2l6ZSk7CglkbyB7CgkJaWYgKChjID0gZ2V0YyhpbikpID09IEVPRikKCQkJYnJlYWs7
Cgl9IHdoaWxlICgoKGJ1ZltsZW4rK10gPSBjKSAhPSAnXG4nICYmIGxlbisxIDwgc2l6ZSk7Cgli
dWZbbGVuXSA9ICdcMCcKCglyZXR1cm4gbGVuOwoKIEknZCB0ZW5kIHRvIHdyaXRlIHRoaXMgaW4g
dGVybXMgb2YgcG9pbnRlcnMsCiBzb21ldGhpbmcgYWxvbmcgdGhlIGxpbmVzICh1bnRlc3RlZCk6
CgoJY2hhcgkqcCwgKmVuZHA7CgoJYXNzZXJ0KDEgPD0gc2l6ZSk7CglwICAgID0gYnVmOwoJZW5k
cCA9IHAgKyAoc2l6ZS0xKTsKCXdoaWxlIChwIDwgZW5kcCkgewoJCWlmICgoYyA9IGdldGMoaW4p
KSA9PSBFT0YgfHwgKCpwKysgPSBjKSA9PSAnXG4nKQoJCQlicmVhazsKCX0KCSpwID0gJ1wwJzsK
CglyZXR1cm4gcCAtIGJ1ZjsKCj4gKwo+ICt9CgotLSAKIkhvdyBtYW55IHN1cnJlYWxpc3RzIGRv
ZXMgaXQgdGFrZSB0byAgIHwgQnJpYW4gRm9zdGVyCiBjaGFuZ2UgYSBsaWdodGJ1bGI/IFRocmVl
LiBPbmUgY2FsbXMgICB8IHNvbWV3aGVyZSBpbiBzb3V0aCBvZiBGcmFuY2UKIHRoZSB3YXJ0aG9n
LCBhbmQgdHdvIGZpbGwgdGhlIGJhdGh0dWIgIHwgICBTdG9wIEUkJG8gKEV4eG9uTW9iaWwpIQog
d2l0aCBicmlnaHRseS1jb2xvdXJlZCBtYWNoaW5lIHRvb2xzLiIgfCAgICAgIGh0dHA6Ly93d3cu
c3RvcGVzc28uY29tCg==
