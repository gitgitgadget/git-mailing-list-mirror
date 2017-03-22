Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCBC20323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdCVVUk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:20:40 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33771 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbdCVVUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:20:38 -0400
Received: by mail-pf0-f176.google.com with SMTP id o190so14961851pfo.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=msNETHVaqv19jUX+/vDDfpXt6kL3RFTChcvHicNYHAE=;
        b=Cjm3b2wgWJ/aJ+BoAdZdhtTCtI0lPBg7+fC1RDxgMfY3RfFh+YpTKHhUbhPkRXIj8S
         leImC40HfEgEgbUu/zC5W9Eh1JDlt/pHxXaJb8cPeqG+uIfK+IuE+PfQI3QJOj5YIRLv
         FcjTrOBzpTqIzyM0iDfPxUsXmhnqbMELCpiPwLF1bRB8K+PboGuHorQ1gjxIWIf5/Ntp
         5t8Q/BPe3zZ2vmjOu1n8s0T3mSUFbRhmzvurjZl0sfUONlt+MqhauYIRrLKy2fGUFSLV
         TJUOm3/azXTrYJBusOCBUS4q/X41mE6/zqQv8+oztRoFQRjftspscQ+sOkOFxzvIYjRW
         GtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=msNETHVaqv19jUX+/vDDfpXt6kL3RFTChcvHicNYHAE=;
        b=ULKV8lRr/bbpjjjM7sTJivNSwLhzW+ega5LkoHhV1eI207J7rwtEIIdvFEBZb6sQlp
         3W3V7ZZknSmwg8Z2K/GjLg1t7IxX1ipuqrU30mFF2+snTGGP4GCO7gz3box2oOSTqJnL
         u1qFRAuUn7eFOd891hv0lJ9dyNe3hWrX/qQJkmwGfrPGahL6V3b2LXfikxH4FJ/veWnh
         WIBhsODZA76EeM7hj+gQzMZyaOgKXgp1G+erBoGB72keWyPZuzKIttI9dtXYIJEvg69p
         mvxLAXRObDIlO0amab5vUe8Wsfrnnqyz0X2vmCSdfWIwCr1fpY2FCEVJN1J9ncu8Atfq
         ly5w==
X-Gm-Message-State: AFeK/H0SqfQBpeKmNN3wkZd7iHw8B3FKHOfY981cFIyisJ3M0v4d0S7T3oyiW/SplOv9RYQidgI7zFhuEXrTCWky
X-Received: by 10.99.140.69 with SMTP id q5mr45556031pgn.179.1490217637327;
 Wed, 22 Mar 2017 14:20:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 14:20:36 -0700 (PDT)
In-Reply-To: <xmqqshm5huzz.fsf@gitster.mtv.corp.google.com>
References: <20170322195102.165314-1-bmwill@google.com> <xmqqshm5huzz.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 14:20:36 -0700
Message-ID: <CAGZ79kYi3Pzr5U7ef16bOADpYYve9=Hg_bBpn8w32CgMLLna0A@mail.gmail.com>
Subject: Re: [PATCH 0/2] push options across http
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  Why does the topic name sound familiar to me?  Did we have
> a recent attempt to do the same that didn't work well or something?

'sb/push-options-via-transport' sounds similar. Before that we silently
ignored push options in http, with that series we got an error indicating
http doesn't support push options. this series actually adds support for it.

Thanks,
Stefan
