From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/9] "git read-tree -m" and the like require worktree
Date: Thu, 28 Feb 2008 10:22:29 +0700
Message-ID: <fcaeb9bf0802271922j41fbdcaag2d761728379d06ad@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com>
	 <20080227163810.GA28016@laptop>
	 <7vhcftnbxx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZNB-0003t3-H1
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313AbYB1DWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 22:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbYB1DWm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:22:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:34375 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758234AbYB1DWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 22:22:30 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2517094fga.17
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 19:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nfCWX5rk6AaM5jOjQUzBpUIMBlXj9MOdM6UO+cEtwY4=;
        b=D5WybpG6Sh+TzWz8ea0p/O5Or3KQQNvGL5Nw8hYKEsipjOTkuBPqjQsyRxyfa9GyiibDgOWojUqvoGqo90hGTv2lWkXKvfLeOxJaSIGErJ2v+XeuWLIjDaIGBlnUzUJwbE/d82HjIZpPaahl3Tl/ZZ4Pc+b7xD/Bj1KGjJOTWZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xlyCCoO6UG7vg45uU0fzHaBXkiNMIWZQPCJF3D372XGg+dm84r6Kd4hIN5T6Nwe4fToqLS5O7Qthm4AxCBaotSqwR6Ohr9dijddE+x84ynpdr8fjs9I6BHAUKTZ6Uyv/WUqws3LaWDA8EwuViIDIOsBo3w072Ud/ma/NT35ctqw=
Received: by 10.86.84.5 with SMTP id h5mr7205118fgb.75.1204168949130;
        Wed, 27 Feb 2008 19:22:29 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Wed, 27 Feb 2008 19:22:29 -0800 (PST)
In-Reply-To: <7vhcftnbxx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75343>

T24gVGh1LCBGZWIgMjgsIDIwMDggYXQgNzo0OCBBTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJA
cG9ib3guY29tPiB3cm90ZToKPgo+IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNA
Z21haWwuY29tPiB3cml0ZXM6Cj4KPiAgPiBTaWduZWQtb2ZmLWJ5OiBOZ3V54buFbiBUaMOhaSBO
Z+G7jWMgRHV5IDxwY2xvdWRzQGdtYWlsLmNvbT4KPiAgPiAtLS0KPiAgPiAgYnVpbHRpbi1yZWFk
LXRyZWUuYyB8ICAgIDMgKysrCj4gID4gIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQo+ICA+Cj4gID4gZGlmZiAtLWdpdCBhL2J1aWx0aW4tcmVhZC10cmVl
LmMgYi9idWlsdGluLXJlYWQtdHJlZS5jCj4gID4gaW5kZXggZTc4Y2Y2OS4uOTUzMThlMyAxMDA2
NDQKPiAgPiAtLS0gYS9idWlsdGluLXJlYWQtdHJlZS5jCj4gID4gKysrIGIvYnVpbHRpbi1yZWFk
LXRyZWUuYwo+ICA+IEBAIC0yMTksNiArMjE5LDkgQEAgaW50IGNtZF9yZWFkX3RyZWUoaW50IGFy
Z2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICp1bnVzZWRfcHJlZml4KQo+ICA+ICAg
ICAgIGlmICgob3B0cy5kaXIgJiYgIW9wdHMudXBkYXRlKSkKPiAgPiAgICAgICAgICAgICAgIGRp
ZSgiLS1leGNsdWRlLXBlci1kaXJlY3RvcnkgaXMgbWVhbmluZ2xlc3MgdW5sZXNzIC11Iik7Cj4g
ID4KPiAgPiArICAgICBpZiAob3B0cy5tZXJnZSkKPiAgPiArICAgICAgICAgICAgIHNldHVwX3dv
cmtfdHJlZSgpOwo+ICA+ICsKPiAgPiAgICAgICBpZiAob3B0cy5wcmVmaXgpIHsKPiAgPiAgICAg
ICAgICAgICAgIGludCBwZnhsZW4gPSBzdHJsZW4ob3B0cy5wcmVmaXgpOwo+ICA+ICAgICAgICAg
ICAgICAgaW50IHBvczsKPgo+ICBIb3cgd291bGQgdGhpcyBpbnRlcmFjdCB3aXRoICJyZWFkLXRy
ZWUgLW0gLWkiPwo+CgpJdCBzZXR1cHMgd29ya3RyZWUgYW55d2F5LiBCYWQuIFRoZSBmb2xsb3dp
bmcgd291bGQgYmUgYmV0dGVyCgorICAgICBpZiAob3B0cy5tZXJnZSAmJiAhb3B0cy5pbmRleF9v
bmx5KQorICAgICAgICAgICAgIHNldHVwX3dvcmtfdHJlZSgpOworCi0tIApEdXkK
