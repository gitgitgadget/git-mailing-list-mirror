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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7369A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 18:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLSFG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 13:05:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38615 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfKLSFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 13:05:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so13902753pfp.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7BUpx+pFWIOt8j8+GOVN9oGRZolgz+KmSzUIj9CZTQ=;
        b=gjseoXVxyhq9zffvj2/O2HMZoZiormK96GoLrQ6OZ1tTMQFGb+pWTtr+NOkEk2erd2
         EQxUVIgMMnya3oPoqW18K+Y+oTzF3UjHxEllWvV1d+B2MScqemg+c0dWEKVSSlxEYhUA
         0nbtNC4JYSAILY2/CSZspTQiu3svcezQLyi57C7yfDxRTip6zHbtqFCghBWbM6RORXbU
         H/Edp0zreR8MTDLc8slRK92XfmcgBKOQdPx5bOuMD+t1r/DAPNa3oYpaO7/Ys6gnBiHt
         FLxgyAXZ7nZ8h+OIkP7Z+xea5BrZudOx99gCX9Mp/6KOTjF6vjxgGLodJCQMgM822JB3
         ukoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7BUpx+pFWIOt8j8+GOVN9oGRZolgz+KmSzUIj9CZTQ=;
        b=EjYfTBNKcdohFo6gvrbxgkVx7b53iV1FcnlfcVR3f+u6EbKN/eD6sag0+heF0NBnUO
         Km9Didp58YTp50i1oU/ch8JY0kie/lal2fBHV1Jcu/vKHEfRgbmoKodBDlpbUk+Xpf/5
         y0/IhV+LSSGEZtvac41yzUTS7YXNt8gTQ92durqbC35C98FsX9lDhnVusF0RwS5yA7rT
         R7aFUIIDTvI+j2CpHiWfisRuLa8OUX/t0orp7C6nUIrPLYKWvRFofyIFsrzQOgCYz8C0
         ipBpWRr6bqF85YP2LnO6K8QiflQRryHPc2WnD4XSFi5P3nJAhz0/kklKdHRUH0LaOdIx
         jG3w==
X-Gm-Message-State: APjAAAWxG9UnFA+kAe0Jxr4bdh4AfbWS2TAlkNllNn/AsAVqhh4WBpeO
        rOBOqlMO2WdLCp2FLvOMg5U=
X-Google-Smtp-Source: APXvYqyHtdXqWygKRSAn0alDJQTaCPevFzA/xy16wu3rfO0FS6nIrgzc75q8kf2OrO1DFBWJlOp2Tw==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr2608149pfb.63.1573581905639;
        Tue, 12 Nov 2019 10:05:05 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id f19sm14517293pfk.109.2019.11.12.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:05:04 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:05:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Paul Jolly <paul@myitcv.io>
Subject: Re: [PATCH] completion: learn to complete `git rebase --onto=`
Message-ID: <20191112180503.GB41101@generichostname>
References: <CACoUkn6D0cUmN1RbcpfERcOJsbGLdwj6oDeF2oRADV+rX2artQ@mail.gmail.com>
 <22e92546ee49d4502fd5a441741a380d62c834c7.1573507362.git.liu.denton@gmail.com>
 <xmqqpnhxg0ra.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnhxg0ra.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Nov 12, 2019 at 01:46:33PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Before, when there was a space, we'd start a new word and, as a result,
> > fallback to __git_complete_refs() and `--onto` would be completed this
> > way. However, now we match the `--*` case which does not know how to
> > offer completions for refs.
> 
> Very well explained.  Thanks, will queue.

Could you please queue this on the tip of
'dl/complete-rebase-and-archive' since it fixes a regression introduced
in that branch?

Thanks,

Denton
