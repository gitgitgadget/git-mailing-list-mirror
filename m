Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444FF20756
	for <e@80x24.org>; Fri,  6 Jan 2017 10:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761151AbdAFKHO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 05:07:14 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33364 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761190AbdAFKGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 05:06:31 -0500
Received: by mail-io0-f182.google.com with SMTP id v96so29275821ioi.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nwfiOOO6KDt+5Yel/XhJZYpiAYpr08GIYW/cZknTYaA=;
        b=DUSc9VLGWfmSKzirz50+1+WG7HcgN6tycy/xYWRsGs5nj0pwo5c7RSesDhUbrJ3UfM
         pFcLANMBVmEtr0udWt/FeuKAn91MjA6Jq1zA5awzlQzd49V5nYB4K22S5njjjr06bFa6
         zWl1QvPJPA2btjfLrRLyZjbKvbKf8KxoaJ33SQlfvageG/rOuZK1pwl9XxwAUBVrHxC/
         pfVqGOaHmKQkSC0NRj6Yo5Zseyp08yjOORuPQ/2rS1eK0cDdFQQe3/LW504ePFFKh0qu
         xhPc7rHWAPLLivIN2XtuV3JF9jgu8A1ns54M0onEHC6C/tK7ciDqQNTHNLZ5nCzlBgMO
         OHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nwfiOOO6KDt+5Yel/XhJZYpiAYpr08GIYW/cZknTYaA=;
        b=rifpQNyt+Q7isI/2SK8OwpxsVaeQpkdF3rDxNwQtonEWTsuuHJ1Tw0cqNa7AIRqHbj
         kDC77nM5S/dw0DyAQUni6Kcly4epfKbGjEX4g2OqrrR3MuJzu3ms8oHJQDHgVZp/mDxO
         tkZRb2UyvaMFuHqDJZXPoA+nnV0pHCeyKogiJI85IMM33ezP+Dyv+WT4oJ/XB9jOhg+D
         kkmXLKwsVrr3DnxqrRWYMSEtpOrbqe3Cv750YEPklDqDCz+BwYF079B24qN+mIUufgeA
         pBA8BtKwpVxcB3og7bsFqzJI2HsULwcIk21SW7Mvv9ypMwxeakoVNg81t9PBY+wJMij3
         JVhQ==
X-Gm-Message-State: AIkVDXLePJ3FUIOwyRHoppQGEoP2cv8XxiKO0Ki9vKeUqIAudTPZXg3aVwDecL5uqRolpPRPob045+WjudNbzA==
X-Received: by 10.107.44.137 with SMTP id s131mr57289647ios.212.1483697183622;
 Fri, 06 Jan 2017 02:06:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 6 Jan 2017 02:05:53 -0800 (PST)
In-Reply-To: <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com>
References: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com> <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 6 Jan 2017 17:05:53 +0700
Message-ID: <CACsJy8C6QWeHSwhsYyJnupkue=aoCG+3Tecytb_0p+gB-CuVKg@mail.gmail.com>
Subject: Re: git branch -D doesn't work with deleted worktree
To:     Stefan Beller <sbeller@google.com>
Cc:     Roland Illig <rillig@novomind.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 9:02 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jan 5, 2017 at 2:06 AM, Roland Illig <rillig@novomind.com> wrote:
>> Git 2.11.0 gives a wrong error message after the following commands:
>>
>> $ git init
>> $ echo hello >file
>> $ git add file
>> $ git commit -m "message"
>> $ git worktree add ../worktree
>> $ rm -rf ../worktree
>> $ git br -D worktree
>> error: Cannot delete branch 'worktree' checked out at '../worktree'
>>
>> Since ../worktree has been deleted, there cannot be anything checked out at that location.
>>
>> In my opinion, deleting the branch should just work. Especially since I used the -D option and the "git worktree" documentation says "When you are done with a linked working tree you can simply delete it."

Since -D means "I know what I'm doing, get out of my way", maybe we
should continue if any worktree has the branch checked out by
detaching it?

(Yes I'm carefully tip toeing around the deleted worktree issue since
"git worktree remove" is coming. After that point, running "worktree
prune" before "branch -D" does not sound so bad)
-- 
Duy
