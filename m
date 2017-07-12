Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A7D2035A
	for <e@80x24.org>; Wed, 12 Jul 2017 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755819AbdGLAHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 20:07:10 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33434 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754818AbdGLAHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 20:07:09 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so3804268pgr.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pgLx+KwsiZYRVTZw0LtIPYi+roCwYL/a8tl+pu7zK5M=;
        b=Wh2C/FQFohS1pmY4J9DnbIpfSQHsp+hGX2axVutcfT4/1sfx+/sFKuXE/LDicdH7wL
         2HFaaFI0f8PG2bbSrs6j69P4O9WUJokT6RWDTQc4tEdvYxAelkeA4Cm07p9wCQpo+qVX
         w7tGR3K1Wr8qNcSEQZ00F+74xPr8KTMuvQjwZqSMHlXJ8W03jyZz1SR4qzjMgGFYi4Y2
         QXVR7KJiuj/zWdXZj0IISrK9sxCcnhH8G8ZWNZOTvFmKPAxgk2xIbL6Ywbp/pJP+nELp
         hoRqPTiw6qVRl/Um6P/5fphanxz4q9nqDqvVlWF9rwtJfrgwDsurQuYVIPGFjQC/trJD
         cZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pgLx+KwsiZYRVTZw0LtIPYi+roCwYL/a8tl+pu7zK5M=;
        b=Dt6Uj+0/DyMVqJ9PSpHSW1dVPjy3EdUV5yaU8zwnQS0kXzQWOxFcX4ev3Vj1RuV1Pr
         vbopjpGN8rlNWdW/BSF26eWeg1fKmUqNlqNgbjy/e7dWARWC3AEqYz136HNi20FK+TIQ
         PlEIXbzoIn8iZqEjUz3xq9bd3gWrf3XlRDvwrmvwJLXfRlpia/ge5xtmPfmT53pzKH7H
         vMfZPB4wyoEV/jliv4Btk8Jan8EAyc2L9iFEKsJFxWwCfYv7n6Digm0ONTr19XOLswSp
         iQPAqqbhON0DJiR5Z9Z8j/RGkdYYPyEeFuwYlMmMCwqEnzfVWWAiN/rsMUf0eUrk9uf0
         jo/g==
X-Gm-Message-State: AIVw112yNc38CEy3R2im79qbJ31Q3rt+BqLa4b2eyiaHdkoi7BY90RFk
        +qQhzBTw0xmK5MSxMafZxX5zyaBCbRQz
X-Received: by 10.99.54.73 with SMTP id d70mr1016767pga.195.1499818028392;
 Tue, 11 Jul 2017 17:07:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 11 Jul 2017 17:07:07 -0700 (PDT)
In-Reply-To: <20170712000042.GC93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com> <20170711220408.173269-3-bmwill@google.com>
 <20170712000042.GC93855@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 17:07:07 -0700
Message-ID: <CAGZ79kYet0aE20EoPEwy9CRsbzJ_oBNMr2km4J2L+6hXk9dDYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 5:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>  /* The main repository */
> -static struct repository the_repo;
> +static struct repository the_repo = { .index = &the_index };

https://public-inbox.org/git/20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net/
specifically said we'd not use all the features today
but want to have the test balloon long enough up in
the air? (So this is just a critique of the syntax, I agree on the content)
