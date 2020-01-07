Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B2C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65867206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ET+vMISJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAGMT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:19:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:60275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgAGMT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578399563;
        bh=WEty2HZCCTLmWb3O6V0WnSnJZpt7XlQ9+1zCvGrvU08=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ET+vMISJvC61cyWNGhjO4J17nSMQUmKWNJJRdT9qY5qjXv5idz7bLLS3WL60CDhQY
         A0IorLa0wIm3jU0+4h4e44qSWGAKCI0CCsv4DYJJ1Zyt1F/Yhg+tIji/o4xPH5FdZE
         g71EfQWDgODZG0PkO7RHqit5vPINsBwmomeLKQ78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1jRvkT362w-00oEcK; Tue, 07
 Jan 2020 13:19:23 +0100
Date:   Tue, 7 Jan 2020 13:19:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Liam Huang via GitGitGadget <gitgitgadget@gmail.com>,
        Liam Huang <liamhuang0205@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Update imap-send.c, fix incompatibilities with
 OpenSSL 1.1.x
In-Reply-To: <pull.516.git.1578391376.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet>
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ArGNYMFnx9g1bXYhCjaMmugiyq4ZUG0KpzmVEzFnJi39la6SO+D
 XzodpsRIntOIG3Vq3Vp7miqkG0aJodbanIbmobJsF6k6b8nWJeiWFowKS85IZZeLD69N5YG
 OGRxuvTrPe805k3qINGHPbac0OOw2IZUvgYO/JNYpTkpWCZc8FNlgDvN+ChAG0tEAtOUC5P
 csl9fNPphtlb2wg1a1XTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WqlB7fpCvns=:IyFUquSfTND3BSSujVE2Wl
 ZGyq7K9HW/CqXiXUgXb681NVL9YRW4OSvFAI6ec2W/nHcRhmL45/qFO5pBFnmhnYIOnXtVFeJ
 9Nz+Vi5D+xeGlKs1gztwHRuTITDuNkCoggLqa16AGJwa8zhLV2izaGPsj+ZKmfnaJ+5471opr
 ypLkLHa3ynWuXiiJWR8uoNd4ngkvW8dXLd22YXVnynZLzWLLC01jrDvYsTOmhYNgvC0frf4Dx
 V7zWCjpu4EatyWqWh7ifXR9kvJ2m2+fFDrPnX1vyav0V2qF9zrjby61cV5jr1OwkpB5aSAgPw
 ggOOG+eEUOGsO5vugR5Ss7vGXoH0ug518uz7/e3wej7eKVmwm69Ko9UM7nrUTWBY5HlBTeq0T
 JCKlMu/VWnBozYsE/jL3aZl9S04avmu2QdpmrUB93lHtyXkZCNY2XbKz96XCGNnI91EPPcQpc
 JeXVywH9GFvXvTEmNFJxW3q4LnExM3AZAwwtq6CAPWb97Teospp+/hD3TbT+v6SBcz8rINzwB
 db08kpj1mQAHuFNDsORiFyA++6+1K2L5aV7psRdhb3R0nc08hQxW8C+1vj+mbU3gYBnB4CgYI
 2nyhmntHocu804gE30DZmc4HrGiFf4VZgF7lCclm+L2E2ACqrdxc375pVpNwMKL6BfkCOTGRF
 J6nC6w3LrnVRw+Kv/fPkQ04tUsRZfoUo8F7i7B36li+ZNx6XaubVYSIJV1TxC5BvF+lh0v6Um
 e6yyeMQrox7vpxl+7RPFxkruZ0o+UQkhWfou9pMufiSXAGnOkoh7xCbM5B7qiX88a4bZgAmFW
 qBUd04yYrnrYg8JxZv5caVVElQdznNIxeYCHnVY4EefFa47COEpDIwep4A0tWoT0EIyVL0q8W
 e9BfWVgjQqpzhlSr+WapxxPAw1yBW+lS7YI0ZPvkS4CSOK4ZKrxii8C1rVDFr7pLY6Pq9WWLF
 sAJlcE33O+RV1ETSp+tmAGTjiZB2YKX1AaU2AUBxQ5tdq2BWoZEopgRAQn5L+JflXKf0BvgnR
 n4c7NpUEg4Oo68fWb7lHEyIyaNKQzEiTXjbzYh0Gd/l3KT44D3c/2buRXU/DDe5PjFZEAJQv8
 yj80Mcq2oa0rhhZDa0RuA/CX04p+3Grug6I40gqI9hGCWY/Cn/GqKXxyrZm3BXpgf/Ay+b2B1
 aiBAS6sYA1tcef9jZeRffQPKGh/SvwYE2BxmQIRjLwJyWzoUlB02xOKra/igJtPRS6WrxTSle
 ZJ+YWWgYPspMHNSz6gn0svkV3+O40kTHzySRg73H1kdXE0V/qY+RLHIDR0dY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 7 Jan 2020, Liam Huang via GitGitGadget wrote:

