Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724751F51C
	for <e@80x24.org>; Mon, 21 May 2018 19:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeEUT1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 15:27:07 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:43847 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUT1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 15:27:06 -0400
Received: by mail-yw0-f176.google.com with SMTP id r202-v6so4819017ywg.10
        for <git@vger.kernel.org>; Mon, 21 May 2018 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EtAVEE3yRH/UBmXt6+NEn16aQENCK5T4mVR4kLm1Hb4=;
        b=sztao+yHNNjeGugQEth6q0kwN5FuAFV6jGwcdViGWaA/EOpqkzplxp/z0qIZ1t8inI
         sWYJ1BKdKuLV3HUqYC1+67qyX6XakjEYVDV61EN/ypAFRzOW7B2+MEIgXspQa4pd3B5E
         1Wjo/vhKOCBazLfrFbrp/4RVHSCLK2SqB8BGoOFDzU6DySvrcVCw3qz9FNC/qTTtim+W
         BXFOscgVLr1rIPhhixs1ZQZKJMxaFpWWNdZwHap+gk4m/5gmwmVIJ9h0EBYgfZkPHxNC
         pegv2tkcrb3QfMP0/8r6pi56jr/w1ukbE33kSD/FxkOEewQf7J8wf0N2MjreBdxf2i7Y
         DehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EtAVEE3yRH/UBmXt6+NEn16aQENCK5T4mVR4kLm1Hb4=;
        b=Z0tt/6FfZU+kfAlRfnK2q+ifTLj1VssmSz5fmpvjntKKB+X0sA49WtZxbYTUqQ4uOg
         1qc9MxGS7s0Ki1uO7ev8X7kNFaJ6dUdIQS6rBjJjoQxtl3lyczrVxu12HDH0C18E/lI6
         P+ybtEWeZP7g9+/sYYjkK/VGksRyPwK+oF/qivkPdCdm1lUSPD5R3XWLKuENEUisfkax
         YlSq7Jtgo43+Gl6MJnMjz8nZTE7seu8ZZAMbrvD9fhm1tzAUTyjRtUU2KIylvsYX2htf
         xV8wXV5zFwXyY6uScTbPS5/ksYb6veLfgFwwV7Hh8BjqeyfIHXx2wkBu3hni14+wgoo0
         yCrQ==
X-Gm-Message-State: ALKqPweyU8Fp4A2MIggWZ+0e+Cgxh0sK6Yba3gorySxvsIgHnX5qJyPu
        oM1BHDG2TMCVM7q28NTB+8wYoETjk4kthQA6M0fZWFxzQk8=
X-Google-Smtp-Source: AB8JxZpPoYWnujPCptnr4HP08H51ILYU0ZvLLos4TtOJAyZwEQZhV15MEw5FhY+Ap1Fyo62FJn6goiOJdTQIQwXQV78=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr10943697ywa.340.1526930825351;
 Mon, 21 May 2018 12:27:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 12:27:04 -0700 (PDT)
In-Reply-To: <20180521185040.GA125693@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com> <20180516222118.233868-3-sbeller@google.com>
 <20180519063729.GA14755@duynguyen.home> <CAGZ79kbxptYvDoTqsVRe3KOA_--ja8UZir=MkMXw8_LxVXG_-Q@mail.gmail.com>
 <20180521185040.GA125693@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 12:27:04 -0700
Message-ID: <CAGZ79kZ0TBzDMqpim1Wtr9QtF2OtskE=nRPx2Nj+rwyT8HMqTw@mail.gmail.com>
Subject: Re: [PATCH 02/11] repository: introduce repo_read_index_or_die
To:     Brandon Williams <bmwill@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Antonio Ospite <ao2@ao2.it>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

>> One of the reviewers of the series questioned the overall goal of the
>> series as we want to move away from _die() in top level code but this
>> series moves more towards it.
>
> I've heard every once in a while that we want to move toward this but I
> don't believe there is an actual effort along those lines just yet.  For
> that to be the case we would need a clearly defined error handling
> methodology (aside from the existing "die"ing behavior), which we don't
> currently have.

We have the example in the refs code, which I would want to
imitate. :)

/*
 * Return 0 if a reference named refname could be created without
 * conflicting with the name of an existing reference. Otherwise,
 * return a negative value and write an explanation to err. [...]
 */

int refs_verify_refname_available(struct ref_store *refs, ...
    struct strbuf *err);

extern int refs_init_db(struct strbuf *err);

But it is true that there is no active effort currently being pushed.

Thanks,
Stefan
