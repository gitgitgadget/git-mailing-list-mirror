From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] fix attribute handling in bare repositories
Date: Mon, 9 Jun 2008 11:24:19 +0700
Message-ID: <fcaeb9bf0806082124m604e5280o55bd0fef39345ad1@mail.gmail.com>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
	 <484BF7BB.1090802@lsrfire.ath.cx>
	 <7vskvnirjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 06:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Ywx-0007iI-RP
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 06:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYFIEYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 00:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbYFIEYW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 00:24:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:46777 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYFIEYV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 00:24:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1383418fgg.17
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 21:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dlDoOEx+zBionrhE4GhYcSwTNt8htYoYteU66vYFoFc=;
        b=Ry/o9SRpDUosgDa8nzPKnBAg3NH11O3JhBlBfRavbxgxOTNP/6Eg74gznQnFr8d9Od
         0IfpDjMARe2ywf5a4D1za+WcBu1PGX7/Hax7HANa/U6Mcla4wal9cmZRbkKoOZdCkpG4
         4dsJaDPy/W+KyHUneFvjGQknsi6iXTj/ELmo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h3lWa7CDKqwvJkfxpyChnthFbWUOq5dnWqLaczSt5oyzqqiKcClE7UZUv4dLYU13vV
         jxrFYOqchCiOpf1YG2W5C93WBRr8WPh7F8fKnp8l1zQ/lR1FD2vQ2H35PON0X03LJd4/
         h0DpsqQAKvmG/c/PhNf3rY6EQ6fmolYx4A2fk=
Received: by 10.86.52.6 with SMTP id z6mr3683844fgz.48.1212985459244;
        Sun, 08 Jun 2008 21:24:19 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Sun, 8 Jun 2008 21:24:19 -0700 (PDT)
In-Reply-To: <7vskvnirjm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84360>

T24gTW9uLCBKdW4gOSwgMjAwOCBhdCAzOjQ2IEFNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBw
b2JveC5jb20+IHdyb3RlOgo+IFJlbsOpIFNjaGFyZmUgPHJlbmUuc2NoYXJmZUBsc3JmaXJlLmF0
aC5jeD4gd3JpdGVzOgo+Cj4+IE5ndXllbiBUaGFpIE5nb2MgRHV5IHNjaHJpZWI6Cj4+PiBIaSwK
Pj4+Cj4+PiBDdXJyZW50bHkgYXR0ci5jIHdpbGwgcmVhZCAuZ2l0YXR0cmlidXRlcyBvbiBkaXNr
IG5vIG1hdHRlciB0aGVyZSBpcyBhCj4+PiByZWFsIHdvcmt0cmVlIG9yIG5vdC4gVGhpcyBjYW4g
bGVhZCB0byBzdHJhbmdlIGJlaGF2aW9yLgo+Pgo+PiBZZXMsIGl0IHByb2JhYmx5IHNob3VsZG4n
dCBkbyB0aGF0LiAgV2hhdCBhYm91dCB0aGlzIHBhdGNoPwo+Cj4gSG1tLiAgSSBkbyBub3Qga25v
dyBpZiBpdCBicmVha3MgYW55dGhpbmcsIGJ1dCBpZiB5b3UgYXJlIGluZGVlZCBpbiBhIGJhcmUK
PiByZXBvc2l0b3J5LCB0aGUgZmlsZXMgdGhlIGNvZGVwYXRocyBhZmZlY3RlZCB0cnkgdG8gcmVh
ZCB3b3VsZCBub3QgZXhpc3QKPiBhbnl3YXksIHNvIEkgYW0gbm90IHN1cmUgd2hhdCB0aGlzIHdv
dWxkIGZpeCwgb3RoZXIgdGhhbiBjaGFuZ2luZyB0aGUKPiBiZWhhdmlvdXIgb2YgY2hlY2stYXR0
ciBmcm9tIG5vdGljaW5nIHRoYXQgaXQgd2FzIGFza2VkIGZvciBub25zZW5zZSBhbmQKPiBiYWls
IG91dCB0byBub3Qgbm90aWNpbmcgbm9yIHNheWluZyBhbnl0aGluZyB1c2VmdWwuCgpZZXMuIEJ1
dCBqdXN0IGluIGNhc2UgdGhvc2UgLmdpdGF0dHJpYnV0ZXMgZXhpc3QgYnkgYWNjaWRlbnQgKGZv
cgpleGFtcGxlIHlvdSBhY2Nlc3MgYSBiYXJlIHJlcG9zaXRvcnkgZnJvbSBhIHdvcmt0cmVlIG9m
IGFub3RoZXIKcmVwb3NpdG9yeSkuIEkgZG9uJ3Qgd2FudCB0byBjaGVjayBjd2QgZm9yIC5naXRh
dHRyaWJ1dGVzIGV2ZXJ5dGltZSBJCndhbnQgdG8gdXNlIGdpdC1hcmNoaXZlIDopCgpBbnl3YXkg
aWYgSSBkbyAiZ2l0LWFyY2hpdmUgPGNvbW1pdD4iIGl0IHNob3VsZCByZWFkIC5naXRhdHRyaWJ1
dGVzCmZyb20gdGhhdCBjb21taXQsIG5vdCBmcm9tIHdvcmtpbmcgZGlyZWN0b3J5LgotLSAKRHV5
Cg==
