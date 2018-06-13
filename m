Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EDC1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 06:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeFMGPf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 02:15:35 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38122 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeFMGPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 02:15:34 -0400
Received: by mail-vk0-f66.google.com with SMTP id b77-v6so834155vkb.5
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Od1cmhfUuE0m7//wCQYz2rusnFYJihMB1rjMhj7nb6E=;
        b=ed4SjbGO9QqJxdDw+nPbdyK9iki54KiGqFQz7yK5dGg3NAjGB2iRCKQjnkRUHE1Joc
         ecaPgR04GUxL/mxCEDrTFJikLDanhHEMyMcRDic2p5B0oHtqEoRkxtv+HU+lw5ocutW9
         svw7lyBt6ZFlneDqmfYXXS01Mn0YfqA/W0xvi2nPk7CmnoLdzHKc0f6Q9B+s/uEtNlWL
         xIuQ/TOycxhIg4cZPEIQDdZcsupCPnALumDAY359d3mWi7XCZdwn+r/GAuWXdM4RvktX
         jAG0+OCl4mtzUCZIxURi0wn7sC+Ec90cIFS3dyI0NgtKsObEPFG4WsKcdjaelZ1kZukA
         m5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Od1cmhfUuE0m7//wCQYz2rusnFYJihMB1rjMhj7nb6E=;
        b=MWvIK8uSm0Gj88MbFe3mesLu0K8YryV9I9T3ZpFKh0y03BwUnmF2kl9q3lq63XnoXb
         L75BTtuhfSE1k0M21mBCckmkhxseFEJwfyvgaDiWHIwo/TB5KbSBJzswJTbn4P2kLRt0
         h+0Gd5aZBlobcWyGdGIHeEzExHdwF4WWIl3PYq2QfdamnvV8gCR8dxMIzay263xlNvo5
         UwNKTvgXguafCVJrwghy15tju3ZaTMLIs/mPzZkuJbNDGGh8yQAu3UhYAb1g5jXyhMQD
         fkNGjDDF1p2aFtGuAjstDL/oqEmakATjzIFr6z+/qZWs1i2rDFtt+UXKDkifsPRwk/AM
         6dOQ==
X-Gm-Message-State: APt69E07m22eq8Cx9mD6hYtZbg6KqJw4nTTS+btcgewCLnNZpTW0BXuG
        ZrJpzvAX1j2raZwl34v1dFrzixUolYQu9eZxViU=
X-Google-Smtp-Source: ADUXVKJ8kE9a6YUbuw4XFxymG3RXISGy/7KtrOMc+ZZfv1oPOSU/+29a/fel5m8MSRvZFIFYoj4dVAddO3AIBVXUnFA=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr2201270vkj.160.1528870533443;
 Tue, 12 Jun 2018 23:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180607051958.759-1-tmz@pobox.com> <CAHqJXRHGq9ofPcCzffUbTmuL6fuoB=33aZnwqNdqYy+nAVA_gw@mail.gmail.com>
 <20180610022802.GX3094@zaya.teonanacatl.net> <87efhfvxzu.fsf@evledraar.gmail.com>
 <20180613030852.GG3094@zaya.teonanacatl.net>
In-Reply-To: <20180613030852.GG3094@zaya.teonanacatl.net>
From:   Luis Marsano <luis.marsano@gmail.com>
Date:   Wed, 13 Jun 2018 02:15:20 -0400
Message-ID: <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] contrib/credential/netrc Makefile & test improvements
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Ted Zlatanov <tzz@lifelogs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 11:08 PM Todd Zullinger <tmz@pobox.com> wrote:
> As far as removing the autodie dep, is there anything more
> to that than dropping the 'use autodie' line?  It looks like
> doing so leaves us no worse than we were before, but I
> haven't written any perl in a long time.

Erasing that line should remove the dependency.
I added it as a gratuitous safeguard.
I think it's fine to simply remove it.
If anyone knows better, of course, I hope they'll say.

> Thanks,
>
> --
> Todd
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Ocean, n. A body of water occupying about two-thirds of a world made
> for man -- who has no gills.
>     -- Ambrose Bierce, "The Devil's Dictionary"
>
