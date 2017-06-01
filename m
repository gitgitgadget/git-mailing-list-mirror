Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2420720D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdFAXOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:14:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35551 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFAXOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:14:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so9504506pfd.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8nw61ebbDo8pmKHDyHcvkpZ9Q9yS6C7k6WlxCyl4Gd4=;
        b=LiLncb5omzjBOmsdLyro4g0W2yLXl/r4NmCUbWtxj22y7NfNYmDmMdARscfkng2fzt
         cWqiurSZfyHRsiCdMZlcxSMHBm+exc17IuOXgS1CRBNrOlzwgsnOR8srU9E7J+fcWpHS
         5rCyGz1LzX1Hc576+bN62lNaaCYKdD0DBEQoec/eyUhReC2kgBFWDaBTa9aVMJWcIK3J
         g1YlSy/0H3BobHHLhgip4NGNkdkins+ej91CKv0qa2SNnUmolo+V8Mc5U4XFVqCFY1Un
         XtD/OpUSX3O+h0N7I6aPAIAjyKgfjh0a5xrp6gQ91G+59121HI9v7dKiYMZLQk7aZPeO
         N3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8nw61ebbDo8pmKHDyHcvkpZ9Q9yS6C7k6WlxCyl4Gd4=;
        b=aqwWtjjFrRI0ZMXCJVh3InZmaxr7NEjNTYuMVhTuYGGpDK1Z42O0/heNZ1DiaAReNl
         fpFyo2iDf8lA/FzCTrOA4Yju/BciHVPa9GGE3l0rd/HjDcslU3cWk2/Mma19gZjYHR/y
         O4WuRqD3Jk0qiixKfndBTsjTrbHPOIyEk6OfKJ81JFgvKyoM9hEeaNs8d57QXTQBZjpz
         a04QtFNFX8/ed5FEARE3u8t1MPeVMw56uZgckY7lnln7MOfCk87kLWsVCx1RHSw5WB93
         U2ZU8HgqinT0OrtBVyHWGeMyCtcSZE5KhI89DWlHcFHqVF/FeO2Glh0kZu8cHheV20IL
         Ge/w==
X-Gm-Message-State: AODbwcAdX3OVA1j9rtVlsFGdiZ+DhYXw9jY5gWGJgfIwTr6Dwy6yaFNw
        OR5Pnr8ffzbn4Bdwn3WvZg==
X-Received: by 10.84.232.206 with SMTP id x14mr674456plm.7.1496358871959;
        Thu, 01 Jun 2017 16:14:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id h123sm32639428pgc.36.2017.06.01.16.14.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:14:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: git-send-email no longer works outside a repository?
References: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
Date:   Fri, 02 Jun 2017 08:14:30 +0900
In-Reply-To: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
        (Jacob Keller's message of "Thu, 1 Jun 2017 15:45:04 -0700")
Message-ID: <xmqqo9u747xl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I often use git-send-email in order to send patch files. Recently when
> I tried to do this outside a repository I got some cryptic failures,
> I'm using the master branch, git version 2.13.0.311.g0339965c70d6
>
> I generate the patch files and copy them into a separate folder
> outside of the repository, and make sure everything looks good and
> write a cover letter, then I try to send them with
>
> $git send-email --to=<address> 00*
> Can't call method "repo_path" on an undefined value at
> /home/jekeller/libexec/git-core/git-send-email line 1759.
>
> Even weirder, if I move into the repository and try to send files
> which are outside, such as:
>
> $git send-email --to=iwl<address> ../patches/00*
> fatal: /home/jekeller/git/patches/00*:
> '/home/jekeller/git/patches/00*' is outside repository
> format-patch -o /tmp/AZatqXB1uD /home/jekeller/git/patches/00*:
> command returned error: 128
>
> I would expect that if you're outside a repository the command (as
> before) would alllow you to send files. It shouldn't strictly need to
> be inside a repository to function.
>
> I found this first on pu, but as above, I checked out master and still
> seem to have the problem.
>
> I'm working on a bisect now.

This certainly is not an intended change.  That validate-hook thing
must be made optional and conditional to the existence of a
repository.

Thanks for reporting.
