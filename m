Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5466A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 16:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeCPQil (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 12:38:41 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45766 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeCPQij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 12:38:39 -0400
Received: by mail-ua0-f195.google.com with SMTP id x17so499505uaj.12
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=95nclwoDoABo9xHlDe7AKLMYfxYn6IOBq6lk+ZqqcCE=;
        b=h6dhBPbIimHq4x2Ax8QrLs/4JCqAPiPhAKmLBhvlbJM8ctcBeunKMpa9HnQvZ3haHK
         8cdlVDi6wA2gkpokh9T+VsSMNCKCsug0ROUtHM2Dp4c4A36fNXUf08x96IbqMo9S9mOx
         dN+guzd/7TVjMOJQUJ0HEzOVZfL6kAZxaGz61ZoTaWc5Y55d05qkhvFAfEC3+bvfD/fN
         ml9TSnJdmY7tMnhvlfSYqaX8+Ybtshpx9OcML0QxQ6tF4Pfqr5nE0SjNZjfG7DmsAsPu
         APO2zwQYZ1CfnQ7/F9/AW0/P5uP2SO1vh9eyWVY8C/3qPaGkLyqkGppqcI91jjapGPqy
         jgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=95nclwoDoABo9xHlDe7AKLMYfxYn6IOBq6lk+ZqqcCE=;
        b=c6lpxjtoQCBnWZOcbZ8X7YxlS6iA5eOE6x1xv7QKbexYKNB8nkTCEZjUNLkhz38lk+
         CUEwR2N3af5JMAVaMdrJ0vCi285PRQ1VbgvVSHt6W0Y4GawHNyXvuLbhh3F7kdWtUb6j
         TcnjcE+m95Lp0eKOwNqbmRVwaqQY26ohTWk/7XIIrSJO3hvIPVFE0n3VgB+LDCcKoAOj
         goXPY8TcQRYxFuw/GTmHW+uD3SxGucMSjLt0OWGDfPQ72ChwI8NlBudphDVSeIpyzPIh
         kbDHsfaW2jrKVOkmOxrO04Q7y/VyPfBsdeEnjju1Bjf1ZpBzf1spUjtSe7SL9DjBedxC
         TAVQ==
X-Gm-Message-State: AElRT7Ee+Pam61P1hj2tNMleCxzFfKOZzUulIcIu6pUTRbsmEAxbaG7Y
        +Pq1+tTmU71GLxFOJ5Ht1IFEHyBlfzyV5ha9XeA=
X-Google-Smtp-Source: AG47ELt/Di0xqCQG5hmsol+OT9GDlGV+IusH+bGs3FJ2JBk/dLs95I/J05gwmtTRqVnZfLiXNRnOjAGKQWqZ9PXDyJg=
X-Received: by 10.176.82.202 with SMTP id w10mr1826708uaw.31.1521218318165;
 Fri, 16 Mar 2018 09:38:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 16 Mar 2018 09:38:37 -0700 (PDT)
In-Reply-To: <878tasdpqo.fsf@evledraar.gmail.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com> <878tasdpqo.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 16 Mar 2018 17:38:37 +0100
Message-ID: <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 4:06 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> I noticed that it takes a *long* time to generate the graph, on a bigger
> repo I have it takes 20 minutes, and this is a repo where repack -A -d
> itself takes 5-8 minutes, probably on the upper end of that with the
> bitmap, but once you do that it's relatively snappy with --stdin-commits
> --additive when I feed it the new commits.
>
> I don't have any need really to make this run in 10m instead of 20m,
> just something I found interesting, i.e. how it compares to the repack
> itself.

You should forget '--stdin-packs' and use '--stdin-commits' to generate
the initial graph, it's much faster even without '--additive'[1].  See

  https://public-inbox.org/git/CAM0VKj=3DwmkBNH=3DpsCRztXFrC13RiG1EaSw89Q6L=
JaNsdJDEFHg@mail.gmail.com/

I still think that the default behaviour for 'git commit-graph write'
should simply walk history from all refs instead of enumerating all
objects in all packfiles.


[1] - Please excuse the bikeshed: '--additive' is such a strange
      sounding option name, at least for me.  '--append', perhaps?
