Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AAB20A10
	for <e@80x24.org>; Mon,  6 Nov 2017 19:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbdKFTQp (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 14:16:45 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:54658 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753748AbdKFTQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 14:16:44 -0500
Received: by mail-it0-f46.google.com with SMTP id 72so6355571itk.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 11:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HJiJb2DXqK5cYaFDCTCbRH2zvaG+dNjFfQMqeqwc0g=;
        b=tVLgVSMknQjzXNtvoH1SVuRk/IlW72WVm9OyNProf31h/WxmFHJFZfpD/U48GSsP9q
         4YN+7CjsACsr4vBsdmUh8nAiHlu4yJw29/2nUuOsge2wWwITE5igoCMyyqVyHBdqoKa2
         qIU0ONWCQCb61jqoZT3INeClK9B/LtkfE4j2He8VEU7TBsBrfLSlXNcafRvClVHm80f0
         oMFfh5q+c38g93FZyXAKuiKMA1VtYlAYe2/Vvmeg5TvTVIcOdewHf5f56ZjU1zQDoF5v
         Wom1Ynqxnp3KnGncbNJtizmwdiuNrlJz1/vZNxcExkw9pzgdOyGINMn2NaeTzZBlZx0l
         QEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HJiJb2DXqK5cYaFDCTCbRH2zvaG+dNjFfQMqeqwc0g=;
        b=RaeLFWVrob84AUqgNdzd8V6TbXZhVrpEVeCM0/KmPaJimqKgT3+a4657EqDI/T6QJh
         ld2jUc1KzSYbOD1CVS3IsJGP6XYBYX3C3zDmzR7hdyAunjGWhzkwJn8GRil8IgyZd4Xo
         mrSTllL754XjqPLaBI1wcpsADvg1o51DUUiM9fFR5KLlCpx7bFkyyrhWPKcBT945zmii
         VuTDVd8nwYqYd2+em12zK5LV9Zo4u3PEips1n4ErEfSsuUynQylyP0i+tLRXPt6vt16f
         rrPh6ejJ8GDB38d83EG0oBqhfVL0yitW0FqmrO57SBLqqW1kHsGTSZjMhAqKHFzRcyPc
         imrQ==
X-Gm-Message-State: AJaThX4vcAjJ6atGqX9Y33F0SaXRmXjgZHqbQPwpxvNDQTvG40KzW3tu
        3+4g/qGcDEsralWmA+G4dtTkZU+U6nk=
X-Google-Smtp-Source: ABhQp+SNBag2ZpwoPTJ/audlW2OOYoUk6CvzNQhn4l7jUOC/nMz/dx8cvOjYKUSSO+83niqUCdO4IA==
X-Received: by 10.36.213.213 with SMTP id a204mr10874679itg.51.1509995803505;
        Mon, 06 Nov 2017 11:16:43 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b9ff:79e6:288e:1217])
        by smtp.gmail.com with ESMTPSA id r15sm5905747iod.12.2017.11.06.11.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2017 11:16:43 -0800 (PST)
Date:   Mon, 6 Nov 2017 11:16:42 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/9] extension.partialclone: introduce partial clone
 extension
Message-Id: <20171106111642.696a006e802cf0259098b44f@google.com>
In-Reply-To: <99b7c61b-f8ab-43a0-0707-62ac1db4d080@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
        <20171102202052.58762-2-git@jeffhostetler.com>
        <20171102152427.32544b3d6149e7a7bfe840c8@google.com>
        <1db01a45-85c4-6243-c43f-9f5e50e9a6a8@jeffhostetler.com>
        <20171103113919.396807c82dbfdecff7f19c41@google.com>
        <99b7c61b-f8ab-43a0-0707-62ac1db4d080@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 6 Nov 2017 12:32:45 -0500
Jeff Hostetler <git@jeffhostetler.com> wrote:

> >> Yes, that is a point I wanted to ask about.  I renamed the
> >> extensions.partialclone that you created and then I moved your
> >> remote.<name>.blob-max-bytes setting to be in extensions too.
> >> Moving it to core.partialclonefilter is fine.
> > 
> > OK - in that case, it might be easier to just reuse my first patch in
> > its entirety. "core.partialclonefilter" is not used until the
> > fetching/cloning part anyway.
> > 
> 
> Good point.  I'll take a look at refactoring that.
> If it looks like the result will be mostly/effectively
> your original patches, I'll let you know and hand part 2
> back to you.

Sounds good. I uploaded the result of rebasing my part 2 patches on top
of your part 1 patches here, if you would like it as a reference:

https://github.com/jonathantanmy/git/commits/pc20171106
