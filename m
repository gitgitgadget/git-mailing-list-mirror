Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C747207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952708AbdDYWfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:35:39 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36464 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952700AbdDYWfh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:35:37 -0400
Received: by mail-pg0-f54.google.com with SMTP id g2so34500495pge.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QZNfRdnWSkpinxJcCfCC6kcgQc7bIosCNUTAKX8maFE=;
        b=AVRSiEch0qJKZi88KsmMErMZjGphpPs5O6T67+K784WHo74FZi1e01WN9RZLDALkPg
         CJRJWCY/AKe6/FGrG0fW9ixIyS/JuhHmxrXTHIROYEl3cKAhS6eJav3etvCx6Gl25t0N
         grePU1ahCkwFdlgGx4jse/Q9fS8m+Ha4roqOwqbslC9I0OggGwS0qjOkh07N92Y1nTEj
         P7TNo8mYfDScjZi0uP1OzWyALzlyCeOkPLc+MVbclL3YE3yhx+7OBs0xoWQjuiG0bL7L
         v8GlBuzq1ap8MsOB3YJnx/vFbgf16j7eYeONWH40q6Dh4NljwjnlN3dMYkpkbxUVHrn8
         eDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QZNfRdnWSkpinxJcCfCC6kcgQc7bIosCNUTAKX8maFE=;
        b=ULERkBmpjXlMlEYprw9UaJtX8v1641Rr0Z7o5DdtWIG+rbB2DQFpex5tl4P3QEcLrK
         QTu3J+h3WBa88nV+5EyJSrrVyJQbLoLU96l6BuxqrnfUp3FLSdzWf14w/OX58vYRt4wx
         JGUXItkkCUb5RFvzwO9C8rsfM4ilGXJfSHWSxz3bql8fDlIApvR/Gvt3AgHBsoyunEAt
         Djvgtu0i6b1Z7BTgxODlrXYo1++pbM35xgoG1z9cs/RqKoTl2kP8rrRaMZqFTMc7anv4
         IbFYj5Cw/xai9MdlJwT6+fZsaV850hVwuk7GyUL8gjTFr3htcKhkNBn877RQZnGVXUKo
         gI4Q==
X-Gm-Message-State: AN3rC/4Jy6yJLiQQ9Alwqh+CA9f1JZW+DUXzPLThUQYW7uOlns+nk+XB
        6P0xl4ccGMvMmA==
X-Received: by 10.98.158.205 with SMTP id f74mr30057466pfk.119.1493159736221;
        Tue, 25 Apr 2017 15:35:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id f18sm2118140pfa.130.2017.04.25.15.35.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 15:35:35 -0700 (PDT)
Date:   Tue, 25 Apr 2017 15:35:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: add a --no-tags option to clone without tags
Message-ID: <20170425223533.GL28740@aiede.svl.corp.google.com>
References: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
 <20170418191553.15464-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170418191553.15464-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Add a --no-tags option to "git clone" to clone without tags. Currently
> there's no easy way to clone a repository and end up with just a
> "master" branch via --single-branch, or track all branches and no
> tags. Now --no-tags can be added to "git clone" with or without
> --single-branch to clone a repository without tags.

Could --single-branch be made to imply --no-tags, like --depth implies
--single-branch?  After all, all I wanted is that one branch, not some
tags.

Callers who really want the tags could still pass --tags to request
that.

Just thinking out loud,
Jonathan
