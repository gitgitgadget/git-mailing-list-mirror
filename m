Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BBBC433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 00:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5243B20704
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 00:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eToPVVOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgHPApc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:45:32 -0400
Received: from mout.web.de ([212.227.15.4]:45059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgHPApb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 20:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597538730;
        bh=yeAwSrlxDKEZSthkAihRncfq+nOHmFT5cyUqar2ttwk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eToPVVOBri5hbTerc7ArDdF3r50BTXLaljKXbaIND5Id4HEOzfphKe0L5LuBCLmKe
         o6JaUNzlBxyWNmUXtXKuSl7eBLHgIHPreX7G60iHJCcKBxm1P1xdMepa8RwmkkwFvL
         98JN3M+uJRCSGpPvecocutGf6fPXI0RhRppFjFco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ZZo-1k1MkC1iA0-005VRG; Sat, 15
 Aug 2020 09:14:28 +0200
Subject: Re: What's cooking in git.git (Aug 2020, #03; Thu, 13)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd03u18q3.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6e2d4472-8293-4f10-0ba6-82ae83f7a465@web.de>
Date:   Sat, 15 Aug 2020 09:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqd03u18q3.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k2QayXMLTr3GUPCALJ871/j0oTH4DjIQZxl/Z+IzI8sQo+CoYe7
 LcMo/nBfIrVprQw6n0S7tsglaZHbRfsjyxeQNBZupNri6WhtrQML3mIbBzocCUlGTCbSPO4
 0Qy9DEC748V/uT10Fa7zfbuCl9HcAAL4/659QspGgVAfzxb/Bf7kpf/hyRlOLqbh6faHWOj
 bbWh2LVe7Z6hhKXvOFePQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUGYtvphKHk=:gVtvK7/boxiumaF1tmcPu6
 BeG0j+/FZ93S2BtymT/hJNsU9IqbHN+XrpmjoB8+kQGa6cpL48O9v4Efpa9nXQdc6/eo9UsXu
 yY/0NIoE7Uoo/dHDRZVs4Gj02mFnyqopPjLEApaHKGdt1RhTQXeyjWxKXjN/x40ohM5f7Etff
 gDNQDMY061jFt8sKrkYGV5dH6QfCKXajOd9dgqOilgbuiCowndGUrwHQcfGO76VCra2DvChuH
 6mum7q/Vq/JuyOOjvECqHIGS7Trn2fPF39uRySWn8Cu+YQ/Bq4cS3PkvMBTsC1srNNwZ5YTGE
 OYDZf3aEeJyMA+uC7Pnc4+2J3lpsgXTM4k8MQ5ud2r6C04/EwO4M7XbN9n9Yygs0TH2mCP9dz
 J4lVpgdtug2ESxSz0iEWVAKlJviiFxsngdy1SlZJ9lPNQZJCutJ8mOVL0xKVIhCmEKsnHS7RM
 qKE6HGD3LcyreUtTkQKjXCC9Q+4wlxyhPAC6clNJV3WOez9qZHRoZ+e8ZupkwpENpWEAzwNxe
 qGxrB0gTlbdzfwN7ZWTTzu7WZq9yHBtYqcrj/KNJ52UeR19OzEUL/W9pvVk93aRgBGpduW47E
 312maISt/plMc75FVQ5pwwkWTvxhE2AuS3vc9TGN8JP/fH6ucbplvHNkqj05AI29HPbeX6FJb
 iZszeP7hxJjXtznZOVsI+/tx8JrESex41gk3wYWznyrR1KNFQLBfH39VSLyYlxTz+ovExhWsU
 ieNyyiGmfSRxUadc3hTPYZUwr4upxek60uhBQq7q0aZWHdujoPos1sfFCGbBdbDS0gTk6qwJF
 wcdwGmfO0dnclBgM9b+lYvutb1bSOQ3OFmOSj5ulc5XL97xS9BaGsF4XynIR+pFrSt2f3H54v
 oic23arb4l+X1N7VdoVfr+8BKZOY9jv5WWsp4EL45GHPORHQFq1J4poeecLH6nDLtdsvuBNjO
 iN8SA++4DEa7B7Jxn0gf91W4fY9MaSpzkG1do9KtjIjoOmB6xgjkauN5s9h++U9m0BnUGSACX
 wn98SDichh5R1cJLTIOPxyke77evUoZs4//OKmetzJDW7iQSrg45bKY7OeXfl1DS4d+pjsJgD
 na5Ocydykzy/ABBM61fiVEf5spyzjBddvLo+6yMmK1VTedt47afCBhI8MaUckmrHg/jM5nBif
 5qXYiZCyxHHYxZAejYPinIj/NRAXlI60qOkZR7Tb61FLdD/FxX8vQfTaGSxv0paNsnE27QS6P
 sb9Bh5kMZm0dOOYfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.20 um 00:28 schrieb Junio C Hamano:
> * rs/fast-export-anon-simplify (2020-08-13) 1 commit
>  - fast-export: factor out print_oid()
>
>  Code simplification.
>
>  Will merge to 'next'.

Please drop that one.  I'm not convinced anymore that it takes us in
the right direction.

> * rs/more-buffered-io (2020-08-02) 3 commits
>  - upload-pack: use buffered I/O to talk to rev-list
>  - midx: use buffered I/O to talk to pack-objects
>  - connected: use buffered I/O to talk to rev-list
>
>  Expecting a reroll.

Sent version two as replies to the original patches:

https://public-inbox.org/git/2e3ac6f7-77c2-4792-d6df-891ede6318ce@web.de/
https://public-inbox.org/git/9162c1cb-36fd-3203-ec58-4bd1501938d0@web.de/
https://public-inbox.org/git/cf395005-af63-f698-fe19-6c4b6f1a8a4b@web.de/

Ren=C3=A9
