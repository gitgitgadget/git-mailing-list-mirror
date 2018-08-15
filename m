Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EC21F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeHOTZw (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:25:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54805 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeHOTZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:25:52 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so2481796itb.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6Mnq6l1sSvZfIRFzz1LiFny6CJrsHp4VUf355GK/ro=;
        b=CnHLJlavCTFvj2rc9GY9IEJ6+3vOo0r3g2Z5JLOcWfTUQZxipUmAUZ7+SvHltYOOZY
         QA2zl0+ANf4CaJSHsS6HI+36FGbMVxFiKehj4JS/mz9ZMTjWJ8YwSmN18Lb0RjPgnjDr
         NCLgVbGnmcFhjKEKA39V8aqE8B3SIqgKy++zLgjdHunQndYlG/+0y0wYAmCOWKm/sLKg
         5vCKId33p11iXm2neQcKgIzAOeu9Qyit1MtSzLfGOl5qjDTNw+ThDABu1Z7nplvoJ+N1
         8OOFbBK7NRc+dAH3XCLAgmSIs+z985OAy50ueM8FBWkORVCi0wSrbjCSGlnHFyv0gMc9
         yaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6Mnq6l1sSvZfIRFzz1LiFny6CJrsHp4VUf355GK/ro=;
        b=O+F0SdBffW5MsVBADVjp9sHnf/NYDVGj2iMtmusF0+sTOOKCTs78AMu2rRmJxenMSk
         EWBOvm+Fr+ts569Fh1FovJhWpjRwyrWilEN431rWCXt7ZgMhIHkg9XvoyzA8+/ZBksAk
         j0ETWWpotFj6n25e03jj9QIc56iAmPucd+i3ZGmPosPF192OUJXOHpnBqvKmLnWe0HJz
         5frS8WL0sF+yabMUrbSUX/aYeFYhSGvgPch1jo07EpmA8YhVyL7rMSj8vrPDtwdof9sW
         HzYZcIU5PCkx54Oq/WgULDM348QTHi6ni1VdKqKg5jIWB6IZYnbr2Ha2cwkdLNkFoR04
         3b+g==
X-Gm-Message-State: AOUpUlFKngAI5DWcltQVZLinaJ7K8jHsyci0R1TnicSDaaH0NAPhiswV
        e6ICp0yWIXgYPkT90/7qfaMppPqGwifwK027jpY=
X-Google-Smtp-Source: AA+uWPzIvS0XxgrYvebpOl/Pm11rBIWrm02J01VGXdPXp4DrU9wDxPghiP/dOmFonGeg8YhkYhkz+TLHEKOjOTZdtIA=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr17853228itf.121.1534350781696;
 Wed, 15 Aug 2018 09:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com> <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com> <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
 <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
 <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
 <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com> <xmqqeff0zn53.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeff0zn53.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 18:32:35 +0200
Message-ID: <CACsJy8C5xPOa26q_dvGgrmkV+C-k2kmc8_nQbwzcDVNue4ehYw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 10:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> > It's not just sampling points. There's things like index id being
> > shown in the message for example. I prefer to keep free style format
> > to help me read. There's also things like indentation I do here to
> > help me read.
>
> Yup, I do not think that contradicts with the approach to have a
> single unified "data collection" API; you should also be able to
> specify how that collection of data is to be presented in the trace
> messages meant for humans, which would be discarded when emitting
> json but would be used when showing human-readble trace, no?

Yes. As Peff also pointed out in another mail, as long as this
structured logging stuff does not stop me from manual trace messages
and don't force more work on me when I add new traces, I don't care if
it exists.
-- 
Duy
