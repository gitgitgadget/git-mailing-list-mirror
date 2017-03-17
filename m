Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7175720951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdCQX0g (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:26:36 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33737 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdCQX0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:26:34 -0400
Received: by mail-pf0-f169.google.com with SMTP id e129so4698967pfh.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=74n+VDzoyfqZafGgPw499my1jSC8JpU1E+H/0Z5/N3U=;
        b=fbkOjTUDsro6q21mPytg3Hwm6mAEG3dYhisXL8Uj5o/PjxYStgKrFlfAjZWA/NFTSf
         XDLbV9pypGX2dBFEGZ4cB2cr584Lzfzx+XcrmLtffDSUPYQCvGbrmDr7kLi40wvR+cJe
         rN0alEXnrcx3yEc9Qb4tqttQhfsyUF4C/c3dLG0LtS3zgJdJzO39cRxBSEqv0EY6kkNN
         ZjZZSC2Rtm8jN3dE3krVqVvPzDr5iogNJUglB5uZ0U8m5J8IMmE6cOvwRF1+jlBJBqJE
         uTY23YbB4f7Tlf5LtEdjv2KnxdiMVr1TXnqHj3hcVJ7hMI2S7ZyH3AWB1rj8hTFnQEQO
         XhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=74n+VDzoyfqZafGgPw499my1jSC8JpU1E+H/0Z5/N3U=;
        b=t8aUTrobq4MqOTJE/kHUdsj2g/0QHC+/C3LdWoPG50PfBtWZ8tPG7w4dP1W67sLcKF
         /YxunXMfVmsIfV7f+1UU92MlOGjrOYNsi4BbMI6MasDSiGSqK3vGB3HLuoHSDZOKdL7s
         WIEKgtfogoOPEUrjPUOqCiIVVnl4PbB6mm1xfs4tnSAYaMIXAc1XQkCixBOqKLuO9JM3
         hEBQMQi8p5i/YNxyf8Bysl0KoLMXQBH01FWHCWYE4mUO+qasy3uY+e0pMFGVw8r9upXY
         /NphvJNDZpHqalAmGafgti9Tm307Cg6L4jfc/IG7RTxrAm2uzdp+698GYhSOdMOAyYXm
         6QJQ==
X-Gm-Message-State: AFeK/H0JbumGotJgXhAICCXRrtzJ+74VI/Fib3z2M1NKyJFcZjruUMhMVozoh/1RtiE/D9+JiHYZrU8uI2J1Se1j
X-Received: by 10.98.44.15 with SMTP id s15mr19613713pfs.161.1489793148130;
 Fri, 17 Mar 2017 16:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 16:25:47 -0700 (PDT)
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com> <20170317223805.95271-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 16:25:47 -0700
Message-ID: <CAGZ79kbUW4L7G8+18Umeysv+tPuWxZUF9e4axBdb_=8BwjqzVQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] decoupling url and submodule interest
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 3:37 PM, Brandon Williams <bmwill@google.com> wrote:
> Changes in v5:
>   * Add "NEEDSWORK" comments to indicate where attention is needed once
>     per-worktree config is a reality
>   * --no-recurse now works by clearing the string list of paths.
>   * module_list_active() now does post-processing instead of duplicating code.

Skimming these patches, they all look good to me.

Thanks,
Stefan
