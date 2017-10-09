Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C5B20372
	for <e@80x24.org>; Mon,  9 Oct 2017 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbdJIV7V (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 17:59:21 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:55114 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdJIV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 17:59:20 -0400
Received: by mail-qt0-f169.google.com with SMTP id z19so473987qtg.11
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nbhqTSfEXGffkJsuOAbBslCqUFu7Wq6miUOrOigKD/c=;
        b=L0lkpfT8MCwN/VFXs5pPKTDNGKF/OOLJxQHUe5RWNe5dzA7XKpqY2+iw7S25OsF16t
         vXscS9ZDhe+LkUDy0S2vTDf0OM/upPaiEmC+9Lr0IH0h84NlGgWTg1akFXxrEuwLvjWp
         eGnSv9icUmHYSwsfcr0XawHDgaqTFZT60C1K9hiLJnf2G0IJYVd5en9yetB6ENAzXrOU
         1BqsNRn8kM2YMroK8Ez7LlUVfWlzRL5GC03te0zIYqmC2Axjny2FjOmLEgh4icMykX4D
         jrCN/azT0rYZlUMzANkyGNvUBPaeUu8i+EPQNKtFqGgv1tGn60UTwSh+ZFbqvDSfPNFf
         Wq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nbhqTSfEXGffkJsuOAbBslCqUFu7Wq6miUOrOigKD/c=;
        b=uW0OSepHYboS8usa8Dk3mqq+C8Qs6Ln6fzlikzWHhyF/+v4pCZW+TeMSKAPhfI6FD0
         Xg/38V7UddIl3aao6BM04yPrO/x7pA2bR5t45ytQ+BTMIB16I2B7Vmb1abGtJL6R7hGN
         2lRndIINa0Ho/M78F3TAigX70XyFJLYcXDSMX71SH6XG3XIz46eN3PqmYJVkTFcjDlBn
         GpHve1gni2AiXBAPg+Nx5pYSO8gq93WNzLV09MGtJpj0Yca7/TJ0iJoGOTnqnQZYJAGo
         Z/V5PBm/aBZP2GAdV6ywWQYpkWft3DNMwhr6g5iIyvt4w/vhh/zca7Ofk3ud5D7Xi1La
         dyqA==
X-Gm-Message-State: AMCzsaU+1BjDdVPLu+d7rQn7rwyLgJW1osgpYbN1wtHO+AyOjDWJP2FO
        lHzFluj49CsTEXR6AwO4IlyRA5lSo7yUgttUQxXp6w==
X-Google-Smtp-Source: AOwi7QBxSK7vg49a5Cb14SVZLaEZtK8gtoe7XjHFvnKXuPOqU3/nolBwb1sgKTsrngFXj606vJm1Tk1ldQabyyWnACY=
X-Received: by 10.200.36.175 with SMTP id s44mr16761702qts.298.1507586360096;
 Mon, 09 Oct 2017 14:59:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 9 Oct 2017 14:59:19 -0700 (PDT)
In-Reply-To: <788230417.115707.1507584541605@ox.hosteurope.de>
References: <788230417.115707.1507584541605@ox.hosteurope.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Oct 2017 14:59:19 -0700
Message-ID: <CAGZ79kYTY6U0eNwvU0PcDyt_QXGyYGm5VkDvWLtuQgQG6BbtFA@mail.gmail.com>
Subject: Re: Branch switching with submodules where the submodule replaces a
 folder aborts unexpectedly
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2017 at 2:29 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
> Hi,
>
> I'm currently in the progress of pulling some subprojects in a git repository of mine into their own repositories and adding these subprojects back as submodules.
>
> While doing this I enountered a potential bug as checkout complains on branch switching that a file already exists.

(And I presume you know about --recurse-submodules as a flag for git-checkout)

This is consistent with our tests, unfortunately.

git/t$ ./t2013-checkout-submodule.sh
...
not ok 15 - git checkout --recurse-submodules: replace submodule with
a directory # TODO known breakage
...

> If I'm misusing git here I'm glad for any advice.

You are not.

Apart from this bug report, would you think that such filtering of
trees into submodules (and back again) might be an interesting feature
of Git or are these cases rare and special?

Thanks,
Stefan
