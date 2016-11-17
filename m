Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3A71FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 20:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbcKQUIP (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 15:08:15 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33943 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbcKQUIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 15:08:15 -0500
Received: by mail-qk0-f174.google.com with SMTP id q130so236910538qke.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F46Gaa92ndO5DUnyivYUCqAfOqO+m2COuW2noIYmyhA=;
        b=VW9wn5Rpe9TVbesiMGcOT1AO3wYwGIBpPoZG0ujUjuuBZKQLdTM/tZj3bPLQEv8BwT
         LmB9v6AEwra7sZcpyP2mqSk1W2+s+A9/rpwk79/FqDLzRROL72+wK/d17uEUM6pgRSAQ
         vgdzS7SmvZhI0zoNwsNaf8e4sv4lGC/+MtLoT7LpstY8dc3qe9YBohBDu96RksEtdaMs
         JRBNAHoWffydTEyotTY5eWlZ+bZ2KXl7Iaghw2pMx6lYoTn5pi3Utq8sWyVyEVIAOEr+
         mx4t/yY4xFtivrwFJ84xqHbcqZf/uzite+JwgX1hZD3FWQwUpfNVN8FGln31lyrNC6Pr
         U7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F46Gaa92ndO5DUnyivYUCqAfOqO+m2COuW2noIYmyhA=;
        b=FPror+qBXAhmqDXi8pDMKpYAC5yfmLjqfGtlZE8ON3VCnQpzJ9YhQa2uOf3Yja7V9w
         MPECtLIailOUVQ+EaOTCpjno8/2bSVpBYnEFI4l8SPXMy+02RJEAztbuO6k2TQurBiM4
         CGFRgdl79+I3ALS1fgGBJ9W10Teh7XweG+xcqbMBS0cYyc8o9NYJBUm0LBxXIeawUxoV
         VDFkjNwFsGDFxNiaLq10sKXE1H0ldIbaj07Nwd0SmU2QXdJdMeQzjWiBCJ4kUKZiE0JT
         EG1DfO2S+jn9Wow5rq4xp4fMAzfek7JOwrC5ccTz+hE7KjzJNiBCUTRkJmKh35NFOlbT
         y58A==
X-Gm-Message-State: AKaTC00W8diWG1hreH7KF4O13W7mZzJ14fI1WRgcfPphEPk/CniFdkApG9kfHw/5nRuw+mwG0Zu9c22Qfk0MRBxF
X-Received: by 10.55.191.134 with SMTP id p128mr5475485qkf.58.1479413293915;
 Thu, 17 Nov 2016 12:08:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 12:08:12 -0800 (PST)
In-Reply-To: <20161117105715.GC39230@book.hvoigt.net>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-8-sbeller@google.com>
 <20161117105715.GC39230@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 12:08:12 -0800
Message-ID: <CAGZ79kYEdA6crWTf3ZW2EthenZA4=PeWd4HfKnCAKxgZoz54qg@mail.gmail.com>
Subject: Re: [PATCH 07/16] update submodules: introduce submodule_is_interesting
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 2:57 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> It seems that you are only looking at the submodule config from a
> commit. Should a user be able to override this with local configuration?
> Haven't looked further in the patchseries so maybe that is somewhere
> else?

It turns out that in later patches we pass in null_sha1 only, which is
looking at the config and possible overrides.

I'll refactor to take no sha1 argument and use null_sha1 here directly.
