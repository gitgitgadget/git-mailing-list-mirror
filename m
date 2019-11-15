Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDDD1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 20:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKOUhm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 15:37:42 -0500
Received: from mout.web.de ([212.227.15.4]:33003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKOUhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 15:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573850260;
        bh=R6Mby58X+zgjuux2z9p8rpPHC/v8QqrEgn1ixUzy3ig=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jiDLEVQLQVvLE27DAJuWiyApqhkCtWUwqvvQUV5ID7IqynBwd55+ThvhbdLPQNjBp
         0Y5aRiGbn1+h32hdp1bbTI6WHau4UvoRSqxWAa1U97Tlm5bAUyPCY4as5lBui0ZL27
         yiglHDMrAPHqu4QhQm47crOWaScS/x27f/mi6XJE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.93.34]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRRay-1iKoHL3vlw-00ScCw; Fri, 15
 Nov 2019 21:37:40 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
Date:   Fri, 15 Nov 2019 21:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ALoB3TYnPIhPm6Bzil51n3ssv6thfsogU3KeqdYIjmsoBZKWYpD
 CfKPfytpWkYeLPRdgJ3l6umf6cRSpS/Ulwe2gJFa/DDgjSALmKRw1GVuj39/nqnSfW9fUoh
 dw2qnMkBwUbTZT7KRBZEEliAiz04ZTQmT/csc8VJY0QnayIZuj9SUanIK8cS3aKsjvcf0iR
 GNj7lFtypgm3T40SS9GdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GswPEPX7K4=:vuGHwrSPcIB3TtA7QOjJSE
 oH3vWdcszBFcT09Gb9ooqNgc4VSxC4dPtonNDDjjYnrU7TkpFzVmcu+is+ueqEHjtkyoTbvsd
 MrlBy5qIH9gh+xnBZTuOIQKKxpfBLFrUkaz5D+pLgndDGmWMUHIO7Wqiy8mqyfaTcDsp+XF8n
 PcfCTKL84//+oMkwRbFUaK3f0M2ZrXi7xX9OvEzn30rzWhr9qDN5fzA8NHTJ6siPNsY5eW70N
 DLRS1eSeCjql0oKKyb4XnPEhEZrFGBrZ+MlsxKVHQkv26Ne32ZBdU6Z9sQml7/WXbcyy4+L4x
 c66q6cOni9NMx+KQinc3I9skZ16KsEbxp/tZv/7Dcz+1QoWVC4bJcM9BDx25QDmVYv8J7qJ7l
 H/DAUFFALGoRZONbp+BGX1djykdp1dwRhwkJQ+lVYeUayiWvL0tmlZ10KVX/1MmUI0xzmjyJg
 Hbs4CE6qf1ZSCcX+yT3zoxmwYXW4/UktXHS2gppiGeq5xDko/7CFGFbAE2nydQxWMMSyRZRDu
 iN6GlmCRUH5ij17X01zSTZrSuchkmoXA8Ier4vxCwMp0EswvkUqEipSDVtFzZYGzidepBJt+z
 17poAZxw18wUfrE1RtitJSMwDavyie8v4HQPjQtNk7JSirnr3Tcq7BCVgzCXHoPILHI4xiLiO
 rZZ7J/eMs/kIodm443ANg+4tUwaVCj1JQK9+ODNoWI+MmiocmJ9WCBbqXHMWMprtgyjyrblL5
 7oKWUE+SyBhGGmAjlAy6F9x3Qx9zCT9QeKiyyPTt3hXIFZsADOHucWxJdqwTazREu8bibMUm9
 7/kZkgEf/AhKYjEawcul7PMgSntDtGapch3nd5tR9cMi+IprBM2lzw51ZvwIxJXCePTYl0xHE
 ecSxgIBLOAiT9O4zcWZRNmcbFCZ/vNKDvTOVfZpwJjmytJtE9imTIWQGV4D5B68+h0X/+1Afi
 WoQUzPn1p7CNhkqUod8UbfaLl3ObFZHo0ACBPW1WvTGjT/2I8ztbLN6wN4yLTeSW//4Zi2btX
 4gHfpG6PdxznLkSm7QVnBkFQF4vuY+IrMWaBlwtxChtuEukF1qkPjedr6FHixN19OIJ46U5qX
 gOaQ/kpzWAb4i3GP6xp/s1Y/gE3XdKFEfVi7T9ttGtI7HfQY1Q3k82jyBXImnmzuMRaPA8q5n
 xSJQYd21zvHQR/z3R+H9BTKqP3JdRjtucI0zE/c9D+rWn6lEGDHh31nLYI0iUWgFlpYuJ/GPM
 lOxtE2j73xdnmjU0Al1tQcKgwYbyxBl1XgxLkyqwIvkOE+u7j1sG2AQM8Xcs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This eliminates duplication in the semantic patch, which is good.

Thanks that you think in such a direction.


> It messes up the indentation of n in some of the cases in 921d49be86 ("use
> COPY_ARRAY for copying arrays", 2019-06-15), though.  Hmm, but that can
> be cured by duplicating the comma:

I have picked up further improvement possibilities for this SmPL script.
Would you like to integrate any of these changes?


@@
expression dst, src, n, E;
@@
 memcpy(dst, src, sizeof(
+                        *(
                           E
-                           [...]
+                         )
                         ) * n
       )

@@
type T;
T *ptr;
T[] arr;
expression E, n;
@@
 memcpy(
(       ptr, E, sizeof(
-                      *(ptr)
+                      T
                      ) * n
|       arr, E, sizeof(
-                      *(arr)
+                      T
                      ) * n
|       E, ptr, sizeof(
-                      *(ptr)
+                      T
                      ) * n
|       E, arr, sizeof(
-                      *(arr)
+                      T
                      ) * n
)
       )

@@
type T;
T* dst_ptr, src_ptr;
T[] dst_arr, src_arr;
expression n, x;
@@
-memcpy
+COPY_ARRAY
       (
(       dst_ptr
|       dst_arr
)
       ,
(       src_ptr
|       src_arr
)
-      , (n) * \( sizeof(T) \| sizeof(*(x)) \)
+      , n
       )

@@
type T;
T* dst, src, ptr;
expression n;
@@
(
-memmove
+MOVE_ARRAY
        (dst, src
-                , (n) * \( sizeof(* \( dst \| src \) ) \| sizeof(T) \)
+                , n
        )
|
-ptr = xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
+ALLOC_ARRAY(ptr, n)
);


Now I observe that the placement of space characters can be a coding style
concern at four places for adjusted lines by the generated patch.
Would you like to clarify remaining issues for pretty-printing
in such use cases?

Regards,
Markus
