Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C335820954
	for <e@80x24.org>; Wed, 29 Nov 2017 03:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdK2Dsw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 22:48:52 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:34360 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdK2Dsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 22:48:51 -0500
Received: by mail-it0-f54.google.com with SMTP id m11so25074589iti.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 19:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hHeV1/FmpwmfQDSP8QP4JLs9n46wsdz07XLj1VyGSO8=;
        b=V32djVjRRN7Dka8bjzCYAKA4qeUdD6+rSlV2gRuvW8coTFozcchLVbvYNpuf9lNqLe
         ltNi8/UZcsb6ZH3CeWl8m2UoYkYbo6g2zyHHA6zTf8yMmqRBk4gX0Kdzn6VNUxJRyhqN
         55Y0uUKsmBQ3oJR90E1jC8MYA0X2kEnc9OzFSoKI1HhpPywBJ6DhsX8CWiy+5nGL46LJ
         1JxfokmquUQG4tHy3bxUw9hPBsGS+knQtGzn344S8K8O8dmjiME2tKgbwJAjY09f6R/w
         O17lTYaQ0Fpzd/LyVPCxwRLmhvYLWSIhGoQ1ZfZJlqnSWAwNqd1aLATc3YjtsbUM4tkZ
         30Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hHeV1/FmpwmfQDSP8QP4JLs9n46wsdz07XLj1VyGSO8=;
        b=pgsC4eRcwPwoLOLpS/6l+jPzB8AkSAcO75Q++pXf/EjH61AhxjpW3ZvPPmbyE6QqaN
         n3DGpKZQi/RuEn8SJimjagqjrtCjksPm77EAdJKny0BhnhrtwrOOt8YUiYHtym0yHWX1
         WrUIUhGc+3PF0TebJmK+BndSMnPT+ry2g1zI4qYgNnYjCiG3kxExYFSMT08uTah/cfYp
         vaz1czr97NVptiTrWSphNfR9dG2PyGgipkU1sXzz6JZBjsY1veWcxA2AJBTqQWIVlLcz
         pCHA8VjbTkXjj/zwjc9P1TaQ6H/6vOsAsnbLqOjXHq1yqEFNvslGYsFhOqswuKG0FJia
         TTlQ==
X-Gm-Message-State: AJaThX412uREWYwjP/7i1I29Ub8XO56Q57sh8l5vDaSspVPvV99uuBLB
        vFi2X162lsNnWuGtJZ8Kh7UzBpG7HQ33Sy4oR5Lvog==
X-Google-Smtp-Source: AGs4zMb480VoHoqvy2sx8SyqrgBVlDYWdLgex8c9d5cRk/8KnB3PQNqm/n6rbZDrA6E98dkyMPVcFplA+crUfnk52YM=
X-Received: by 10.36.128.67 with SMTP id g64mr5329961itd.5.1511927331192; Tue,
 28 Nov 2017 19:48:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.169.76 with HTTP; Tue, 28 Nov 2017 19:48:50 -0800 (PST)
In-Reply-To: <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com>
References: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
 <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com>
From:   Patrick Rouleau <prouleau72@gmail.com>
Date:   Tue, 28 Nov 2017 22:48:50 -0500
Message-ID: <CAL1_K8C3bNMae6PFk73c7n6AvnbO=5Sujz3oqL_jBj=DpiEO1g@mail.gmail.com>
Subject: Re: git-p4: cloning with a change number does not import all files
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Nov 27, 2017 at 7:52 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> what is your goal here? Do you want to convert the repo to Git or do you
> want to use Git to interact with a P4 repo?

I want to use git to interact with a P4 repo. I am used to git tools
and I prefer them to
P4V. Visual Studio is also slower with P4 plugin and I hate P4
approach to check out
a file before modifying it. The .sln files always get check outed for no reason.

I am working remotely. The P4 server is behind a VPN. That one reason
I am trying to
clone from some point in the past. I also want to have some history to
see from where
come the code and from who.

Regards,
P. Rouleau
