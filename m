Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCB51F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdHVXSs (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:18:48 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33137 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdHVXSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:18:47 -0400
Received: by mail-yw0-f174.google.com with SMTP id h127so971273ywf.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jopljS7UePCc/bAyKJHS3Z0lDx5xiVsQntQzmCMFomo=;
        b=I4tJkvJzTGbSGy1TThSvfcPAij7kNbmF5Xsuu/lPKUQCTivDtGqfgRwFj+lY3vB0Z+
         3NCSuWvjzY1vD9ybdgQ4umBy3xktnHkrXA5+vUU9/e4LWVRqVY/JXgpGXHtm7rOfLKpJ
         JEEowhfHvcrqTOx5QRSSOAEzhAv0xjg1A9jXJfKjlEL88HGvsoSRjP2zU50GuB1goKzG
         g7Q7w4vb+ZWOs4jkG59VSCnIOkEEKIvXCDdQO3otnnONOvcFHy4xdAOHLaSJkGAAyX88
         Hm7rnHyJ8HVDdOSgc/6wfBxX6hv858qiubq6+quKvd+Kchy0aIypp5EOXA+rhvtiQFdI
         mE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jopljS7UePCc/bAyKJHS3Z0lDx5xiVsQntQzmCMFomo=;
        b=cGJQr/W/kx/+KCdoB22DRKuG2j3wp/34IYsiuytIfCDWcRig5kjtxAkwI7qeC+I8L4
         fmUiz8XUmTphGTOYdxyCu1k+uUnz+fAHhOEft+5SFMZOn4yaYS9yw4E5xIZWR6KNbpl5
         Drx4H4VSjX3EnLttDHfbBd0DwDJ/yrR7M6kbBkD6cRjPvDVm04mHGdH+u5Gx6ZWeJ++m
         XLsVN4YWWV7nOYey18nVgphq08AykOzuyPftAu+TaukzwyKpO7fF7BpkZpDHAhBoQd+e
         SoSrSWOVbaZj6G5FgLeQbZ5Z5pqXYmQAQBja5sVLL1j8uY/H5Kys7DKJVhpYxZDjZXFO
         sazw==
X-Gm-Message-State: AHYfb5jEx/Z1g0thYND9GaVgoALEb4a2ezh+MP7Hnlpa2KF7DQYheMQi
        XXEb1e7FEc45OObY6/2fIx3kBYL+AypV
X-Received: by 10.129.93.194 with SMTP id r185mr607176ywb.33.1503443927109;
 Tue, 22 Aug 2017 16:18:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 16:18:46 -0700 (PDT)
In-Reply-To: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
References: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 16:18:46 -0700
Message-ID: <CAGZ79kZW_+GEKyP4+8agZ7nyjGEZ9p5d3N99W6sC3GTY_4Cm-g@mail.gmail.com>
Subject: Re: git send-email Cc with cruft not working as expected
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 4:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hi,
>
> I recently found an issue with git-send-email where it does not
> properly remove the cruft of an email address when sending using a Cc:
> line.
>
> The specific example is with a commit containing the following Cc line,
>
> Cc: stable@vger.kernel.org # 4.10+

Please see and discuss at
https://public-inbox.org/git/20170216174924.GB2625@localhost/
