Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE96C43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiGDQqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiGDQou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 12:44:50 -0400
X-Greylist: delayed 147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 09:44:18 PDT
Received: from thsbbfxrt01p.thalesgroup.com (thsbbfxrt01p.thalesgroup.com [192.54.144.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD2634E
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 09:44:18 -0700 (PDT)
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 4LcBR10C7Mz45Tl
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
        s=xrt20181201; t=1656952909;
        bh=D+HWwtQssANckirJg+8PEIJ4BSIEfDUFna5ZiGxgT7U=;
        h=From:To:Subject:Date:Message-ID:Content-Transfer-Encoding:
         MIME-Version:From;
        b=HAXT+2TAmDRMT/NFyKkrg1Bxic/TtdzAv4NJxQlyH1AKZMRppYDenX+pRXc3Xs1SL
         niWiZM2NBTDefBOMFL9RXuWf/UMI53tKKOUJSuLZCQ6Lwo7kEga4qLxY8qcRv6Pr1W
         1GPWPxaUp7XyzhRbtnS1U/2syL9hm+aqxq+8IIse4KkmxwUDy7Ok/sTZkEr48h/QBi
         9JHbXStxXAT3Jny0JwXaA60eZwW1RawQo/vZwNVJ0f/bS0VOx98q40ydY/LcUkp+9+
         bgpaHLm0ICG4xUVJtc9fQm2KeYLowfqVkecKIR9bgHwiE/Oo5Q4S7r7+bYrtd6bAlk
         JJnJQzdwg3vlQ==
From:   ALEPINS Etienne <Etienne.ALEPINS@thalesgroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: sparse-checkout --no-cone deprecation {TGO}
Thread-Topic: sparse-checkout --no-cone deprecation {TGO}
Thread-Index: AdiPxPLMhZdu99L0SmOc/nq6KBIANA==
Date:   Mon, 4 Jul 2022 16:39:37 +0000
Message-ID: <9817efb01cf644e19d53ad89712093fc@thalesgroup.com>
Accept-Language: fr-CA, en-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-janusnet-msgid: 19CA50361E67452E8B815E00175CA25B
x-janusnet-threadid: 384D95DC061640129C0938F0F043E7E9
x-janusnet-classifier: Janusseal for Outlook 3.6.7
x-protective-marking: VER=2021.0, NS=2022.1.thalesgroup.com, SEC=D04FB6C2,
 ORIGIN=Etienne.ALEPINS@thalesgroup.com
x-janusnet-pm-uuid: v=2022.1;g=8B588949-9E88-505D-8F6C-559DBF8054DE
x-janusnet-pm-origin: Etienne.ALEPINS@thalesgroup.com
x-janusnet-pm-time: 2022-07-04T16:41:45Z
x-janusnet-dialogconfirmed: True
x-janusnet-pmconfirmed: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Q2xhc3NpZmljYXRpb246IE9QRU4ge1RHT30NCkhpLA0KDQpHaXQgMi4zNy4wIHNwYXJzZS1jaGVj
a291dCBkb2N1bWVudGF0aW9uIHNheXMgdGhlIG5vbi1jb25lIG1vZGUgd2lsbCBiZSBkZXByZWNh
dGVkLiBJIHRoaW5rIHRoaXMgaXMgYSBiYWQgaWRlYTogSSBkb24ndCBzZWUgb3RoZXIgbWVhbnMg
dGhhbiB0aGUgbm9uLWNvbmUgbW9kZSB0byBvbmx5IGtlZXAgc29tZSBvZiB0aGUgZmlsZXMgaW5z
aWRlIGEgZGlyZWN0b3J5LiBUaGUgY29uZSBtb2RlIGFsbG93cyB0byBzZWxlY3QvaGlkZSB3aG9s
ZSBkaXJlY3RvcmllcyB3aXRob3V0IGdpdmluZyBjb250cm9sIHRvIHNlbGVjdC9oaWRlIHNwZWNp
ZmljIGZpbGVzIGluc2lkZSBzZWxlY3RlZCBkaXJlY3Rvcmllcy4gSSB1bmRlcnN0YW5kIC0tbm8t
Y29uZSBtb2RlIG1heSBkaXNhYmxlIG90aGVyIGZlYXR1cmVzIChlLmcuIHNwYXJzZSBpbmRleCks
IGJ1dCB0aGF0IGlzIG9rIHdpdGggbWUuDQpJIGhhdmUgcGVvcGxlIGluIG15IHRlYW0gY29taW5n
IGZyb20gU1ZOIHdoaWNoIG9mZmVyZWQgdGhlIG9wdGlvbiB0byBpbmNsdWRlIG9ubHkgc29tZSBm
aWxlcyBvZiBhIHJlcG8uIEdpdCBzdWJtb2R1bGUgKyBzcGFyc2UtY2hlY2tvdXQgLS1uby1jb25l
IGlzIGEgbmVhciBlcXVpdmFsZW50IHRoYXQgc2hvdWxkIGJlIGtlcHQgYXZhaWxhYmxlLiBNeSBn
b2FsIGlzIHRoYXQgb24gZGlzaywgdGhlIHN1Ym1vZHVsZSBjb250YWlucyBvbmx5IHNvbWUgb2Yg
aXRzIGZpbGVzLg0KDQpUaGFua3MsDQpFdGllbm5lDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQoNCkFWSVMgSU1QT1JUQU5UIDogQ2UgY291cnJpZWwgZXN0IHN0cmljdGVtZW50
IHLDqXNlcnbDqSDDoCBsJ3VzYWdlIGRlIGxhIChkZXMpIHBlcnNvbm5lKHMpIMOgIHF1aSBpbCBl
c3QgYWRyZXNzw6kuIENlIGNvdXJyaWVsIHBldXQgY29udGVuaXIgZGUgbCdpbmZvcm1hdGlvbiBj
b25maWRlbnRpZWxsZS4gQXVzc2ksIHRvdXRlIGRpdnVsZ2F0aW9uLCBkaXN0cmlidXRpb24sIGNv
cGllLCBvdSBhdXRyZSB1dGlsaXNhdGlvbiBkZSBjZSBjb3VycmllbCBwYXIgdW5lIGF1dHJlIHBl
cnNvbm5lIHF1ZSBzb24gZGVzdGluYXRhaXJlIGVzdCBzdHJpY3RlbWVudCBwcm9oaWLDqWUuIFNp
IHZvdXMgbuKAmcOqdGVzIHBhcyBsZSBkZXN0aW5hdGFpcmUgb3UgdW4gZW1wbG95w6kgb3UgdW4g
YWdlbnQgcmVzcG9uc2FibGUgZGUgcmVtZXR0cmUgY2UgbWVzc2FnZSDDoCBzb24gZGVzdGluYXRh
aXJlLCB2ZXVpbGxleiBzJ2lsIHZvdXMgcGxhw650IGNvbW11bmlxdWVyIGltbcOpZGlhdGVtZW50
IGF2ZWMgbCdleHDDqWRpdGV1ciBldCBkw6l0cnVpcmUgY2UgY291cnJpZWwgYWluc2kgcXVlIHRv
dXRlIGNvcGllIHF1ZSB2b3VzIHBvdXJyaWV6IGTDqXRlbmlyLiBBVFRFTlRJT04gOiBMZXMgY291
cnJpZWxzIG5lIHNvbnQgcGFzIHPDqWN1cml0YWlyZXMgc+KAmWlscyBuZSBzb250IHBhcyBjcnlw
dMOpcyBkZSBmYcOnb24gYXBwcm9wcmnDqWUuIElsIGVzdCBwb3NzaWJsZSBxdWUgZGVzIGNvdXJy
aWVscyBzb2llbnQgaW50ZXJjZXB0w6lzIG91IGFmZmVjdMOpcyBwYXIgdW4gdmlydXMuIEJpZW4g
cXXigJl1bmUgc3VydmVpbGxhbmNlIGFudGl2aXJ1cyBzb2l0IGVmZmVjdHXDqWUgw6AgbOKAmcOp
Z2FyZCBkZSB0b3VzIG5vcyBjb3VycmllbHMsIG5vdXMgbuKAmWFjY2VwdG9ucyBhdWN1bmUgcmVz
cG9uc2FiaWxpdMOpIHBvdXIgZGVzIHZpcnVzIG91IHRvdXQgYXV0cmUgw6lsw6ltZW50IGRlIGRv
bW1hZ2UgcG91dmFudCDDqnRyZSBpbnRyb2R1aXRzIGF2ZWMgY2UgbWVzc2FnZS4NCg0KV0FSTklO
RyA6IFRoaXMgbWVzc2FnZSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgbmFtZWQgcmVjaXBpZW50
cy4gVGhpcyBtZXNzYWdlIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgY29uZmlkZW50
aWFsLiBBbnkgZGlzc2VtaW5hdGlvbiwgY29weWluZywgb3IgdXNlIG9mIHRoaXMgbWVzc2FnZSBv
ciBpdHMgY29udGVudHMgYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIG5hbWVkIHJlY2lwaWVudCBp
cyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCBhIG5hbWVkIHJlY2lwaWVudCBv
ciBhbiBlbXBsb3llZSBvciBhZ2VudCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcmluZyB0aGlzIG1l
c3NhZ2UgdG8gYSBuYW1lZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSwgYW5kIGltbWVkaWF0ZWx5IGRlc3Ryb3kgdGhpcyBtZXNzYWdlIGFuZCBhbnkgY29w
aWVzIHlvdSBtYXkgaGF2ZS4gV0FSTklORzogRW1haWwgbWF5IG5vdCBiZSBzZWN1cmUgdW5sZXNz
IHByb3Blcmx5IGVuY3J5cHRlZC4gSXQgaXMgcG9zc2libGUgZm9yIGUtbWFpbHMgdG8gYmUgaW50
ZXJjZXB0ZWQgb3IgYWZmZWN0ZWQgYnkgdmlydXNlcy4gV2hpbGUgd2UgbWFpbnRhaW4gdmlydXMg
Y2hlY2tzIG9uIGFsbCBlLW1haWxzLCB3ZSBhY2NlcHQgbm8gbGlhYmlsaXR5IGZvciB2aXJ1c2Vz
IG9yIG90aGVyIG1hdGVyaWFsIGludHJvZHVjZWQgd2l0aCB0aGlzIG1lc3NhZ2UuDQo=
