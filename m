Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6D020248
	for <e@80x24.org>; Sun, 10 Mar 2019 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfCJTcQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 15:32:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36850 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCJTcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 15:32:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id j125so2295908wmj.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Iu/OmYomLd/wcQBZPcvNUEWb5q/xp2XcCX9MF0DiXwg=;
        b=DR8YFZvHqTaOqmOZb2MiHfECf+zKP5VMeuuXesuNHJVs61aMWeP4m7NlYV+OrM4CzT
         y5i24bnjop3eiLHRLDOo2DL7KXX0yshlqtjaDqECPPw2eFCD22/fEdsZoJYJj/5aQsaE
         TOdNkM7ZZ5U9iKmc5z/5S/CMtf2HSaSS/K896QQvGlzYB7DW4bXSkzJ40EEnmeaYTehX
         zxd29VCuDGmDTtFVeolbkuv/BE24ES3GBTVCAn8y8XEYtKHUGwnGfvgyCB6CmUXBFhIa
         9zidATkVNnx08wkdlFcAez+8yeXrXySju/1R5EHtMIgDyU8G9CTcb+cYofWoPkrA/LRe
         GoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Iu/OmYomLd/wcQBZPcvNUEWb5q/xp2XcCX9MF0DiXwg=;
        b=BgEwXBNTxyT16en06GfIB4oroKDkMM1Hsf7m/Ql+f9Q+TxFN0giVr/R8nSVWhdd+OK
         rIchZ2IA8Ev60b+z0d27SFuyZNWmJ5pxsH1bmeHuskwbOsUBCLWSSeMTvvdyoZg3kLkD
         iGAPuqUsEXsssHvmT+/gzB/qduSOt9z/II19A2a8F8xrRZsbRQeDM7Js1yD/Bz0/WSIa
         KCMHPpbYJ+LRD/i4Rnhez4MRocDKORKRnSHfvBSTFV5V5V4R5guk0VopqxHryc2aC7fq
         kSNABA5nJ1TuS4UhmFFxWtQ/c4NTD2MnYj3QIr03Z7HNkOe/HRLFFYALvKPzG4+1xRd2
         Q+WQ==
X-Gm-Message-State: APjAAAXuInpSfuAiRBtHpQOK+f/Pzmq3bTA0Qyny/0Mq9eQj6XKC6Bmv
        7/toHOx23sIXj2KtBk4BQ8E=
X-Google-Smtp-Source: APXvYqw8lTlfdZAuOUqb5WbSS9G3ucZpLn2Vm7pYwsSyRh8ggsNrToTUnSNPkHHbcrswCX0WBWYq6g==
X-Received: by 2002:a1c:2d4c:: with SMTP id t73mr15077221wmt.142.1552246334103;
        Sun, 10 Mar 2019 12:32:14 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id o5sm7207118wrv.70.2019.03.10.12.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 12:32:13 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Sun, 10 Mar 2019 20:32:11 +0100
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: Re: [PATCH v3 11/14] switch-branch: only allow explicit detached HEAD
Message-ID: <20190310193211.GA444@esm>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-12-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181129215850.7278-12-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 10:58:46PM +0100, Nguyễn Thái Ngọc Duy wrote:
> +	if (!opts->implicit_detach &&
> +	    !opts->new_branch &&
> +	    !opts->new_branch_force &&
> +	    new_branch_info->name &&
> +	    !new_branch_info->path)
> +		die(_("a branch is expected, got %s"), new_branch_info->name);

Wouldn't it be nice to give more context here, for example the symbolic
reference that the name actually points to? When expereimenting with the
feature and trying to switch to a tag, it refuses with
"a branch is expected, got v1.2.0". I personally would prefer something
more like "a branch is expected, got v1.2.0 that resolved to
refs/tags/v1.2.0", so I get "oh, yeah, that is actually a tag ...". Does
this seem worthwhile to dig deeper into? A quick glance left me a bit
puzzled, I admit.

Greetings,
Eckhard
