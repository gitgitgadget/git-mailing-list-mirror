Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCE21F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeH2AK1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 28 Aug 2018 20:10:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42542 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH2AK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:10:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so3251498qto.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d0G1pIYw8qTv0oWXI746r1lvmxovfi+FmEe9aKIcAws=;
        b=Y23qR/I5CpwI8SL9Z44rALseaqMqhDzJCD5UvRuWuC02KBOrJJb6JGQYh3LDFllPxQ
         RG3SviufQciStZ/mIJm2bQTjWZjZN8cEA2hmxN7Gbvn49a3DLQZzo8LqqkKfDspA8geZ
         vraRztkn3IcS3MfoOjHaH0Z9x55GmqxOnDscCKQxaIP55iX4gH8RhzHh6KaCvkZXVRWZ
         zR+odVMExURFPzDDKcNvS/Js8QyMgahrGsp7vOBBZ9vfkrWXb/yXqjL3w+yt/BayL39p
         Lk+kjp0sFBpiFdjGDXSVSfZvSsD2r+oRvLtGpJ+RvEWbaMmPu02x4QRJgHh8H6tLgZRV
         obvw==
X-Gm-Message-State: APzg51D3jChVPnFmqEbBfSNNfmjI66Q59rR6m0wwd+sQuSqNFoDc8UP+
        kVnG0fI+bZYtOwC0S8ESKgEmHBTVeKMwEe4f8Lk=
X-Google-Smtp-Source: ANB0VdaJQoVhP8MDGXTNupEp2sMtme/ArjyEdp1lAETy9s6/KBVcvt2GpgF9e8Mt761Wf9vDoiZkhBMTKCiXIwvMMA0=
X-Received: by 2002:aed:3baf:: with SMTP id r44-v6mr3488856qte.77.1535487431738;
 Tue, 28 Aug 2018 13:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
 <20180824152016.20286-5-avarab@gmail.com> <CAPig+cQxUdr0g+i6AztcH4Q51X-W4MtdhKGv=wau+b6SFsniAQ@mail.gmail.com>
 <87a7p6dza3.fsf@evledraar.gmail.com>
In-Reply-To: <87a7p6dza3.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Aug 2018 16:17:00 -0400
Message-ID: <CAPig+cTo402TVFpdrz5JPOrX7OhNNQCs6vGCP4LdQ8=a3dtgww@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] tests: use shorter here-docs in chainlint.sed for
 AIX sed
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, benoit@openbsd.org, kn@openbsd.org,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 4:14 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Aug 24 2018, Eric Sunshine wrote:
> > Shortening the names makes them ugly and often unreadable. That's not
> > a complaint with this patch; just a general observation regarding
> > 8-byte limitation with this platform's "sed" (and POSIX). See a few
> > suggested improvements below, but probably not worth a re-roll.
> >> +:clssolo
> > ":endsolo"
>
> I was meaning to get to this with a re-roll, but since this is already
> in next & these label renames seem cosmetic, it seems better to do this
> after 2.19, i.e. the compiler doesn't care about the specific names, but
> shortening them to <=8 fixes the bug.

Sounds fine. There's no rush. Thanks.
