Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A611F453
	for <e@80x24.org>; Thu, 14 Feb 2019 08:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfBNIXC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 03:23:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39803 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfBNIXC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 03:23:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so2719822pfa.6
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 00:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QCQzr6YJc6g5zOI1pA/VNAd2rCg2j358lH+BebWjbfc=;
        b=RnNrAhzX70tvZMVmPIA9grMFN0p7jwUm6UsYFT8EBCr8IxHw4/uhNH1rjtbkfEpP+Q
         uzQngFccEDZbssMwQSulDEhb6W+PFzp+RiHfTX632dN5I2Qt3uwt0xOuOZvx81hwM6kr
         zuBW1Gi97+UK3rE3jEvyDnREjvFd6q9wVx+D/X53TpJe06K8xHxXdnmLj/PymDySBo2g
         IVh0MQeic5mP1qzL7Ne9iLnjZm0T5L8t6jQ7IdJjnT2CYUpyhEwxWt7k+x6WrKJ54Uyi
         TNul/H1KTKsL43X5bOUiKdn8jZ7F2edSKlx/jMqYkQNVQOXJBv4cIOl+thcysP9SqJ1V
         Cffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QCQzr6YJc6g5zOI1pA/VNAd2rCg2j358lH+BebWjbfc=;
        b=jIO7W4GTjuwRbZfSqNwiaE7DBdLXn8KSbLlAl1SCnT+fiHvBYO7bRiQgC4SmB1TvT7
         6AVe3sUUE/AXqyvebry+GBti6WDtWn9XPO6oxzd92WhgwGXIWxYcUWKuKF24femh5Joa
         lEGiwXSlRnyqalNS3gpvSoQPLJ1RWGSmH0d/mEMm96sbX7YHIqeJjbAlkbGMPqQdd05t
         ccOg44DXUj+V3OYQi87a277vpY7cCriC4UHPsVJ4JD6xxLsBFJ1n6uXMys1KIHEwxdQj
         z8MvmMDBBIFK83mndoDRSl18YAOW06+RquzQhCKEXep7yJYw0YcfKDuBDivy3f6VOew/
         SX8A==
X-Gm-Message-State: AHQUAuZ4I7q0Cn+usEsQgj2s1yM0CW8t1n/Ds5NQhbem15cP8QPqR9ig
        M7pWhIOlOHONs7Ck/Umwe3SHi+IIHp0=
X-Google-Smtp-Source: AHgI3IY5mLD6lH7/XfeB9FIln6B1Z03Q8Ya69hqrcrJDzmugNXZlT9u9Wr7xlK/2qHxH2U9Ahk2PXA==
X-Received: by 2002:a62:168e:: with SMTP id 136mr2823171pfw.116.1550132581031;
        Thu, 14 Feb 2019 00:23:01 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id k71sm4033260pga.44.2019.02.14.00.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 00:23:00 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:52:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     git@vger.kernel.org
Cc:     vincent.guittot@linaro.org
Subject: [Bug report] git diff stat shows unrelated diff
Message-ID: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am not sure if it is a bug or not, but the output I got wasn't what
I was looking for. And so looking for some help. I was looking to send
pull request [1] to PM maintainer and was generating the request
against his tree [2], which already has kernel upto v5.0-rc6 merged in
it.

These are my local branches:

Branch A:

55538fbc79e9 cpufreq: qcom: Read voltage LUT and populate OPP
f896d06665ec cpufreq: qcom-hw: Move to device_initcall
1c7fc5cbc339 (tag: v5.0-rc2) Linux 5.0-rc2

Branch B:

a4f342b9607d PM / OPP: Introduce a power estimation helper
285881b51eb5 PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
bfeffd155283 (tag: v5.0-rc1) Linux 5.0-rc1

pm/linux-next branch already has Branch B merged in it (with an
earlier pull request).

Branch C (7c139d3f0f99) is a merge of Branch A and Branch B. When I
try to generate diff-stat with:

git diff -M --stat pm/linux-next..7c139d3f0f99

It shows me the diffstat between v5.0-rc1..v5.0-rc2 as well.

If I do

git diff -M --stat v5.0-rc2..7c139d3f0f99

it shows only the files that have changed in patches in branch A and
B.

Since pm/linux-next already has Branch B and all the rcs upto rc6, I
was expecting the output of first diffstat to be similar to second one
(without branch B stuff). Is the expectation incorrect ?

-- 
viresh

[1] My tree: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
[2] PM tree: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Top commit in PM tree at the time I was trying it:

d26ff2405272 (pm/testing, pm/linux-next) Merge branch 'pm-opp' into linux-next
