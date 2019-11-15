Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844121F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKOOUg (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:20:36 -0500
Received: from mout.web.de ([212.227.15.14]:42825 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfKOOUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573827627;
        bh=HtBJXt5/TsniHP44rGk4+AQbyFEiQC2c9FTtZBBTNqA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=iDu/Jj/vAMObhHvmeuGSiel95BcN5qB9EayzVIg4LO0g1w6/97SpL5fspDAFhw7d1
         TxICIkNo4D/ZGh8MEbGMRExYAUCLDJoXrITUel19fjm79iBeHQWpk0m3/2rJQz93en
         6vkI56QgbaI4neiZ7HOVRt/xk0AaZ3LplgP/9J3s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.93.34]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbMg8-1iCz9C3fRk-00IlX3; Fri, 15
 Nov 2019 15:20:26 +0100
Subject: Re: git-coccinelle: adjustments for array.cocci?
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Coccinelle <cocci@systeme.lip6.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d2fe2be3-f68f-d5fb-076b-3c740fe5a29a@web.de>
Date:   Fri, 15 Nov 2019 15:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E1qtbQ2evR3+HIJTNotekPrcJYN7+T/R2LhOrbThPuegfjoFHpP
 Ol3/jrnJ86cRYU+vwSngNI1dY26A6/NCprFM/k2owPSgX7owHOaSF8nd3U5oIh0LtqKW+d3
 PfJzEKMolACfJVKknPyuFjXGU1eWmLnMIJpK6CHICYgGvPyQ87JQgmVCXAC752I2iPliroS
 kLip59P9hI9UBrKiScKAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCS2vGDY9Vs=:2DkdduAXBzntqoz6dOkUzQ
 +3rU9l+Gy7cihwV+tS0IJU79ZSOccTKXMgJ3YsdfMJdDjBVN4Ut1gvIX27y+Duis2yPaUOJKA
 ImhOF2MfOpeQ/zhVWP7PP4/FTdwl3k+xoUygBz+XSrD+fc/yU47kx41i4/pO7J3I1cYPlyW5o
 2dmh0w0KNkc3e5YigTfktdrjUWlhRvJt/VC2ZSO6CJmpxoVXgXvtsXJpgpyqBOPPN22+4fzqg
 9XHjRCYaYZbGcPAGNI1npEpxxe0XDw6h4C/S2TMsy6GvuIltD6NtIV4piwgZUjNeKJ/rfUR3q
 UT/TOPuHiKdTNSYxKEG8w9BM7lOaU+DTDZRm9YLjB0AWiWYJqvBsj/QPAEAX0+gAPtiu8s8ih
 5UWiX9P+KkLpZuxGFZInRU46HpI0ams2CAr08TmoDj0XUtgMzI8B3/p2HdC6wpClhnE59Dpms
 xX6NLs+PbVPfo75yHNHNOCurVGTFKbrNCTWtQ9l1OoworJ7smsAOchkbb0aAr5/vpP2FhnqUw
 Fp7ADrbOqRH6Zx+VbrGO4Y7k5uzYZMZR5imgfcJ8GMaFMhPXj5eXVBUzGhO2PVE+KllM9mrvP
 DAR7zVKNkgF3jA2xrAjleiEe1iS9ghCq1NwjKSRgxSRjPC1NQb3XEVIw+3DLGWCGB9mvcdqhj
 OlGkTwiWZoAQJiZ9MZDoFu7NGtKXiMISxObeAm0VySak2HMGOhCBXutpjXCGmuGu/rLETb/v5
 CyEv8N1ltZz26NGPekLRxkvNNFDCQEgc3FiTU0IcTE1JEvv3Y5h0Q8rS/Yc829CHqQFG4B1o0
 3hMb2hcPXr8TXseLibfpz5LR94fYAI24eWQAhGie1X05kwTtFfWffGq9mUZgNpoazQYiVo2pr
 j6u7REdjVhycFIEIlUh1r2oHWsIwRdtJSEjwOW9T4PkFghUzcUCnm+4M77WjMWgEdfyrU3+9M
 ZL69+BzFX9SzbA2hBFy9XiFvPAuwpFH1TutHLdbOSq/lNo5QOlWs/Z9+iRlZaaEQ0EMa5GENi
 +jeJP85bvbATT4vTWM79Bbx+RbRV1WMe2DNFXlEEIBJittuuAD4aHcFGPiFcA/LMpRqE4HgNZ
 8gE5GbZ5qvygVz7+hQVKoqs3ouiz+WkpRM8aMnpq+Y3SviItDju4uLUN630iaYHmpSDxJw9XN
 AueB59bQa0U2mBSDZwgnD8J/WqbL5xFM34/8aUv0UCIdL+F/ZdsBSAmhkbkgUt4w4lguX68DU
 ko8yW///Uxmu3EiSyqxXYnBoRQ/xPL3GAU8GrgDQsEjRSEu+oONl7smYGo1o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> --- array-released.diff	2019-11-14 21:29:11.020576916 +0100
> +++ array-reduced1.diff	2019-11-14 21:45:58.931956527 +0100
> @@ -6,24 +6,10 @@
>   	r->entry_count =3D t->entry_count;
>   	r->delta_depth =3D t->delta_depth;
>  -	memcpy(r->entries,t->entries,t->entry_count*sizeof(t->entries[0]));
> -+	COPY_ARRAY(r->entries, t->entries, t->entry_count);
> ++	memcpy(r->entries,t->entries,t->entry_count*sizeof(*(t->entries)));
>   	release_tree_content(t);
>   	return r;
>   }

Can another variant for a transformation rule help to clarify unexpected
software behaviour around data processing with the semantic patch language=
?

@@
expression dst, src, n, E;
type T;
T *ptr;
T[] arr;
@@
  memcpy(
(        dst, src, sizeof(
+                         *(
                            E
-                            [...]
+                          )
                          ) * n
|
        ptr, src, sizeof(
-                        *(ptr)
+                        T
                        ) * n
|       arr, src, sizeof(
-                        *(arr)
+                        T
                        ) * n
|       dst, ptr, sizeof(
-                        *(ptr)
+                        T
                        ) * n
|       dst, arr, sizeof(
-                        *(arr)
+                        T
                        ) * n
)
       )


elfring@Sonne:~/Projekte/git/lokal> spatch contrib/coccinelle/array-test3.=
cocci fast-import.c
=E2=80=A6

Regards,
Markus
