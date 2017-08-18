Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99907208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbdHRTJ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:09:56 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36760 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdHRTJz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:09:55 -0400
Received: by mail-yw0-f177.google.com with SMTP id u207so64320047ywc.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6FrBUYVZXlXgCMdxenrFamIKZ6SndtJEZ7qummZ0FI4=;
        b=py0aA+zrvBVO40Pd+x7qvF0wlpZwSn6Ay6r/cRCSdw4KTSaHVX49yBwU6HLsqTXsuJ
         4hHokw38uEhWorNvuDsk1AMxGQeMkMKV06bI12frYrL13oEoSoscsNp1Mp24wLWb4zYZ
         sCLm3WrejdM7GM1vFSlzn5usGCdopNbz6lvrw1VIjsQdWBjRI1RfwaKkfFk+MlJcsaA0
         B3c6mhJyFbh2G/mJYBkrurNw+ZkkDMA1nxZHLxpx13Fg7ZMnAksCkD7Uu3lIkQMTVD79
         ZsvhteBL6QZ85p+HZHQXPTMBaQwSJG56NbT3MvxvA4KwYf6n2tiLUaOzRWJ2p8wLGkFu
         JEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6FrBUYVZXlXgCMdxenrFamIKZ6SndtJEZ7qummZ0FI4=;
        b=NcAkhD6jn/zzmSYQFhqn6NjsloJ0DgTBeJ8H0afhul5RkkTgYNjMByPs8x6P7T6xvu
         kMnhyZJwo57bn+OFuvsbUa6AJINd1UGO9AUVKcYV7OqIzmHJCEOaPg4BhDLDNBopXahr
         GVTkSK3oPe5L7Ea4wcnCSVKzTTu0BuGC1a2koqOFIsNlSg2ppJhQ4QUGz1j9TYVNcZ0/
         cj0ZcXGmuv02sUJBM9HAkLRIzUoyHQNR8lBqfNqoaHQYI6CHqL/0law0hD771GWOQE1c
         yFmyLTXix6mrUHsXXfXHuI2n5DG2RS6LOAKpsfoVT3d/gMfMvXrRkriiltWKOPWDEzsL
         zD6A==
X-Gm-Message-State: AHYfb5jWlSDULg+tG3HNFkVnV0jfAlaSYbd0qOqIJIK7hmDp6HB1Sad+
        ufQdotTc/fhb5C8aBEsXboFi21zjir5Z
X-Received: by 10.13.229.3 with SMTP id o3mr8058724ywe.137.1503083394580; Fri,
 18 Aug 2017 12:09:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Fri, 18 Aug 2017 12:09:53 -0700 (PDT)
In-Reply-To: <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com> <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Aug 2017 12:09:53 -0700
Message-ID: <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 9:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if I follow.  Submodules are not trees and one of the
> reasons people may want to separate things into different modules is
> so that they can treat them differently.  If submodules allow you
> a richer set of operations than a tree that is part of a monolithic
> project, is that necessarily a bad thing?

It is not a bad thing on its own, but we have to consider which
additional actions are useful.

Jonathan brought up the following very long term vision:
Eventually the everyday git commands do not treat submodules
any special than trees, even the submodules git directory
may be non existent (everything is absorbed into the superproject);
so it really feels like a monorepo.
When you want to work on a submodule individually, you have to
make a new working tree.
