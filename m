Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892EFC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F8760D43
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKLHAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 02:00:07 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:49747 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbhKLHAH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Nov 2021 02:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
        s=s201512; t=1636700234;
        bh=85qgeVI68hcjMGwHWi/EEU/VUkW9gd0GvJ2ARhRF/FA=;
        h=In-Reply-To:References:From:To:Subject:Date;
        b=ZafsOVLafzWHztvYOxCRtGIKFpAvIc+OMwp+EJphh0tLNnupLeZyvNG4QsvNRU71H
         N5/tGfq2EYJDnd2xtpA87Itr63Z0ZWGdgNo+3yrKpUn2hsGm/db0QiRhSY5dMdimy8
         aLYlMuZPWdOsTPQe6uoWzunTIa1hWX7ZZe+x5a9M=
X-QQ-FEAT: oHWrrGTW1dBLOpUwnNstqWnlSG3bxRlF
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: NT9b64/RmY6NE9+KBUhzu/TUcjfGOoxUcG9Gyro+krD9t8c1IZGOztha2jbtGo
         AZp9SAVv/HXoodUOu9kN8tsMK2L2J7KBRqNPLsUvcbCiRDh85tjBMr+ZDrJKWbKsoVZO8g+TlLfdG
         QgmPGhWyE+udlI4hetmT67nnEviZjMR2mQniOW70HDbUQjVvYs2sVTWbfb7kHxQECH49EiYY2rvMp
         DEwE4xUjPPyZWrDRNfrYWExswdmk/hZpdOq6fbIgEnbJr+bRvm79/JQm52rzDTET6PY93ac3OJhse
         gk1OMsO/HhR3D3BoFHu/iMYSDcpVe1SvrUaoPmV2KIi7Qlo7f23Jmv5jk1i44i15AEfZYopPQmSWb
         +j+VV4xYuw8vDEkSbRYFxQaOWtPLrYSnL99SmfbOB5VhjfV/sblp8sckFEwVcSzjVw2+qQM1dLkVu
         6ma/iFpfdCeSu7B7AaSzePKjLGQKodqcrgbI+6xV6GsgMvmDdYwz+6C6hmv8/PH3e65xwpTMtdgE9
         tlqTi92dcjR9VfV2meq6N3+IE+GhagA4UPHQvivvjImmc6q0N+snbuNC5/8YEcY+261DWfFIpIQE4
         cvpYlyhzd3fpaNt2yAUWnT4jT/sVMRkjvT2EJbUT0Upbc4+mXeWGALsX7WksZw7eReap6axCgpB4p
         ajGCaq1zDZj/456SNonGjxCO1GnyHG17e5ENxutTJi78CDXaOJ2ZVV3SPbdBBWv36s9HGpe9LGd7H
         3bx5dp6+3jihBi9wjiVcZkgsk+W+Z3xUMv0KuAhYZ5yv+LEMP+Z0yKsgPjNEnivlRSIloa+vVKpR3
         /n/SX8bcOF6o/oZZo9EtN5WZTf/XwTm2IIFpWaLdhchnnSk+ocluMMhc7oyX9GNFjTJQFHEACP15a
         Lxjy77gOsK1ETmpsAzzy0Lj+EV7Q35L
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 61.144.238.247
In-Reply-To: <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de>
X-QQ-STYLE: 
X-QQ-mid: webmail514t1636699320t9742521
From:   "=?ISO-8859-1?B?QWxlZW4=?=" <aleen42@vip.qq.com>
To:     "=?ISO-8859-1?B?UmVu6SBTY2hhcmZl?=" <l.s.r@web.de>,
        "=?ISO-8859-1?B?QWxlZW4gdmlhIEdpdEdpdEdhZGdldA==?=" 
        <gitgitgadget@gmail.com>,
        "=?ISO-8859-1?B?Z2l0?=" <git@vger.kernel.org>
Subject: RE: [PATCH 0/2] am: support --always option to am empty commits
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Fri, 12 Nov 2021 14:42:00 +0800
X-Priority: 3
Message-ID: <tencent_EEC1D953A204CC69ED49D8471A89110F3605@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhcnMgUmVu6SwKCj4gVGhlIHN5bW1ldHJ5IGlzIGNvbXBlbGxpbmcsIGJ1dCAiYWx3YXlz
IiBpcyBxdWl0ZSBnZW5lcmljLiAgSSBjYW4gc2VlCj4gZS5nLiBzb21lb25lIGV4cGVjdGlu
ZyAiZ2l0IGFtIC0tYWx3YXlzIiB0byBpbXBseSAtLWtlZXAtbm9uLXBhdGNoLgoKPiBnaXQg
Y29tbWl0IGFuZCBjaGVycnktcGljayBoYXZlIC0tYWxsb3ctZW1wdHksIHdoaWNoIGlzIChh
IGJpdCkgbW9yZQo+IHNwZWNpZmljLiAgVGhhdCBzZWVtcyB0byBtZSBhIGJldHRlciBvcHRp
b24gbmFtZSB0byBjb3B5IGZvciBhIGNvbW1pdC0KPiBjcmVhdGluZyBjb21tYW5kIGxpa2Ug
Z2l0IGFtLgoKSXQgd2FzIGRlc2lnbmVkIGNvcnJlc3BvbmRpbmcgdG8gLS1hbHdheXMgb3B0
aW9uIGluIGdpdC1mb3JtYXQtcGF0Y2gsIHdoaWNoCndpbGwgYmUgcHNzZWQgaW50byBnaXQt
ZGlmZi10cmVlLiBBcyBhIGNvbW1pdC1jcmVhdGluZyBjb21tYW5kLCAtLWFsbG93LWVtcHR5
CmlzIGFwcGFyZW50bHkgYSBiZXR0ZXIgY2hvaWNlLiBJIHdpbGwgcmUtc3VibWl0IGl0LCB0
aGFuayB5b3Uu

