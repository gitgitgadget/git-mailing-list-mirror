Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC8C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E295B61369
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhGVMNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:13:19 -0400
Received: from utm.cloud6.fr ([185.65.30.130]:27039 "EHLO utm.cloud6.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231928AbhGVMNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:13:18 -0400
X-Greylist: delayed 12330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jul 2021 08:13:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=md6.fr; s=dkim-20171024;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=JC4rJfPbjGr35jpUiYUtTnWo5vSIqHlunUvT6baphOQ=;
        b=mr6nt+TkUWg1k7Z+SIAT5U93Xs2QoKa76Tg8ApVRzvtGsw5EY2SB/xbPMOqSd6xTAYTvuhQqUePmZZ4+NFWvPIwBybeztk9JqDvU8H/BX/49dL0bR2SUkSzv9Oa3aE6PjmEyNK6R5ANjPo7EOqJzvyougapOYu+qVDvFJlpzDHQ=;
Received: from wscorpmbx1.corp.lan ([10.100.0.21]:22254)
        by utm.cloud6.fr with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <sylvain.bentz@md6.fr>)
        id 1m6YCx-0002WL-33; Thu, 22 Jul 2021 14:53:48 +0200
Received: from WSCORPMBX1.corp.lan (10.100.0.21) by WSCORPMBX1.corp.lan
 (10.100.0.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 14:53:47 +0200
Received: from WSCORPMBX1.corp.lan ([::1]) by WSCORPMBX1.corp.lan ([::1]) with
 mapi id 15.01.2176.009; Thu, 22 Jul 2021 14:53:47 +0200
X-CTCH-RefID: str=0001.0A782F15.60F96A5C.0005,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   BENTZ Sylvain <sylvain.bentz@md6.fr>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug: Commit a merge resolution with non-closed conflict markers
 leads to errs, segfault
Thread-Topic: Bug: Commit a merge resolution with non-closed conflict markers
 leads to errs, segfault
Thread-Index: Add+2nkEiZmufg3zQy2G6lCpX2KZX///8S6A//+9nwA=
Date:   Thu, 22 Jul 2021 12:53:47 +0000
Message-ID: <66af2662ae884fff81f51a4eb5ac1dd1@md6.fr>
References: <bdb6c03f290c49bb96e6c0a3d9742a52@md6.fr>
 <60f9477d9cd3a_3fba2082@natae.notmuch>
In-Reply-To: <60f9477d9cd3a_3fba2082@natae.notmuch>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.0.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2ggSSB3YXNuJ3QgYXdhcmUgb2YgdGhpcyB3aGVuIEkgaW5pdGlhbGl6ZWQgbXkgTVdFIHJlcG8s
IGZyb20gZ2l0LWNvbmZpZ1sxXToNCg0KICBCeSBkZWZhdWx0LCBnaXQtcmVyZXJlWzFdIGlzIGVu
YWJsZWQgaWYgdGhlcmUgaXMgYW4gcnItY2FjaGUgZGlyZWN0b3J5IHVuZGVyDQogIHRoZSAkR0lU
X0RJUiwgZS5nLiBpZiAicmVyZXJlIiB3YXMgcHJldmlvdXNseSB1c2VkIGluIHRoZSByZXBvc2l0
b3J5Lg0KDQpUaGUgY29ycmVjdCBNV0UgcmVxdWlyZXMgdG8gZW5hYmxlIHJlcmVyZToNCg0KICBn
aXQgY29uZmlnIHJlcmVyZS5lbmFibGVkIHRydWUNCg0KLS0NClN5bHZhaW4gQmVudHoNCg==
