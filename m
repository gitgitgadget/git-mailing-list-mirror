Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4540420373
	for <e@80x24.org>; Mon, 13 Mar 2017 23:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbdCMXB1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 19:01:27 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36486 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdCMXBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 19:01:25 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so54800618pge.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Me5ar3CtosI74n74ekVQLw788x7vomtJYRZCXAB7WiU=;
        b=qZayfHJvbWA+eJUUexkSxUUFBPtiEysuvxkAwNWv1oUpzpgl2AnSpgx0Y2UidlEBFj
         7tOodDQ0CoryOs+Fi3Rn/i5+HFc8+jFe9Ue7kWD0FNfCOB4K+cyrI96WN+xXqjT80tve
         U9mz2BAXx0vKd22efwOvVbxbSSBN23w5QYMLKVsAJN0nb03LkxgRPN3WUAMlxMiiJI1E
         fUARUneibrCrc0374rJd7CPw6lH6IYAHsGHYQjNAjJf3lwbLm+NPyHi81/OfAb02xS3x
         +bZX3xZhFKE6tW6fjqhO86OjtW2uj4d+5HX24vIvAmy1VU/HwfVG+KyDFLJwPpfOSFSP
         cz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Me5ar3CtosI74n74ekVQLw788x7vomtJYRZCXAB7WiU=;
        b=Rux54Ngn1RQYlydssEzXuYdBFs9FkRKrgTU3oU5HTeuc00lmLKkhXzn5cqa4a9Bixg
         sxRyhkfzB+1DOZi4ui4iiOmS/aPgggY3bvSN5rhOoA9OIYf7UboIGVDySXplJH5fYOy8
         tEWrBgBfJO2ZhRazZr1N3FRLFFeU2VbhFys30WfYqTQlDaGDq21FPihEIrLRMeMuFQo0
         aI8qwjDiwX0EdrJfkZzLldN5F+c1A4Jt7hBnRcxSSoBPDH574hncgC/GMN+QszXOq2zI
         L49TmOFruN4RHHLiJ9866TZzpYl7bSzsIefZE7rZhGxYRYWowZmbcjK3omntp5Drcint
         WtNA==
X-Gm-Message-State: AMke39mk08kuHgmlXmeQQ27WQKLWduSPpG0ZydV1kjQEi744rVWsOMiz/l0+42/lHIHrzXHlrx3ftqC5lymKipZx
X-Received: by 10.99.134.199 with SMTP id x190mr39123878pgd.194.1489446084437;
 Mon, 13 Mar 2017 16:01:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 16:01:24 -0700 (PDT)
In-Reply-To: <xmqq37egn6fs.fsf@gitster.mtv.corp.google.com>
References: <xmqq37egn6fs.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 16:01:24 -0700
Message-ID: <CAGZ79kaXnHhKA=XumfxHFUbuEs3AGz2h65Jf8ufcOWqp3Mu20g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2017, #05; Mon, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/rev-parse-show-superproject-root (2017-03-08) 1 commit
>  - rev-parse: add --show-superproject-working-tree
>
>  From a working tree of a repository, a new option of "rev-parse"
>  lets you ask if the repository is used as a submodule of another
>  project, and where the root level of the working tree of that
>  project (i.e. your superproject) is.
>
>  Almost there, but documentation needs a bit more work.

Care to clarify what parts of docs you mean?
https://public-inbox.org/git/xmqqr327z5rn.fsf@gitster.mtv.corp.google.com/
sounded like the topic is done.
