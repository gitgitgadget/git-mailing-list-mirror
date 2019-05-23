Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964B91F462
	for <e@80x24.org>; Thu, 23 May 2019 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbfEWT3G (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 15:29:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53070 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391843AbfEWT3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 15:29:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so7022534wmm.2
        for <git@vger.kernel.org>; Thu, 23 May 2019 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sUTnG2IXFg1jeDvwslLRGmzMPRjocEZoMn+o8a4J058=;
        b=Nvdyv2ZlPCwgkL2pzCiGs52eZUCHdZFaLd7qH2/quyoTF/L3aTCnkxKeHdTBcTQn4r
         B1uZSyE4+NdNcZ6UIW9TRo8IHZaY87Tg53z147gmtyP7y9Utitp8Ut3IdfG8W7TzxFwM
         ttL62ETQ7yXo0xpJEekb47IcCS6PM+jLH6nCeh5uRROJbtRorAWgCdTemaedm3a8dG/1
         j//Twr5Gcyxc0M6AYKcjJ4/szbaVYpj8NqPFPTp6TjGOXxH5NfKyJOSQmkQI1CATxsEh
         rXVGXPCy7vJVxBH3R41m0ldki91104tVa/hul1rINxqTbBd3fWZtoz7d82szceg1YvFB
         9X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=sUTnG2IXFg1jeDvwslLRGmzMPRjocEZoMn+o8a4J058=;
        b=JkrVFXMMkHKntEijWIZPcE64LNruZll/SS9+Apv5kh8IWN+5mJcRKI9ZmBpgBqmgGe
         /unsD+VlyTg2rJXjqSzI3qZCnJLj923n/AVSKxLIrMQ87a0RhfNIqKfCrKe/I31BzIdB
         Ikpz5YA0I9vri7RTA0JdriMF2oRmQsD2J8VUnpMp3WodkWvk6Daxb0pKVpydDak3jjNY
         AeKc0Zm6y8d16pV23y26mslkBvZOAsgy2Nv3SA2Ffa5ITOSDF2G+yoVOODh5CLzR7B84
         NcITFfBIYhMY1iVQlMKMmd06dMZlpDGAWWmleN37FDzSu5Bt0KEduaehuWeyo5AcLwJr
         2jEw==
X-Gm-Message-State: APjAAAXuKMLVO2ijTr7udPBZlwE+ohYKleyawkf4Dih8bO0vfnLjn45K
        ey8zG4eQirv/vPF2aYdBn5m0X3KeKsw=
X-Google-Smtp-Source: APXvYqwl8inxfSo6MKl3Wkc3RTla83xq2fX3ynsoQJw4v3xZ4u2dgKnlUdMFtxnUmIx65/oq8bFoVQ==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr13699301wmi.15.1558639743644;
        Thu, 23 May 2019 12:29:03 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn89.neoplus.adsl.tpnet.pl. [83.21.181.89])
        by smtp.gmail.com with ESMTPSA id a14sm298626wrv.3.2019.05.23.12.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:29:02 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
        <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
Date:   Thu, 23 May 2019 21:29:02 +0200
In-Reply-To: <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com> (Derrick
        Stolee's message of "Wed, 22 May 2019 14:59:33 -0400")
Message-ID: <86blztq8ap.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/22/2019 2:49 PM, Karl Ostmo wrote:

>> After producing the file ".git/objects/info/commit-graph" with the
>> command "git commit-graph write", is there a way to answer queries
>> like "git merge-base --is-ancestor" without having a .git directory?
>> E.g. is there a library that will operate on the "commit-graph" file
>> all by itself?
>
> You could certainly build such a tool, assuming your merge-base parameter=
s are
> full-length commit ids. If you try to start at ref names, you'll need the=
 .git
> directory.
>
> I would not expect such a tool to ever exist in the Git codebase. Instead=
, you
> would need a new project, say "graph-analyzer --graph=3D<path> --is-ances=
tor <id1> <id2>"

It would be nice if such tool could convert commit-graph into other
commonly used augmented graph storage formats, like GEXF (Graph Exchange
XML Format), GraphML, GML (Graph Modelling Language), Pajek format or
Graphviz .dot format.

Wishfully thinking,
--
Jakub Nar=C4=99bski
