Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2FF20248
	for <e@80x24.org>; Tue, 12 Mar 2019 02:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLC6q (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 22:58:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCLC6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 22:58:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id g20so997593wmh.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 19:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpq2T1m9kaO7RPafDVAJ40iaw+ABg7NsA1otzWkVXEA=;
        b=flJOXTmgFjquB3KQ14XKGIWDBvySaTmWISqZ0ZPBxmTWMGoYLJ8nayqLOgEuVmQ+w0
         vMRs7dlrOeyWoDiI+pKSAih94pNsZYONavtJLoPRYeo83GrdlJoPbOuuWXYlLl1vTx8H
         DxFiY5gCCm3EaGNMzKwBoudm+V6u+fRCettVAltS55yo6p9skK27fG//lb0ojZsvwe0w
         RTKrnpw3h14RnlWiGglYc7dNVY1DP+Hz4mpHETF1V7vkgvL2fc2oodUilaxB5W3slG/m
         KPHxXb+Ksm+s3htZAV2PiapxToHkOofvk23KllAPfXyULOqOORdrf9ar8iWzib9wD3uc
         jjVg==
X-Gm-Message-State: APjAAAUQAV9HRLsX71h1uImn3qJzU+G6gUfo5MDTrkzXJg0TPkykON9D
        IzJcSwZZdunUMhAJyI3EEFV1XrRdM1redVHwNXQwgdNu
X-Google-Smtp-Source: APXvYqy2XOFl2LqBXs0iM+lN9b67kD93kVhEadB/UUdIcVvwbhZLC5O6oQdcaqOblujolWPqBOnOx9oedxvzjx/i0O4=
X-Received: by 2002:a1c:f503:: with SMTP id t3mr76417wmh.71.1552359524044;
 Mon, 11 Mar 2019 19:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <d5d47b6b-25d9-a649-e13d-76e98e07ed51@ramsayjones.plus.com>
In-Reply-To: <d5d47b6b-25d9-a649-e13d-76e98e07ed51@ramsayjones.plus.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 22:58:32 -0400
Message-ID: <CAPig+cTqdeVXyYZarGOb+AiLOERO0HpK+ykYgrAddyFzPG0+Mg@mail.gmail.com>
Subject: Re: [PATCH] sequencer: mark a file-local symbol as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:53 PM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> If you need to re-roll your 'dl/merge-cleanup-scissors-fix' branch,
> could you please squash this into the relevant patch (commit 9bcdf520cb
> ("sequencer.c: define get_config_from_cleanup", 2019-03-10)).
>
>  /* note that we assume that cleanup_config_mapping[0] contains the default settings */
> -struct cleanup_config_mapping cleanup_config_mappings[] = {
> +static struct cleanup_config_mapping cleanup_config_mappings[] = {

This was also suggested during review[1].

[1]: http://public-inbox.org/git/CAPig+cQGvmi-237s1Leb1NpOMA0683PkCG4HBCKn_+x5YDHnCQ@mail.gmail.com/
