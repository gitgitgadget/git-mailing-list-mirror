Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C51E1F829
	for <e@80x24.org>; Mon,  1 May 2017 03:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163718AbdEADPP (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:15:15 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36599 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162660AbdEADPN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:15:13 -0400
Received: by mail-pg0-f47.google.com with SMTP id t7so40277471pgt.3
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mfTEaRInYYjhqdfzOejuzUEY+eyqjdu06I5kfj35+bA=;
        b=bxXM+w/8kkav8ojyUl54rsoMr8N44MJ6csehd89DDCyVYoxdmOQTf8Fq/cswBJqW0D
         E069+wFLjo84R2p5NaDSDhX2biH72a3/qIazD+wX1GUn4RGh9Iz3oM2yhNGgAmc+3IFU
         BaFvQZuoozeU3WMv7GI3OlgQPsCXl9UfctMJ+AKcFPKRPqGNDTH+nQfvjJQHtqW1+OUc
         Gk2WajnoAj2oA7eSVzHjXy5RkKqNuCP7FtKxM7zBcTN2C8et/tyQ8KfwgUhArAOk26HY
         dWJbrm2RusWATzryDSLI7mFjoU65qvN4f+oFZQfaVkevHUxQg03I1sTvLj5Jz0nhVRtP
         +6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mfTEaRInYYjhqdfzOejuzUEY+eyqjdu06I5kfj35+bA=;
        b=YlgIEg+/FIwGqP1o9M05ykwkZ9hIpz21dxEnW26NIk21WTugtENvT2H/cR5gZfTywU
         G1+NFY4NvK1kwd5VFttrhEiQgLKhQjND6ujMJSkIaRq346DbJoo0qLPlBkmLQlri/Nue
         uYNfJdL3ioATV9ZHp+FtltFuISkMIIg8M8QRLHWcfrPjq7P9Cngl9gk9iF1vxzPNs0cL
         pK+r+KkgEAbyp4eqsr308cQMuyLwfehPVS/zl4Z5GsUIMzd6C4g7QehXAaVm51WzKuGi
         QdRcqYYRce1/sabNsx7AQIBrXOncbp2LBv9vuVpU72xAPQ/dwY8+B4Uu7oD6R1+BGgXS
         NjUg==
X-Gm-Message-State: AN3rC/5JFa5SVb0GytsI2QuIkdtpUf0nCJUZxokoG3EsYjB41+j72W1R
        9MbyCrBwq+GfyQ==
X-Received: by 10.84.210.72 with SMTP id z66mr30971050plh.191.1493608512914;
        Sun, 30 Apr 2017 20:15:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id p80sm21330208pfk.50.2017.04.30.20.15.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:15:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Johnson <chrisjohnson0@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report: .gitignore behavior is not matching in git clean and git status
References: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
        <xmqq60hljqud.fsf@gitster.mtv.corp.google.com>
        <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
Date:   Sun, 30 Apr 2017 20:15:11 -0700
In-Reply-To: <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
        (Chris Johnson's message of "Sun, 30 Apr 2017 21:56:43 -0400")
Message-ID: <xmqqziexgtds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Johnson <chrisjohnson0@gmail.com> writes:

> Also, and sorry for the noise, but I did a reply-all here, but will a
> reply automatically include the rest of the list? Or was reply-all the
> right move?

The convention around here is to do reply-all (in other words, make
sure that Cc: line has git@vger.kernel.org and others involved in
the discussion and mentioned on To: or Cc: line of the message you
are responding to).  Your message (i.e. the one I am responding to)
has correct addresses on To:/Cc: lines AFAICS.

