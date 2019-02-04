Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7961F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfBDVaL (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:30:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfBDVaL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:30:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so1506488wrt.4
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uill9019nUjRGrTOtlWRQKSObNoxf8hF+EGyxba5k/Q=;
        b=hQv1VBx2VlWYqA9Hq1iecL99lTfjn9nWud+qvgbBWlcMnZlYHqjBgyWR+O/XYh5Gx3
         /bAv0NZjgcFxT1NDAyJsP+yhR+ktczkbsBWGSZ+3BmFlNiieCRIHbm/dQgfEtpX+XGya
         TTEoyWnewbkEfLtvKNaaAYnQ+5G4BiAmlK8JYHNcuz28uAGfFzJSpUHS+DpgOnEu80sc
         gk5ebZ/EDDwVEuhYSBIiURQwiItsLCIXXvjUdQiGY6bLz7TVpeTc6UEm6qyeIf4GRj7N
         J73HvbMsTCtECVakqYd9bx/eEpaWCWPuIezyDjXIgZ3QUG9rrDWI7aB/wPB1TIEDOWB9
         rO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uill9019nUjRGrTOtlWRQKSObNoxf8hF+EGyxba5k/Q=;
        b=b+pDnujGDyseXbHKzDrz38Y8OY3kB6s2Uil/LOkmr/11pEOD8/FPjQeS4KnoNxkBLS
         YGQOmAa1yuBoPVpTiLhLHdix8WsyXCVHSbZO+yITVXaqa1t18t2uoS9DDihqSwtf+H2w
         G1u4PgNXYxjbuQVXgjCELfZjcVfPOd8zAqMNRBrc451tFD98NOCUpW4W/OZY4rb895ZA
         W5qweGvbXTZxTgOg3CCj83h05VZsYpPuDw288fvivSc9DmputNN/5dERbnz3fvNjNZXx
         qSRIGBdQ4UumO88UfiPyYmafufle2SDk4TmUOdQsCzRmFxc5VdH6r5HrpRif5ac9Hdtq
         lZWw==
X-Gm-Message-State: AHQUAuY0FXwKp/2DTM4WnTObL5LeZ7ByozQLe7UMd6V7/zlRh63w7DUb
        opo1vGO79tciHevjbxs3iOY=
X-Google-Smtp-Source: AHgI3IaAqCjN+M8BZx/uu0wn66SE6sObCq+9rqX+hk/i8WF+slj9DWWFhCU9JkBcT5myQR+7w4UDAA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr1069704wrj.133.1549315809251;
        Mon, 04 Feb 2019 13:30:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j3sm9258433wmb.39.2019.02.04.13.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:30:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
        <20190204211316.GA6085@hank.intra.tgummerer.com>
Date:   Mon, 04 Feb 2019 13:30:08 -0800
In-Reply-To: <20190204211316.GA6085@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Mon, 4 Feb 2019 21:13:16 +0000")
Message-ID: <xmqqh8djtf6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> There was also some discussion around the naming of the option, but I
> don't have a strong opinion on that, so I'm happy with keeping the
> --[no-]overlay option.  I just wanted to bring it up again here in
> case someone had a very strong opinion, and would prefer it being
> changed before this goes into 2.21.  (Not sure if I'm too late for the
> series going to master).

I do not mind leaving this topic out of 'master' for now, if that
would help migrate people only once instead of twice.  I think the
real UI improvement would come with the new pair of commands split
out of here, "switch-branches" and "restore-files", which will not
happen within the timeframe of the current cycle anyway.

In any case, I think it is probably sensible to revert this step.
Will queue; thanks.
