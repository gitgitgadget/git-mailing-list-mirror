Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B05208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbeHGAXX (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:23:23 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36732 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbeHGAXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 20:23:22 -0400
Received: by mail-wr1-f50.google.com with SMTP id h9-v6so13810819wro.3
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 15:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X+xCLpj5kQRYnQ84sGvwF0MPbPgQtJGdpZ6ny3n/H5o=;
        b=R37v2fLqhSebh6aue6P5goyqg5WUlvhNPi30+rRwXetHHJQVmYQLZwozYGwkyRkJja
         3SfXxD3dzUtyoqPC5Eq0kVttNCWUPC9I6D2eRVKMbQ4AeeE0xAAjmgnAFSrmAWJ1fXEN
         uPCCnphIN1KE3iMECDxI0TvPCvnx1A118BSs53RlFPAhgQKOCY6NrRyxJd27EdDjbh+j
         nge86s+Kvx3QozlPRhIWU+OV3BS8JtG7urmag8ZQH7EAQlcihyLSfJGMYX3zn0PduUw4
         NySOe6RmPME14sKVVKp98mQ6mz8IDqCG4ZSSq4n6Nhp45OufHT76Ze4LRYb72EXiGKBo
         T5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X+xCLpj5kQRYnQ84sGvwF0MPbPgQtJGdpZ6ny3n/H5o=;
        b=hSGCGD94GsmCKGPoysUEBa3Hltguejb+murSxtmEhSTiREXnOQ8nZKfHT/wMQwFsL9
         YThKW4wV3UfMRQHqo5g4zw2fjxe+l6RAWzlZfSmMxXcDilVNi4WqgcOwSKB1+xiWFp1q
         GW9y/lRmY2Tk6970GWOJgoLh7c3PNgXcYypM6GTPY2xjDw6oqOa1wK3xCRJa3G0hSJz0
         SCGGhUbDr6RIFygteJMIt7qQPP8BMKd+K5sHquBfMFvYSQuVTOwPHdNNkZy+eTMAyhpx
         AWQdABNStFLrUIttpf2h25bjvU0yj6U1fn3YarmHSwk8NkI5pASAFaarRpmNPZydwdeB
         RRQQ==
X-Gm-Message-State: AOUpUlEKfe3OzggZu4O9RHQ38eC11vxW5EW5Pp2Sj7PRJqkKlKYdGlOc
        lX6vl/d1axyycrNZCq9FFE4=
X-Google-Smtp-Source: AAOMgpe2Ndb2A2unbUkvqzwJ7EbqxedueZxVpJahoPQBYbNJHRqw6favVMSCLY+5tI8WQE9buKh0GQ==
X-Received: by 2002:a5d:504d:: with SMTP id h13-v6mr10402380wrt.18.1533593532698;
        Mon, 06 Aug 2018 15:12:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 200-v6sm15974925wmv.6.2018.08.06.15.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:12:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] sideband: highlight keywords in remote sideband output
References: <20180802114753.9715-1-hanwen@google.com>
        <20180802114753.9715-3-hanwen@google.com>
        <xmqqpnz01vdr.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_OnUHcJSryq7vTdkvBuna64y0Q3+C+NX7o4_tFwSqjcDg@mail.gmail.com>
Date:   Mon, 06 Aug 2018 15:12:11 -0700
In-Reply-To: <CAFQ2z_OnUHcJSryq7vTdkvBuna64y0Q3+C+NX7o4_tFwSqjcDg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 6 Aug 2018 16:06:12 +0200")
Message-ID: <xmqqy3djm9fo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> If your "make test" did not catch this as an error, then we may need
>> to fix t/Makefile, as it is supposed to run test-lint.
>
> I've been running tests individually as
>
>  sh t5409-colorize-remote-messages.sh  -v -d

During your own development that may be sufficient, but do run "make
test" to run tests by other people; it will help you catch new bugs
you are introducing whey they notice their expectations are broken.

You are breaking 5541 (there may be others, but I noticed a breakage
there) perhaps with your debugging cruft.

