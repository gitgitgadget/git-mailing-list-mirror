Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939CC1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeI1HJs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:09:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38218 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1HJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:09:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id z16-v6so515462wmi.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oB1ioaDiQgri4cftqsXQb+6whbL4jn38bLkIhI0HE2E=;
        b=nhIP2lbyQdRFD0JegySj/jykH+QgpaSKt2PGfEuZDhKv3v3TBfCiuhAc1qr8t6gokk
         CldsPjyla3X3QUnmbJxH1V5sZXcfjt/U+39Yzfqmnq+iPv821sFy7u6Fi075FOdRVLv7
         LeRTnmGGu2Eoj90Il1S+vvUiVKAjR1c3SSU4xw0GHx7jqH54S5mWlcZ5FeX2alXcD7Eg
         yd3ekRnXq4blbkF0cdb6TTBXghS+n7xgaYH6tlADCMXfiqguGyAiaogFKvMzKYwfORn6
         AshZZ1paM1KwIIEhp+4XmubuosR19/y5imil4Lx+kXkVZmU6ShharPrZxNpiBRYuK43o
         o9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oB1ioaDiQgri4cftqsXQb+6whbL4jn38bLkIhI0HE2E=;
        b=PF3zYk1yWl4s9XaF9N9oa+5wnVt3QlUaUbrq72Y/gM4laKMVKU8uH2/MwseSSpCUwF
         savMRNfs4PLxdDID/fnEK00GYaZr9XfVfa9TRkvGt7/P+WUJqO0QFyHtMQW6cf3DPNuQ
         0Tlw3NoEJTVeiJiuaGMkaW1twCYRfxPYeSL/BjEg6ZhEtnV5sMuUIIj3M0TjfzALlYia
         Ew/9n4YVVAg4bZn8tnw1UeOSmQIr3T1Q4LMYcngVWDVdaY+r8tL+Da4ocJ9bwt+EMmUz
         eMAkaC9L8vsCg2nXke6dI3gz5zxpk1ZNA3WhvWzswU5bkI6vaCxtzz+XbolgVAmMFlSL
         E0eQ==
X-Gm-Message-State: ABuFfog3PeA8rq5axb6MXyED3rZl/K+vR9dD4jyoOVgBu7kqxzWGksCt
        yD+INvU5V9x2LTuFwB6TPsQG69hn
X-Google-Smtp-Source: ACcGV61wmIBXW/VWoL33PA/W1D1KIc8I+Cp4+aq9jlK5tYxkxqhr/xGvwstpo+OpclXou1xKrkzcUA==
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr19979wmg.67.1538095726549;
        Thu, 27 Sep 2018 17:48:46 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id n14-v6sm411387wmc.14.2018.09.27.17.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:48:45 -0700 (PDT)
Date:   Fri, 28 Sep 2018 02:48:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 1/5] split-index: add tests to demonstrate the racy
 split index problem
Message-ID: <20180928004843.GP27036@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180927124434.30835-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927124434.30835-2-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Thu, Sep 27, 2018 at 02:44:30PM +0200, SZEDER Gábor wrote:
> diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
> new file mode 100755
> index 0000000000..ebde418d7e
> --- /dev/null
> +++ b/t/t1701-racy-split-index.sh
> @@ -0,0 +1,218 @@
> +#!/bin/sh
> +
> +# This test can give false success if your machine is sufficiently
> +# slow or all trials happened to happen on second boundaries.
> +
> +test_description='racy split index'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	# Only split the index when the test explicitly says so.
> +	sane_unset GIT_TEST_SPLIT_INDEX GIT_FSMONITOR_TEST &&

Please note that this patch adds another use of the environment
variable GIT_FSMONITOR_TEST, while the topic 'bp/rename-test-env-var'
is about to rename that variable to GIT_TEST_FSMONITOR.

