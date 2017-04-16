Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C09D20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756270AbdDPQ3k (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 12:29:40 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37434 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755948AbdDPQ3i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 12:29:38 -0400
Received: by mail-wm0-f51.google.com with SMTP id u2so20620973wmu.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eP7NWwCfju2ZBq5MHgbxoQatxoU2V78OJWqhua9qcvQ=;
        b=uphMFnxAyiDibmfBcjMEzp7Sek69AXfLz7nvUxXvR9X7PBVmCjgq+AX4cW1y1Y79Z0
         dZVZ9A1YOpWWHBndSOiK0JnOk4Hk/dRV+r94SCv4EvIFg1b2O5x7lbpC6/jOa//u+EoE
         Yfjifse54R5IVIEOJ97/6csbh1suMp4pSONv81VYjiyGd1Yln40PwCGKIUfWEUFxN3Cv
         sbTXMBIc37Ol35ps0S2RkPW9xANA9HS72Gq8XhX0KZ/X0btuX6MeR5tbqUBuqMixDuqo
         kwuO6x42+PZUMG/YzEfjUfxyMB7Btg/nhzNQ1gcN0On3uy7t5txZGcBEyPhx070g0UbN
         GkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eP7NWwCfju2ZBq5MHgbxoQatxoU2V78OJWqhua9qcvQ=;
        b=j9xx8LTQRXmX/Q+m5jMO1vupe35kT7t0sip5IpQ4O9OM1hdD24kQ8sjDpDkAYPi1q8
         si9vlmjIOb3QyaDbg1qG3loLP4lIhxrV/N9SKfV7k4IrEl+2aS4uUKKq6H9d3bJTkfrI
         oZe1qXSgIw++EboNM7+dliQcSP7/ZRzxtT2clnJQyPPApOb83BfIscLWxaCjpuEECN+5
         uB3wKtY7/pqZtdBhj4q+zPhsdpbjfVzI3mwPqqSwzJDMc+0H9cS80kijSE3gQpRJaC0W
         WgyqEWLwKp5PzpzIrW1K4N3yfK1ozz68/vuxIKedAJhhQKXdn469GxwaFf6wmKcPUZgj
         OK7Q==
X-Gm-Message-State: AN3rC/5IW88tUkLiQFU18WgdfZgxKjliZyz9StwBUr0bwN5Z1Zh2UjgV
        Wf55hGF4tRMI4SyS1VyDfSiDUW29VA==
X-Received: by 10.28.175.209 with SMTP id y200mr6248215wme.81.1492360177399;
 Sun, 16 Apr 2017 09:29:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.173.78 with HTTP; Sun, 16 Apr 2017 09:29:36 -0700 (PDT)
In-Reply-To: <CACsJy8DQWrLZF3wUQ5WF2FfriM6ko8Zwm_x5ErEEWTE6n5rayw@mail.gmail.com>
References: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
 <CACsJy8DQWrLZF3wUQ5WF2FfriM6ko8Zwm_x5ErEEWTE6n5rayw@mail.gmail.com>
From:   Alistair Buxton <a.j.buxton@gmail.com>
Date:   Sun, 16 Apr 2017 17:29:36 +0100
Message-ID: <CAO-Op+Fd9x7O66skWWy5TkTfMst7ohUiw3U9MMujyvYsjWnFSg@mail.gmail.com>
Subject: Re: [BUG] ls-files '**' globstar matches one or more directories
 instead of zero or more directories
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 April 2017 at 12:25, Duy Nguyen <pclouds@gmail.com> wrote:
> git ls-files ':(glob)**/*'
>
> Without that '**' is a normal '*' and matching just subdirs is expected.


But '*/' should match exactly one subdirectory deep. Instead it
matches one more more subdirectories.

Meaning it behaves the way '**/*/' should.

Try the following in the git source repo:

    shopt -s globstar
    diff <(ls -1 */.gitignore | sort) <(git ls-files '*/.gitignore' | sort)
    diff <(ls -1 */**/.gitignore | sort) <(git ls-files '*/.gitignore' | sort)

of course it works as expected if you say the magic word:

    diff <(ls -1 */.gitignore | sort) <(git ls-files
':(glob)*/.gitignore' | sort)


-- 
Alistair Buxton
a.j.buxton@gmail.com
