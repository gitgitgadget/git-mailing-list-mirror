Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E37207F8
	for <e@80x24.org>; Wed,  3 May 2017 19:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757449AbdECTso (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 15:48:44 -0400
Received: from mout.web.de ([212.227.15.4]:64072 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754402AbdECTsm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 15:48:42 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNP6P-1d8TEX3yHZ-006tIN; Wed, 03
 May 2017 21:48:33 +0200
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
To:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
 <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
 <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
 <CACsJy8CdjLySD+UEKE2NkbYqEoVOQtvydFBui6UbbnFLo8U1Ug@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cddd09e5-8e8a-3dc9-001f-f307d3647619@web.de>
Date:   Wed, 3 May 2017 21:48:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CdjLySD+UEKE2NkbYqEoVOQtvydFBui6UbbnFLo8U1Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rcAPf0tLy1j4z+IWGIBufOwomonCsD4uRz/hZo6A+YJVWH7xWpV
 Pyi3PlXSE79g5KhGiWBJPX3gKVc/Ox/O7Ast3cI3Le7Z+fbumo3Nwy7tLeZC1KuPWq0X6SG
 F+FdeGQLx3CSOgFEJZMtKmN60krSaVRlVCDOT15aej0Tve512/0b1Fx95ud15M2p+7fCZnW
 gyqrxewjvy0rP4isDvjDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qdwOBZV/AJo=:1ulS8tTM5PRmbtBFlaAAqO
 +2X8eAkRxNPzT+5v5F3jgrY1juiPeFqJs2kRNTfQCJGEvE8OD3GvCFeYc1Gf+uq+TLm5UGfeE
 lOErxKypgUrSLOwOv7lyvTaKIy1e4slBH1PfeHHjyDB87yprjJ9eY6pSkR9zdoKmycNP2Mlb7
 xhij3Sk91Ltp7y5qj67eB7n4obJT47gz3mLWPND6haxCKVi8OQwAEBTuqVAFXZjeagQWHYtde
 HU/zETOalBzVXwOI3JkR/xm20ftcVvNABTLMdbJffBmhjf4r+/A9vYL9jR46mkhJ4gLc8g/Zt
 A/c8ZrtO4WAqORzzfiyvXjguxYplL/IlcZrPk8fd76OFOBHF9y8hgb0RvPF1lR+SMIavhJEcd
 eDzBfqnHU9SXNLWzC0ZAKkUNG/vgM20h9q1psxl8bLK6XttHH4UbLZqFK35DIJWC+PYjqjOS9
 Xo/v8LA0nKRMEIb9caThdNBYVbZumGgo8EbpVfEdnfnRUxHv4SgpY5WRrNSI5MfwNL8w0WF4I
 h+OlbK7eMlauTFLylgcZ4q7EZqtZVtFOUtK/fL3E4H4cNNOp9ZldZocfdqgb4qUe6FWXsB7nT
 3xWeDOnSTVY0rb6J62vqmJ2MqcLi4fjTIm7S6bw3ZWvXpZP5XlxOyJ27P9j4PSkBl9SYIGEwO
 HhHrBG6nnkQ0HvpXxOZJzaMJ1OoOS0XNlqBduEDbW22eFrOnvlm39/DaJ88tqZUrpdVR2JzaW
 RuTlxjkbAZhHuYAku7FCcd1ZP8Tjx5xilnucZepC7fXBEo+lzd4+7vd2Lay4DcvwIJ6v4d5fj
 s2UKaoi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.05.2017 um 11:46 schrieb Duy Nguyen:
> On Tue, May 2, 2017 at 2:22 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, May 01, 2017 at 01:23:28PM +0200, René Scharfe wrote:
>>>
>>> I can only get gcc and clang to call memcpy instead of inlining it by
>>> specifying -fno-builtin.  Do you use that option?  If yes, why?  (Just
>>> curious.)
>>
>> I do my normal edit-compile cycles with -O0 because it's fast, and
>> because it makes debugging much easier.
> 
> Same here. My CFLAGS (without lots of -Wstuff)
> 
> CFLAGS =  -g -O0 -fstack-protector
> 
> Maybe it's -fstack-protector then? This is gcc 4.9.3. I think Gentoo
> does not add any distro-specific patches on this particular version.

gcc 4.9.2 on Debian i386 still inlines memcpy for me with these options.

https://packages.debian.org/jessie/gcc-4.9 links to a 5MB diff, and it
adds these lines to NEWS.gcc (plus changing a whole lot of other files,
of course):

+ - Better inlining of memcpy and memset that is aware of value ranges
+   and produces shorter alignment prologues.

That might be it.

René
