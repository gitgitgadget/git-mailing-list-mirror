Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CEAC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBPTlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPTlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 14:41:45 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3503442FB
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 11:41:44 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i6so1181734ilk.5
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SriWLh0eFm0ELzFlzIvrYzS4SnvRLTmwnPriDVrNQOQ=;
        b=T11rQT4w0tYzlxsd7Er9Cc90EIEQj3O/RNdtE5z/5lzzErSGfFvMv+f+rQiAp3C/sE
         9CMugj5nQM0WL2oHCKq3b5KEK1g5NN2P2rX+SqMquzbWw1hzhMPMIMKHF932YinzrepI
         7+RW4tu/KOdGnbFTf6ox0JpfMp67upjZGJcEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SriWLh0eFm0ELzFlzIvrYzS4SnvRLTmwnPriDVrNQOQ=;
        b=shO7IIdBDy8h+Y/CVRqIfWsCcFwXi7cHINv2vA55r6hVLL1o6rnJkkSdxsq9YMWLk+
         u5nq9l241mLWD506NfjsgqHTytXJhcpVN7c8j/rDFbSWF0Lw+cK3kq9H4tAS6lsZqaJp
         W7aaLwh5QqzhfqNU1Bj2WYY+Bg4icZr62SJr3cbm8igEBE4UOjsrZQYPy8VeWs1dnbGb
         9WaF4yxukSwGiq/cjCPjoqRmK4ESL8RKtgsKRDXwCPdDElS1rJJvPCUIfX9mLsapWUiG
         ip6HXkxRUfov+iEKuIBFsE/cjDHSYWqywIw16lVJGJXeVJfFKe7SOHo1De/eaaa7sed0
         gA8A==
X-Gm-Message-State: AO0yUKVdsFOiE02IRA2RX4wKXOL5n2IjtZ02gtV9pwrw4ugJGoYz5NiV
        vK7qxVybvHGINclMvZhjPxYYUazrV3qOAlrT
X-Google-Smtp-Source: AK7set9ep7qkVhjJl5jwOYVQDhJ5/v0XClA+qVjhXED3d1xRdRvI1ETuBNEODQpSW7o6/o2gVP0hjQ==
X-Received: by 2002:a92:9404:0:b0:310:c6f7:c1e9 with SMTP id c4-20020a929404000000b00310c6f7c1e9mr4681731ili.5.1676576504117;
        Thu, 16 Feb 2023 11:41:44 -0800 (PST)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id r7-20020a92d987000000b00313ca4be5e1sm706962iln.12.2023.02.16.11.41.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 11:41:43 -0800 (PST)
Date:   Thu, 16 Feb 2023 12:41:42 -0700
From:   Raul E Rangel <rrangel@chromium.org>
To:     git@vger.kernel.org
Subject: Feature request: Add --mtime option to git archive
Message-ID: <Y+6G9n6cWRT9EKyl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating a tarball with `git archive <tree>`, `git archive` will
use the current time as the mtime. This results in a non-hermetic
tarball. Could we should add a --mtime option that allows passing in
the time? 

Thanks!
