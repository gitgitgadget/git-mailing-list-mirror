Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683D71F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeBHWAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:00:20 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35747 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHWAT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:00:19 -0500
Received: by mail-qk0-f196.google.com with SMTP id c4so5324570qkm.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rTM8vZnlYJcx6GQk8fdL+cC5NI6luowi8Y8lyax2tDM=;
        b=pBp7L28eahsJ0C9270WVpqmTPAYc96Hq+SI6X1cBqkyXPhpgvURW73vemPBmpd1c30
         P0cdbZL5V/SBulUQO9NMI3x25fAbfLqXI53bJCnwW/RHZ3QluYOhN7MRFRwZybEEGiWm
         NKhmomFuQMVQN7H029iXQ33SKEEpxnBD/KlFywo1JFCokc3w+azgmFd6MvmMyt8Id6Jg
         kV1GQFlDULb70xiQzZQgw62EzHgymg7wsxs+8oSA7+w5qpwisBomSsIS9McclrT9cZrz
         +O9lim/fDdqNJrXuYj6MvEuD7z/NspJCgcJf871da7wCj82bfMbvvxcY+vfFkcCrwnDQ
         1hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rTM8vZnlYJcx6GQk8fdL+cC5NI6luowi8Y8lyax2tDM=;
        b=fLpO8sokWff42QlVV4cxzPUlcTBGkzf2iJ+FwMsFPjhj9VztuUqJ6pgzGJCvVqWTEC
         /HuQQsEj2CwSpmnkhDZrMREtAXWZfFFeIPVgUdFH0xRP85AyTzQZDLTRziBHyq7umHsC
         08XcQ5Gyxk994y3hJ0ae96Um2ZF2DCSwYEwe3QbXwzWN+JSm0H72ImLiFdFpNLj7Eg7K
         XfYF/pIb0FO/VGLfmE74b5JgWbWyMCgGJGAkRohBRy1M3Rv8lRUVD0+KamTEW1Ut6Tx+
         n18DhtTvCrJmjg9L7qUyCW6YCqfBFxTihv8I6QZ88QxjljYBGc/ARaSxnFuefK8/N53s
         +Zmw==
X-Gm-Message-State: APf1xPAlybAxUWWElZUaTf7ol+velXDOM1yHRP3bU9+hSotjbwQOaI06
        jGIF/tmZ5EScABlyDMMqihTxcudI8301EGt5DH8=
X-Google-Smtp-Source: AH8x224ABBdg/mJifOINVSmM7CYDHwsvuMDL8g3vs7FrEg5XwvGPovX2vsN2K38xi/L72q031AXsXs3wfhGmhP9ftac=
X-Received: by 10.55.36.68 with SMTP id w65mr737076qkg.132.1518127218621; Thu,
 08 Feb 2018 14:00:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 14:00:18 -0800 (PST)
In-Reply-To: <CAGZ79kZ1WA15cybgi9u5h2fh37TOjYmDpLdHgFfyLGBf8pUwpg@mail.gmail.com>
References: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com>
 <20180207234359.31493-1-sbeller@google.com> <CAPig+cQejz+1ZWep31hw0pjxUoewRt+-2WATtw6PEusfvhn8EA@mail.gmail.com>
 <CAGZ79kZ1WA15cybgi9u5h2fh37TOjYmDpLdHgFfyLGBf8pUwpg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 17:00:18 -0500
X-Google-Sender-Auth: HXvq33Vsld-vyUiTpT0CIUNrMRo
Message-ID: <CAPig+cRyx1KHJMn97mNy_BmX1D+cGEqVUT6x3Bw+tmsUOE3J+w@mail.gmail.com>
Subject: Re: [PATCH] send-email: error out when relogin delay is missing
To:     Stefan Beller <sbeller@google.com>
Cc:     Ramkumar Ramachandra <artagnon@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, mina86@mina86.com,
        mst@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jan Viktorin <viktorin@rehivetech.com>,
        xiaoqiang zhao <zxq_yx_007@163.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 1:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Feb 8, 2018 at 12:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Feb 7, 2018 at 6:43 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +die __("When a batch size is given, the relogin delay must be set\n")
>>> +       if defined $relogin_delay and not defined $batch_size;
>>
>> This only makes sense is 'batch-size' is specified but not 'relogin'.
>> If the other way around, then the error is confusing. How about this
>> instead?
>>     "--batch-size and --relogin must be specified together"
>> ...or something.
>
> I like this for its expressiveness as it would have helped me a lot.
> I dislike this because it is incorrect when you use the config options
> instead of command line arguments.

Perhaps:

    "`batch-size` and `relogin` must be specified together
      (via command-line or configuration option)"
