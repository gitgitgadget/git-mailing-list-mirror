Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73AE20179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbcFQQnQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:43:16 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38640 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbcFQQnP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 12:43:15 -0400
Received: by mail-wm0-f50.google.com with SMTP id m124so7077003wme.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 09:43:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZC9pfsgO7UvQgM6Nmzl0HvXWfzyL3qy++HJ1oU0p5TA=;
        b=DLzbbqWOZbm2b9gbNUwSiZx2TBojv5fg5T8PkwfX6gkL36NFjTkhsutN+tyA7vb3Wb
         OX2d+2AJsXxHgKUg7zSSpfkdOGigMO1P1k0q5NOXn2jo+HAnGJD2JCqqNdw/dHB3ifQ2
         7YdU7nrN+YhUNf0VAgxTlre59UJhJxAP6nCy90M9mdVwlgc2TFCDgGHaFkg0VlFhn2Xb
         bQYfy6pWEMXfQ0Pwya6pZPGc2ujxNLGidlWGHWFvFVLKTK/2nAhL0kIXTaeDw57Ub5Pe
         xc9RdIoyZ/Nmvg7yyHWmCL6gjKzwrHWjsyFINER7tKPGmElG9gOFRqiZndgM5+aunsM8
         imgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZC9pfsgO7UvQgM6Nmzl0HvXWfzyL3qy++HJ1oU0p5TA=;
        b=lu4tRx4fliBOSf0A2yEtQF3srlTIyIjEvZ2dXoT1+rdJjGmz37Q0bN4aXMdy2b2rmE
         ENCOVmfn2OpCO0J885tV/MSWJrdioliigkjJ1bsFYCutsNCOMD1QZdY+xgVaLlj55E0N
         tdU//O2+ctyIJHhrAZHT0ROXYgS77hJ0S3iE5cMw6g4KfpWn4KTOd5ARy2voLX4Z4Asa
         IfrvbPgeEHNryujCjKTerXpPXyACxHJIbV2XqL063NdOVGpm4mfx5vZ8l3zhQ/wCEMm5
         o2FZU44QQrDJMqPJL7cUDC3eMCzJX/48niYH/7gECw/q27S1f6rNcgVSTwZEDTpPGWg4
         cPMw==
X-Gm-Message-State: ALyK8tJXIcSJQtYhtuPKjgDNbMHxKqzjDZ/Gq7+x4QkrhUfoIyla6O4FDBRNM3p5ES6YffcmlWVForjZXnkrTQ==
X-Received: by 10.28.129.208 with SMTP id c199mr522706wmd.79.1466181793863;
 Fri, 17 Jun 2016 09:43:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Fri, 17 Jun 2016 09:43:13 -0700 (PDT)
In-Reply-To: <1463694357-6503-5-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-5-git-send-email-dturner@twopensource.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 17 Jun 2016 18:43:13 +0200
Message-ID: <CAP8UFD0RAgUmKr4tG7xHcz75vpXAeuWi9t1+9mvbGOVzOcHcFA@mail.gmail.com>
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	David Turner <dturner@twopensource.com>
Cc:	git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>
> +static void loop(int fd, int idle_in_seconds)
> +{
> +       assert(idle_in_seconds < INT_MAX / 1000);

This assert may not be very nice to users setting the value using --exit-after.
