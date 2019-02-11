Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06101F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfBKXuf (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:50:35 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:58838 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfBKXuf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:50:35 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D2BFC10C03E0
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549929034; bh=YJHXHZEADjkna5mZnOP8/76WH9B3y9zs+/q1mpT6XAk=;
        h=From:To:Subject:Date:From;
        b=OUfKONEMp6GawkH1Iiz+d9Gkgll1OsMYK+lfGLbAdTvEutqsXQZA7xwdPJCHTB6rN
         xoxJiVzQHNTlfQQ8S2bLEiVqHRt/89L8Q1CBwYnFCjkqA3HSpirNZU+Gv+ZF+1KUK4
         sZlzYokQ/c5B868/xG/QHAgcU4aoRW5MlbEGnvXefyb4AOSZ2nStOGty3E1RUk7KJN
         QpW1Q3JfUcRM6cZWh77tTXkcSqMujxsDoUeULJE1iQg77zyGD/6/ZKWu0EVgx+/U4a
         zejtEh/djjHOqotJD34hJncjfRZRo2Z9qqCUIGoMiCiVUZ0ntKjX3/ErPWvxcQV4CR
         VC5VgRPvPsfwA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C3477A0071
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 23:50:34 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 11
 Feb 2019 15:50:34 -0800
From:   Cameron Gunnin <cameron.gunnin@synopsys.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: BUG: git worktree add directory-path fails due to over-aggressive
 disallowing of worktrees with same suffix
Thread-Topic: git worktree add directory-path fails due to over-aggressive
 disallowing of worktrees with same suffix
Thread-Index: AQHUwmSUNlzPQcNvjk+Ur7NdwUUAvQ==
Date:   Mon, 11 Feb 2019 23:50:34 +0000
Message-ID: <0308570E-AAA3-43B8-A592-F4DA9760DBED@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF42984B1638F94F853D34F5B0842050@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGJ1ZzoNCiAgZ2l0IGluaXQgd29ya3RyZWUtdGVzdC1yZXBvDQogIGdpdCAtLWdpdC1kaXI9
d29ya3RyZWUtdGVzdC1yZXBvLy5naXQgY29tbWl0IC0tYWxsb3ctZW1wdHkgLW0gImZpcnN0IGNv
bW1pdCINCiAgZ2l0IC0tZ2l0LWRpcj13b3JrdHJlZS10ZXN0LXJlcG8vLmdpdCBicmFuY2ggYnJh
bmNoMQ0KICBnaXQgLS1naXQtZGlyPXdvcmt0cmVlLXRlc3QtcmVwby8uZ2l0IGJyYW5jaCBicmFu
Y2gyDQogIG1rZGlyIHVuaXF1ZS1wYXRoLTEgdW5pcXVlLXBhdGgtMg0KICBjZCB1bmlxdWUtcGF0
aC0xDQogIGdpdCAtLWdpdC1kaXI9Li4vd29ya3RyZWUtdGVzdC1yZXBvLy5naXQgd29ya3RyZWUg
YWRkIHN1YmRpciBicmFuY2gxDQogIGNkIC4uL3VuaXF1ZS1wYXRoLTINCiAgZ2l0IC0tZ2l0LWRp
cj0uLi93b3JrdHJlZS10ZXN0LXJlcG8vLmdpdCB3b3JrdHJlZSBhZGQgc3ViZGlyIGJyYW5jaDIN
CiAgIyBGQUlMUyBXSVRIOiBmYXRhbDogJ3N1YmRpcicgaXMgYSBtaXNzaW5nIGJ1dCBhbHJlYWR5
IHJlZ2lzdGVyZWQgd29ya3RyZWU7IHVzZSAnYWRkIC1mJyB0byBvdmVycmlkZSwgb3IgJ3BydW5l
JyBvciAncmVtb3ZlJyB0byBjbGVhcg0KDQpOb3RlOiB0aGUgZm9sbG93aW5nIHdpbGwgc3VjY2Vl
ZCwgaW1wbHlpbmcgdGhhdCBpdCBpcyB0aGUgc3VmZml4IG1hdGNoaW5nIHRoYXQgaXMgZ29pbmcg
YXdyeToNCiAgY2QgLi4NCiAgZ2l0IC0tZ2l0LWRpcj13b3JrdHJlZS10ZXN0LXJlcG8vLmdpdCB3
b3JrdHJlZSBhZGQgdW5pcXVlLXBhdGgtMi9zdWJkaXIgYnJhbmNoMg0KDQpUaGlzIGFwcGVhcnMg
dG8gaGF2ZSBiZWVuIGludHJvZHVjZWQgYnkgdGhlIGZvbGxvd2luZyBjb21taXQ6DQogIGNvbW1p
dCBjYjU2ZjU1YzE2YzEyOGUxODQ0OWM5NDE3ZGMwNDVmNzg3YzFiNjYzDQogIEF1dGhvcjogRXJp
YyBTdW5zaGluZSA8c3Vuc2hpbmVAc3Vuc2hpbmVjby5jb20+DQogIERhdGU6ICAgVHVlIEF1ZyAy
OCAxNzoyMDoyMiAyMDE4IC0wNDAwDQoNCiAgICAgIHdvcmt0cmVlOiBkaXNhbGxvdyBhZGRpbmcg
c2FtZSBwYXRoIG11bHRpcGxlIHRpbWVzDQoNClRoZSBpbnRlbnRpb24gb2YgdGhlIGFib3ZlIGNv
bW1pdCB3YXMgdG8gYXZvaWQgYSBiYWQgY2FzZSB3aGVyZSBhIHdvcmt0cmVlIGF0IGEgZ2l2ZW4g
cGF0aCB3YXMgcmVtb3ZlZCBtYW51YWxseSB0aGVuIHJlLWNyZWF0ZWQgdmlhICdnaXQgd29ya3Ry
ZWUgYWRkJywgbGVhZGluZyB0byB0d28gZW50cmllcyBpbiAnZ2l0IHdvcmt0cmVlIGxpc3QnIGZv
ciB0aGUgc2FtZSBkaXJlY3RvcnkuIEhvd2V2ZXIsIHRoZSBidWcgc2hvd24gaGVyZSBpcyBhIHZh
bGlkIHVzZSBjYXNlLCBhcyB3ZSdyZSB0ZWNobmljYWxseSB1c2luZyB0d28gZGlmZmVyZW50IHBh
dGhzLg0KDQpUaGUgZml4LCBJIHRoaW5rLCBzaG91bGQgYmUgYXBwbGllZCB0byBidWlsdGluL3dv
cmt0cmVlLmMgdG8gdGhlIHZhbGlkYXRlX3dvcmt0cmVlX2FkZCBtZXRob2QuIEFmdGVyIGZpbmRp
bmcgYSB3b3JrdHJlZSB0aGF0IG1hdGNoZXMgdGhlIHN1ZmZpeCAodmlhIGZpbmRfd29ya3RyZWUp
LCBpdCBzaG91bGQgY2hlY2sgdGhhdCB0aGUgYWJzb2x1dGUgcGF0aCBvZiB0aGUgZm91bmQgd29y
a3RyZWUgaXMgdGhlIHNhbWUgYXMgdGhlIGFic29sdXRlIHBhdGggb2YgdGhlIHdvcmt0cmVlIGJl
aW5nIGFkZGVkLCBhbmQgYWxsb3cgdGhlIGFkZCB3aGVuIHRoZXkgYXJlIGRpZmZlcmVudC4gT3Is
IHBlcmhhcHMgdGhlcmUgc2hvdWxkIGJlIGEgd2F5IHRvIGludm9rZSAnZmluZF93b3JrdHJlZScg
c3VjaCB0aGF0IGl0IG9ubHkgZmluZHMgYWJzb2x1dGUgcGF0aCBtYXRjaGVzLg0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgdGltZSwNCi0gQ2FtZXJvbiBHdW5uaW4NCg0K
