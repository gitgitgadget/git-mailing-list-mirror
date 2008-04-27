From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Sun, 27 Apr 2008 16:48:25 +0800
Message-ID: <46dff0320804270148y52a593fbt57b8a8fc3184267d@mail.gmail.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
	 <1207590845.17329.98.camel@gandalf.cobite.com>
	 <47FC2190.3070303@alum.mit.edu>
	 <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
	 <48141379.9030306@alum.mit.edu>
	 <46dff0320804262251g3a0f12b2rb9197fc07ea57c51@mail.gmail.com>
	 <46dff0320804270038t651d94d4t3c63fe0cb5240e0d@mail.gmail.com>
	 <46dff0320804270048h6938b8c9scdc1f3e922e41231@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "David Mansfield" <david@cobite.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 27 10:49:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq2ZR-0001Lq-7K
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 10:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbYD0Is1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbYD0Is1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 04:48:27 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:22425 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYD0Is0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 04:48:26 -0400
Received: by an-out-0708.google.com with SMTP id d31so1104266and.103
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jYCH+J3qYdOzNQ+JnP63ONm8TqsfqpKvZZBHZauOOgs=;
        b=TmDtr4Qrq/Qhl87VfJm1K0W8zO2K4sfI/s6UAgfcPvs9bEU1XBrNwQXk7++zW8T6YnlGAiCTfovwskyEhIbjo0VFv4DTYW4bGZyjmQN2eEbk2nfaGTXfNailRk3jBAHkWccXbnVzLprsiNB81Z6nC3JZVF+t6zuNsMG/kmVgj4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fqBvWdxGwmmUDi22yAKQcEHzwEQHfrfaVk0yGj8l7GZ4AYuUQCFr6d4ojMH+wk8xj4GypQmWrBWDB2l3sMxIstEmGf7HuapTxLgUM9fQwY2oGIhMfEdLN+116IXWMEH98u+42ALSPsTm1XyELJcBKp7WsUZW9k0qXRSj0TRvvzo=
Received: by 10.100.31.3 with SMTP id e3mr2819242ane.70.1209286105190;
        Sun, 27 Apr 2008 01:48:25 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 27 Apr 2008 01:48:25 -0700 (PDT)
In-Reply-To: <46dff0320804270048h6938b8c9scdc1f3e922e41231@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80433>

T24gU3VuLCBBcHIgMjcsIDIwMDggYXQgMzo0OCBQTSwgUGluZyBZaW4gPHBrdWZyYW5reUBnbWFp
bC5jb20+IHdyb3RlOgo+ICA+ICA+Cj4gID4gID4gIFRIWC4gSWYgaSB0cnkgb3V0IGN2c3N1Y2ss
IGkgd2lsbCBsZXQgeW91IGtub3cuCj4gID4gID4KPiAgPgo+ICA+ICBHcmVhdCwgaSBzdWNjZWVk
LiBBbmQgdGhlIHJlc3VsdCBpcyBleGFjdGx5IHdoYXQgaSB3YW50IQo+ICA+Cj4KPiAgTm90IGV4
YWN0bHksIGZvciBteSBhbm90aGVyIGNvbnZlcnNpb24uCj4KPiAgJCBnaXQgbG9nIC0tcHJldHR5
PW9ubGluZSAgLS1uYW1lLXN0YXR1cyB4NjRfVUlfMDcxMjA0Cj4gIDcyNGViNDcgXAo+ICBUaGlz
IGNvbW1pdCB3YXMgbWFudWZhY3R1cmVkIGJ5IGN2czJzdm4gdG8gY3JlYXRlIHRhZyAneDY0X1VJ
XzA3MTIwNCcuCj4gIDkzNjI5ODcgYWRkIHN1cHBvcnQgb2Ygd3JpdGluZyBjb29raWVzIG9mICdm
cm9taWQnOwo+ICBNICAgICAgIGxvZ3F1ZXVlLmMKPiAgTSAgICAgICB1aS5jCj4gIE0gICAgICAg
dWkuaAo+Cj4gIFNob3VsZCB3ZSBhdm9pZCByZWNvcmRpbmcgdGhlIGNvbW1pdCA3MjRlYjQ3IHNp
bmNlIGl0IGlzIHRoZSBzYW1lIHdpdGgKPiAgY29tbWl0IDkzNjI5ODcgKG5vIGNvbnRlbnQgY2hh
bmdlKe+8nwo+CgpJIGhhdmUgZm91bmQgdGhlIHJlbGF0ZWQgaXNzdWUgaW4KaHR0cDovL2N2czJz
dm4udGlncmlzLm9yZy9pc3N1ZXMvc2hvd19idWcuY2dpP2lkPTExNyBhbmQgdGhlIHNvbHV0aW9u
CmNvbnRyaWIvZ2l0LW1vdmUtdGFncy5wbCAoaW4gY3ZzMnN2biB0cnVuaywgbm90IHJlbGVhc2Vk
IHlldCkuIFNvcnJ5CmZvciB0aGUgbm9pc2UuCgoKLS0gClBpbmcgWWluCg==
