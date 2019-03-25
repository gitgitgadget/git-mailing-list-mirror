Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD40420248
	for <e@80x24.org>; Mon, 25 Mar 2019 01:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfCYBSE (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 21:18:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33298 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfCYBSE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 21:18:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so8449663wmi.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 18:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RtA4grjmNBFzdp81uzijYxeVF9dGiGedgZsWCzAoMnA=;
        b=KU3pgOAu2su02z5RJs+8kfxpaLU+p4rkWnAQwKcDPCvN9VfrG6AmlJnNgbKk8RKjNl
         dVvpbj4PkzJcFwkPC7TwEo7bfyp7ypjvCJLQnWE+FA8HQRKW/PktaS2qfI3SmWOwDlGj
         WA8kjYS6xxgKgL0ugwxcQsaL4Si2dryEyNXFCfxeNrX9rIJtfpIBvojalVq7ZQK0ZZet
         b0mm2wiu5ftthcLmjw1FSAPsyamsRrv+UU6jiA82SQ/tF1fPnFdcZPJ2AoCjeQsBKJKK
         XjbWmBn82KRTRjYqh5ECRKwQGPGiG5khv8snalbO0ZMAwi7vG4j+eT1X6dbZn93l3Qzf
         +2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RtA4grjmNBFzdp81uzijYxeVF9dGiGedgZsWCzAoMnA=;
        b=KrPd4JtFjFpG9hcmwxUAV0S/CF6BksoZM4xGZtDuoa6doszrXoUIK98R5vI+0JkKRx
         zjFBg31yYH5wKcgT9Rzqka/zryIfs30B2CnCIhzPyYL5vx6zkjkitHcfrQUWfY0VL67i
         o1h1lcQ8n14wKtJriQvkrXZzAJx1n7eBL+Q+LO4UUksu2n7yjeWVjYmZwrdW13Xn0HAI
         g3UmjRmm03Z00hyqqct9XzbvpKZ0Zv9tE8oISNFaGepePZQl2h55bBiZgmY/HG50zlmP
         nVB8Rxh1FKP6xfs5NiB51ykJpqiJqO37MGDxeLsweszwb+VeifPx81UKZ2BF0wnPuQOU
         L5Zg==
X-Gm-Message-State: APjAAAU9epdvWm1+0Cb5KKu1HkLRw89R7zJ8CRLEAhztDXvivYL/OvDH
        PKYV5x/KOSJoHpaICtvGGZ8=
X-Google-Smtp-Source: APXvYqwPvYMfzDuc9Su/vRMWFbKsp56fjU9/82b0gCrqexCrYAESjB2wCq0KA1l1HjBS/G/oXKFKUQ==
X-Received: by 2002:a1c:d04a:: with SMTP id h71mr3608814wmg.120.1553476682669;
        Sun, 24 Mar 2019 18:18:02 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id o12sm728205wrx.92.2019.03.24.18.18.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 24 Mar 2019 18:18:02 -0700 (PDT)
Date:   Mon, 25 Mar 2019 01:17:17 +0000
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline
 --abbrev-commit
Message-ID: <20190325011717.GA5357@rigel>
References: <20190323041332.9743-1-alexhenrie24@gmail.com>
 <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
 <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Sun, Mar 24, 2019 at 04:37:25PM -0600, Alex Henrie wrote:
> 
> Can we compromise and make --pretty=short the default for --graph?
> 

I agree that `pretty=medium` is sometimes hard to read and, as of now,
`pretty=oneline` can be very misleading:

    $ git log --graph --oneline todo~2..todo master~2..master

This will look like you have a sequence of commits when in fact they are
completely unrelated.

But If we make the default to 'short' (or anything else), what should be
done if the user has `format.pretty=` defined to something? Is `--graph`
special to be allowed to not follow said configuration?

It's inconsistent itself, and introduces inconsistencies on other things
like the configuration above.

In my opinion, a better alternative could be having a configuration like
log.graphFormat, similarly how we have log.graphColors for colors, to
determine which format should be used with --graph.

This would still require user configuration which may be what you were
trying to avoid by proposing the change in default behaviour.

Settling for a compromise feels like giving up on the strengths from both.

Cheers,
Rafael Ascensão
