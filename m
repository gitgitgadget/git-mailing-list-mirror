Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9571F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 18:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbcI1SG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 14:06:29 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36727 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbcI1SGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 14:06:19 -0400
Received: by mail-qk0-f176.google.com with SMTP id z190so54957962qkc.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PBwpTHs4yrJyM7zOPF1s0ina3mLaRifIQsToT4XTlw8=;
        b=HKMaKSeyxyQTvfVCqYFN6yssRdHAQvNOh8pci20yhKxE21B925o0W2JtGltL+wrtCP
         byuw2KKYolFkFNa4ZzqIXGeWtqsM4NS+5Gtf84UXsRuYycUsvUyuU56/Ul9KMtd8Mcm2
         f4jmZb09y0Ob/7yE5VNlrmhvkYgQIVVc+I69OMgdotzr+68HZYjRMmZjG9Yt8GkG1xQ8
         UwQOnJ9G3tqERBHEEkMVfn6xibkW0tFyMj2M3s8X3dEd/zO+kizm38uBOrpINARKFipv
         cTBqa5sEKOz3wVVyAw2/Qt2ePJhexoz9xzCs1iOlpU9/j3Q90ZZq5Jt/FHlZvejsekE2
         iHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBwpTHs4yrJyM7zOPF1s0ina3mLaRifIQsToT4XTlw8=;
        b=g9OSGr1qndUc8MDoP37lFYuXfZltcyhe26WnRlxlgFO/fVWu3LMakOA7WPJC09YOOJ
         jDYypy5eaK/lWNhL/Aot/SC4DSsAqbFECzEkxowqIsI+kZR8QK4xno2alNYUbLJ8weLq
         CLC1xlvIcnWtc3XXj3NGtXwAHS50BZDJ1eCk5UzWDOhBYLtGJbKSZvDb+SUSwK7Go/es
         u9jF/+cjaRjGEV9LosV/HXi13XdQeHylbaXiI30sjRtlsJrW5d+cmoR9I0jtU+CcYsp3
         +2lt4ze/KZ46FfZb9dSpUEHM0wQl1JlebFjuvslT6Uw0Wp0f18d4+xil487G11Kgdl/Z
         NzkA==
X-Gm-Message-State: AA6/9RliuvY+a9/OrXYSlT13/OkMBhfWwV+cdbLbCCr2s9y0ksagfBNY5tYZfLFmv7g8JQ==
X-Received: by 10.55.26.87 with SMTP id a84mr13991958qka.187.1475085977928;
        Wed, 28 Sep 2016 11:06:17 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id 44sm4466184qtt.5.2016.09.28.11.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 11:06:17 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 14:06:15 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/11] run command: add RUN_COMMAND_NO_STDOUT
Message-ID: <20160928180615.GA3942@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com>
 <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
 <20160928044622.GE3762@kwern-HP-Pavilion-dv5-Notebook-PC>
 <xmqqponnkiz7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqponnkiz7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 10:54:52AM -0700, Junio C Hamano wrote:
> 
> I just got an impression that you were apologetic for having to add
> this option that is otherwise useless and tried to suggest a simpler
> solution that does not involve such an addition.

Sorry, to be clear, I meant I was ok with your suggestion. That's what I meant
by 'this change.'
