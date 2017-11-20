Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B9E202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbdKTTUB (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 14:20:01 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:45482 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdKTTUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 14:20:00 -0500
Received: by mail-it0-f68.google.com with SMTP id x13so4819250iti.4
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 11:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIMCQh+OQp6xqo5+qIhqC1rBS3X0Qa560VadFt9z7IE=;
        b=kWI1wqSgcg9SQUU1cM872szMzXjNbCNkqo4lxkVMiLXIP3K6KIph7GY+Hb8oX90lT2
         ICInjjeAkJpTAuTJycQqcTFevHRdDkkScn0WQOTCpr/bHVsAHHAH0XzzhmQ1m4LNhDoh
         gopOflVKGhKegHVe+5FJ7Y9f59kg/Ko1HtqZLfZFFO7FL7K8BknCKvmnAfHP1KWyTYC7
         i33QEPNdDla7WJpS0P7yag4T6GGAK/ScTw8Y5/+yVg9dEJ2gnXguDEr1MC+AN1A0Hnpk
         g9XApy5DqLWevu+7vwIRKVH7DowONXfDZy9Bqx6l2FQxQU0hwc0MqhvwJKJaJCX2fTEa
         k7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIMCQh+OQp6xqo5+qIhqC1rBS3X0Qa560VadFt9z7IE=;
        b=sc5edUJHNJcFXljYJoskb9SMK9HiwXZQOdN8NhPP0oHyRWLLJfbLc548z2uo2pV0mz
         3Nn/MmW+sRFEPwb4QPssPZfRud4K0t4kcneKWm/WPMXRs+8ybACtkrI6/Y9mBiEx66lF
         YD7cVr3DDaDmdqkurZBwAi+0AGzecTGrnAS4fD0sJPBZptE2g8s7QmglQ2tqJECJlRkm
         aKkK3hwD+vg16xwxisEfqgh+tXr5T4HU/KS/noB7oQ09/4vd0Xa9tF2qIqo4rtIeflFJ
         HkvVFmCg506yHRausR4RNT0rXgQnTKF360ek/3d5IsZcJVYLCRC3PeDq1Huh2nZDBvnn
         SmrQ==
X-Gm-Message-State: AJaThX7oTFDk94k6U/b90dJr5J+e+sh1sDuFMBHjiCfDeW/BiZFUBvM3
        LFhzDii9VkwwdlxU1BqI0cM=
X-Google-Smtp-Source: AGs4zMaOpkHSUIaFrAPSNWwbPrbRMCq7a4JIZii8ofZ0ICXeHhgfuwGkSNXqqWJjd/eCSWWv0GM/hA==
X-Received: by 10.36.249.132 with SMTP id l126mr20536319ith.52.1511205600040;
        Mon, 20 Nov 2017 11:20:00 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o1sm5265332ite.2.2017.11.20.11.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 11:19:59 -0800 (PST)
Date:   Mon, 20 Nov 2017 11:19:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120171517.6365-1-chriscool@tuxfamily.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:

> By default running `make install` in the root directory of the
> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
> and "gitk-git" sub-directories to build and install these 2
> sub-projects.
>
> When Tcl/Tk is not installed, the above will succeed if gettext
> is installed, as Tcl/Tk is only required as a substitute for msgfmt
> when msgfmt is not installed. But then running the installed gitk
> and git-gui will fail.

Hm, I am not sure I understand the point of this change.  E.g.
if I run "make install" for git and install tk later, wouldn't I
want gitk to work?

Can you say more about where this comes up? gitk is a wrapper
script

	#!/bin/sh
	# Tcl ignores the next line -*- tcl -*- \
	exec wish "$0" -- "$@"

Would some error handling there help?  E.g. something like

	#!/bin/sh
	# Tcl ignores the next line -*- tcl -*- \
	exec wish "$0" -- "$@" || \
	{ echo >&2 "Cannot run gitk without tk"; exit 127; }

> If neither Tcl/Tk nor gettext are installed, then processing po
> files will fail in the git-gui directory. The error message when
> this happens is very confusing to new comers as it is difficult
> to understand that we tried to use Tcl/Tk as a substitute for
> msgfmt, and that the solution is to either install gettext or
> Tcl/Tk, or to set both NO_GETTEXT and NO_TCLTK.

Hm, is this the motivating problem?  This is a condition where
the rationale for failing the build seems clearer.

> To improve the current behavior when Tcl/Tk is not installed,
> let's just check that TCLTK_PATH points to something and error
> out right away if this is not the case.

At first glance I had thought this might set NO_TCLTK automatically,
which I think would be problematic for the reasons mentioned above.

Erroring out like this patch does and asking the user to explicitly
confirm that they want to install gitk without Tcl/Tk is less
problematic, so I am not *against* this patch, just interested in more
background.

Thanks and hope that helps,
Jonathan
