Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FDC1F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeCVIin (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 04:38:43 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54181 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeCVIij (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 04:38:39 -0400
Received: by mail-wm0-f48.google.com with SMTP id e194so14246760wmd.3
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kyvgxiAtaKQdDzgXo5Qwg5ik7G8q5sLyhnPYI5DM80Q=;
        b=dA/p5zA6cbf8omGabyHq6bhMtnl0p55LClm/xQGv4srZCZPN1m3Qkxwct3SOGP67Mt
         tXYqJ1a1sMfGWXEguOaJryFnqZw3SmJqauRhzsH0aUqbM+LPjcgu+SctzuvY15FR0wOk
         iPgp1j5ahmAItfYHky72HmQmlP167OroOrMTTq7XBYkLfxUinFmAy1eJjPvMlrXNMw/p
         aUvp6rZsgx0XurvGCsx/GyNgPc8HNvK+c8seOa2Bj3tVCWN++rmoDd1E0dzmV/bXtumy
         XNaiWE6Jv5lrLcuR2G4DzrLsb+l2qu6ZxB8K9ApLBT/uCMART4jtg27RPw4LQepiG6hx
         wvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kyvgxiAtaKQdDzgXo5Qwg5ik7G8q5sLyhnPYI5DM80Q=;
        b=KGnDfZSfgwsZevgb04Ec2kfZf9lgSBmVzAkCb3foijClBLB8EX/h4X2bfvKNHdc68m
         QHwAwu2hAj/KhihZl79lTCgMujfZs7SNTxonkN7ginnVBxud8+2zV0xgNHY4WHCQ9yiG
         nVVBZ4Xj8tTxS1CWs2VFnM0rMy4oRuNTk6lYxG39I2qRs0mNvFj9UEsOVOEMIyJG/7PJ
         A7gdepNP9u0G4uY/sKljOAs7uIlQJ/wdM+zjBjbTV7xszhhCo+KEpFOoz3Onl84RDN/o
         TOvU8C3u0w2q/wGT0Y4ZN/hO7EOhYuHGzi1mZbHo4rKG3VSelBQRed6A8B1OS/c0sOdf
         1jKA==
X-Gm-Message-State: AElRT7Fvf8T7f9AKfYNjH70x3LrBrMJXF5SjLdNtzeI68TIDqtYfsyTH
        y4EudoOsNhAnDDGnB8ogQWw=
X-Google-Smtp-Source: AG47ELtPwcV4ucwj6cWmD+/yUD3h1of12wX3NKYE5yo317AegK0xV5y/dH7TIAZjzpRL+Cl36yDgyg==
X-Received: by 10.28.136.18 with SMTP id k18mr5209766wmd.111.1521707918224;
        Thu, 22 Mar 2018 01:38:38 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id p21sm7208929wmc.0.2018.03.22.01.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 01:38:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] routines to generate JSON data
References: <20180321192827.44330-1-git@jeffhostetler.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180321192827.44330-1-git@jeffhostetler.com>
Date:   Thu, 22 Mar 2018 09:38:34 +0100
Message-ID: <87sh8sy06t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 21 2018, git@jeffhostetler.com wrote:

> So, I'm not sure we have a route to get UTF-8-clean data out of Git, and if
> we do it is beyond the scope of this patch series.
>
> So I think for our uses here, defining this as "JSON-like" is probably the
> best answer.  We write the strings as we received them (from the file system,
> the index, or whatever).  These strings are properly escaped WRT double
> quotes, backslashes, and control characters, so we shouldn't have an issue
> with decoders getting out of sync -- only with them rejecting non-UTF-8
> sequences.
>
> We could blindly \uXXXX encode each of the hi-bit characters, if that would
> help the parsers, but I don't want to do that right now.
>
> WRT binary data, I had not intended using this for binary data.  And without
> knowing what kinds or quantity of binary data we might use it for, I'd like
> to ignore this for now.

I agree we should just ignore this problem for now given the immediate
use-case.
