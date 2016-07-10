Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6552018E
	for <e@80x24.org>; Sun, 10 Jul 2016 16:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbcGJQGF (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 12:06:05 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35966 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757214AbcGJQGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 12:06:02 -0400
Received: by mail-io0-f169.google.com with SMTP id s93so38835900ioi.3
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 09:06:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O6qFO9EjEme3ByIthBEZJMAn9WcL05bmiYdKt8tqx98=;
        b=YA0ThU9O0oqVUC4BZFIxXVIYt3XH+SSAaNQZsokYavcBDOr3d4smkPnXUhEGlyMxZL
         Jm0PQc9TnA81/Ujf/qdbUEzEjPTe0TP4ZElDtAIjRkqFlxnq4y6G854gnaAar7bG3jG3
         5BcBk3kJ+qNlpmM3J/xnq2h+9BozG6PfYgNuVOqMumGRcyzZg4oM0pzufBBkS1vCt2qn
         Kn4MCiQF0PBPe+AWt1zjFRUppInIVVR4yoaOOmChn+ZKx7sDjuVmLO6K0GKKsq/qowwc
         B5Nt2RE3YoQ/Xbgzv1IETj8qDwQg0/TvoxPw7CVssaU3ggHYi2ynmirgUFbnJhOPsuYw
         Beaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O6qFO9EjEme3ByIthBEZJMAn9WcL05bmiYdKt8tqx98=;
        b=b9gOH6vDGkPC2JjdjgHotZ5tayOrX7EqKyLqK+MnhK04BOIWHzaqbQEi32i8NUAMOh
         QrZfDnGIsd+YASjpgxuIwbSJ8UPcqJWICpwiPLENQItGZrv8KUXjBeKbL0hxP4sMNXCI
         Su31SjOnsnzL8EXSzbuGsVuMX2dNo8XxJf1+XCf/KnU4J0k0D4OcYWg+TqFX5/bCx32c
         Qy9S0E19hP3pJgLSANBq47ThBXAdMxV1bisFeBvkHiLu7NJJJyjf0yDmZUk/KThbzWch
         VbenNcAPouoiblNOvdUfmfp0yb8JRTzZsa3wRWUkbBo9KwWwLNCrPh3Mhx4GOJ71KXru
         gIQw==
X-Gm-Message-State: ALyK8tIkGFMYaz1W3AYIhWw6QrwaV4KOZECZyhG1YBCJlUTCJhj6ujbdeU9k60JVzuSzuCCAGvyT1mh8VZqgmA==
X-Received: by 10.107.159.16 with SMTP id i16mr15685990ioe.29.1468166760917;
 Sun, 10 Jul 2016 09:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 10 Jul 2016 09:05:31 -0700 (PDT)
In-Reply-To: <20160710142622.GE26097@thunk.org>
References: <20160710055402.32684-1-tytso@mit.edu> <20160710061644.GA19640@sigill.intra.peff.net>
 <20160710142622.GE26097@thunk.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 10 Jul 2016 18:05:31 +0200
Message-ID: <CACsJy8CSqjTztFu1fOXqyS1jXjt=D_pgAC4MXpnECAcu+dRu2w@mail.gmail.com>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
To:	"Theodore Ts'o" <tytso@mit.edu>
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 4:26 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> One other long-term thought.  Maybe past a certain point, we should
> just make it easy to get the data from git-log into a perl or pythons
> script, where it becomes possible to do conditionals, more flexible
> padding rules, etc.  So some kind of --format=yaml or --format=json
> sort of thing.

I thought libgit2 would already give you all the information you need.

> Some interesting ideas of how we could do this can be
> found here:
>
>         https://cloud.google.com/sdk/gcloud/reference/topic/formats
>
> ... although I doubt whether git would ever want to do the equivalent of:
>
> gcloud compute images list  --format='table[box,title=Images](name:sort=1,family)'
>
> which will print something like this:
>
> +------------------------------------------------------------+
> |                           Images                           |
> +------------------------------------------+-----------------+
> |                   NAME                   |      FAMILY     |
> +------------------------------------------+-----------------+
> | centos-6-v20160629                       | centos-6        |
> | centos-7-v20160629                       | centos-7        |
> | coreos-alpha-1097-0-0-v20160702          | coreos-alpha    |
> | coreos-beta-1068-3-0-v20160627           | coreos-beta     |
> | coreos-stable-1010-6-0-v20160628         | coreos-stable   |
> | debian-8-jessie-v20160629                | debian-8        |
> | freebsd-101-release-amd64-20150101032704 |                 |
> | opensuse-13-2-v20160222                  |                 |
> | opensuse-leap-42-1-v20160302             |                 |
> | rhel-6-v20160629                         | rhel-6          |
> | rhel-7-v20160629                         | rhel-7          |
> | sles-11-sp4-v20160301                    |                 |
> | sles-12-sp1-v20160301                    |                 |
> | ubuntu-1204-precise-v20160627            | ubuntu-1204-lts |
> | ubuntu-1404-trusty-v20160627             | ubuntu-1404-lts |
> | ubuntu-1510-wily-v20160627               | ubuntu-1510     |
> | ubuntu-1604-xenial-v20160627             | ubuntu-1604-lts |
> | windows-server-2008-r2-dc-v20160623      | windows-2008-r2 |
> | windows-server-2012-r2-dc-v20160623      | windows-2012-r2 |
> | xfstests-201607030209                    | xfstests        |
> +------------------------------------------+-----------------+
>
> and will even use fancy graphics characters if you're using a terminal
> which supports them.  :-)

Putting everything in columns is my thing :) We can do something like
that. It should not be so hard to put titles on top and draw some
lines, I think, if you set fixed column widths. I'm just not sure if
it will be really helpful. What sort of use case do you have in mind
(besides git-log --oneline with customizable columns)?
-- 
Duy
