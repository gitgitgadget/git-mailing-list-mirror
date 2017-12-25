Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7250A1F404
	for <e@80x24.org>; Mon, 25 Dec 2017 09:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdLYJA6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 04:00:58 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:43266 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdLYJA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 04:00:57 -0500
Received: by mail-oi0-f46.google.com with SMTP id f69so22366439oig.10
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 01:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TZ/0wEgVNaTbrnND6gKkDNqk2ool+/YCrsy0JRCOAwU=;
        b=f1bfSdFS1SW0RMEV/I356B33BfAfVfQGyHx7+qjwIg9XvdSDOfBNYm6yN8ZGHUk52Z
         ShIBJZrkUsra+uKriO9Dsc2yk1mGwEknN6h7PpdXi2t/kPDBog/k/USaHxbgE3SKnFzb
         fe9o7E4bUmjtL3Jmt2knD8xom9N7wDu9+9lAeockveVyw5p2wDKckW5rw3LWp1udGwhO
         QGPKkCD3KQ+Scxx0iOpWn5Cif2CazF6sNmwCqvWV+vRyvpN7h3fCZUZcNHne9K8fBuXA
         oB7xFMv1G+CCuX7NVFvuyQl4J/7pYemldw7x+g0e9fQg5U1uCU/jUjrbrGk0cd+9Wv4U
         nwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TZ/0wEgVNaTbrnND6gKkDNqk2ool+/YCrsy0JRCOAwU=;
        b=TdFD10ipQF/vjID2ypQnWFTyS9OEyNdnh7tHCnpZqGYJOxThEmFzFNo2Ow4fGhICpr
         rxgxb3bR5zJoEILfNsJ6HjDvEqsN0hQafcYqYVLOncWGHwdTfAdtCxsjroaImo/y62Aw
         7VgOtAappwwY5kOUni4wlwmA0QaysTNnqzMwhRAtqVnpofdqWdVGRsFFQk89y5ig3zSM
         JDo7kGPjpWVrnNMDMMbMWRKYRoM4Mbs8pFqw/++IH2bBm/+ErBKpaV50+eRrhGHIg1qJ
         dUMxuMtUoot0/oJCi7fyGbCoSJkqvzZsH69fcJCTZXyVaaAqiWfJcsD788+gWyYjABzc
         Qcrw==
X-Gm-Message-State: AKGB3mJv4NH0d2LhxwbhaklqHXTmUytpQdlBq4sWwOukNcNJ2f0a00cL
        5+1Ee7TkBs0t30eS95KlzN4J8BVMNQLUMq894lw=
X-Google-Smtp-Source: ACJfBou1XgNBqENM0DjECmGkEgw+P3elRyUg1V+Qg0J6X5vmBERXPJl0j7dp+AKyOOmsEpy1IVhZd9IqmhGJ4mH/E4U=
X-Received: by 10.202.207.13 with SMTP id f13mr15241637oig.351.1514192456704;
 Mon, 25 Dec 2017 01:00:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 25 Dec 2017 01:00:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 25 Dec 2017 16:00:26 +0700
Message-ID: <CACsJy8A=jZ9LAuM50GVjNT5gtdiYYMyMuPBSrJFO4LmKVQsETQ@mail.gmail.com>
Subject: Re: [BUG] File move with `add -N` shows as rename to same name
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 23, 2017 at 9:42 AM, Alex Vandiver <alexmv@dropbox.com> wrote:
> I just stumbled across the following oddity:

Thanks. I'm looking into it.
-- 
Duy
