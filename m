Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E734D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCNFp7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:45:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33219 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCNFp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:45:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so4431334wrm.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7TvQMNZMK68+PicsgvLnH6uEuNnQaJUn7ATUlDvrzrg=;
        b=o0NsauLz3+WMGZfM12ohlp5R0Fw3HZYn+oL2fD+5/pbWaCl+83aikNfmcL4jnoOikT
         v/1dGUr5p6ZOFsWwoybfLG6EsSYVjuVffadJ6wE0VnkB+XSnBoCNTRMn8btOu4CITcw/
         JaDUTuI5xhLEx60W3+oFiYEzuap7SCX2p7oLbZucqytDM/T/hDEV/vWxvkYYEnyaeaEO
         RMtyiujJ01PcWaEoml3CwPdqFgXFfMubA0UyyanNrFyz5Fd3wn/QOXtEB79eYFM/4jb+
         +wT8OJUE9bIs1KRGEY9uJ9wPA4/HwlvMO4L3mpbdN/Q2gmQn4PkbE739GZ/B76i/cEKc
         nl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7TvQMNZMK68+PicsgvLnH6uEuNnQaJUn7ATUlDvrzrg=;
        b=JQNHCjaC3polg50HKezOWpOSmuisYmlz+ouKq5NXBDtp/BiK+Th9cpPF8zf+8sKVwI
         kesOS+Q3DoOc48jIZvHSpvUphxX0KlCpxs+umJc2je5JMcQaphSbTK+boLHTrMDM79B3
         OpPhmTtsQuWL6b/Zn/vZ4029c/hAuU9AFvapCEZS2//Vhq3x55ULS6WczAWks+x6rlaY
         nj3y77nBCm48hGyVPXbs65qZFPwwi5n3LMpi+rNNBNgJxTQJfVUz6TuRzfC5AphcoxDk
         WZXU+DvW0diIdBPZ0E0zSomcVzM7NzFst1N8cBSW3X3x1Dw100fvn5kMrR+HlEc4p503
         8UnA==
X-Gm-Message-State: APjAAAWVCG42nUXvG+yPgoMrmYnL7CPRLFRb6ssoY8YMKMqP1CftDt6n
        VkKtfguuiFQsDDShYOx39Ts=
X-Google-Smtp-Source: APXvYqxuSyksVHcgOb6A0qeHLHaF+fh72i1xiBtLfN9pPdp9HOlc5jSngP1kP/QC3HcRvYnhctgxeQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr29160943wrn.21.1552542357766;
        Wed, 13 Mar 2019 22:45:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o127sm690165wmo.20.2019.03.13.22.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 22:45:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v1 09/11] t: add tests for restore
References: <20190308101655.9767-1-pclouds@gmail.com>
        <20190308101655.9767-10-pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 14:45:56 +0900
In-Reply-To: <20190308101655.9767-10-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 8 Mar 2019 17:16:53 +0700")
Message-ID: <xmqq5zsm9ffv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> new file mode 100755
> index 0000000000..df91bf54bc
> --- /dev/null
> +++ b/t/t2070-restore.sh
> @@ -0,0 +1,77 @@
> +#!/bin/sh
> +
> +test_description='restore basic functionality'
> +
> +. ./test-lib.sh
> + ...
> +test_expect_success 'restore -p without pathspec is fine' '
> +	echo q >cmd &&
> +	git restore -p <cmd
> +'

This stands out as a sore thumb, being an invocation with '-p' while
all the other tests for the '-p' feature are in t2071.

Shoudln't it move to somewhere near the beginning of 2071?

> diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
> new file mode 100755
> index 0000000000..46ebcb2413
> --- /dev/null
> +++ b/t/t2071-restore-patch.sh
