Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15AA1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfJFR6C (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 13:58:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33389 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfJFR6C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 13:58:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so6795632pgb.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2019 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mzvpvrh0xjgZ4wAyRR6AHZIgOweCs8/8OBf+75vpEXM=;
        b=vN+QwKKv+zx1iNu39HS/GzEqltxoDVesexH3Cyqb5jHs27CAkChguTYLVgaUaHxCx8
         B/OHpvOF1iQ0Ifk3an3M2GmzkcAAPn/naFVuSZa/hMH2FqHOsRxE0cXIhx5ZKXfQK7tk
         0xqvl1DSGVuaBl4sZDDQzdHjoJGkB5vqZQ0347SZfhGxAUiO8ogxlQYOE1hU/TRobRB3
         U14GsPzBwN+Yw7txZzNCM+ol71r+aHziGfhbudaxLVddH473AxNEmpy6RMjKZOxCYdww
         zNCC1Jfpfpiq6IMFnACdvSp0r5pb9VkTDJGF4DAQjyDn1ioR4aBfTRlPOyiu3IUkxZUd
         aBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mzvpvrh0xjgZ4wAyRR6AHZIgOweCs8/8OBf+75vpEXM=;
        b=mFlQpwgnVCwyQcte1HQlpf1F4o4V9ykdhKVRuCaM4ImfUU+HT46tnUSKwNiPteaOfG
         GaxIjPRSM92Cru954UdphFPhCY1zacURDe/irX+EzIP8TeaZJadsSN7acP5Rt37TqNKb
         H+xz2JUPB2IyxpZANiYDH3fnmN8pfHbpN04naq3M24HiODjMYxA3Ebscv2W1T9yZ6cyP
         p27TPJ23RBzaw4pdk5FIMrME/eBqEV5NJ/FSdut3GeEzSugu7/+inEktnbuwcB2ZMuVO
         524n7nbAQx/dq0Nr5VP0RsjmmLJLk8ySO6ll8giZspt7hLRnJaQh6GkHKPjyrxyICysV
         lxVw==
X-Gm-Message-State: APjAAAXWdsiKW8RakEA3cohislD5Czw7XsEpXtkuNm5vm5hTyax9/1FB
        Tr7f0DNhbq3FSpq1qMEUCvM=
X-Google-Smtp-Source: APXvYqx9FK66LAf/rg6Gc3vgWEJ5J4IJHEo6ztL1VvtJHJJunmlkHZuqRVw5jiXos4sXdh/2SmeN5w==
X-Received: by 2002:a62:196:: with SMTP id 144mr7732576pfb.5.1570384680547;
        Sun, 06 Oct 2019 10:58:00 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id f185sm16161707pfb.183.2019.10.06.10.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 10:57:59 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood@dunelm.org.uk, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [PATCH v4 1/6] rebase -i: add --ignore-whitespace flag
Date:   Sun,  6 Oct 2019 23:27:13 +0530
Message-Id: <20191006175713.17164-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <9e311cef-1f9d-4146-c2a7-c8179cdcdaf1@gmail.com>
References: <9e311cef-1f9d-4146-c2a7-c8179cdcdaf1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Fri, 4 Oct 2019 10:29:36 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> [...]
> --rebase-merges now supports --strategy_option so we should fix this.

Yes, now that it supports --strategy_options I'll remove it from
here.

> [...]


Thanks
Rohit

