Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE3C1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfG3TTN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:19:13 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38214 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3TTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:19:13 -0400
Received: by mail-wr1-f48.google.com with SMTP id g17so66969787wrr.5
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HaeuyDxda49Bez/jSoNVay8586vE9s+EgigClNyFpM4=;
        b=JnR1+J/sIfM6gqzFBE8opvJ86Fml8YwxVq7B4ynggNoij8fXEWiQSoqgqxQ5c7CtmB
         LSMQ4YDwU9hSMbeyvWXFtEPtXeMbDuI3gEQQeBa3N0tnLrbUdx6hpfq/th5sJtZDgoWQ
         mAaLLbZGJFLPt+yF4F2vur/rqcHQhNTBhf49QC9Lxgg6UviPqzndM4b2aQS2OhdIInVD
         N9ix8wK8Y9PmityUN3o3YQYzkVhmX1fYA4YUXAjuquJ15Dpb0o5Gik1xiYxWmwfrMZz8
         9DIzji6XOWhud/IxvXXyJmS3JvB7fKuEp2nfe8QVZnrjw5/tqshcbiPAZWZ9Wu7nyeA3
         cnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HaeuyDxda49Bez/jSoNVay8586vE9s+EgigClNyFpM4=;
        b=nUIvgS/nOhLVby5mzOZ1WytWX0ApPwXzCD2VhHjWfYeMd5yitBn/BzmYkGfHSDiSnX
         dAOA2axx4QpHg7qgwoAevf6UeR1tqv2GPCmyn7JpXKgp/+46aNtEDqmH88el6rbCMXbO
         bL4DYLbmhx1S0JVsbibnEwFwUp7E1Uv16NUO2oWnHWdrsfQEdQrGze9QH1utHGb/0lov
         Rw0Mz26EC6Mx3PqVhoNYLA9ujf6zth50QkNPXAvtXKGzLxdaT7weQ9dZP07/9YhP9NuU
         3uaqUdgczNb/r59tPMQUymMNiRIW10N1l+16fjNN7dp1CuBpmNnm9fmJ4d7IH+goGihO
         GB6Q==
X-Gm-Message-State: APjAAAV7bHEYZf8mKa78v5ffpouwQE34GCdf/O7FtWtVOL7n/8FqD5Kw
        5euYjZvRx7M0l8FyRAYOVXU=
X-Google-Smtp-Source: APXvYqwLsfAe+K8+x4Lg9yfhKLNw0miasiCZpP4iRmKpn5kMSZdbgJeI2+eYsFwEIPfAIy8EatOhKA==
X-Received: by 2002:adf:f544:: with SMTP id j4mr24318481wrp.150.1564514351249;
        Tue, 30 Jul 2019 12:19:11 -0700 (PDT)
Received: from szeder.dev (x4dbe512f.dyn.telefonica.de. [77.190.81.47])
        by smtp.gmail.com with ESMTPSA id x16sm49741864wmj.4.2019.07.30.12.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:19:10 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:19:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCHv2] send-email: Ask if a patch should be sent twice
Message-ID: <20190730191907.GQ20404@szeder.dev>
References: <20190730162624.9226-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730162624.9226-1-dima@arista.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 05:26:24PM +0100, Dmitry Safonov wrote:
> +	if (@dupes) {
> +		printf(__("Patches specified several times: \n"));

Is this message translated?  (I don't know what __("<str>") does in
Perl.)  If it is, then ...

> @@ -589,6 +591,19 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success $PREREQ 'ask confirmation for double-send' '
> +	clean_fake_sendmail &&
> +	echo y | \
> +		GIT_SEND_EMAIL_NOTTY=1 \
> +		git send-email --from=author@example.com \
> +			--to=nobody@example.com \
> +			--smtp-server="$(pwd)/fake.sendmail" \
> +			--validate \
> +			$patches $patches $patches \
> +			>stdout &&
> +	! grep "Patches specified several times: " stdout

... this here should be 'test_i18ngrep' instead of plain old 'grep'.

