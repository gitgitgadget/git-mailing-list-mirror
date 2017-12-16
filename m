Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225C01F406
	for <e@80x24.org>; Sat, 16 Dec 2017 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756865AbdLPS5g (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 13:57:36 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:42137 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756846AbdLPS5f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 13:57:35 -0500
Received: by mail-pg0-f54.google.com with SMTP id e14so7599802pgr.9
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=/QQLJk3LB0fPGxqDUgEE9nbEJFzUF+Mn8iJA1WhbG0E=;
        b=rKDE/8j/WboncVt1rDr3ArFYbfhofgmYAdcU1FzgqD2aDVBNhMCDasu0lnpZZ17D/K
         HRc1o5OTWjsmm4wgBRx5AnJRxKiyhw4IdromqNEjehHlTiKYgZ94WlKI9ni8FZhJ6ybS
         8JjLFcBIr5ETc+Y84kgAhRhOvSOLCyy3sC1y8yFKnupUd75xLYhDGXl2ZXJ9UABz7MXR
         wxGoBi0fvynmzw2B4H97jO3jgX6CzT2Rcp5jL0iFTH/roexcTc7IcHDMkOZsQOHwzPTD
         weKoUzMMs6zD2QqBTwBmFe995jbgRQyUsXb+g2UIac7KuWwvAiIgX3EDRQyH1UM3PUm3
         cdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=/QQLJk3LB0fPGxqDUgEE9nbEJFzUF+Mn8iJA1WhbG0E=;
        b=XlZ1I75UEOE5DgZes2hwGKiR9U3VDBOrcaO9Lrq2Go1YZXtTG2po9dpjcwCr/s8D6+
         SPv5ei1yjvgl8cOudvxJppfcvYswkcBxo3YNto9T33g5es/U01xSo8EYEDTU3PO8BWnv
         LdNF2xzsbh/LaE2hnl8r/bed2yjC1xPXaN+d0jeJSHIUWL4eV9CAsxACulf5UoJHQDQW
         KV21Nzdpot0MB1Q8kBt5uqRv7/Llxd/6jKBTZiazV6OzO2OlA+HrW4Dqe7e7UpkgAx4k
         DIyjK1ZkEbE/DQ+F2mDzNLBW3hOYAltDAqzNUDyOab59FhY1EJe6BynvosonIENMwcjl
         +LVA==
X-Gm-Message-State: AKGB3mJz4yblne/1ViwarO1qy6KIs9gGHblpcmCTaXaXVn/6SMQTO87N
        JKgD3G7OB3Hnx1lEVpFL1pOssO87
X-Google-Smtp-Source: ACJfBotUdW+x4+gpVsHXc/Jp/1wI6X0Dna8rW+tw8zl9zoBQo75eFrDlQ47G7HOFSXoD14dKKPCgyw==
X-Received: by 10.101.81.69 with SMTP id g5mr15587302pgq.324.1513450654780;
        Sat, 16 Dec 2017 10:57:34 -0800 (PST)
Received: from [10.4.2.238] ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id f79sm19201588pfd.45.2017.12.16.10.57.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 10:57:33 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: 'git format-patch <ref> --summary' seems to be turning off the stat
To:     git@vger.kernel.org
Message-ID: <b620caf9-e11c-1511-67a6-d9f981f28728@gmail.com>
Date:   Sun, 17 Dec 2017 00:27:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for "--summary" option in the format-patch Doc states, 
--summary Output a condensed summary of extended header information such 
as creations, renames and mode changes. It doesn't state anything about 
turning of the stat. Why does the stat get turned off when "--summary" 
option is used along with "git format-patch" ? Note: I do see that 
"--summary" is a diff-option but does that mean we should't be printing 
stat information in the patch when the user didn't mention "--no-stat"? 
Yeah, "git format-patch <ref> --summary --stat" does bring back the 
stat. --- Kaartic
