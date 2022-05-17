Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B7C433FE
	for <git@archiver.kernel.org>; Tue, 17 May 2022 05:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbiEQFyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 01:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiEQFyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 01:54:02 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3F3DDD7
        for <git@vger.kernel.org>; Mon, 16 May 2022 22:54:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id B868B160130;
        Mon, 16 May 2022 22:54:00 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L2voixOXwEhl; Mon, 16 May 2022 22:53:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id B1A71160138;
        Mon, 16 May 2022 22:53:59 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rpv0vNRIZRcE; Mon, 16 May 2022 22:53:59 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 7A05B160130;
        Mon, 16 May 2022 22:53:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------7001syjG4dtK0Ylr3BevtnRV"
Message-ID: <27c09033-a7f4-e9f4-5871-42ac38111b75@cs.ucla.edu>
Date:   Mon, 16 May 2022 22:53:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, GNU grep developers <grep-devel@gnu.org>,
        "Carlos L." <00xc@protonmail.com>
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
 <xmqqilq658b3.fsf@gitster.g>
 <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu>
 <MHNbacVw7D6ZU3OJvgIqqRMu70HlgYIYQPduUEUnzWCqkGUsUGRLopGGWj-CbyjNilDcUfLB6elfSRgDOaob9cPpjeAf-I6xuMArQZ0y3io=@protonmail.com>
 <xmqq1qwt5w2e.fsf@gitster.g>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: [PATCH] grep: add --max-count command line option
In-Reply-To: <xmqq1qwt5w2e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------7001syjG4dtK0Ylr3BevtnRV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/22 08:36, Junio C Hamano wrote:
> "GNU grep has been doing so for the past 20 years and existing users
> of the command expects '-m 0' to behave that way" is a good enough
> reason, especially if '-m 0' is not the only possible way to say
> "unlimited".

Yes, I'm inclined in the same direction, now that I see more of the 
context. That is, GNU grep can continue what it's long been doing, with 
the only change being to the documentation so that we document -m-1 as 
meaning "unlimited". This minimizes possible disruption to existing 
scripts and satisfies the use case of having a way to turn off any 
previously-appearing -m option.

I installed the attached to the GNU grep master doc to do that. Hope 
this works for you.
--------------7001syjG4dtK0Ylr3BevtnRV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-grep-document-m-better.patch"
Content-Disposition: attachment; filename="0001-grep-document-m-better.patch"
Content-Transfer-Encoding: base64

RnJvbSAyZGVjYTg5Y2YwYzdhOTk0NTBmODhjZjBhYmZhZGQzMzY1MTE2MzNmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEVnZ2VydCA8ZWdnZXJ0QGNzLnVjbGEuZWR1
PgpEYXRlOiBNb24sIDE2IE1heSAyMDIyIDEyOjE4OjI2IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gZ3JlcDogZG9jdW1lbnQgLW0gYmV0dGVyCgoqIGRvYy9ncmVwLmluLjEsIGRvYy9ncmVw
LnRleGk6IERvY3VtZW50IGJlaGF2aW9yIG9mIC1tIDAgYW5kIC1tIC0xLgpUaGlzIGRvY3Vt
ZW50cyBsb25nc3RhbmRpbmcgYmVoYXZpb3IsIGFuZCBpcyBjb25zaXN0ZW50IHdpdGgKaG93
IGdpdCBncmVwIC1tIHdpbGwgbGlrZWx5IGJlaGF2ZS4KLS0tCiBkb2MvZ3JlcC5pbi4xIHwg
MTAgKysrKysrKysrKwogZG9jL2dyZXAudGV4aSB8ICA0ICsrKysKIDIgZmlsZXMgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RvYy9ncmVwLmluLjEgYi9kb2Mv
Z3JlcC5pbi4xCmluZGV4IGFiYTA4NWEuLjViYTkwZWUgMTAwNjQ0Ci0tLSBhL2RvYy9ncmVw
LmluLjEKKysrIGIvZG9jL2dyZXAuaW4uMQpAQCAtMzIxLDYgKzMyMSwxNiBAQCBTY2Fubmlu
ZyBlYWNoIGlucHV0IGZpbGUgc3RvcHMgdXBvbiBmaXJzdCBtYXRjaC4KIFN0b3AgcmVhZGlu
ZyBhIGZpbGUgYWZ0ZXIKIC5JIE5VTQogbWF0Y2hpbmcgbGluZXMuCitJZgorLkkgTlVNCitp
cyB6ZXJvLAorLkIgZ3JlcAorc3RvcHMgcmlnaHQgYXdheSB3aXRob3V0IHJlYWRpbmcgaW5w
dXQuCitBCisuSSBOVU0KK29mIFwtMSBpcyB0cmVhdGVkIGFzIGluZmluaXR5IGFuZAorLkIg
Z3JlcAorZG9lcyBub3Qgc3RvcDsgdGhpcyBpcyB0aGUgZGVmYXVsdC4KIElmIHRoZSBpbnB1
dCBpcyBzdGFuZGFyZCBpbnB1dCBmcm9tIGEgcmVndWxhciBmaWxlLAogYW5kCiAuSSBOVU0K
ZGlmZiAtLWdpdCBhL2RvYy9ncmVwLnRleGkgYi9kb2MvZ3JlcC50ZXhpCmluZGV4IGI5Njg4
YzguLmIwNzNmYTcgMTAwNjQ0Ci0tLSBhL2RvYy9ncmVwLnRleGkKKysrIGIvZG9jL2dyZXAu
dGV4aQpAQCAtMzQxLDYgKzM0MSwxMCBAQCBTY2FubmluZyBlYWNoIGlucHV0IGZpbGUgc3Rv
cHMgdXBvbiBmaXJzdCBtYXRjaC4KIEBvcGluZGV4IC0tbWF4LWNvdW50CiBAY2luZGV4IG1h
eC1jb3VudAogU3RvcCBhZnRlciB0aGUgZmlyc3QgQHZhcntudW19IHNlbGVjdGVkIGxpbmVz
LgorSWYgQHZhcntudW19IGlzIHplcm8sIEBjb21tYW5ke2dyZXB9IHN0b3BzIHJpZ2h0IGF3
YXkgd2l0aG91dCByZWFkaW5nIGlucHV0LgorQSBAdmFye251bX0gb2YgQG1pbnVze30xIGlz
IHRyZWF0ZWQgYXMgaW5maW5pdHkgYW5kIEBjb21tYW5ke2dyZXB9Citkb2VzIG5vdCBzdG9w
OyB0aGlzIGlzIHRoZSBkZWZhdWx0LgorCiBJZiB0aGUgaW5wdXQgaXMgc3RhbmRhcmQgaW5w
dXQgZnJvbSBhIHJlZ3VsYXIgZmlsZSwKIGFuZCBAdmFye251bX0gc2VsZWN0ZWQgbGluZXMg
YXJlIG91dHB1dCwKIEBjb21tYW5ke2dyZXB9IGVuc3VyZXMgdGhhdCB0aGUgc3RhbmRhcmQg
aW5wdXQgaXMgcG9zaXRpb25lZAotLSAKMi4zNC4xCgo=

--------------7001syjG4dtK0Ylr3BevtnRV--
