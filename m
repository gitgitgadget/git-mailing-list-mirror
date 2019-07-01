Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C909A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfGAUkW (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:40:22 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40657 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGAUkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:40:21 -0400
Received: by mail-wm1-f54.google.com with SMTP id v19so894380wmj.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dKQmGYEFj8bHbHRXR5PVseIbkqG1Ym35uFa+tRp9CcQ=;
        b=UzQGU9ILcUgRiOlcY31FgxdYOVUZRac59ncHpKOyHngQdxa65t4za6jRyZC22bFjnV
         PJVUrxQGZ2a8I/AWGaNczG6jeAubs0O0Dd8+XaE3vhlh0htXhDzKF4G2Ov5jKLK1TzYz
         SlfLR7kLWsHdsE9LzElYgmHrCNXsJoK4agZo+mJs4F2JkQPcNoA8wh3PSN33WyK78Lnk
         w5gYRp82gg0IHj0H+GvSYQGRNCE56Md+TnGGbl9D35pG5qEXiZP3IDSQSpPb/8MwQSKN
         IfgcF32S+psP9TC6eNNqFPEsYclatNoKf9gCAXm8jn7yua2/1d4y51RRy864txigWIsX
         8jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dKQmGYEFj8bHbHRXR5PVseIbkqG1Ym35uFa+tRp9CcQ=;
        b=qaBLwTOjpf74zEToGo2mdnnT8yiwia6w7VFCpwprcsgDsG6z7r2t38TfDv8Puq9zXs
         JiUIxNXRHuxe4JEK6O/qZ4ffb5kvtiXEFaZKem7FML0X+zT5tgy4poaz7TTTPkZ0JsHs
         FWmiuOVFjAGgWvGZFaRP7Iz+9s0Akl9sdOqubhakoC2im1i6VeFIknjzsDJNyJ5NCrpU
         enppJTIxo3py7QlrWaJJGhYeLfru3Bu5B8X1Cd2AgsnaGz4QpHFOWn6XNQU03AmEl/xj
         1BgH9Vb06gJwbvBmQdXQHkaC0rI/poG8MEr4On65Ul9q2W9/7oaJJTFB+rnfoUWkCarn
         dBQQ==
X-Gm-Message-State: APjAAAUHGkFvAfIGhbljlJbneBUXHH1HQgzxMVK3DNenGoH2p/z2ZB3U
        vyRQuNrJ3duTtfFWf4klNH8=
X-Google-Smtp-Source: APXvYqwwZ9XJVCT8/RZmBGlHd5sOR8whJG756a2BvgVzrH6A3uVolXWOrSm0J7c4AVfW80Lh4e/z4A==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr613909wmc.170.1562013619964;
        Mon, 01 Jul 2019 13:40:19 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id y1sm491773wma.32.2019.07.01.13.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 13:40:19 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Mon, 1 Jul 2019 22:40:17 +0200
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Kulcyk <Eric.kulcyk@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tracking parent branches in Git
Message-ID: <20190701204017.GA7537@esm>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 12:48:16PM -0700, Bryan Turner wrote:
> Since branches are ephemeral names and have no intrinsic metadata of
> their own (unlike, say, annotated tags or commits), I suspect
> implementing something like this may be more complicated than it might
> initially appear, especially if said metadata needs to be communicated
> to remote repositories (which implies it might require changes to the
> wire protocol as well).

You can right now give meta data of your choice with --push-option to
the push command. The Gerrit system makes use of that already. However,
this would not be intrinsic to Git, but the serve needs to react on
those options. And it should be in good company with suitable client
tools.

Take care,
Eckhard
