Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3CC433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 00:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiAFAWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 19:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbiAFAW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 19:22:26 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37499C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 16:22:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id m2so1107925qkd.8
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 16:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+raghmH9t5+QVakSMdDRvU+bruMCOBBuXsLLKWWVkyM=;
        b=KtEbUxP4ttIq2uzdJT0OvsUSLAfXFWq1wZwpxjsKM9zc+CEzH499c/5G3Ex22wkpsW
         xt7COf10+JZ+qfqVPvcL38v/DxWOUf/3uE+iJYt671Wvxpd3w5Ujm174eAuAOLfmnCi8
         N7aakZKqGSkIFGr7JkS9EEzbxPCJymuIBRd0lwttK5HndLljnl5LcHkgwBgR2QD6iDHE
         jPi9mZezDCf7BnX+WMTHdw8jIWjhRCd0dqdKBhZMhFW53ONFdH3e+8e1FvlFvHR13SRq
         /nLM5tm1vRNcv8wvCZkXmBV59xWgZCVw3wKPKR1Of/fFCq0c7CjSEWSgNzJkKkqE2aLl
         DYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+raghmH9t5+QVakSMdDRvU+bruMCOBBuXsLLKWWVkyM=;
        b=o2cocI9Ngecsb3/d1/t7N9Xvz/u6fNcrUzYa9bKNBw1npyNmY1livAaqYti53ETeLO
         G6n7X3ZUgF6pepo6esm4232EKDu7FtXBpZsBh0i99nfSsQGOuSr80GSJtkjm0ZNESYep
         f+EkyLuJoh2dPdbYm+/6B+DUp7iMIW/njV3gDrWEMuOv20eXlatgxgtAVBTqnBu/g4jr
         uruVROlWkqvTUX5Gag0QNzJ8Nsl7ljcH45eB1NMuaxghkSkya9MRPZfoaKsft/L6rAii
         Vxz3aOhT07exjomlFaKFhgJpGW3l9BfPa7f+w6/jDcsyg1aP5oTiBSgT7czwQTKs5L2F
         YkgA==
X-Gm-Message-State: AOAM531S+laBjwhHFXFn/P69c3p1Y2BEPUb5t4CT4hnBpH92EZp/B5kK
        v6PAka61UiiX/GTy1Gugxlc5XAfsgeGAfQ==
X-Google-Smtp-Source: ABdhPJyDgCzybeMnQ0HF8z61P2GvLMqVB9hwl0Hx4/ZdX0AJBg0QVchTl38RxBUv1x2ypm91t3jf3w==
X-Received: by 2002:a05:620a:1904:: with SMTP id bj4mr40142339qkb.536.1641428545403;
        Wed, 05 Jan 2022 16:22:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e15sm295177qtq.83.2022.01.05.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:22:25 -0800 (PST)
Date:   Wed, 5 Jan 2022 19:22:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "Nanekrangsan, Sucheela (NYC-GIS)" 
        <sucheela.nanekrangsan@interpublic.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Frank, Carson (OMA-GIS)" <carson.frank@interpublic.com>
Subject: Re: Git bug report git remote get-url
Message-ID: <YdY2P+xX/a6aHB2b@nand.local>
References: <00FDB880-5FF6-4C67-9144-5599B2872830@interpublic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00FDB880-5FF6-4C67-9144-5599B2872830@interpublic.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 05, 2022 at 05:22:06PM +0000, Nanekrangsan, Sucheela (NYC-GIS) wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. I put [remote] entries in /etc/gitconfig

This is almost certainly the culprit.

`git remote get-url` doesn't output anything (except the error message
included in your report) when `remote->configured_in_repo` is zero.
Indeed, looking at remote.c:handle_config() where we actually add a new
remote:

    remote = make_remote(remote_state, name, namelen);
    remote->origin = REMOTE_CONFIG;
    if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
        current_config_scope() == CONFIG_SCOPE_WORKTREE)
            remote->configured_in_repo = 1;

we only set configured_in_repo when we're looking at local or
worktree configuration. Since $(prefix)/etc/gitconfig isn't either of
those, we'll avoid setting configured_in_repo, hence we'll end up inside
of this if-statement in builtin/remote.c:get_url():

    remote = remote_get(remotename);
    if (!remote_is_configured(remote, 1)) {
            error(_("No such remote '%s'"), remotename);
            exit(2);
    }

...producing the error message in your report.

> 4. After `git remote add xxx`, I can get the URL from `git remote get-url`.

This makes sense, since `git remote add` will configure the remote `xxx`
in your repository-local configuration, not the system-wide one.

Thanks,
Taylor
