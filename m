Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E33208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 10:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdHQKiX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 06:38:23 -0400
Received: from mout.web.de ([212.227.15.14]:53063 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdHQKiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 06:38:21 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXpqx-1e3Lis04QR-00Wiru; Thu, 17
 Aug 2017 12:38:05 +0200
Date:   Thu, 17 Aug 2017 12:38:04 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
Message-ID: <20170817103804.GA18336@tor.lan>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
 <20170813183026.GC31079@mail.zuhause>
 <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
 <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
 <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
 <20170816202238.GA3008@mail.zuhause>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816202238.GA3008@mail.zuhause>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:ktjNi+lzAsUO/XJQ5mpmuZoOHwP0kKn+xsvl/o1ZkSP/A32f6Ny
 KrQB4fATG37ZT/+5PW6g+PoY37OOZ9I04xo5CnQmVMMclDBVKeX3weMP3kVNbe1nDQNEMt2
 LZ3Ana59GmcwlswlpR4jsX2KBib8PbSMMlfbzUTHc52xoE0KeJQNTfnmh597UjpbybDVc/s
 wW1di2qdQ9v7qiMF3EP/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hZ5JDFbD8tI=:3gqIWwTegU8xCF748Q1VJO
 G8HIZZloDGFPUTe70egvA4LX1u3k38VKPDWK0pCYUhKcXP1AMgQjgqYtQqEIt0tZ3tQdTItFc
 XNM53pNAiOlyAS65wVEZ4ia8wPEAtOn0WpkL/VzbkhBv/xEMtPIjneW9Agon69El0IcrCQBX6
 c/lKtAnVMKrsgycvfK/JXJfB2ERieMucGyDsAIUmNVR8wdmtgOXHlQN1qxakKNQ7vA9QUYoui
 fKJr+hO6HHWa/Y+jV9h8tocrT5qUBtk3DMWjOnDHaygPHrBKZf2HTofqcP9RSJjhcRN/yph4e
 PXdaCr2Fs9aY9un7jNTTKWSBjljw6sxKymDUTFVhoN+h1IVg3+bcTWtyQ3tW2hi7lTeh1M6pE
 kU9VvIcTwxVxDipaJOMWNFQb0W/XGuqRmcvnTlUsXa29IxcN0QQ6BkPuVPoQMy5yE9J7wpVqU
 NHUrpoP32XCnW72sGpytRbuZpSkF1PR6qhGKrJCoNwMmVq34vfgazqBtDpt+YEA8vGHbc5029
 uVtjRnCSJ8uSoxOUePfacJwBlWdmhhEAek7lAsoaiielFXmxk+hEzqV5BvhvBHd6NS7NbD56K
 dgx2K5wcLUu1Vob0BpRd/NJkud+oO9F2vr/ALbbZTTneLOZgtY0pR9kphcMYPfrk+F1hvLRCN
 m9sWoYZFasnwBo3vwW6TxlMAIwuaZ7aInRHqOdDT76KodQ3dhQy0LyVw0I4xh6W5snN9pcKWd
 J0+knkK0uzefbM+Yyn2uGzrV0zvOpu3O1LDLk/AUVY+rbSNqnSfE1O5TXyynod4hUR0h8xLPc
 VpaPjJ1akFJqqVoyFj/anXAOkhbow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 10:22:39PM +0200, Martin Koegler wrote:
> On Mon, Aug 14, 2017 at 10:08:05AM -0700, Junio C Hamano wrote:
> >    It may help reducing the maintenance if we introduced obj_size_t
> >    that is defined to be size_t for now, so that we can later swap
> >    it to ofs_t or some larger type when we know we do need to
> >    support objects whose size cannot be expressed in size_t, but I
> >    do not offhand know what the pros-and-cons with such an approach
> >    would look like.
> 
> Where should the use of obj_size_t end and the use of size_t start? 
> 
> We often determine a object size and then pass it to malloc. 
> We would start with a larger datatyp and then truncate for memory allocation, which use size_t.

The truncation is done with xsize_t:
The "old" sha1_file.c has something like this:
    idx_size = xsize_t(st.st_size);

I personally don't think that obj_size_t gives us so much.
There are "objects" which are "on disk", and they may have a length off_t,
And there are "objects" loaded into memory, and they have a length size_t.
And everybody can check that we use the right type.
Additionally I don't like it very much, when object size in memory is counted
in a 64 bit value (and this will happen if  obj_size_ = off_t == 64bit)

Anyhow, to answer your question:
All calles xmalloc() must be prepared like this:

p = xmalloc(xsize_t(size_of_object));

That should do the trick.

> 
> Regards,
> Martin
