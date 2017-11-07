Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7520320A10
	for <e@80x24.org>; Tue,  7 Nov 2017 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbdKGRmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 12:42:33 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44551 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbdKGRma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 12:42:30 -0500
Received: by mail-qt0-f195.google.com with SMTP id 8so33260qtv.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tedhhgKEaohBZTmgZFRkZtYb8ZiqOBNAVRqslPS46D4=;
        b=rdzwA6x0d1HYt9ZyMRwO+5gIjObIylXbkmWlyWswW5093QYVAkKJAmZ7QK4TYgzarS
         cULmrN8j5b6/qXtCQjWkiEUhXM383pgq0CTc4SUArDiLCYlL1SxmVETFyOqt2I38RPcF
         uVSeBLeJ/GDUB2jV3ez85GWPtO1no/MkKYReBRqEjCDWeUtRczKumpOzePHV/yywR3Vf
         9OiKoXlyrc0OV9wY9h8PanAF3JUtkgst9v3TFVulbf6glBHrSUpB5qquA/unstmqb/Wo
         1Ts/LS+4+RwyG9RXXRGco9m5rgKYZkKcP77/1lx0fncDoeiqOD+YJtqIpZZler2l+Fea
         OEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tedhhgKEaohBZTmgZFRkZtYb8ZiqOBNAVRqslPS46D4=;
        b=NCYKZV9fNPryAZSvMHYTdkMF0via1tE+1+wKkr32M310oBzjDTKFOi1JJxr+SrcVh2
         JVXmNy9sKxcTuVTj6lHCnpaX1M2fRpuT8D79MuDJdupyGAU4qvp66T13wQGRCAgQyO/K
         sOvn6Pb7Rul/wclAgn31n9pQqGIy7x+ozOIRla5bwamj0i9s7j7RSFWyciXt5hqjDv8v
         f2b+5jTH9nn9arp6vP7hFTlYUn02K9LgdjEHDlICz5tMlTJh/It6gP2CZoVyFILIBxZI
         +oNzI5f268hAMeIs+T8hZtz+ZCbItLsPs/i2oMm3322yI+xhnDw9iNd/MLvnemwRHqLs
         c2qQ==
X-Gm-Message-State: AMCzsaXymQyKaJ/q1Rk7EmgvVDXFAsQNNC5wbr87pfgliTDgg5n6kOPT
        xCK6iUUEM7RMrmZi2Rx746bFpt4Q+bTLbySr3fn5Tg==
X-Google-Smtp-Source: ABhQp+TUUGdUBOZzNZQgOMMZdtY2tNKn7EPzZFsRNIyBx9e+5VPZAvMvf3CZ/4tCSv16mCAJnXZQ4UoO3Avik4l5r68=
X-Received: by 10.237.37.132 with SMTP id x4mr27526713qtc.224.1510076549407;
 Tue, 07 Nov 2017 09:42:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 7 Nov 2017 09:42:28 -0800 (PST)
In-Reply-To: <xmqqinemdsxm.fsf@gitster.mtv.corp.google.com>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com> <20171107064011.18399-1-gitster@pobox.com>
 <alpine.DEB.2.21.1.1711071329280.6482@virtualbox> <xmqqinemdsxm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Nov 2017 09:42:28 -0800
Message-ID: <CAGZ79kY3OH_o9w0XqcxevuKTqNWDpjVPn3P8gttO_DgcDekFSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Teach "diff" to ignore only CR at EOL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 7, 2017 at 7:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Good. I was wishing for such a feature in the past.
>>
>> However, the short and sweet `-b` or `-w` switches are really, really
>> nice. `--ignore-cr-at-eol` is just very cumbersome to type out. So I think
>> you will want to add this patch to your patch series:
>
> Yeah, I should probably have added that to 2/2 from the beginning.
>
>> -- snipsnap --
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 0e16f017a41..b7a45e8df29 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1400,7 +1400,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>>                       --patch-with-stat --name-only --name-status --color
>>                       --no-color --color-words --no-renames --check
>>                       --full-index --binary --abbrev --diff-filter=
>> -                     --find-copies-harder
>> +                     --find-copies-harder --ignore-cr-at-eol
>>                       --text --ignore-space-at-eol --ignore-space-change
>>                       --ignore-all-space --ignore-blank-lines --exit-code
>>                       --quiet --ext-diff --no-ext-diff

That series, with this squash, looks good to me.
