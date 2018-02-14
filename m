Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46781F576
	for <e@80x24.org>; Wed, 14 Feb 2018 08:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbeBNIAg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 03:00:36 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:42279 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeBNIAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 03:00:36 -0500
Received: by mail-ua0-f174.google.com with SMTP id 47so13171987uau.9
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qR3z8hx/T4FM3oUOSdd8gKo1uy/+huXRbeBxtfBG73E=;
        b=piQadBC+bjDoCSsSmetYwBeR9wZPCBxRy/rTcpZHOsZGQyNh6K04aJ5UUzJNpL9YLK
         t2AN4+io+mxPnuBbpC6XQKE3SWCZx4xI+SqGOQqbcOWm/eIhlyIpNM81wxAd0nWz1usj
         mqYt+C/QfepYgZTLGvzOxFsGRnH7pwZIt061DQq9W2d0tiPnVeZN9FPh/WlZJncyhNaA
         HCxnFjwWh0lNkkDh3l8vxM6O059kIzzUqOQ49yAi8c6gQ0pTSSTwh589PNYq+JFYqnqq
         Q3FBjOYhFKVonegK0ftd5OlC/ItOH9NTouWjAxR3C0+cWpnOomHo3dRhm1r113FLGSCK
         0eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qR3z8hx/T4FM3oUOSdd8gKo1uy/+huXRbeBxtfBG73E=;
        b=CEPbPvfhIaMDPzBnGfRlLdjfYI/UzJTLqIwTcIo/YU155Rb05cYPRuqe1tuNYBQwIh
         td5rEH40ixNXXVTLPLA9bUMrk2VAH3AD2GfJezzaO0UqfZzpYXRHW2zZ2FxjyjTzzQYb
         DmedgTTh5X4sjc64iDjGLKCDjcIFx01Pb69YFcwhn+PEqBDb76Alx6UzCz+1sXATOtHX
         KuCevjYLoysXqiiNo/0iI/B58eSD7l8JUdgcPVK9xF0VvVtPk3oU1F1yjdfruHhDJVj3
         Jyzn4R4YTuqGgxh4NX0uLpLGk382kAWoMxYyJTfik47h1qWSCVnlcydeTUGlT9Gm14w9
         1kzg==
X-Gm-Message-State: APf1xPAubhWMU5r0DyjpWJWU+5oTRBzH1rrVKbQXvqO/Jnb+3msfhPTU
        Gi1TYF0P3qAIOJlhRhdpw08e/1WG6nb3Z1kVlzQ=
X-Google-Smtp-Source: AH8x224SKEw6vAOh2Po34iT1CfLdPMkiswzJfy9Ouqg9jTOwi1eTOA3v/TfaZGFkg5eTXwak/i79EMRw3gUv22xETzQ=
X-Received: by 10.159.40.70 with SMTP id c64mr3696654uac.165.1518595234961;
 Wed, 14 Feb 2018 00:00:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.11.72 with HTTP; Wed, 14 Feb 2018 00:00:14 -0800 (PST)
In-Reply-To: <CACsJy8DYwvNGSWBP-2RNUn9xLBHUGtW1D7EuEYn7q_5f-N9Kvg@mail.gmail.com>
References: <20180204093823.3671-1-pclouds@gmail.com> <20180207092141.4312-1-pclouds@gmail.com>
 <20180207092141.4312-2-pclouds@gmail.com> <c755e388-89a5-fc0f-f872-16fd5d5686b0@gmail.com>
 <CACsJy8AHa6QDmWu7TFjgW7m0pHysYkZq_WJ1QOVBVYaT4XdL4Q@mail.gmail.com>
 <xmqqinb0rcw5.fsf@gitster-ct.c.googlers.com> <CACsJy8DYwvNGSWBP-2RNUn9xLBHUGtW1D7EuEYn7q_5f-N9Kvg@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 14 Feb 2018 00:00:14 -0800
X-Google-Sender-Auth: dtmHtvUfrz09epOEAqeUnKYY7Wo
Message-ID: <CAPc5daU5qjoKkqTvy-xUUP9VAE5KWy0B+CqpujSrabp8MtzqPg@mail.gmail.com>
Subject: Re: [PATCH v2] dir.c: ignore paths containing .git when invalidating
 untracked cache
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 5:24 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I am worried that always doing the right thing may carry performance
> penalty (this is based purely on reading verify_path() code, no actual
> benchmarking). For safety, you can always set safe_path to zero. But
> if you do a lot of invalidation and something starts to slow down,
> then you can consider setting safe_path to 1 (if it's actually safe to
> do so).

Fair enough. Thanks for articulating the reasoning.
