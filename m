Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65752C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiHIQqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbiHIQqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:46:16 -0400
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37964115D
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:46:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07345476|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0257836-0.0010459-0.973171;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.OpoBxKa_1660063561;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OpoBxKa_1660063561)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 00:46:02 +0800
Date:   Wed, 10 Aug 2022 00:46:02 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Jeff King" <peff@peff.net>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Re: [PATCH v2] rev-list: support human-readable output for `--disk-usage`
References: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>, 
        <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>, 
        <YvJfpNSKMIPqVQmD@coredump.intra.peff.net>
X-Priority: 3
X-GUID: 050A15DC-2DD6-46F8-A6AC-07B18F058CA8
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022081000422739665018@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pk9uIE1vbiwgQXVnIDA4LCAyMDIyIGF0IDA4OjM1OjIxQU0gKzAwMDAsIExpIExpbmNoYW8gdmlh
IEdpdEdpdEdhZGdldCB3cm90ZToKPgo+PiBUaGUgJy0tZGlzay11c2FnZScgb3B0aW9uIGZvciBn
aXQtcmV2LWxpc3Qgd2FzIGludHJvZHVjZWQgaW4gMTY5NTBmODM4NAo+PiAocmV2LWxpc3Q6IGFk
ZCAtLWRpc2stdXNhZ2Ugb3B0aW9uIGZvciBjYWxjdWxhdGluZyBkaXNrIHVzYWdlLCAyMDIxLTAy
LTA5KS4KPj4gVGhpcyBpcyB2ZXJ5IHVzZWZ1bCBmb3IgcGVvcGxlIGluc3BlY3QgdGhlaXIgZ2l0
IHJlcG8ncyBvYmplY3RzIHVzYWdlCj4+IGluZm9tYXRpb24sIGJ1dCB0aGUgcmVzdWx0aW5nIG51
bWJlciBpcyBxdWl0IGhhcmQgZm9yIGEgaHVtYW4gdG8gcmVhZC4KPj4KPj4gVGVhY2ggZ2l0IHJl
di1saXN0IHRvIG91dHB1dCBhIGh1bWFuIHJlYWRhYmxlIHJlc3VsdCB3aGVuIHVzaW5nCj4+ICct
LWRpc2stdXNhZ2UnLgo+Cj5PSy4gV2hlbiBhZGRpbmcgLS1kaXNrLXVzYWdlLCBJIG5ldmVyIHJl
YWxseSBkcmVhbWVkIHBlb3BsZSB3b3VsZCB1c2UgaXQKPmZvciBodW1hbiBvdXRwdXQsIHNpbmNl
ICJkdSAuZ2l0IiBpcyB1c3VhbGx5IGEgc3VpdGFibGUgYXBwcm94aW1hdGlvbi4gOikKPkJ1dCBJ
IGRvbid0IGhhdmUgYW55IHJlYWwgb2JqZWN0aW9uLiBJJ20gY3VyaW91cyB3aGF0IHlvdXIgdXNl
IGNhc2UgaXMKPmxpa2UsIGlmIHlvdSBkb24ndCBtaW5kIHNoYXJpbmcuIFdlIHVzZWQgaXQgYXQg
R2l0SHViIGZvciBjb21wdXRpbmcKPnBlci1mb3JrIHNpemVzIGZvciBhbmFseXNpcywgZXRjIChz
byB0aGUgcmVzdWx0IHdhcyBhbHdheXMgZmVkIGludG8KPmFub3RoZXIgc2NyaXB0KS4KU29tZXRp
bWVzLCBJIG5lZWQgb2JqZWN0cyBkaXNrIHNpemUgZm9ywqBhbmFseXNpcyB0b28sIGJ1dCBJIGRv
IHRoaXMgYnkgaGFuZApub3TCoGJ5IHNjcmlwdC4gQW5kIEkgYWxzbyBub3RpY2VkIHRoYXQgZ2l0
LWNvdW50LW9iamVjdHMgaGFzIGFuIG9wdGlvbiAnLUgnCmZvcsKgYmV0dGVyIG91dHB1dCwgc28g
SSB0aGluayBpZiBpdCBjb3VsZCBiZSBhcHBsaWVkIHRvICJnaXQtcmV2LWxpc3QgLS1kaXNrLXVz
YWdlIi4KPgo+PsKgIERvY3VtZW50YXRpb24vcmV2LWxpc3Qtb3B0aW9ucy50eHQgfMKgIDUgKysr
LQo+PsKgIGJ1aWx0aW4vcmV2LWxpc3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4+wqAgdC90NjExNS1yZXYtbGlz
dC1kdS5zaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIyICsrKysrKysrKysrKysrKysKPj7C
oCAzIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPlRo
ZSBwYXRjaCBpdHNlbGYgbG9va3MgcHJldHR5IHNlbnNpYmxlIChhbmQgdGhhbmtzIMOGdmFyIGZv
ciB0aGUgZmlyc3QKPnJvdW5kIG9mIHJldmlldzsgdGhlIHN1Z2dlc3Rpb25zIHRoZXJlIGFsbCBs
b29rZWQgZ29vZCkuIEEgZmV3IHNtYWxsCj5jb21tZW50czoKPgo+PiBAQCAtNDgxLDggKzQ4NSwx
MyBAQCBzdGF0aWMgaW50IHRyeV9iaXRtYXBfZGlza191c2FnZShzdHJ1Y3QgcmV2X2luZm8gKnJl
dnMsCj4+wqAgaWYgKCFiaXRtYXBfZ2l0KQo+PsKgIHJldHVybiAtMTsKPj7CoAo+PiAtCXByaW50
ZigiJSJQUkl1TUFYIlxuIiwKPj4gLQnCoMKgwqDCoMKgwqAgKHVpbnRtYXhfdClnZXRfZGlza191
c2FnZV9mcm9tX2JpdG1hcChiaXRtYXBfZ2l0LCByZXZzKSk7Cj4+ICsJc2l6ZV9mcm9tX2JpdG1h
cCA9IGdldF9kaXNrX3VzYWdlX2Zyb21fYml0bWFwKGJpdG1hcF9naXQsIHJldnMpOwo+PiArCWlm
IChodW1hbl9yZWFkYWJsZSkKPj4gKwlzdHJidWZfaHVtYW5pc2VfYnl0ZXMoJmRpc2tfYnVmLCBz
aXplX2Zyb21fYml0bWFwKTsKPj4gKwllbHNlCj4+ICsJc3RyYnVmX2FkZGYoJmRpc2tfYnVmLCAi
JSJQUkl1TUFYIiIsICh1aW50bWF4X3Qpc2l6ZV9mcm9tX2JpdG1hcCk7Cj4+ICsJcHV0cyhkaXNr
X2J1Zi5idWYpOwo+PiArCXN0cmJ1Zl9yZWxlYXNlKCZkaXNrX2J1Zik7Cj4KPkl0J3Mgbm90IGEg
bG90IG9mIGR1cGxpY2F0ZWQgbGluZXMsIGJ1dCBzaW5jZSBpdCBpcyBpbXBsZW1lbnRpbmcgcG9s
aWN5Cj5sb2dpYywgSSB0aGluayBpdCB3b3VsZCBiZSBuaWNlIHRvIG1vdmUgdGhlIGZvcm1hdHRp
bmcgZGVjaXNpb24gaW50byBhCj5mdW5jdGlvbi4gU29tZXRoaW5nIGxpa2U6Cj4KPsKgIHN0YXRp
YyB2b2lkIHNob3dfZGlza191c2FnZShvZmZfdCBzaXplKQo+wqAgewo+CXN0cnVjdCBzdHJidWYg
c2IgPSBTVFJCVUZfSU5JVDsKPglpZiAoaHVtYW5fcmVhZGFibGUpCj4Jc3RyYnVmX2h1bWFuaXNl
X2J5dGVzKCZzYiwgc2l6ZSk7Cj4JZWxzZQo+CXN0cmJ1Zl9hZGRmKCZzYiwgIiUiUFJJdU1BWCwg
KHVpbnRtYXhfdClzaXplX2Zyb21fYml0bWFwKTsKPglwdXRzKHNiLmJ1Zik7Cj4Jc3RyYnVmX3Jl
bGVhc2UoJnNiKTsKPsKgIH0KPgo+YW5kIHRoZW4geW91IGNhbiBjYWxsIGl0IGZyb20gaGVyZSwg
YW5kIGZyb20gdGhlIG5vbi1iaXRtYXAgcGF0aCBiZWxvdy4KT2gsIHRoaXMgaXMgcmVhbGx5IGdv
b2QuCj4KPihBbHNvLCB3aGlsZSB0eXBpbmcgaXQgb3V0LCBJIG5vdGljZWQgdGhhdCB5b3UgZG9u
J3QgbmVlZCB0aGUgZXh0cmEgIiIKPmFmdGVyIFBSSXVNQVg7IHRoYXQganVzdCBjb25jYXRlbmF0
ZXMgYW4gZW1wdHkgc3RyaW5nKS4KPgo+PiAtCWlmICghc3RyY21wKGFyZywgIi0tZGlzay11c2Fn
ZSIpKSB7Cj4+IC0Jc2hvd19kaXNrX3VzYWdlID0gMTsKPj4gLQlpbmZvLmZsYWdzIHw9IFJFVl9M
SVNUX1FVSUVUOwo+PiAtCWNvbnRpbnVlOwo+PiArCWlmIChza2lwX3ByZWZpeChhcmcsICItLWRp
c2stdXNhZ2UiLCAmYXJnKSkgewo+PiArCWlmICgqYXJnID09ICc9Jykgewo+PiArCWlmICghc3Ry
Y21wKCsrYXJnLCAiaHVtYW4iKSkgewo+PiArCWh1bWFuX3JlYWRhYmxlID0gMTsKPj4gKwlzaG93
X2Rpc2tfdXNhZ2UgPSAxOwo+PiArCWluZm8uZmxhZ3MgfD0gUkVWX0xJU1RfUVVJRVQ7Cj4+ICsJ
Y29udGludWU7Cj4+ICsJfSBlbHNlCj4+ICsJZGllKF8oImludmFsaWQgdmFsdWUgZm9yICclcyc6
ICclcycsIHRyeSAtLWRpc2stdXNhZ2U9aHVtYW4iKSwgIi0tZGlzay11c2FnZSIsIGFyZyk7Cj4+
ICsJfSBlbHNlIHsKPj4gKwlzaG93X2Rpc2tfdXNhZ2UgPSAxOwo+PiArCWluZm8uZmxhZ3MgfD0g
UkVWX0xJU1RfUVVJRVQ7Cj4+ICsJY29udGludWU7Cj4+ICsJfQo+PsKgIH0KPgo+V2UgY2FuIHB1
dCB0aGUgY29tbW9uIHBhcnRzIG9mIGVhY2ggc2lkZSBvZiB0aGUgY29uZGl0aW9uYWwgaW50byB0
aGUKPm91dGVyIGJsb2NrIHRvIGF2b2lkIHJlcGVhdGluZyBvdXJzZWx2ZXMuIEFsc28sIHlvdXIg
Y29kZSBtYXRjaGVzCj4tLXNob3ctZGlzay11c2FnZS13aXRob3V0LWFuLWVxdWFscywgc2luY2Ug
aXQgbm93cyB1c2VzIHNraXBfcHJlZml4KCkuCj5Zb3UgY291bGQgZml4IHRoYXQgYnkgY2hlY2tp
bmcgZm9yICdcMCcgaW4gKmFyZy4gU28gdG9nZXRoZXIsIHNvbWV0aGluZwo+bGlrZToKPgo+wqAg
aWYgKHNraXBfcHJlZml4KGFyZywgIi0tZGlzay11c2FnZSIsICZhcmcpKSB7Cj4JaWYgKCphcmcg
PT0gJz0nKSB7Cj4JaWYgKCFzdHJjbXAoKythcmcsICJodW1hbiIpKQo+CWh1bWFuX3JlYWRhYmxl
ID0gMTsKPgllbHNlCj4JZGllKC4uLik7Cj4JfSBlbHNlIGlmICgqYXJnKSB7Cj4JLyoKPgkqIEFy
Z3VhYmx5IHNob3VsZCBnb3RvIGEgbGFiZWwgdG8gY29udGludWUgY2hhaW4gb2YgaWZzPwo+CSog
RG9lc24ndCBtYXR0ZXIgdW5sZXNzIHdlIHRyeSB0byBhZGQgLS1kaXNrLXVzYWdlLWZvbwo+CSog
YWZ0ZXJ3YXJkcwo+CSovCj4JdXNhZ2UocmV2X2xpc3RfdXNhZ2UpOwo+CX0KPglzaG93X2Rpc2tf
dXNhZ2UgPSAxOwo+CWluZm8uZmxhZ3MgfD0gUkVWX0xJU1RfUVVJRVQ7Cj4JY29udGludWU7Cj7C
oCB9ClRoYW5rIHlvdSBhIGxvdCBmb3IgeW91ciB2ZXJ5IG5pY2Ugc3VnZ2VzdGlvbnMuCgo+Cj4t
UGVmZg==

