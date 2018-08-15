Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219891F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeHOUPc (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:15:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36756 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:15:31 -0400
Received: by mail-yw1-f67.google.com with SMTP id v197-v6so1374357ywg.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I88mia58JdvmBL51R1oxlnggJDlP114Gw+yIEqxnRJs=;
        b=a75OpBN/tIjxb2SUwL5urlHd5JsyXb7GI05vGqUSIQuAMNn/JO4L0xLF169gESuV82
         IMpeXeNOsOMU5fVzN9VU43TlD+Ka6zOvaOuTxhrze+QhAzND2RAewcoJ/f56+eUup2t3
         6n8Qk/1PEnYrFORGAQfGnarIq8xkLlIFJNYuIL4iAzWfPnE/4+q9L/L+RxeiPsmLtHo6
         nZ9gunKgK3ujSWMCudVy0XBarKWuw8iErfM8zuNDl0k0GuUBLDcM4WVV6ovOSiv1n6h4
         +Jz7n1kRi0zR2LWAWvTPukeVYARg2hXmLxOUb/5M3hBGuAIUaQ8L7whp7PWZEsGQ/YHg
         V31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I88mia58JdvmBL51R1oxlnggJDlP114Gw+yIEqxnRJs=;
        b=kasT/gHLNCQsG0ZEez/Zi6vsjQ5EvmCHtbAx8KjFM1Nb51KX+9lzETKYIuaW5Y6zlz
         Vjvcodqr4bdRfGyJpW8vFT7KXkRR8OoRp7hndCs95Jx9Q87lce2tv4oFclETcxQMPZzq
         WoAeMoBi199hVgfNTznEiXzqtFjFatT6sV5Gw20JGX9S15JpX9YX7lSnU5GywM0Q7EK5
         0vjgHwd9kJntt7ovaEB+NzpbLcbpmMEhTChvsIZlT5pS/ANAB/EBWsqTKI3Wn4P0CdRp
         taGID3k68x3An3G6qCtAGQhsR9uAtoyi0W4BWikNvaOgycCWIn8GYH0315+VLFef3OT7
         IgWA==
X-Gm-Message-State: AOUpUlHOyTwE/CxVpqC+SOaFZxbVp1pFYI8RlqxtT3xOzZy7WU1MrdQX
        d8CNI00FY7hwH+MTVNEvuVpc5COfE8BNJcTuzdHE+w==
X-Google-Smtp-Source: AA+uWPxmDCb64viYEuzlwy1qsA+hXPCs45aM7uGk3frSEZV+ajvGEZ8Daix3A64qyiVlm0KqMMS70sRiSyjohGGg81c=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr14221047ywh.238.1534353749474;
 Wed, 15 Aug 2018 10:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <20180815162308.17747-2-pclouds@gmail.com>
 <CAGZ79kYo-icUHfezTMg77s_2GtKcgH6jysNTu11XOoL4UT-9bQ@mail.gmail.com> <CACsJy8Br==4ugLh5G2jU9NV1XRsH8iBmYkMZ2Ke_9jZgwuyJ7A@mail.gmail.com>
In-Reply-To: <CACsJy8Br==4ugLh5G2jU9NV1XRsH8iBmYkMZ2Ke_9jZgwuyJ7A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 10:22:18 -0700
Message-ID: <CAGZ79kaeOoEniNDq_NEeYGH88Qkch7EodGJ-taNdxv=hC7t-oA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 10:18 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Aug 15, 2018 at 7:09 PM Stefan Beller <sbeller@google.com> wrote:
> > Technically you would not need patch 1 in this series, as you could call
> > remove_branch_state(void) as before that patch to do the same thing here.
> > I guess that patch 1 is more of a drive by cleanup, then?
>
> Yes.
>
> > It looks a bit interesting as sequencer_remove_state actually
> > takes no arguments and assumes the_repository, but I guess that is fine.
>
> Don't worry. My effort to kill the_index will make sequencer.c take
> 'struct repository *' (its operations are so wide that passing just
> struct index_state * does not make sense).

Cool! I'll give that series a read, then! Thanks for killing the_index!

> > I wondered if we need to have this patch for 'a' as well, and it looks like
> > which does a sequencer_rollback, which is just some logic before
> > attempting sequencer_remove_state. So I'd think remove_branch_state
> > could be done in sequencer_remove_state as well?
>
> sequencer_rollback does not need this remove_branch_state() line
> because it calls reset_for_rollback() which does this deletion. Patch
> 1/1 kinda hints at that because it touches all remove_branch_state()
> ;-)

Gah! I am being slow.
