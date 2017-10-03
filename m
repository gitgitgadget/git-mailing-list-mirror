Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E61020365
	for <e@80x24.org>; Tue,  3 Oct 2017 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJCLAA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 07:00:00 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:48438 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdJCK77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:59:59 -0400
Received: by mail-io0-f173.google.com with SMTP id f72so781066ioj.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Idqp/zQiuojKV9gQmMhn2biahSCg2Uz6d+m4hafG6E=;
        b=c3Q6Ed1/XMeXRX4m7PMMeOqGClVV5dERvBdmQoMNB0hvQzot2V3UIGE5laRvAqkhRB
         5bagfeIZbiBWIden53Qd8hAMi0NZAkLGYPMXynkEFq7J9DuAXXeR/i2wQoRjf412Ouvy
         XCeS9a+23nG7oPSaKHilV+CkTi0dFMe5w27B6l4PrdOBoapq1o6xTm0UvliS/0lOeWQr
         zDQSELdb2iGD71WbRUb8GeG/vGY7RhH17uC/OERjQabkgGbuD5Qw8GJggcQCRkHUEE0t
         Nf6GqySjJ9Vpy0ZhEJFw5nKZkW3txOQXXI7/GnTOu1sr0L5s+58LshTGS87rgKmGPcN6
         DlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Idqp/zQiuojKV9gQmMhn2biahSCg2Uz6d+m4hafG6E=;
        b=fEtb+orvDZHUG/RPQPkMhD2umbHIu5TtO/LpKq7Tsxw01NJy2ih+a9YJA9ADzEhzs1
         WaN557eqHmkTvn+dVMBiXqRR40wNRL2LYL4lOMylJ2W5olDEjG3y5js7n97tx7PAEAkm
         MkNZHsBD7CfxsCj3QgCBHkLablwH1roSmiSGZnqiD5sbo8ARMorZlup4IwFZV+6AwS5d
         UDgtuQxjChSPJ4QXLAOd5ezxJlZaJ+HRb4ieZK9Lfj3OR0MTWwecuLvnkE9wzDM8cKct
         98N4fqMuJHneYd0G/fzst/r6LQiQ6Y/rZLn5e15yeC7r1/zt6eZiY1FZ4FocWtkxD2Lz
         FqmA==
X-Gm-Message-State: AMCzsaX859avM7vnjR5fwuyiNnKY7vanVNHnbCXnskqv+Gf2FLaCR5PX
        9gOfIQuRllbNRhWVtS2/UCedclMez95FUICqyxc=
X-Google-Smtp-Source: AOwi7QCA+c5Q3Y574eLBi5O7d+GP2kCcIRDBWKkG4vIX9bC7bpO8qjP+QOsHJhkSMoUGnsgaD38q8GY7Ibrlz/EBvlM=
X-Received: by 10.107.137.96 with SMTP id l93mr27584838iod.138.1507028399179;
 Tue, 03 Oct 2017 03:59:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.142.216 with HTTP; Tue, 3 Oct 2017 03:59:58 -0700 (PDT)
In-Reply-To: <20171002234517.GV19555@aiede.mtv.corp.google.com>
References: <20171002234517.GV19555@aiede.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 3 Oct 2017 12:59:58 +0200
Message-ID: <CAP8UFD3FJBns+dnJz94SN6htboDt1aKi5FZCLQMGc39+yORH0A@mail.gmail.com>
Subject: Re: Security of .git/config and .git/hooks
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Loic Guelorget <loic@google.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Oct 3, 2017 at 1:45 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Proposed fix: because of case (1), I would like a way to tell Git to
> stop trusting any files in .git.  That is:
>
>  1. Introduce a (configurable) list of "safe" configuration items that
>     can be set in .git/config and don't respect any others.

Maybe we can already add a --list-security or --check-security or
--unsafe to `git config` to list the unsafe options and their values
as well as the active hooks, so that admins/users can already easily
take a quick look at the config before they start playing with a
potentially unsafe repo.
