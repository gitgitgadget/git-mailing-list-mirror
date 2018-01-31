Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7ECE1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 17:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeAaR24 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 12:28:56 -0500
Received: from mout.web.de ([212.227.15.14]:57480 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753121AbeAaR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 12:28:52 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDjw6-1eXWfo411S-00H7Qp; Wed, 31
 Jan 2018 18:28:39 +0100
Date:   Wed, 31 Jan 2018 18:28:37 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for
 working-tree-encoding
Message-ID: <20180131172837.GA32723@tor.lan>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
 <20180129201911.9484-1-tboegi@web.de>
 <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
 <20180130144002.GA30211@tor.lan>
 <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:Zbrif2WBLRpFvjrCzDsBsxXBHeR0iCF1YXWL4wwZHymH1++C1Ri
 tNXByT7wXN6PEIhuUtUAPeDDRmBxQCv+8k4SHzpe3z8Pw1o1qg4DPYPij6kL16mejNs+eeN
 NpcmU50ZicKRZhBxUEG7YgprICxCSkKwY88eHez/cLGXINfszJfBJ8PKkQL40ZwZ6F6rUW8
 xYRtCq/11aqlB+BYIwjDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8tJVXre7+CE=:JlnS3eqPZcqvQs9F6W4eKl
 BggStR4Gj+3lvcmVyo2aZ4jyhVgNo4lJFW82lVnCQ57eUEl1HlY/Ogsmtt/e7QaWZGa8ywLh2
 21k3vrhnGFGBifhn4FJdZ/pzuaRQdWPqxfq9V2z666NBpnaPDeAraRlpxBU98fiWVCeOQVk7u
 hJKP/vJKdUbmNyhTk4I8jkE0eAMXTVPCfKnuW7PoX2HJfGBzGJhoorBAzcIB1Bc3URSzEQppP
 1LVeYfJc+pEAjeHXpfCMvtHap6HwQ2qZI8ovxtUgchBl0uOvhlvivpw64ZN3BCqrM28EXp/4e
 Rd7u+Fv0CErkdsrvPTlEKVjV92lMFif8pZvJugLmDS491UP7cx2t2bn98kq25SNN1SXIf0Dbh
 ANxiN88Y6tRIto6B26OlBSjGjR+VFrNor9tG4abUCivZO2d3/BFk4Xy6WAQONF0z0mQoj4K9o
 HQ1qHkScx4hDPhKVc40IXeXdmV9puAEb9a+ECOyp/yTgoUExIRjLJgHqQHTwD2R4HpCCcZGiv
 gejOmXCGenbg5atcUT+7FGucye7JcjI8iBT/9IpJ3N7cDcy/KX/T+XSxWMSceCTNW0ASpGB4R
 eLsgSf2wVt2SiCuMDF7yADcUCDQ53pdheO/3neE4ZEyOs/hw8jwTp3x8Dpk6H1+I62iG/LyUg
 76bcA6HOr+Cx3Cnjn2CUoT7IyDCwcwmvWFRU/9CtWs/hPaG3sT6jDlk6Kq05gMpcbFNMQFN6u
 0E96s37BZJnFtVo5BNAdM9Bq84IA5bbdh+1jMTaepcvuEBDcfbPGw247lBftzGJjFWyKzb81W
 OfiuBwXpCCQ5ucTu12657Q6VTossA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
> > That is a good one.
> > If you ever plan a re-roll (I don't at the moment) the *.proj extemsion
> > make much more sense in Documentation/gitattributes that *.tx
> > There no text files encoded in UTF-16 wich are called xxx.txt, but those
> > are non-ideal examples. *.proj makes good sense as an example.
> 
> OK, I'll do that. Would that fix the problem which this patch tries to address for you?
> (I would also explicitly add a paragraph to discuss line endings)

Please let me see the patch first, before I can have a comment.

But back to the more general question:

How should Git handle the line endings of UTF-16 files in the woring-tree,
which are UTF-8 in the index?


There are 2 opposite opionions/user expectations here:

a) They are binary in the working tree, so git should leave the line endings
   as is. (Unless specified otherwise in the .attributes file)
b) They are text files in the index. Git will convert line endings
   if core.autocrlf is true (or the .gitattributes file specifies "-text")

My feeling is that both arguments are valid, so let's ask for opinions
and thoughts of others.
Erik, Junio, Johannes, Johannes, Jeff, Ramsay, everybody:
What do yo think ?