> Some APIs have been changed since OpenSSL 1.1.0, so fix incompatibilities
> with OpenSSL 1.1.x.

In your PR, the "Checks" tab shows that this breaks the build for all
non-32-bit Linux builds and for Windows. Here is an excerpt of the failed
`linux-clang` build:

-- snip --
[...]
imap-send.c:253:43: error: incompatible pointer types passing 'struct stack_st_GENERAL_NAME *' to parameter of type 'const OPENSSL_STACK *' (aka 'const struct stack_st *') [-Werror,-Wincompatible-pointer-types]
                int num_subj_alt_names = OPENSSL_sk_num(subj_alt_names);
                                                        ^~~~~~~~~~~~~~
/usr/include/openssl/stack.h:23:41: note: passing argument to parameter here
int OPENSSL_sk_num(const OPENSSL_STACK *);
                                        ^
imap-send.c:260:51: error: incompatible pointer types passing 'struct stack_st_GENERAL_NAME *' to parameter of type 'const OPENSSL_STACK *' (aka 'const struct stack_st *') [-Werror,-Wincompatible-pointer-types]
                        GENERAL_NAME *subj_alt_name = OPENSSL_sk_value(subj_alt_names, i);
                                                                       ^~~~~~~~~~~~~~
/usr/include/openssl/stack.h:24:45: note: passing argument to parameter here
void *OPENSSL_sk_value(const OPENSSL_STACK *, int);
                                            ^
imap-send.c:270:23: error: incompatible pointer types passing 'struct stack_st_GENERAL_NAME *' to parameter of type 'OPENSSL_STACK *' (aka 'struct stack_st *') [-Werror,-Wincompatible-pointer-types]
                OPENSSL_sk_pop_free(subj_alt_names, GENERAL_NAME_free);
                                    ^~~~~~~~~~~~~~
/usr/include/openssl/stack.h:33:41: note: passing argument to parameter 'st' here
void OPENSSL_sk_pop_free(OPENSSL_STACK *st, void (*func) (void *));
                                        ^
imap-send.c:270:39: error: incompatible pointer types passing 'void (GENERAL_NAME *)' (aka 'void (struct GENERAL_NAME_st *)') to parameter of type 'void (*)(void *)' [-Werror,-Wincompatible-pointer-types]
                OPENSSL_sk_pop_free(subj_alt_names, GENERAL_NAME_free);
                                                    ^~~~~~~~~~~~~~~~~
/usr/include/openssl/stack.h:33:52: note: passing argument to parameter 'func' here
void OPENSSL_sk_pop_free(OPENSSL_STACK *st, void (*func) (void *));
                                                   ^
4 errors generated.
Makefile:2382: recipe for target 'imap-send.o' failed
-- snap --

For the full build logs, please have a look at
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=25858&view=logs&j=8f20da19-31b7-5cef-4813-95b8788bd086&t=56027f08-fde3-50ad-0c9a-5ec7df432ed0

Could you fix those compile errors, please?

While at it, please also fix your author email: it should match your
_real_ email address, i.e. "liamhuang0205@gmail.com", not
"Liam0205@users.noreply.github.com".

Thank you,
Johannes
