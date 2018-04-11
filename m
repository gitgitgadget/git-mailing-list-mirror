Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B22E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 19:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757023AbeDKTcl (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 15:32:41 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:37830 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755371AbeDKTcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 15:32:39 -0400
Received: by mail-lf0-f51.google.com with SMTP id m200-v6so4272030lfm.4
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tB47CsW0/Dzw5nnxYWJIP935gtweM4XbGrfq6/qyyKI=;
        b=T6fj0MqBoDVGFnfjW3aRElJt8i2s7mv1F4E0lfnshYhU8VY8gb4OFG5n9rFP5/ctPG
         Bdt1yu9kbIXra2AA8YQFsVScFtmjcBkrWSR65iJg8sBeoVFwO28eZ2Rv5xOFNN5HWumc
         2qPq5UmswBkiWCnlNHGUvun7KX/B2rKonGei5LmhhSjMOoU7BOuN1h3XlmaGOfZ/dPjn
         O2m6qVst+Y/UoMWqLMdX+vN4aylK177mguUrPR0jg8Ux4jvcWNl1tMyesYNvAqVlMrjO
         OAN459U7fCnuuHk8xtpIAUYHn/rj23catl7WldTLF44+KSbdJWMxOiHMewQn7WbU6xxY
         K8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=tB47CsW0/Dzw5nnxYWJIP935gtweM4XbGrfq6/qyyKI=;
        b=tbRIxL++YVeJO26T1FwHxx3nIlgvsgzxghadjtIrOqnGPRxaidW7w3HggI+0cje8ap
         58A5E0oggyZhJm7ik7BDfmCn3ZPNhM3Eob8z0iZdY2B/guzbSaGGdURqZmgVYq1evETZ
         Q4ZHGz3l13hpzFyr/FVpOMDkW6QbCMVEYpRomskqPF/KlvpFSM2PLAcKECjhIFwb8SkF
         dyfeKcidqXNWe4Wa+V8RQg6VNjj+65iT8ntpzitGIKeLvLJy7ThnV3JaiYfs2VWTsQR5
         R0lqGy3tf2VaZn4401OnQRcJriZsl7S5Tpqr+Tr7eL85aEDY/G8zmbWrGzR2M66Nzp7l
         imsg==
X-Gm-Message-State: ALQs6tCvLx0LTQ+g5tvt3Yq0yu5XICdG4Il/SfTbipkFDH1P5PBbOA50
        sq5vpDCoSOv7nqxlZo0UmTE=
X-Google-Smtp-Source: AIpwx49rxxYeLis3dGT5DqmKQfmYIRAtSqs4J/S4PbuKUXgKb32thiKGDKCOo8ulWoHaWcPCOmjjCA==
X-Received: by 10.46.21.86 with SMTP id 22mr3965709ljv.111.1523475157678;
        Wed, 11 Apr 2018 12:32:37 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrk101.neoplus.adsl.tpnet.pl. [83.8.104.101])
        by smtp.gmail.com with ESMTPSA id d4-v6sm378437lfg.65.2018.04.11.12.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 12:32:36 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <867epjez1n.fsf@gmail.com>
        <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com>
Date:   Wed, 11 Apr 2018 21:32:32 +0200
In-Reply-To: <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com> (Derrick
        Stolee's message of "Sat, 7 Apr 2018 21:06:24 -0400")
Message-ID: <868t9t5yjz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/7/2018 12:55 PM, Jakub Narebski wrote:
>> Currently I am at the stage of reproducing results in FELINE paper:
>> "Reachability Queries in Very Large Graphs: A Fast Refined Online Search
>> Approach" by Ren=C3=AA R. Veloso, Lo=C3=AFc Cerf, Wagner Meira Jr and Mo=
hammed
>> J. Zaki (2014).  This paper is available in the PDF form at
>> https://openproceedings.org/EDBT/2014/paper_166.pdf
>>
>> The Jupyter Notebook (which runs on Google cloud, but can be also run
>> locally) uses Python kernel, NetworkX librabry for graph manipulation,
>> and matplotlib (via NetworkX) for display.
>>
>> Available at:
>> https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
>> https://drive.google.com/file/d/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg/view?u=
sp=3Dsharing
>>
>> I hope that could be of help, or at least interesting
>
> Let me know when you can give numbers (either raw performance or # of
> commits walked) for real-world Git commit graphs. The Linux repo is a
> good example to use for benchmarking, but I also use the Kotlin repo
> sometimes as it has over a million objects and over 250K commits.

As I am curently converting git repository into commit graph, number of
objects doesn't matter.

Though Kotlin is nicely in largish size set, not as large as Linux
kernel which has 750K commits, but mich larger than git.git with 65K
commits.

> Of course, the only important statistic at the end of the day is the
> end-to-end time of a 'git ...' command. Your investigations should
> inform whether it is worth prototyping the feature in the git
> codebase.

What would you suggest as a good test that could imply performance?  The
Google Colab notebook linked to above includes a function to count
number of commits (nodes / vertices in the commit graph) walked,
currently in the worst case scenario.


I have tried finding number of false positives for level (generation
number) filter and for FELINE index, and number of false negatives for
min-post intervals in the spanning tree (for DFS tree) for 10000
randomly selected pairs of commits... but I don't think this is a good
benchmark.

I Linux kernel sources (https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git)
that has 750832 nodes and 811733 edges, and 563747941392 possible
directed pairs, we have for 10000 randomly selected pairs of commits:

  level-filter has    91 =3D  0.91% [all] false positives
  FELINE index has    78 =3D  0.78% [all] false positives
  FELINE index has 1.16667 less false positives than level filter

  min-post spanning-tree intervals has  3641 =3D 36.41% [all] false
  negatives

For git.git repository (https://github.com/git/git.git) that has 52950
nodes and 65887 edges the numbers are slighly more in FELINE index
favor (also out of 10000 random pairs):

  level-filter has   504 =3D  9.11% false positives
  FELINE index has   125 =3D  2.26% false positives
  FELINE index has 4.032 less false positives than level filter

This is for FELINE which does not use level / generatio-numbers filter.

Regards,
--
Jakub Nar=C4=99bski
