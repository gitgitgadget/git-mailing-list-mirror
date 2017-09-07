Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0711D20286
	for <e@80x24.org>; Thu,  7 Sep 2017 17:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdIGRrh (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 13:47:37 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37069 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdIGRrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 13:47:37 -0400
Received: by mail-pg0-f49.google.com with SMTP id d8so719341pgt.4
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=6uhXnRkJwS1UVu8JLgRCTFbXz68JnoQ56YXg8TDpelA=;
        b=hPymmA51++FHjnbPEiBlT8pfO9y2FUjuc0OwNE08Wi8jJhRC4FbmldhN5APbQ/RdCG
         1LzU+75F/UQ+jtpfU1tJR+13Q9//CNV6Qsjx4xtpPysgfvTEBXQKWY7JXw4dlk/ZUym8
         nR6zuHnDCtuRbWBuo1i64GnBQ4m72eW31QTE8uHs0Io5lUH32VDeFn503rH/t8A159rJ
         b1F3jsS+nGZ81Ec2VZXr23hZidfAJEyiNsphRBTvJOkPjWN/nmvYmvVG2QfmODBcvInQ
         D8x99io9H+MSDv3TfROlnJntbc7yHERYQpR/7Q5HaEpxqqX5MNpM9JsbCmQBA7Ax+zbG
         kd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=6uhXnRkJwS1UVu8JLgRCTFbXz68JnoQ56YXg8TDpelA=;
        b=nKKty4DQp3SlUSnms7bZ9jhhCzfjUSUMWdUGeQuVFV4t5s/Vl3Xew21oeoF3kMrvWH
         E64CeOHnqRkL+aLI08qQQRScNxPpa11Rjf2gY4vy6WPirJbXRZQj4Y2aIUouzLaerMQz
         5dN5qL7inr291sBq29/nPY0TsG+Zj9NH688BOd9isLKs/vcdOZr3rgbYQ22VFpXuJmri
         m2fezC3jpuVQ572ZNS9DGCylQhfQVvWIkLiKidTtcncPH8y+D0QA6xeNq0+5Ch9fJQn8
         byoWjLt9m3x++r0amRzYDai6DhU/rGCjv80CUNTwM42JAN9rp9WlNGr33nQMpRwCGPnk
         r8Qw==
X-Gm-Message-State: AHPjjUiWeNJ4XpUBYdam+ADng71oW7Bpw7XZtb/CPVY7mzKvvsKgf/RF
        9sYII+qevlaLhY2fY4ykqk7nOd07QA==
X-Google-Smtp-Source: ADKCNb4qJW7ANws4zqoAWy5pImSFvgLMn8hSH+r9Oadq/+bgqk+qOHaeWjuwqPptrduWBVVjIN1W+wxUlrlVPQeLc1s=
X-Received: by 10.98.71.198 with SMTP id p67mr130123pfi.15.1504806456481; Thu,
 07 Sep 2017 10:47:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Thu, 7 Sep 2017 10:47:36 -0700 (PDT)
In-Reply-To: <DF5E912A0E6343DF8C3E984A165490EF@blackfat>
References: <DF5E912A0E6343DF8C3E984A165490EF@blackfat>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 7 Sep 2017 19:47:36 +0200
Message-ID: <CAN0heSpT=W=5LiQL0SPOffkUO94uTGB-Aatn1fUc07aGqLG16A@mail.gmail.com>
Subject: Re: Git diff --no-index and file descriptor inputs
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 September 2017 at 18:00, Jason Pyeron <jpyeron@pdinc.us> wrote:
>
> I was hoping to leverage --word-diff-regex, but the --no-index option does
> not seem to work with <(...) notation.
>
> I am I doing something wrong or is this a bug?

There were some patches floating around half a year ago, I don't know
what happened to them.

https://public-inbox.org/git/20170324213110.4331-1-dennis@kaarsemaker.net/

> -Jason (reply to list please)

Martin (not CC-ing the OP, though I'm not sure why they'd want that --
it's usually the other way round)
