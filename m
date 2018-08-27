Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977F61F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeH0XMX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:12:23 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37526 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeH0XMX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:12:23 -0400
Received: by mail-wr1-f46.google.com with SMTP id u12-v6so79995wrr.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=usOhNDHLftJXel0BKRSKjrWUKhvvRVrVSK2WLpCQZq0=;
        b=ULmeN7VoBfBuvFGTkHZOYu0m8PTaaveuCAkeV8Lk/1qmeYjUhqlaiHMCUYVq9ix+HR
         Q7WsbdbuDCsVEv7Dgcww9s3gElRIWIx+U9P2zZcFCDxkrPhjUbx07+6OFks2AsEIdLFh
         jVFw+Ot4+U3oDg0Jga1OZhYL1+P4maxrIrsApxF8sCokgCHud4Elc4UKAfsSonC61wBd
         Dj3Bx4BtomHLFir5zWBnEozyG26Wz865guCPYhAw2+WN+VX0isVL+SYL53BN0sQzXWgk
         zN0XyJK10GQHEb8Bzie61kvu3Vtk+r7qlVZ3ar1l9X62ViaoyoJOQAqvncfYF9mzQgus
         E8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=usOhNDHLftJXel0BKRSKjrWUKhvvRVrVSK2WLpCQZq0=;
        b=rnHrHqCQj8LtzTmddeCi/O/XnA30vTJCW38A0bHZUzeDHw7TV8DuOTeonujYUqU/8L
         CC8Hkc69x8hM25mp76I5Xzkoz6AKogjaTyoZ0nBeJMWQ9Hw7BNZHpFKU+XkUmK76f2Sl
         yHpOZrlRt8NNtbII8hgKpWcpmKBmtWpsSDn7tutI+10xgWgDABQU+u3Mpxj5l/zEEJ86
         ISYnnP1R1du/pcmgb2Z5q2hBaQjUcE/RTWCrQy+0xAQqGTne230i3X/SvYIYxGdp5ND0
         SMBgvZ3C/c3HG4mll+ed8IW5/RHQCIoPrWRdP3tI2p7i23y0qAsLM3MpWj+B1qQBghqO
         2i1w==
X-Gm-Message-State: APzg51DmjC8ce95G61hzVWFsHA3JVL+JRLL09Nvfhwlf1z07VFiRLwN9
        58Z2RTjWDHkbpc2/BflAyDk=
X-Google-Smtp-Source: ANB0VdYcXSBg3wbHGs89VGXTw/BpAAeEnqhk+l8rLXnP/GxkW1tiZd93JA2I+kee59afL6jaUBAvKg==
X-Received: by 2002:adf:a196:: with SMTP id u22-v6mr10158765wru.50.1535397866150;
        Mon, 27 Aug 2018 12:24:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q200-v6sm122627wmd.2.2018.08.27.12.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:24:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Scott Johnson <jaywir3@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Would a config var for --force-with-lease be useful?
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
Date:   Mon, 27 Aug 2018 12:24:24 -0700
In-Reply-To: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
        (Scott Johnson's message of "Fri, 24 Aug 2018 11:39:27 -0500")
Message-ID: <xmqqin3vk3yv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scott Johnson <jaywir3@gmail.com> writes:

> Hello Everyone:
>
> I'm considering writing a patch that adds a configuration variable
> that will allow the user to default the command:
>
> git push --force
>
> to:
>
> git push --force-with-lease

I actually consider "--force-with-lease" that does not say "this is
what exactly I am expecting to replace with my version" a fairly
dangerous form to recommend to the general public, unless their use
of "git fetch" (or "git pull") is disciplined.  In the extreme case,
if you habitually do "git fetch origin" only to update the remote
tracking branches (so that you can do things like "git log ..origin"
to see what others have been doing while you were offline), using
"--force-with-lease" offers no value over "--force", as you're
likely to find your remote-tracking ref to be up-to-date, but it no
longer is what you based on your decision that replacing the tip
with your version is safe.

So, from that point of view, I would recommend thinking twice before
considering to add such a configuration variable.
