Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0ADC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 04:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE28600D4
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 04:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhG1Epq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 00:45:46 -0400
Received: from smtp501.hk.chengmail.me ([113.10.190.210]:39716 "EHLO
        smtp501.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhG1Epp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 00:45:45 -0400
X-CHENGMAILHOST: 113.10.190.210
X-CHENGMAIL-INSTANCEID: 6a01.6100e0e1.38866.0
Date:   Wed, 28 Jul 2021 12:45:21 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "jerry@skydio.com" <jerry@skydio.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: git apply --3way behaves abnormally when the patch contains
        binary changes.
References: <fdfd283aeee311ebbfb50024e87935e7@oschina.cn>, 
        <CAMKO5Cs1HP7JNmJLYKti0kajGmD4XK+Boc3WRV2Dpph5a3b5Xw@mail.gmail.com>, 
        <4eb90a4eef4011ebab68d4ae5272fd1139378@pobox.com>
X-Priority: 3
X-GUID: 97D76123-B745-43DC-B542-32A402FF7765
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021072812442037686463@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <9f510f56ef5e11eb90f70026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGRlZmVjdGl2ZSB0ZXN0IGRlbW8gSSBwcm92aWRlZCBpcyBub3QgdGhhdCBpbXBvcnRhbnQo
Zm9yIG1lKSwgdGhlIHB1cnBvc2Ugb2YgdGhpcyBpcyB0bwpicmluZyBvdXQgb3VyIHRvcGljIHRo
YXQgImdpdCBhcHBseSAtMyIgYmVoYXZlcyBkaWZmZXJlbnRseSBvbiBkaWZmZXJlbnQgR2l0IHZl
cnNpb24gd2hlbgp0aGUgcGF0Y2ggaXMgYmluYXJ5LgpNYXliZSBJIHdvdWxkIHNheSB0aGlzIGJy
ZWFrcyBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCBidXQgdGhlIHBvb3IgdGVzdCBkZW1vIGRpZG4n
dCBwcm92ZSB0aGlzLsKgCklmIGFueW9uZSB3b3VsZCBsaWtlIHRvIHNlZSB0aGUgaW5jb21wYXRp
YmlsaXR5LCBoZSBjYW4gcnVuICJnaXQgYXBwbHkgLS1pbmRleCDCoC0zIGJpbmFyeS5kaWZmIiBp
biBjb21tYW5kIGxpbmUgaW4gZGlmZmVyZW50IEdpdCB2ZXJzaW9uIGVudmlyb25tZW50LgoKPkpl
cnJ5IFpoYW5nIDxqZXJyeUBza3lkaW8uY29tPiB3cml0ZXM6Cj4KPj4+wqDCoMKgwqDCoMKgwqDC
oCAjIDIuIGJhc2VkIG9uIGxlZnRfYmluIGJyYW5jaCwgbWFrZSBhbnkgY2hhbmdlLCBhbmQgY29t
bWl0Cj4+PsKgwqDCoMKgwqDCoMKgwqAgZ2l0IGNoZWNrb3V0IC1iIHJpZ2h0ICYmCj4+PsKgwqDC
oMKgwqDCoMKgwqAgY2F0IGJpbi5wbmcgYmluLnBuZyA+IGJpbi5wbmcgJiYKPj4+wqDCoMKgwqDC
oMKgwqDCoCBnaXQgYWRkIGJpbi5wbmcgJiYKPj4+wqDCoMKgwqDCoMKgwqDCoCBnaXQgY29tbWl0
IC1tICJ1cGRhdGUgYmluYXJ5IGZpbGUiICYmCj4+Pgo+Pj7CoMKgwqDCoMKgwqDCoMKgICMgMy4g
bWFrZSBwYXRjaAo+Pj7CoMKgwqDCoMKgwqDCoMKgIGdpdCBkaWZmIC0tYmluYXJ5IGxlZnQuLnJp
Z2h0ID5iaW4uZGlmZiAmJgo+Pj7CoMKgwqDCoMKgwqDCoMKgICMgYXBwbHkgLS0zd2F5LCBhbmQg
aXQgd2lsbCBmYWlsCj4+PsKgwqDCoMKgwqDCoMKgwqAgdGVzdF9tdXN0X2ZhaWwgZ2l0IGFwcGx5
IC0taW5kZXggLS0zd2F5IGJpbi5kaWZmCj4+PiAnCj4+PiAiCj4+Pgo+Pj4gQnV0wqAgImdpdCBh
cHBseSAtLWluZGV4IC0tM3dheSBiaW4uZGlmZiIgd2lsbCBub3QgZmFpbGwgb24gR2l0IHZlcnNp
b24gMi4zMS4wLgo+PiBBcmUgeW91IHN1cmU/IEkgY2hlY2tlZCBvdXQgdG8gImNvbW1pdAo+PiBh
NTgyOGFlNmI1MjEzN2I5MTNiOTc4ZTE2Y2QyMzM0NDgyZWI0YzFmIChIRUFELCB0YWc6IHYyLjMx
LjApIiBhbmQKPj4gcmVidWlsdCBhbmQgcmFuIHlvdXIgdGVzdCBzbmlwcGV0IGFuZCBpdCBzdGls
bCBmYWlsZWQuCj4KPklzbid0IGl0IGp1c3QgYmVjYXVzZSB0aGUgcmVwcm9kdWN0aW9uIHJlY2lw
ZSBpcyBzaW1wbHkgd3Jvbmc/Cj4KPkl0IHNheXMKPgo+wqDCoMKgICogYmUgb24gbGVmdCBicmFu
Y2ggYW5kIGhhdmUgYSBiaW5hcnkgZmlsZQo+wqDCoMKgICogYmUgb24gcmlnaHQgYnJhbmNoIGFu
ZCBoYXZlIGEgbW9kaWZpZWQgYmluYXJ5IGZpbGUKPsKgwqDCoCAqIGNyZWF0ZSBhIHBhdGNoIHRv
IHRha2UgbGVmdCB0byByaWdodAo+Cj5Ob3RpY2UgdGhhdCB3ZSBoYXZlIGEgcGF0Y2ggYW5kIHdl
IGFyZSBzdGlsbCBvbiB0aGUgcmlnaHQgYnJhbmNoLgo+T2YgY291cnNlLCBhcHBseWluZyB0aGUg
cGF0Y2ggdG8gdGFrZSB1cyBmcm9tIGxlZnQgdG8gcmlnaHQgd291bGQKPmZhaWwgZnJvbSB0aGF0
IHN0YXRlLCBidXQgSSBfdGhpbmtfIHRoZSBpbnRlbnQgb2YgdGhlIHJlcHJvZHVjdGlvbgo+cmVj
aXBlIHdhcywgYWZ0ZXIgYWxsIG9mIHRoZSBhYm92ZSwgZG8gdGhpcyBoZXJlOgo+Cj7CoMKgwqAg
KiBzd2l0Y2ggdG8gbGVmdCBicmFuY2ggYW5kIGF0dGVtcHQgdG8gYXBwbHkgdGhlIHBhdGNoLgo+
Cj5BbmQgdGhlIHBhdGNoIGlzIG1lYW50IHRvIHRha2UgdXMgZnJvbSBsZWZ0IHRvIHJpZ2h0LCBh
bmQgd2UgYXJlIG9uCj5wcmlzdGluZSBsZWZ0LCB0aGUgYXBwbGljYXRpb24gb3VnaHQgdG8gY2xl
YW5seSBzdWNjZWVkLCBubz8KPgo+ImdpdCBhcHBseSBiaW4uZGlmZiIgd291bGQgcHJvYmFibHkg
d29yayBjb3JyZWN0bHkgYnV0IEkgZG8gbm90IGtub3cKPm9mZmhhbmQgd2hhdCB0aGUgY29kZSBh
ZnRlciB5b3VyIGNoYW5nZSBkb2VzIHdpdGggLS0zd2F5IGVuYWJsZWQuCj4KPldlIHJlZnVzZSB0
byBtZXJnZSBiaW5hcnkgZmlsZXMsIHNvIEkgd291bGQgbm90IGJlIHN1cnByaXNlZCBpZiB3ZQo+
ZmFpbGVkIHRoZSAzd2F5IGluIHRoaXMgY2FzZSAoZXZlbiB0aG91Z2ggd2UgX2NvdWxkXyBmYXN0
LWZvcndhcmQsCj5pdCBtYXkgbm90IGJlIHdvcnRoIGNvbXBsaWNhdGluZyB0aGUgLS0zd2F5IGxv
Z2ljLS0tbm9ib2R5IHNhbmUKPndvdWxkIHNheSAtLTN3YXkgd2hlbiBpdCBpcyB1bm5lY2Vzc2Fy
eSkgYnV0IGFmdGVyIDN3YXkgZmFpbHMsIGRvIHdlCj5zdGlsbCBjb3JyZWN0bHkgZmFsbCBiYWNr
IHRvICJzdHJhaWdodCBhcHBsaWNhdGlvbiIgbGlrZSB3ZSBkbyBmb3IKPnRleHQgcGF0Y2hlcyB3
aXRoIHlvdXIgY2hhbmdlP8KgIEJlZm9yZSB5b3VyIGNoYW5nZSwgd2Ugd291bGQgaGF2ZQo+Zmly
c3QgYXR0ZW1wdGVkIHRoZSAic3RyYWlnaHQgYXBwbGljYXRpb24iLCB3aGljaCB3b3VsZCBzdWNj
ZWVkIGFuZAo+d291bGRuJ3QgaGF2ZSBoaXQgIjN3YXkgd2lsbCByZWZ1c2UgdG8gbWVyZ2UgYmlu
YXJpZXMiIGF0IGFsbC4KPgo+U28sIEkgZG8gbm90IHRoaW5rIGl0IGlzIGltcGxhdXNpYmxlIHRo
YXQgd2UgYXJlIHNlZWluZyBhIGxlZ2l0Cj5yZWdyZXNzaW9uIHJlcG9ydC4KPgo+VGhhbmtzLg==

