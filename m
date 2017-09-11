Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388B11FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 17:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdIKRZl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 13:25:41 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35141 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdIKRZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 13:25:40 -0400
Received: by mail-wr0-f172.google.com with SMTP id m18so16069712wrm.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jzw2OlN6EIHXGvbf1HQBxWv3djkvEjYkTSSh1qYiCp4=;
        b=N3TNF76t50h8L3TGx2DF+cHgKqOpUuqZ/EMJ136YDgI/1J3Zz65dtGt3AurSFL/MMM
         fANRyUYyrnx3p2Vu8I6q+askio3xS76iHjc2SsKQIuFYqXOKcbNyZ7JOWx71sTZtLhzS
         OxzdTotzVIcpPDXNqs0Y/Ubuw1yLDGyY8Frd+e6st7HLEx2tKjJ3ScDN85rDXvkv/XYy
         C7MnA9YAzM8oamylq4od7oXB+COM4AAtKV4/Rpp/upW6T0FKAZl9JdtX6XnKmOAl+Lm1
         PR6c4gEBg27qPw1eFfKbt2qdk1tLfG2asrJCRCmtV2+HU3grNtjKTfcXAzFRTpIBAAw4
         t5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jzw2OlN6EIHXGvbf1HQBxWv3djkvEjYkTSSh1qYiCp4=;
        b=JrqbuPYsKdSyvtf1IggAVIupDf/DmKHSC+kYn5bMUo8iqgom1mGPD/2tpFYswKg/1y
         ySqYlL2q3nz1o5lu2AFlM6rIqXPEspagYntCHJq0jbh5HVTivxs2hysdT7YUQDuPQlYm
         swzYfER6A9dMSiPqro7AJzIFnpuem8fVPZaeOMYCeEJ+CIqA+Uyj5xpreKSZEzUI2vVw
         owVN2QAN0yumiXAmE45MDHA/Fk1d0JoQYgsmUbrSQyup4D7IQawxEEwvqmS40FJKdXOF
         eteanwZht7HOGn3hn7DktI1nLZaCm3YwdkMu4mWJHxdNpnvtLQeQnQYe01SVws1/8A9d
         p2Rw==
X-Gm-Message-State: AHPjjUiM8Ifb1sAgfboS5J40j5USEsda+Yq5PRUvccma23CQ1gWA9oxN
        01JsEvZKIVRPNBSuvJVFxrOPS/PvQ0uD
X-Google-Smtp-Source: ADKCNb7a6QldH7+hjl9xGWoRL57bzJAI+hm1srFk4kv7vpS+noJD2U832IzuxfbsBGwdSk0YdQjH6/J5yDofaMUYWKY=
X-Received: by 10.223.150.27 with SMTP id b27mr9165527wra.100.1505150739026;
 Mon, 11 Sep 2017 10:25:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 11 Sep 2017 10:25:38 -0700 (PDT)
In-Reply-To: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
References: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Sep 2017 10:25:38 -0700
Message-ID: <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
Subject: Re: commit-msg hook does not run on merge with --no-ff option
To:     Joseph Dunne <jdunne525@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 7:34 AM, Joseph Dunne <jdunne525@gmail.com> wrote:

> When I merge ... however my commit-msg hook does not run.  (The
> commit-msg hook works fine in all other commits / merges.)

When using git-commit, but not git-merge?

See the discussion of patches at
https://public-inbox.org/git/20170907220429.31312-1-sbeller@google.com/
