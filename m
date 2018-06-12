Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2921F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933226AbeFLSWR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:22:17 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38861 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeFLSWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:22:16 -0400
Received: by mail-yb0-f195.google.com with SMTP id q62-v6so8286358ybg.5
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rqDr526vi9cBnuCKU9tWA+1TKUj1qS2vn64tEHwTCQc=;
        b=a6KbUxQfj5jJflxkqH/TzHAz3AGbVfxooCm1um7D22GCB5+xJtHImYxwT+iUP6wPM9
         r7QctUezzcY+Gp4q6oNqkFflkSvx/I8TJk8TVP59Cewg/M2REfDa6qTOcLkAuG2gQxHM
         TnDoqK6PiKZnwpDHwuBuNG25brceK+wGImtz0K/EN6vzQ8pzuoQ8t0jkrrCeEqwgeYp+
         BztJvZHnnH5aBP/jl4bXHiwDLcAlQDwPhYRcChXUCucj4ap0sr3djc7Jcp49ijBRFFG2
         Z21yUB3wZMM0flWuqxQhOwdfJ8t/TcrazKM9mfCdLQVv93PVCikeC5VcMqUk5nNOKvDJ
         itDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rqDr526vi9cBnuCKU9tWA+1TKUj1qS2vn64tEHwTCQc=;
        b=AGGrx/jfxl8oHYMHQsmWWY/imh8AziDg6s0f1H56DvZS0EpV1+oOaJcRiBt6KrUSCU
         TIpDwJTvA/fPh7gL1FAiwqswja20Gjt9oqxlwXBqlOhSMrdxyP9yWJ3xSQyoGqpjAf1z
         /YriQm8EIHXxFXSEsuyLdHTvdYOoa2T3V4vjgpV3EtjIJfZohUx1TQgCc+r5bhLBy66v
         /0mD6ZMeiPXA3Q1EjMsn8laBiPqcx0eLT/q3zSnRtvD3JsyIIGLJhEmq5wWMnCCV4Cf5
         40niYkUPPzlMYf8L0+ZNoPxdteZtik+o022KKdhtcDli4gevoBfQzhFpNH7CDcEea2Hp
         qmQQ==
X-Gm-Message-State: APt69E2HA5ZoaGQpyF4MX72KfNC5WFG0EkSYVI+VXA3P2+YrchxdIm6e
        DJ1qNLwHdSJy8Z14VJzZUoMBuwU/nMkpWrIC3RU=
X-Google-Smtp-Source: ADUXVKLNd85Ii5lYm1vZkkGhdlf5j5E8zVf4kMtyuOrz/91hfI03fZt/o2plYt/P3aAddFouk3EnWaDDdVbsPOr3zZM=
X-Received: by 2002:a25:d612:: with SMTP id n18-v6mr772627ybg.12.1528827735525;
 Tue, 12 Jun 2018 11:22:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 11:22:15
 -0700 (PDT)
In-Reply-To: <20180612181624.GB28554@aiede.svl.corp.google.com>
References: <20180612172623.165420-1-masayasuzuki@google.com> <20180612181624.GB28554@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 14:22:15 -0400
X-Google-Sender-Auth: JMVDtzIjoJMsGE5X9OFr3NogUIA
Message-ID: <CAPig+cQZe2TH01eWOYE2Gzo9vTjMoEAQFxZZhu7vcE2jwV9Yuw@mail.gmail.com>
Subject: Re: [PATCH] builtin/send-pack: populate the default configs
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Masaya Suzuki <masayasuzuki@google.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 2:16 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Masaya Suzuki wrote:
>> builtin/send-pack didn't call git_default_config, and because of this
>> git push --signed didn't respect the username and email in gitconfig in
>> the HTTP transport.
>>
>> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
>> ---
> send-pack is not a command served by a daemon so this is less
> potentially scary than the corresponding potential change to
> upload-pack or receive-pack.  Some configuration this brings in:
>
> - core.askpass: allows specifying an arbitrary command to use to
>   ask for a password.  Respecting this setting should be very useful,
>   even if it would be scary in a daemon.
>
> - core.pager: allows specifying an arbitrary command to use as a
>   pager, if pagination is on (but it shouldn't be on).
> - core.logallrefupdates: whether to create reflogs for new refs
>   (including new remote-tracking refs). Good.
> - core.abbrev: what length of abbreviations to use when printing
>   abbreviated object ids (good).
> - core.compression, core.packedgitwindowsize, etc: pack generation
>   tunables (good).
> - advice.*: would allow us to make "git push" produce configurable
>   advice (good!)
> - etc

This summary probably ought to be in the commit message itself (plus
additional commentary implied by the ending "etc."). It's exactly the
sort of information someone looking at this patch in the future will
want to know to feel assured that such behavior changes were taken
into account by the patch author.
