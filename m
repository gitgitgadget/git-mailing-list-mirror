Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED4D20A27
	for <e@80x24.org>; Mon, 18 Sep 2017 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbdIRUHC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 16:07:02 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50053 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdIRUHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 16:07:01 -0400
Received: by mail-wm0-f45.google.com with SMTP id e71so5779276wmg.4
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x2qMi2huhgu7WalKacuOSzOJCIyxRL1AsN2P1fDcN5M=;
        b=PBiN72+vKc3gxWptglVyDeADGo+lILARqQSN0mn4TWAKrZLQS/fgpSBvY00ezOlZ7S
         uUuV0zQ3sFbBePlXaGBJeljJSwD76gAhGVLhYxsJ31dZPS4v1mq+VNJHJhuLNTSPw4l2
         Lall3K78u63da1cB1tnve0krCF63jiIznL9tcB5cZ0az+OMf0e3fU7WA3U1kK7banYk+
         zCN3Y0jX9I92WWv+nd7clVbTPxsMQyQGAZtuhK9naTh9Am1bn+1vWqy+RybP9x1GXeV1
         nFn9t7KtU0TxTsEomKit656iyUHVoRIoRXqbxY8fy8Wm764nxUWalWHuhLsLieUq130l
         iOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x2qMi2huhgu7WalKacuOSzOJCIyxRL1AsN2P1fDcN5M=;
        b=U4GfbaM9jKIgdrHYgKFOgzZWJWxALjSV9TklI9iIdxRJnlRkvYoKXvX5xbAhJjEuNp
         Wb0Xg+sWmo4Yu9WL04oiI/ut4DHPLiGFFw61Wz2gUytSPekgLELosbkyBcxUvxuDdcLq
         NEwqWz3zjsb57wrIRs0D/ZoRoAbx8H98YQgmUs9bqpnlaCkDYCD2qH2aeTMazRstRNII
         8hmsom/TRKna11KbNPMZkepdRiEteeDN0kt15wKsJM0Yy/jp5ogu+Y/lx9r8VhdUV3B1
         t292/8cw7kdZbYkcAaA+WXvYIk6d67FDqXiJm6v/B4TZ0EMkmAEAfqgyEVXXj2ky1tFv
         pMcA==
X-Gm-Message-State: AHPjjUgH/5rm2t4lvQ+lo8d1PKhpB2wuJO4IX3IdzakgitMIQ+hXRZ2G
        e4jmvpiL9753Wm3bSKCB0s4jotAa4AhM5AodO6vTgQ==
X-Google-Smtp-Source: AOwi7QDs8Jd3T0PRx1RnjUNWIHn4PWcvtBiZ2pUupmgyyIEGUmKFG6677pHoP4UJLfxZxtjlauRnr/AxJ2U+LOQmr04=
X-Received: by 10.28.129.23 with SMTP id c23mr10811224wmd.27.1505765219785;
 Mon, 18 Sep 2017 13:06:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 18 Sep 2017 13:06:59 -0700 (PDT)
In-Reply-To: <20170918195840.GG144331@google.com>
References: <20170913215448.84674-1-bmwill@google.com> <20170913215448.84674-3-bmwill@google.com>
 <CAGZ79kaeWsWdhoC7VDy-YkL1wVWqaQ9=TQUti9HfwjbT2poQdw@mail.gmail.com>
 <20170918170207.GF144331@google.com> <CAGZ79kYQGguodnaiNfT_vWWDQdDdXwZmTi7JnqOmz+Po+FL1+Q@mail.gmail.com>
 <20170918195840.GG144331@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Sep 2017 13:06:59 -0700
Message-ID: <CAGZ79kZ1odSp5O+uF_-ZXZfD4M2r=pZD1LADQ9Thfgki1b7nYw@mail.gmail.com>
Subject: Re: [PATCH 2/8] protocol: introduce protocol extention mechanisms
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> instead compared to the proposed configuration above.
>> (Even better yet, then people could play around with "v1 only"
>> and see how it falls apart on old servers)
>
> Except we can't start with an explicit whitelist because we must
> fallback to v0 if v1 isn't supported otherwise we would break people.
>
> That is unless we have the semantics of: If not configured v0 will be
> used, otherwise only use the configured protocol versions.
>

Good point.

Thinking about this, how about:

  If not configured, we do as we want. (i.e. Git has full control over
  it's decision making process, which for now is "favor v0 over v1 as
  we are experimenting with v1". This strategy may change in the future
  to "prefer highest version number that both client and server can speak".)

  If it is configured, "use highest configured number from the given set".

?
