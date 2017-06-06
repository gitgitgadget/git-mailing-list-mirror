Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921E2209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdFFSZj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:25:39 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33843 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdFFSZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:25:38 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so100543789pfj.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OobG9GnLcXbWuXc84kvMwQq3YB/iYGZlEyzoUaGk0RU=;
        b=pZQaYzjodCD4a5QdlONPKbp0216wyy6YiXt/daFQEDH3NKz6PWPXfhB6kAIgz4zWET
         fk1QGps2haIaIl53mfMW2KMnNSv2jQYxyz/i1f9AY2dUJn3MqUgDP7PN+wHctV22k6TD
         c1PZCxehJ3g/GUfCnLG7KvULVOL/OAKp+VDZcik4bvNmtvjlBOyCeRPBGrzytix2T9AA
         cC13SbimbMvSWsTRgX9I552PhoFDeHiGuSTz7gNvoM12qq99s9MH2IMKpkZ/ELGlj+nd
         eUQapZ6bRdO+Gj8NK5qoXScmxYaMzo1ZN0Il4AlWKed3R5QaJm4QG+1HKHevw9eL/JHk
         SmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OobG9GnLcXbWuXc84kvMwQq3YB/iYGZlEyzoUaGk0RU=;
        b=Tmdhw9pHBAu8jen42N2PugUJ8XpwFJO9rvpD3XmGnzqTHmK+fOv/QYYCEYyKENxlby
         r0ypiEVF2j+lfx8/CuhZRE84ItI7XMmTC/eEgg2zbdUxicqGLSrSLWyetfp6hLEsC+dA
         pQjm6vgkLQAAdfz5FMDIwuTLQfOzvw18ig2LKsieWegwPWfdBSzanWtkmHt5ziFFrcxi
         AUe4kcTXWCvKfHy2FQGp4FuKEypeT5CRKpBDmYbcIGmWeHKyc7m/r0Db/0iGEa7rm8ia
         2A1wiii0XSuWceFgRkJpb/ct4GaGs2h3lEzqQfFRyBCGv/kPD9awrE4KnI0jZmFHheCD
         tL2w==
X-Gm-Message-State: AODbwcCFn6lISX1QrnoIYVud5yuNMqz9UKXfOdd5iZ/FbfTPz8mJq05D
        BNPSlNzt0mdYhzUBzCMnp2OLKJ0NNty7ALj7Bw==
X-Received: by 10.99.9.131 with SMTP id 125mr18849137pgj.178.1496773538049;
 Tue, 06 Jun 2017 11:25:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 6 Jun 2017 11:25:37 -0700 (PDT)
In-Reply-To: <227151496770459@web10m.yandex.ru>
References: <227151496770459@web10m.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Jun 2017 11:25:37 -0700
Message-ID: <CAGZ79kbAwqb87nOm2sG7=uOO2jE6Rkgqofy5iYuZQrg1Jc2okw@mail.gmail.com>
Subject: Re: [BUG] Help > About Git Gui = crash
To:     Konstantin Podsvirov <konstantin@podsvirov.pro>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 10:34 AM, Konstantin Podsvirov
<konstantin@podsvirov.pro> wrote:
> Reproduction:
> - Start git gui
> - Go to menu panel: Help > About Git Gui
>
> Output:
> error: git-gui died of signal 11
>
> Environment:
> Debian 8 jessie amd64 KDE

Care to also share the output of

  $ git gui --version
  $ git --version

as I suspect this to come from git and git-gui not working well together.
