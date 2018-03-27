Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541571F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeC0XHT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:07:19 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:40342 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeC0XHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:07:19 -0400
Received: by mail-pg0-f44.google.com with SMTP id g8so217555pgv.7
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=foz9qmX2dR8+Wr4m2+SSQ4CJKQv3WCSNB1K9yrUj6iw=;
        b=c/KlaHapFPNPyva/YBB3G+GC8L8+5HfwPgUK9V/O663EQjEphKgAVgvcWI09F+P3Vm
         +ww9VYGFC32U9E2EEpUhhzXkyYqLorljDhpXlQ/f4/xkneGtorPwE27ah8y1VFC7rZiv
         U4oC+nQhI1R/M9z1rad9qyidjvRFj5XGRiRDvDMjFGOVBPVJ/EWB/w4LcyqI6EoFdsfr
         aipyrgEV2i/lhKRIj0Eo3UecFunmLH0IXlqDuuG/8I52YIEYui7k9sMpgX+jJKRY95Cs
         MQW3eSdPSoa15eTOPdoeQUfPXNkIbbc5O0XP5h7vxfeVfOMfNTIbtXabTu7Q1skIAloM
         zDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foz9qmX2dR8+Wr4m2+SSQ4CJKQv3WCSNB1K9yrUj6iw=;
        b=QvFUz4JPCrrot/vyLoY/Y9x/gBmf9LPNBAVQO8x7Nj3zrNyAcvoV3becu/DOJmOzAy
         iwfjYEiRxk1CIUXfQMF99kcPUTLgBUohZzTEy2DWGMq3wH0c8oTZCy/UY2esZo2zhnBu
         1B06bzu6lsqfr8pSYXQgqOMlLkIDrROBxfF3+x2aHyEb4DB4ihvD2GouJLknm0WfXIzP
         mxFOr4Jz7OozwtV+o45gHs6K2zAw6XzN57MdAkVSAkxr6Rllf9PcOXYh+UbZS6S6XdzS
         3F1ghhR4Tcp52GwVFuqxbDNmpX04NYQu8IESgBKwmLTQb5zILjxn7gNI4UfgyNqmRMGt
         2wgA==
X-Gm-Message-State: AElRT7G0HdETMXSjl6ums/j2iGGsOFG5RBNc1KHo9BaifnFa4iUQz3CS
        vhU7CtGyNGkpSdFNx2E/9ZU/nShJ4/g=
X-Google-Smtp-Source: AIpwx48MHkmnFpbGXPnYy9BtZLIktCImZC/80Xa/JyO7ZHL5w3FOfA3f8M/qAZrCWVWz05zXyjjg7A==
X-Received: by 10.98.236.86 with SMTP id k83mr957530pfh.84.1522192038522;
        Tue, 27 Mar 2018 16:07:18 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p6sm5294000pfk.104.2018.03.27.16.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 16:07:17 -0700 (PDT)
Date:   Tue, 27 Mar 2018 16:07:16 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, seanwbehan@riseup.net, bmwill@google.com,
        hvoigt@hvoigt.net
Subject: Re: [PATCH 4/5] submodule-config: remove submodule_from_cache
Message-Id: <20180327160716.eec5ae96c7c1c5135b27b08e@google.com>
In-Reply-To: <20180327213918.77851-5-sbeller@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
        <20180327213918.77851-5-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Mar 2018 14:39:17 -0700
Stefan Beller <sbeller@google.com> wrote:

> This continues the story of bf12fcdf5e (submodule-config: store
> the_submodule_cache in the_repository, 2017-06-22).
> 
> The previous patch taught submodule_from_path to take a repository into
> account, such that submodule_from_{path, cache} are the same now.
> Remove submodule_from_cache, migrating all its callers to
> submodule_from_path.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

Obviously correct, since submodule_from_{path,cache} are word-for-word
identical (other than parameter names).

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
