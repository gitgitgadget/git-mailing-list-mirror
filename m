Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC00201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbdEKUbV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:31:21 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35926 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbdEKUbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:31:19 -0400
Received: by mail-wr0-f182.google.com with SMTP id l50so30390387wrc.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRlybqGOe8AxVcKwshW3AwrD++CKwz4badL4cQJN5gU=;
        b=WqJvsqOtoq4IQkiKu+B55j0tITZjBiAyiXosUCZ86dxha8Zk3oAWYPiKgxrtuPphiY
         6WzvQkkJYrLfAOhKLrXk1Co06tIcI34e6/gbNKDjOTUUbnhd/qxY2JxmeltiMZOMycHf
         pOqI2qZmU4qirUzeMMmyC5TOpafmMptsjAjJqCZs0kvKV9zECoeEZMXvGwyMtbCLEqke
         baiU0IbIcUS66+hWWuMgJJq2JzmRafAGWuykf8qChAbKbH8A8xLCrO3xbDLCQAU/7K43
         LF4h9dQOk6UVvOptLWzggF4gcPhz9UhgB5XkLGVC93c7GbH/rDKwtzBPwG75CAGbnHek
         kSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:newsgroups:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRlybqGOe8AxVcKwshW3AwrD++CKwz4badL4cQJN5gU=;
        b=RSWszt3AjBgxbpIJpC7Q1BLImZlx/Q5NYIdjWtW8gtQIiH6EN0tdOe+/5/+T3z71DZ
         i82hD3sM5k5BD3pP7+yaC9UzuJhXTJIA6HV0Ke7iyWNMvAY9CMm8WuUmzoAsLHtInniL
         sbUoxxJ3HFbrqYiu0lPJ+iech+FtMDGDUI4WuWzP+jYLpW7W7cKKSS/9l8TL4S8rz1tc
         BXmoIarUhDglHV9p6NgHpAgOXRDpmypUqC0oxvvUclpXr8OZcE4mZYgmmV1Kd6zjeS3A
         6g0GPCEnZbdSBRLDizSndDbDSEmFJUWxyVLiFJxc6/fvDzzOGzlU/RSsSigSQKPlaJ0K
         Yiqw==
X-Gm-Message-State: AODbwcBmJpOjMazbZuAeDzPHrmEfxk+4KRqlv8k8bkCVGjP3lA1HPZU3
        ig3JX0b4sFc68wJiyas=
X-Received: by 10.223.170.142 with SMTP id h14mr239911wrc.140.1494534678243;
        Thu, 11 May 2017 13:31:18 -0700 (PDT)
Received: from ?IPv6:2a02:8109:8dc0:a7c:e417:f712:eaab:7c0e? ([2a02:8109:8dc0:a7c:e417:f712:eaab:7c0e])
        by smtp.gmail.com with ESMTPSA id b80sm7874011wma.5.2017.05.11.13.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 13:31:17 -0700 (PDT)
Subject: Re: Possible bug in includeIf / conditional includes on non git
 initialised directories
To:     Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
References: <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <5735fdc6-85de-491c-481d-9d0c18912ee6@gmail.com>
Date:   Thu, 11 May 2017 22:31:14 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-11 20:53, Raphael Stolt wrote:

> I might have stumbled this time over a real bug in includeIf / conditional includes or maybe it's just as intended.
> 1) Given I have a correct configured includeIf and I’m issuing `git config --show-origin --get user.email` against an directory which hasn’t been `git init`ed I get the user.email configured globally.

I don't think that's a bug surprise: The condition in the conditional include is "gitdir:". Before running "git init", it simply *is* no gitdir.

-- 
Sebastian Schuberth
