Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B34B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfGKRiv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:38:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38761 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfGKRiu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:38:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so3090951pfn.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doVp0DfiDwn5o/oldIwUuvcqbZHDRXLgrQPliJh5WT0=;
        b=jWeiuKhWy+k5LEVwfwhlRg7y4qvNVckoGnRx0Wsx7Lm2t5oYTcisXDS8737EU7/cr0
         ETApJsObQqbiZhkkIBEPh0eARxOhKL71C/GuatcDfy+FGA31cCc4tTbYJQEjhqO/N4Qh
         KdPCDnnP4WRlseNqeb4dNPvNeZ50GLkHxMkhvLWzSBorXAGtTYs5VnMapw8Jpnu4B43E
         1UMH4AHmDCO+c8emrQCHb2G/bed9bQ3gg1Q7Q9cSFfQJkWOGRp+hsuhp7KScq3znQ6sF
         JvIIUjQPe8euhoo86r8WffS3WHlNU5bvnuAB5GG94F0pjMvfa7XZvM5WmJecB5j/HTqO
         /9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doVp0DfiDwn5o/oldIwUuvcqbZHDRXLgrQPliJh5WT0=;
        b=GtAbwTYkPvguhfW98EvHCsnKq6iO/D3M2j+a/yzC3gsACQ6APEhZXiYRju6ZPSJd5O
         pUlvo0I2XC0+FFo/A/G0yoOcKMzG8Q4cmkJFA0qymUJor5hbbu1yRNQqVvvOfnoa3nUJ
         wkDCqXunKuF5raL0fUCzaXB3eM27qWuTrjZ3cziUfjDv3Rx+lisTK2E0x89CkX7EHxpP
         y8YTq9SlsOZjWK4Ib3hS0Eb8KFzD+T2YWAm76n5lJqM3b2IQHpdHSPrjrFBYOIc7sSnB
         fBoNNWXKwrxGtcoLgYfL0CUReC0LRh32nf07OBde6DsBF1WwxVggfYNxQ7P3epBi0nLM
         tAIQ==
X-Gm-Message-State: APjAAAWv9YPj8xZ8GywrFpd1buTEI+uYaDyN+5dKlZkf6YD0rL1pMs7g
        9sSAZIdQq0mvLADiyR/7TtV0vaoAaLlu2HAQKp4+xbL2
X-Google-Smtp-Source: APXvYqxZCty6pGf9JNZ9hhm0/aE621L41zzmULa13OgT18wx8uZHdr7CWD+SSd2GyWT5hq1KoQozVTQUIJUSY9kd6n8=
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr6262863pjn.77.1562866730278;
 Thu, 11 Jul 2019 10:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190711172626.16480-1-ariadne@dereferenced.org>
 <20190711172626.16480-4-ariadne@dereferenced.org> <f2cd0072-95de-3e60-d860-a5dd2c58c41a@drbeat.li>
In-Reply-To: <f2cd0072-95de-3e60-d860-a5dd2c58c41a@drbeat.li>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 11 Jul 2019 12:38:39 -0500
Message-ID: <CAAOiGNxrkVQy=2OHEJROtH+S_MdUMGCDOnjhgNK_x6iANcGiig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests: add test for git log --no-use-mailmap
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jul 11, 2019 at 12:32 PM Beat Bolli <dev+git@drbeat.li> wrote:
>
> On 11.07.19 19:26, Ariadne Conill wrote:
> > In order to prove that the --no-use-mailmap option works as expected,
> > we add a test for it which runs with -Dlog.mailmap=true to ensure that
>
> s/-D/-c /
>
> This ain't Java :-)

Indeed, it is not.  I thought I caught that when proofreading the
commit message.  Will resolve in v3.

Thanks for the review!

Ariadne
