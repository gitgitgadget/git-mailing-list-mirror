Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B56120193
	for <e@80x24.org>; Mon, 24 Oct 2016 22:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965644AbcJXWVM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 18:21:12 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35137 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965254AbcJXWVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 18:21:09 -0400
Received: by mail-yw0-f171.google.com with SMTP id t193so209643948ywc.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oRLiXdyH5S4DKF0xdF7YqkB0s0YNhQgPjMRS1BRbgww=;
        b=rHkxY/e0E6Ad7YivdfPxAaeRZTpCyWroA9iOb8jXTPDXwVps6ViaeJ/TnujHUcBQbk
         5qdMIHJvauED/c6Og3qBpApXPbToIEN1gfi8AL3GJLDGT5ekh2d35zoK+J2NM1SiTede
         AMnUpHotRCfwMIDi3BVnVOKyhA+tYDGLydyA+kuDYwYM5+wLvvc9h3mD44D+gzVxlEoC
         Remra1zykNPqlDjuLmzpco0Oh1xoy4rZ/Y+RyWamO7WXFDCSeIKxFbrpDcZScpzFPoF4
         ZL509UhaHji7YEb8dG24EKltBJL/f8OR1PstR4vixBRtW1Db5RCpWcFadJe4701Vz/lE
         Ha6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oRLiXdyH5S4DKF0xdF7YqkB0s0YNhQgPjMRS1BRbgww=;
        b=UzIhoT3EUKDSFCHtZIeGFFq6/9b9y3cQVTLKjA1LeIZFciMKC/cMi1P+h4QhIXUAqs
         fKzA4NY3qsfXV9hKSYJOpOcM0Ake7L7hnmXjATNb/nwe/+GyNaSN5K8K5+9NvXcjbSnE
         Fvmscf/CxpS15ezFCRm4lv09sste3bb4uN1G6qUI5UXlhCHiR63p+H+oHDXIlyfEypRB
         unUJGqW00PpXUrQV1AdkJ/PDh5XPTeDU34P7qWqUuNk2d3uDHO1oXD2ZM3vyqttXam2P
         Xa3aZ/cvwCi2ZaRCjty42+43UTJ3wd+KwjijP/2ufuN+iAStDcSZse85wtahe3nn7OPT
         1Ctw==
X-Gm-Message-State: ABUngvci3B9Q8IQ8R4xuHWiHrQvrterrj82qXMTz60E5WL1haPYtfUdnx2gk+6ls7MXu54mxLIOC+85jP5xR3A==
X-Received: by 10.107.167.82 with SMTP id q79mr16287045ioe.120.1477347668207;
 Mon, 24 Oct 2016 15:21:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.212 with HTTP; Mon, 24 Oct 2016 15:20:47 -0700 (PDT)
In-Reply-To: <20161024214601.GA11699@hostname_variable_in_muttrc>
References: <20161024214601.GA11699@hostname_variable_in_muttrc>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Tue, 25 Oct 2016 01:20:47 +0300
Message-ID: <CALhvvbYnTf9qqsCFWjgfnynRy9LDEQf=Y++2tQioTKHbaYGHDA@mail.gmail.com>
Subject: Re: An anomaly, not a bug
To:     "m." <botmetkas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Note: the comments can be started away from the left margin,
> as normal in all unix-linux configuration files we know of.
> Git follows this behaviour fine.

Actually, git reads

    # comment

as 'ignore files with name "    " (4 spaces)', and then a comment.
It does not ignore the leading whitespace.
