Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155F71F461
	for <e@80x24.org>; Tue, 27 Aug 2019 23:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfH0XSb (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 19:18:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33780 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfH0XSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 19:18:30 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so2111573iog.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5o47CicAMyWwKosPdA5GQJV1dh73+TNIrpIrjTGUoU=;
        b=uqmFF5fgkVVe7XSXO+FXu9xxmrSjkJ5Rys3dCGIaDnG5d1fZpVoCFsLS1KOd/ugxyZ
         bhodJs1jQby4VbCTAMq9POeucucqidSm5V8puSJGUZwzwk7RPEzNhnXjgDBijq4dlPFm
         /ehGh+eC5KO1Za9kxOySS3PuOQ8OYPIjgP5/DRWZAtbYAuz4hub43If8uFw87HDKIV4t
         xBfGjEJOehhIqvHLxNcHu+W5TWTRP2FBzvxKUn6KoPUE0U/ocAymKgVXDQH253RBPELv
         Z/fsg0/KSShLA+q2JrDfz/67zife/i1Y2Aly6ntP9LHd6T9SBktYqBKJ6Igc6IwxTkP/
         4EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5o47CicAMyWwKosPdA5GQJV1dh73+TNIrpIrjTGUoU=;
        b=EwWeXWHKva+hcDGHjplAz5p0I7bIU84YXIxGiwbQnNGqhbAHNaqvpotvTbsBLH+OGj
         bGFXgmhnf2lZ1RLW20gwLhy8R2dFsbs2WrPAVn3jeAEuIOsmFlctSCaYkqFuWYWuoDJP
         jbomeL32ZsrY1jqjVSqUxLXo5sr+9dloejJqbaWRuJmHvBRT6Rpl8680JyYfjKMk/oM8
         DzifcyZ1PmZnybKxe5Nv/K35LPnEXXT8mo8r4ATervlI8fFWq9rnLJ+5ra5h675v4sNa
         ajLMyxzGlbkMsiO+CVrF7p2tMuxD6nTsExI+nCmEA1MEFzerHnLS3ayQHz60WTOewR5W
         Po1Q==
X-Gm-Message-State: APjAAAUTbyL4m73UkJbAlCWgKzC/lFutEahI2bsu3E6leLMhEF88XgvF
        dZ1zsu2RswsvKWY3mM4pnJA=
X-Google-Smtp-Source: APXvYqzwVn0k++tShEXY6+Gx7CBE755wSB4zY4oVJtxk2vf6wTpNf+iY2EaO5YmLv8L8e6Q+r0E4Fg==
X-Received: by 2002:a02:cc50:: with SMTP id i16mr1469009jaq.50.1566947909953;
        Tue, 27 Aug 2019 16:18:29 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id v12sm869744ios.16.2019.08.27.16.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 16:18:28 -0700 (PDT)
Date:   Tue, 27 Aug 2019 19:18:27 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] status: mention --skip for revert and cherry-pick
Message-ID: <20190827231827.GA26899@archbookpro.localdomain>
References: <cover.1566637431.git.liu.denton@gmail.com>
 <cover.1566880835.git.liu.denton@gmail.com>
 <be64ce1e92c60f9587b137d36e98532604d4a1ff.1566880835.git.liu.denton@gmail.com>
 <xmqqef162rx2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef162rx2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 02:56:57PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > When reverting or cherry-picking, one of the options we can pass the
> > sequencer is `--skip`. However, unlike rebasing, `--skip` is not
> > mentioned as a possible option in the status message. Mention it so that
> > users are more aware of their options.
> 
> Is this a good thing, though?
> 
> Giving up (because you do not have enough time or concentration to
> finish the cherry-pick or revert in progress) with --abort, and
> committing to the resolution after spending effort to deal with a
> conflicted cherry-pick or revert with --continue, are both sensible
> actions after seeing the command stop due to conflicts.  Is "--skip"
> a recommendable action in the same way?  Doesn't a multi-commit
> series often break if you drop just one in the middle, especially
> if the series is sensibly structured as a logical progression?

I think that the same argument for or against recommending `--skip`
could be made for rebases as well. However, in the rebase case, `--skip`
is recommended whenever `--abort` is recommended. With this patch, I
made it so that revert and cherry-pick would have `--skip` and `--abort`
paired as well.

I'm pretty impartial about making this change but I would suggest if we
choose not to pursue this then we should also drop the `--skip`
recommendation from rebase as well.
