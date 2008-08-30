From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/resend] Fix use of hardlinks in "make install"
Date: Sat, 30 Aug 2008 12:08:44 +0200
Message-ID: <81b0412b0808300308m2d03b94ft8601f02b2fea494e@mail.gmail.com>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com>
	 <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
	 <20080830002032.GA14522@steel.home>
	 <66B007DD-F970-43E5-BA38-6138E553C93A@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "=?UTF-8?Q?Andreas_F=C3=A4rber?=" <planche2k@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 12:09:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZNOx-0004bA-3a
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 12:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbYH3KIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 06:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbYH3KIq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 06:08:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:53562 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYH3KIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 06:08:45 -0400
Received: by wa-out-1112.google.com with SMTP id j37so711917waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LeUrQQpz+WcWySIOcM7P+pxmnqUzWObkCCh0Zbg61ik=;
        b=o6xWaHZ+fvG88e8KUzY5/TGpsilgqKXN/39FXf731NvRQVqSyRhxo077q0yWNo2sUz
         o3Lq6xEamwj83Ttw8aQfRXx+A6VY2Id61YomPKF30aO+mSRdoMScHZrGe9Z75LuHcJyx
         jwmQ9XKHMmpJfnEvvjp1Y35JvlHEbxA4dRKB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Qccr/8alZb2fiKSQdqnyoz1MMrgWURmCaLuc4RTD2Pj933W5i1MK8/F01J3jMDPFJ2
         SCDPXlO8r7j8rw0VJO719v8K0PW9nqx4dLEGYbBvwHeriMIxPPbXwVjYjqiB4e3FpoxO
         vn5b33E2+24LkoDfAtaC86Dkhar4gpZeQS/W4=
Received: by 10.114.201.1 with SMTP id y1mr3494849waf.216.1220090924820;
        Sat, 30 Aug 2008 03:08:44 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Sat, 30 Aug 2008 03:08:44 -0700 (PDT)
In-Reply-To: <66B007DD-F970-43E5-BA38-6138E553C93A@googlemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94371>

MjAwOC84LzMwIEFuZHJlYXMgRsOkcmJlciA8cGxhbmNoZTJrQGdvb2dsZW1haWwuY29tPjoKPiBB
bSAzMC4wOC4yMDA4IHVtIDAyOjIwIHNjaHJpZWIgQWxleCBSaWVzZW46Cj4KPj4gV2VsbCwgYXMg
dXN1YWwsIHNpbXBsZSBmaXggZm9yIGEgdHJpdmlhbCB0eXBvIGNhdXNlZCBieSBleGlzdGVuY2Ug
b2YgYW4KPj4gaWRpb3RpYyBwbGF0Zm9ybS4KPj4KPiBZb3VyIHBhdGNoIHNlZW1zIHRvIHdvcmsg
b24gSGFpa3UsIGRvbid0IGhhdmUgYSBNaW5HVyBzZXR1cCB0byB0ZXN0LiBTb3JyeQo+IGZvciB0
aGUgYnJlYWthZ2UuCgpXaGF0PyEgSGFpa3UgdXNlcyBzdHVwaWQgZmlsZSBleHRlbnNpb25zIHRv
IG1hcmsgZXhlY3V0YWJsZXM/Cg==
