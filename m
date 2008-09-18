From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] generate-cmdlist.sh: avoid selecting synopsis at wrong place
Date: Thu, 18 Sep 2008 23:20:57 +0700
Message-ID: <fcaeb9bf0809180920v33af3910h7ce56aec1db09a54@mail.gmail.com>
References: <1221753703-3331-1-git-send-email-pclouds@gmail.com>
	 <adf1fd3d0809180909o2043ae36vda7ae2370f900169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMGf-0005ZE-AG
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYIRQVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbYIRQVA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:21:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29972 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYIRQU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:20:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so2049586nfc.21
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6MVPy06rgOuRu5xiSBUNhVLcZvWGMKmbfrC8g6+KoL8=;
        b=KH/6iUCqrIfWHO/N2/Wk5yIiayVhci4A6HyRIYguv6HYZAatc4L2skHTZ1766ExNQo
         +HBsMmiUSM+AOqEmBwWl9Vy6Mue7OyBqP2+7yWYpN14BUF7rk74H7UxJ2mtIPq5qPBuv
         /bO3wMH3d4NBdBv+FMSlAAprAc2fiA5wtFDQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=q1lJyDQukObZOEurfOG2jm7iM0z59izV1+X9JoyIJo5buGU1j6pPXq28xHS0l/9pnZ
         vd1kyN4EdDQ/oBt87uUVdpsUaEAl1bVa7d++ZR27I/yW04Jwv50MlakXyrhU8FnzwL+V
         KdyPAvonAaq81hkldkgNsBbmEVp1oJ5UMz9oU=
Received: by 10.86.52.6 with SMTP id z6mr894962fgz.48.1221754857639;
        Thu, 18 Sep 2008 09:20:57 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Thu, 18 Sep 2008 09:20:57 -0700 (PDT)
In-Reply-To: <adf1fd3d0809180909o2043ae36vda7ae2370f900169@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96211>

T24gOS8xOC8wOCwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29saW5hLm5ldD4gd3JvdGU6Cj4gT24g
VGh1LCBTZXAgMTgsIDIwMDggYXQgNjowMSBQTSwgTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8
cGNsb3Vkc0BnbWFpbC5jb20+IHdyb3RlOgo+ICA+IEluICJjb21tb24iIG1hbiBwYWdlcyB0aGVy
ZSBpcyBsdWNraWx5IG5vICJOQU1FIiBhbnl3aGVyZSBleGNlcHQgYXQKPiAgPiBiZWdpbm5pbmcg
b2YgZG9jdW1lbnRzLiBJZiB0aGVyZSBpcyBhbm90aGVyICJOQU1FIiwgc2VkIGNvdWxkCj4gID4g
bWlzLXNlbGVjdCBpdCBhbmQgbGVhZCB0byBjb21tb24tY21kcy5oIGNvcnJ1cHRpb24uIFNvIGJl
dHRlciBuYWlsIGl0Cj4gID4gYXQgYmVnaW5uaW5nIG9mIGxpbmUsIHdoaWNoIHdvdWxkIHJlZHVj
ZSBjb3JydXB0aW9uIGNoYW5jZS4KPiAgPgo+Cj4KPiBZb3UgY291bGQgbmFycm93IGl0IGV2ZW4g
bW9yZSB3aXRoIC9eTkFNRSQvCgpUaGF0IG1heSBtaXNzICJeTkFNRSAkIiwgd2hpY2ggaXMgaGFy
ZCB0byByZWNvZ25pemUgYnkgZXllcywgYWx0aG91Z2gKSSdtIHByZXR0eSBzdXJlIHRoZXJlIGlz
IG5vIHRyYWlsaW5nIHNwYWNlcyBpbiBnaXQuIEl0J3MgdXAgdG8gSnVuaW8KdG8gZGVjaWRlIGhv
dyBzdHJpY3QgaGUgd2FudHMuCi0tIApEdXkK
