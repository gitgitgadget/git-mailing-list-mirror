Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E12D1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbdJYEY5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:24:57 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:45817 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdJYEY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:24:56 -0400
Received: by mail-io0-f169.google.com with SMTP id i38so26202651iod.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a/MmwyfWntR8m4U1SNu9PGS3yHRpKa3xI+e36JGU3/0=;
        b=DbGJjvR1RKyyljawUyBenwXQxzaY2npADcnYKwuO33qcncfsYW5HCIZ0DCtLxXPF40
         GeQWDcKeiMUWxtQAUG4o0nNmXWJDZqFY0t4QtDTdBzrATYPqtslilDjfSx8ltUgPlHFM
         ES7syY+y6zmr2S2GepUHigVyG5ixd15d4jz7J71/lb0qWApCLGFESJTlHXlPoc4P0DCS
         4eUVpOnAZEQxNcdNQ/N3FQgICIrW09r/loZE/ejZph6nZ93+ePfWyc9uPA+7w4xCKKRH
         oUhFDnhVDDmH2L07wWhpl/+xYFtkz7Xy2sjxApDP8JzxxgRY/6P/11W85oGHygtDDqxH
         KZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a/MmwyfWntR8m4U1SNu9PGS3yHRpKa3xI+e36JGU3/0=;
        b=VHenVevYvTZqe0vql/Ng2aZQjR2lz/bqpOOi08HAXugI0ppr1+1dSMLaEUcZ3Uvzrq
         DuBcfL5fCDGuAbt1iil5+qkPfm2fpFEMOYrl5X1I7BKDoN3RXCuoEk5smzGzIw1xxR2L
         PfCHno4iu6GL8dtX/ycduztdNL4tEoRu319bfJzLZ2DdjO1JdPzoTilXjvjC1vQOa6lP
         a70QaNg1QI2hLT/uhDnrzwnGCaAli4Eylss24p9IJa7muSPQ800mjA2zT3NSGMG+5lM2
         9PmJvsXUBg8qgPlRKz51vWHkdH/kKUDt6JtTvaGW2mo4R1VQyvFNoIcG4uErMuSUrgmB
         ZBHg==
X-Gm-Message-State: AMCzsaV/5ligmSaj71vX8BdFMW2cEqaalK2s9zr8Si5jhLSQPxdXzLe7
        tE0MjI0talIBVq4zCwZ0I3sGvpdt7P3HiR76/GZAxQ==
X-Google-Smtp-Source: ABhQp+RUujevUws7OjlmlSLF8B6xo/ScNpveF2rm9UmWCIh1HJihE/dSPzVuWrDXFeiCeKC/fouBvppQw3g3L8rEZBU=
X-Received: by 10.107.53.42 with SMTP id c42mr25205260ioa.254.1508905496106;
 Tue, 24 Oct 2017 21:24:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.174.66 with HTTP; Tue, 24 Oct 2017 21:24:55 -0700 (PDT)
In-Reply-To: <20171024185332.57261-9-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com> <20171024185332.57261-9-git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 24 Oct 2017 21:24:55 -0700
Message-ID: <CAGf8dgLU_70vq8JNpr-cihgk9SbC_7GYcaEF6c9NgmJRXPAcmw@mail.gmail.com>
Subject: Re: [PATCH 08/13] list-objects: add traverse_commit_list_filtered method
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> +void traverse_commit_list_filtered(
> +       struct list_objects_filter_options *filter_options,
> +       struct rev_info *revs,
> +       show_commit_fn show_commit,
> +       show_object_fn show_object,
> +       list_objects_filter_map_foreach_cb print_omitted_object,
> +       void *show_data);

So the function call chain, if we wanted a filtered traversal, is:
traverse_commit_list_filtered -> traverse_commit_list__sparse_path
(and friends, and each algorithm is in its own file) ->
traverse_commit_list_worker

This makes the implementation of each algorithm more easily understood
(since they are all in their own files), but also increases the number
of global functions and code files. I personally would combine the
traverse_commit_list__* functions into one file
(list-objects-filtered.c), make them static, and also put
traverse_commit_list_filtered in there, but I understand that other
people in the Git project may differ on this.
