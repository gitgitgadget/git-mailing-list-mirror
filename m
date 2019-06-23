Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2EA11F4B6
	for <e@80x24.org>; Sun, 23 Jun 2019 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFWOyy (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 10:54:54 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45297 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWOyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 10:54:54 -0400
Received: by mail-ed1-f54.google.com with SMTP id a14so17439428edv.12
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ysz3B+vCl2NP2jh4MucS12BGTEtQAuprKRE97rnPLTY=;
        b=Tl+TYnt+Nae6fkYuF+YBe4RNgLRElpRpd5b0ccyleGEhczDvEa+a+tgj+3HELAynH1
         QxgcSlmFzNmrDqqSbuPqIdyAptXtfTriYE4o/dP01jfOP0nde3gcwRMD2KqsA45I/s/2
         elnZZDuxHApmxjNG2ZsL+ft0pU9laYugr4X+K5ftiSd5O4i3Yefqdt9SAyLkCaLzme3f
         VAi9N4N6iYWxJQJ6arC7QnByQIdiqvkgOfUexxEXaIwOKH3GIXH4hOUxwhw5Nouvx25I
         5IVEsWtfWEW5NME/6lzQzl6WD9hR5Gygs9MLTvsvkGRX+juSnWrFqZgqK46D3Tu7UDNi
         S3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ysz3B+vCl2NP2jh4MucS12BGTEtQAuprKRE97rnPLTY=;
        b=iNawCqGomL2jQKgBNiD1wVdcZ/CrAK72LSgVEKQVT2Mp39T/XUwB4g0MjeOp5WsnAg
         5ppV7HuKmAQHPEqd95O4AeL/g4O9//G8o1s6SKUm8yNPHsIBhGvLQfN8myjLHowmJ+TC
         wtNRTHUFfkDtwoMQZzGjPGajx3A+TqgCKAzGXPK1zmyci3AOxgJsA9YDf9+KHXtrBrfA
         GrkI1FEUXDrMBwty954mLd2OPu/G627D0r7PU/NEkiqu9Cr6CiKvNxOfaFJSkJNAnN5N
         N1Cjn3lRBq/Hc/BG9sq6Rp7dNKp8h6niZ6KfLpcYlKPf3fcPETQ58TXrZydj1LuLoVLr
         58Dw==
X-Gm-Message-State: APjAAAX+DaOlnViciUhiIn85GWPQTBhsTHmkNAb8mppUwALVA/qHnD0y
        fOMoeCankK8qqUzWk/idiL8=
X-Google-Smtp-Source: APXvYqwVTh6QJbzf4HSs4ns9lwzaz6A/7CGSIyrp29zIFBuvb5zzLQKTa3+Mtrx69q/qzEAvxqlWIQ==
X-Received: by 2002:a17:906:1ed4:: with SMTP id m20mr57852792ejj.154.1561301692107;
        Sun, 23 Jun 2019 07:54:52 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id x55sm2886452edm.11.2019.06.23.07.54.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 07:54:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Janos Farkas <chexum@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: 2.22.0 repack -a duplicating pack contents
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
Date:   Sun, 23 Jun 2019 16:54:50 +0200
Message-ID: <875zow8i85.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 23 2019, Janos Farkas wrote:

> I'm using .keep files to... well.. keep packs to avoid some CPU time
> spent on repacking huge packs and make the process somewhat more
> incremental.
>
> Something changed with 22.2.0.  Now .bitmap files are also created,
> and no simple repacks re-create the pack data in a completely new
> file, wasting quite some storage:
>
> 02d03::master> find objects/pack/pack* -type f|xargs ls -sht
> 108K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.bitmap
> 524K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.idx
> 4.7M objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.pack
> 108K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.bitmap
> 524K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.idx
> 4.6M objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
> 116K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.bitmap
> 524K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.idx
> 4.6M objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
>    0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
> 108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
> 524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
> 4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> 02d03::master > git repack -af
> Enumerating objects: 19001, done.
> Counting objects: 100% (19001/19001), done.
> Delta compression using up to 2 threads
> Compressing objects: 100% (18952/18952), done.
> Writing objects: 100% (19001/19001), done.
> warning: ignoring extra bitmap file:
> ./objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
> warning: ignoring extra bitmap file:
> ./objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
> warning: ignoring extra bitmap file:
> ./objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> Reusing bitmaps: 104, done.
> Selecting bitmap commits: 2550, done.
> Building bitmaps: 100% (130/130), done.
> Total 19001 (delta 14837), reused 4162 (delta 0)
> 02d03::master > find objects/pack/pack* -type f|xargs ls -sht
> 108K objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.bitmap
> 524K objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.idx
> 4.6M objects/pack/pack-8702a2550b7e29940af8bc62bc6fca011ccbd455.pack   <= ????
> 108K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.bitmap
> 524K objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.idx
> 4.7M objects/pack/pack-879f2c28d15e57d353eb8e0ddbcb540655c844c9.pack
> 108K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.bitmap
> 524K objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.idx
> 4.6M objects/pack/pack-e7a7aebfc6dc6b1431f6f56bb8b2f7e730cc4a0c.pack
> 116K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.bitmap
> 524K objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.idx
> 4.6M objects/pack/pack-994c76cb1999e3b29552677d05e6364e6be2ae5e.pack
>    0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
> 108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
> 524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
> 4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
>
> The ccbd455 pack and its metadata seem quite pointless to be
> containing apparently all the data based on the size.
>
> If I use -ad, a new pack is still created,which, judging by the size,
> is essentially everything again, (but at least the extra packs are
> removed)
>
> 02d03::master> git repack -ad
> Enumerating objects: 19001, done.
> Counting objects: 100% (19001/19001), done.
> Delta compression using up to 2 threads
> Compressing objects: 100% (4114/4114), done.
> Writing objects: 100% (19001/19001), done.
> warning: ignoring extra bitmap file:
> ./objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
> Reusing bitmaps: 104, done.
> Selecting bitmap commits: 2550, done.
> Building bitmaps: 100% (130/130), done.
> Total 19001 (delta 14838), reused 19001 (delta 14838)
> 02d03::master 9060> find objects/pack/pack* -type f|xargs ls -sht
> 116K objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.bitmap
> 524K objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.idx
> 4.6M objects/pack/pack-46ab64716d4220aac8d53b380d90a264d5293d3d.pack   <= ????
>    0 objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.keep
> 108K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.bitmap
> 524K objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.idx
> 4.6M objects/pack/pack-e5b8848e7c1096274dba2430323ccaf5320c6846.pack
>
> Previously, the kept pack would be kept, and no additional packs would
> be created if no new objects were born in the repro.
>
> With the .keep placeholder removed, the duplication does not happen,
> but all the repro is rewritten into a new pack, which does not look
> correct.  Am I doing something unexpected?

I haven't looked at this for more than a couple of minutes (and don't
have more time now), but this is almost certainly due to 36eba0323d
("repack: enable bitmaps by default on bare repos", 2019-03-14). Can you
confirm when you re-run with repack.writeBitmaps=false in the config?

I.e. something in the "yes I want bitmaps" code implies "*.keep"
semantics changing from "keep" to "replace", which is obvious in
retrospect, since we can only have one *.bitmap per-repo.
