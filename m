Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D341FF32
	for <e@80x24.org>; Thu, 19 Oct 2017 09:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdJSJej (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 05:34:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44748 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdJSJdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 05:33:40 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20171019093339epoutp02b15c19acc508b227fac57ac63ca7f7be~u7usz7fnP0744407444epoutp02F;
        Thu, 19 Oct 2017 09:33:39 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171019093338epcas1p2ffa52be7f7711f8d3989495338e1443c~u7usb3SrE2606526065epcas1p26;
        Thu, 19 Oct 2017 09:33:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.03.04439.27178E95; Thu, 19 Oct 2017 18:33:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171019093338epcas1p1ee5a0fb32991500373aa449af670e81e~u7usKHcPP1125811258epcas1p1P;
        Thu, 19 Oct 2017 09:33:38 +0000 (GMT)
X-AuditID: b6c32a35-8adff70000001157-13-59e87172079b
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.62.06995.27178E95; Thu, 19 Oct 2017 18:33:38 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OY2009PBD7UVT60@mmp1.samsung.com>; Thu, 19 Oct 2017 18:33:38 +0900 (KST)
Subject: Re: [PATCH] commit: check result of resolve_ref_unsafe
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, l.s.r@web.de,
        avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <62255b66-67be-e6cf-92e9-bed92c6b2899@samsung.com>
Date:   Thu, 19 Oct 2017 12:33:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <20171019024919.ram3bzabt5fra2lc@sigill.intra.peff.net>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ1pZ6hULxXlCIkkNRpsFGniMhplCSTOgw9GTRSN4igjELbS
        AUJ9UBQxWECwING6ABKC7AlUVpdI3UOBIpBAVYIhbFo3oiBxSzua9O275/z/PflPDk0oW6S+
        dFxSKq9L4hJUMjnZYlkXuEGXMhUZVP1IzdRPvJYwhoFcCZOZP0AwzfYRxJzr7ZYw3XcLCObL
        9eckk1vsQMz8+TyCKXnQRoXK2XbTG4qdyL+HWFv/avbTg0EZe8lcg9jZplWsfaKF3EMdku+I
        5hPi0nndxuBj8tjy4RdIm0tlPPxoozJRv9SAPGjAm8Dyro8wIDmtxG0ISox5MvExh6C+2ogM
        iHapam6GOw1K3IngezUrakYR3Lf9IpyNZTgEvnaUSZzsjcOgz/yYdIoI/ATB51t21zgZDoTe
        hULKyUuxGl7N33KZFTgY5hrqXXUSr4HnC6Uu/XJ8EJ5ZqpCo8YL5orekkz1wBNwZeO/yEng7
        TPzOlorsA09Hh5HI/tBc5yDEmFkUXM1iRY6AhvZBmcjLYOaZmRJD+kH/k51i+Qxk54y7FgE4
        B8GsqZISGyFgNrTKxP+XwMdveVLRq4CcC0pRwoKtbujf2DCoPWuVistqlcDCUJasEPmb3OKY
        3CKY3CKY3CKUIbIGreC1QmIML2i0mkCBSxTSkmICTyQnNiHXNak3t6Hint1dCNNI5algiycj
        lVIuXdAndiGgCZW3InnPVKRSEc3pT/G65ChdWgIvdCE/mlT5KJY3Dh1U4hgulY/neS2v+9+V
        0B6+mWhL5uK+9QXHixfVxuvPzPQ0VE1fOVo6ab7DbmCte3/ePlwX69UYUPdH3qy3Nvb476vo
        vFyh/XGgqyHbhy9du82SEmDW1OjtVdbglUGdjpD90RGVNy6OnfQUjNNY87JoPC3qdJyH+kjG
        LpuufDR4a/gHmgs1ctdwQckWx82RsY52FSnEcho1oRO4v2slEABJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t9jAd2iwheRBg3vpSzWPrvDZNF1pZvJ
        oqH3CrPF5tu3GC2azp9hsjiztZ/Z4uPsEywW3VPeMlr8aOlhtpi2bwe7A5fHzll32T2e9e5h
        9Lh4Sdnj/b6rbB59W1YxenzeJOdx+9k2lgD2KC6blNSczLLUIn27BK6MhTdPMhZ0s1fsf3eR
        vYHxEmsXIweHhICJxKq5zl2MXBxCAjsZJa40NLBCOA8ZJTZ8vM/SxcjJISxgL/Fp1wImEFtE
        wFHiwpYjLCBFzALHGSWW/zjODNXOJHHp/zuwKjYBPYnzvyawg9j8AloSl3/MYwaxeQXsJL6v
        WwsWZxFQlTjxaz4riC0qECHxvPk9K0SNoMSPyffANnMKuEisuPIarJdZwEziy8vDrBC2uMSx
        +zcZIWx5ic1r3jJPYBSchaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iowDAvtVyvODG3uDQv
        XS85P3cTIzCith3W6tvBeH9J/CFGAQ5GJR5ejynPI4VYE8uKK3MPMUpwMCuJ8OYHvIgU4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJg1OqgbHritVm41TRKKvM
        2ytnPXlYI3b7k2vNSmZNPXNl2WUdt+NfnAheWhZ77+eTjTftW1Y9V+PXfDn5EFdu+JWKsvQ5
        V4Vsktat95cVsmk2dGDmnLR3yj9zs79/bghWnnbq2Js/sZb3iPcTG/YtK4ruLnjVd6z93p4p
        r3d99HstM1XV+dWHvSxRK6OUWIozEg21mIuKEwGtgnrgpAIAAA==
X-CMS-MailID: 20171019093338epcas1p1ee5a0fb32991500373aa449af670e81e
X-Msg-Generator: CA
X-Sender-IP: 182.195.42.142
X-Local-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIb?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG0xlYWRpbmcgRW5naW5lZXI=?=
X-Global-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIbU2Ft?=
        =?UTF-8?B?c3VuZyBFbGVjdHJvbmljcxtMZWFkaW5nIEVuZ2luZWVy?=
X-Sender-Code: =?UTF-8?B?QzEwG0NJU0hRG0MxMEdEMDFHRDAxMDE1Nw==?=
CMS-TYPE: 101P
X-CMS-RootMailID: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
X-RootMTR: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
        <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
        <20171018183453.lr67zw455bkdmrlz@sigill.intra.peff.net>
        <xmqqo9p4j7eu.fsf@gitster.mtv.corp.google.com>
        <20171019024919.ram3bzabt5fra2lc@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I also think it's a good idea to record the destination of the updated
symref. But for now the most simple solution is just to catch the
unreadable HEAD error.
Maybe for the future improvement it would be nice to redesign
print_summary passing some ref_transaction results to it.

19.10.2017 05:49, Jeff King wrote:
> TBH, I think the "most right" thing would be to actually capture the ref
> that HEAD points to when we actually make the commit, remember it, and
> then report it here (the whole function of this code is just to say "I
> made a commit on branch X"). But I don't know how much trouble it is
> worth going to for that. It's buried behind a ref_transaction, and I
> don't think builtin/commit.c ever sees the real name (though maybe it
> would be a good feature of the transaction to record the destinations of
> any symrefs we updated).

-- 
Best regards,
Andrey Okoshkin
