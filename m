Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438C21F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 00:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeJLIVq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 04:21:46 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52244 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeJLIVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 04:21:46 -0400
Received: by mail-wm1-f45.google.com with SMTP id 189-v6so10686479wmw.2
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ramUmo6D28qJEv9DDlSmSWSVG3boW4Fp+WiyZiJ+F5E=;
        b=DcVmHl5CSUIwusY1ZnXg/28EqoxwQ20yQGGe2SV7x6XXqG5x7iNFpH/3eo2f+/Qq3U
         P+N+ooSliExybALOmwa37kAbFo/83vWiE7UY8v49sHsFTkLp2jNBLNHHyF1S9IqTjUHP
         SgEj50X0d3W15tv6Wwu4Wf2NObYdqmbFpzxXDcbbabWvKaf5x8+QecXmAd0++CbYOdPN
         m/aecY//aMJOLq4JQ5OybM/E8+dwZpUctLtIOhAQ1+MvT4Lochp09JicdSLxDcBgmwPc
         PlQPwnd2/qPgbRsvLni/gVsY1Akija1JWWIQV+Vah6I3GaOByFRLZGNHIheZsj+HQTJP
         vX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ramUmo6D28qJEv9DDlSmSWSVG3boW4Fp+WiyZiJ+F5E=;
        b=YyTiKxKLi/nl32bMwcZDXHKpPJBi/eJtv6hPpJQGRjIudiqQSkB0FdFsCRB+NMiH9p
         3qyATjMLtALl3oC2pO3tLBtPP5v6hVuOD/cGHVLxKSeyoyKvXhXLOFmwyP4zLG7Ea0Cp
         mjaPsPfIXrPwGQ10rmyHxW4MNfzb7pOs22LV8rqwXNhIU+MQQ4rGYCVA028r6hLSJMXf
         tv0r7hbt8NzPig6hanfbCJcXtHUpxM/Pc/BG0SsbehKPiJ9tqd6yJXJp5dYkcMFjmC+g
         JG2omWj13QafJdKm5QrvhnAVvSvlA1LXIHMQWj66uSDBh3ceBWZVR09w/hUZBN+Ek5BE
         GeHA==
X-Gm-Message-State: ABuFfohoqyQ903o5VRKmu/pOaPKEMucnrHlYFmkkjC0dSA4ZCVLHFZmf
        qRFTBYRXm451/qh2DPPHHig=
X-Google-Smtp-Source: ACcGV61WogyT1LDgDPkbhzzzB7/3P4zOM5ZO+tVbYcv3zLa169qc/u4xk3GkOMn6ozzr4pk5ee5T7g==
X-Received: by 2002:a1c:4385:: with SMTP id q127-v6mr3457622wma.28.1539305515995;
        Thu, 11 Oct 2018 17:51:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m16-v6sm21402814wmd.35.2018.10.11.17.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 17:51:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     phillip.wood@talktalk.net, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
        <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
        <CAGZ79ka1pxPt+xT3vBa5xARG5P+Hd19sjOLO_y_zofVStsDWNQ@mail.gmail.com>
Date:   Fri, 12 Oct 2018 09:51:53 +0900
In-Reply-To: <CAGZ79ka1pxPt+xT3vBa5xARG5P+Hd19sjOLO_y_zofVStsDWNQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 11 Oct 2018 16:06:32 -0700")
Message-ID: <xmqqmurkdm1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I think we should add these tweaks, such that
> color-moved-ws implies color-moved (both config and CLI options)
> and --color-moved implies --color (command line only)

I am not sure what you mean by "both config and".  I'd find it
entirely sensible for a user to say "I do not always use the
color-moved option, but when I do, I want it to handle the
whitespace differences this way by default".

So presence of diff.colorMovedWS configuration variable should never
trigger the color-moved feature by itself, I would think.

