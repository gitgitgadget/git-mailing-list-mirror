Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736B01F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966655AbeFSRCY (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:02:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39651 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966514AbeFSRCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:02:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id t22-v6so376189oih.6
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvLT2+B41db4FlpnSOFRbGEjbVm8o/i5TdEp1W9r2pw=;
        b=QUXwHvda3WIbOWISaWgF5vlbyog3PUZy6H32YGUx/wskt2H6lkhfnAMzH1cvM+Kzqd
         Ak6LIgqYn5aNJzSYVutb15E8hnGcMSDdMlUNELQ1nc7tftaN6ppot/6jqhMwrj/qFi7v
         FYVo96F+dPUFMJnJtV6+Acj/H1X9CpwWpMQ26d7OAzgH3lpWN1rQeh6gsIP/q25dicU8
         MCtKUyLvgnxEaInGK8lfxM3AA+6YN+eSPR4eWt9z7pQFhzTHH77wQ79OBN5xX7Ie00K8
         gjnyjCCVOkSXtR4YOEZn571sTWN45et6UG7blXR4nOGDkEBWLs2X02j1XLrSrbxpOl75
         rNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvLT2+B41db4FlpnSOFRbGEjbVm8o/i5TdEp1W9r2pw=;
        b=l8QQLJ08XTuLHAoYBiXks8XUuM+gD79QvKYQzwPFRx4DpUGzA6WfM6Dm8cQLqGaCme
         Q9ksvePOVw7RhP1LZV9P4l5WboqMO41SpQoaEMD01+B4+rn0T+8qkSMvhdptMGwFM6Pm
         FK+6IOOFSM5TKwdN/p9zayooPgxNl1/uSN6dWRxOM0l9nIc53pCs63QJ0tgL1phpEy7L
         QcqTPYfh8LBSoyFUkJ9UYVf92oBz3lh49rLKzeEz5IygDJ9khsbueIHgYS0GiKY3vrF0
         KIeOOrv3WZBvGzU4JTwn6Z0WWRVi758+EhIxU6ud522mDo4cC0jlWnRV1EQbxnnuFpLP
         Dong==
X-Gm-Message-State: APt69E3ibDVjfFNA80JdNn9UmFnmwKudsd2wWFqa/PgucPWpOszJYjkb
        kPi13/csCPBK6Sue56tpfNxGiA==
X-Google-Smtp-Source: ADUXVKIVw1mcsUDuzditvB9caWna/B5fptxb8k8lI2kFcs7PX85MZbc8FyoE4RIAqZyn14lishaqRA==
X-Received: by 2002:aca:a646:: with SMTP id p67-v6mr9193797oie.149.1529427742755;
        Tue, 19 Jun 2018 10:02:22 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id u15-v6sm102589oif.19.2018.06.19.10.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:02:21 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 19 Jun 2018 12:02:19 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619170219.GA36718@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <xmqq1sd2wwpz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sd2wwpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 09:46:16AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Attached is a ``fresh start'' of my series to teach 'git grep --column'.
> > Since the last time I sent this, much has changed, notably the semantics
> > for deciding which column is the first when given (1) extended
> > expressions and (2) --invert.
> > ...
> > In the future, I'd like to revisit this, since any performance gains
> > that we _do_ make in this area are moot when we rescan all lines in
> > show_line() with --color.
>
> Sounds like a plan.  From a quick scan, it seems that this is
> sufficiently different from the last round so I won't bother
> rebuilding your "--only" series on top, and instead just drop those
> two series from the older round and queue this as the new and
> improved tb/grep-column topic.

Thank you. I recommend dropping the second series
(tb/grep-only-matching) entirely for now. I will rebase that on top of
this so that you can apply it later in the future with ease.

I don't expect the parts of this series that affect that one to change
much, but I'll hold off on rebasing it in general until this series is
stable, hopefully soon.

> Thanks.

Thanks,
Taylor
