Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1584A1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeFDOml (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:42:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39928 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeFDOmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:42:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id t22-v6so25203487oih.6
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+T94QejrCALoe/wbfpVLr3WozYyzMOCsl7xOxTNJ5FQ=;
        b=KsKIUwOyNt0oDJcn0oF9XlaCOKMzY1JCGnt/LbD/l+WLie+ijGZzP3Ef4l3HZp3BcW
         72o5x+5yJAfe4t6hwNijvIzyVc1iXTPRqbynod6TJe7fT8o9yH0bjMutjrjBKu0Zn0NZ
         xIu3R5uqCpeJNZBBKmYNkWRk7N+OszAl5wq3dZcyKHu4EhMRxxtvZevwP6H9Wb2pr8aN
         U3YWQ+QZacpfaSta7V20HjNrtAkZbwkiM3TWPMS/nmbuxU/PBho0O7m5haCDSx7DFLow
         UcYeGhjzDjzfh8CRtDP+4Cal+HMRdsZtaymQVufrqam3se/sp8BLvGT2azCi2UATqGdW
         L76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+T94QejrCALoe/wbfpVLr3WozYyzMOCsl7xOxTNJ5FQ=;
        b=rGfIx4h8ZxUpQcCp6xLwh3NvBioZ0f94I5HoH0zP509Ob786dxud8t3LBIkwIHFSf+
         x5lgzELpAAE2Dw3T1CHxB3+sY5eYTM/j3IZFBhK+58mOc2kGZa+Ag6dg+aCoUcBGOQlg
         d8JJj1B6KtfHFsdQT1SxzIPNsAM6k8mOdhT1rmHGTFiJnSj1QzfXHiDGmYfJGZv8OhZv
         /bWbJHiwLqiz5G9T0Y2jqp88lX+MJFUH0sxnh6xK8xqerMPgnGshdcxHorJVCJdVfmP1
         sVT/iZnws9PUO/w5MfQzIxwrsZ9TwyBFXt1Bo/rLmE3ZQU4aKjCynHv2gUVa9+2JnbTN
         IT2A==
X-Gm-Message-State: ALKqPwc92Yt7UEy8mOWamP7NPiiE7K6WXxEmVhJo8/AYVGGeks4zHvxl
        u6gaeMqszufneGANOxL99njwhiTiVpamuNcaN+o=
X-Google-Smtp-Source: ADUXVKJPKzAi6XjfiH2Neer8aDr84hIlk3u0s0TzLQGiJvACZUNpvr7FsOsb+It8oxJRVWqpkOqKW51MXgheDQCrCSE=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr9682762oie.30.1528123359650;
 Mon, 04 Jun 2018 07:42:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 07:42:09 -0700 (PDT)
In-Reply-To: <86d82fe4-3dcc-48a1-6800-70d49e30af8c@gmail.com>
References: <20180511211504.79877-1-dstolee@microsoft.com> <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-10-dstolee@microsoft.com> <CACsJy8A8NofWCo0MbMxCe=xKTrnAqmM5D+FHSJXC-wO-DPnXwg@mail.gmail.com>
 <86d82fe4-3dcc-48a1-6800-70d49e30af8c@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Jun 2018 16:42:09 +0200
Message-ID: <CACsJy8CGqrAH0A8TvSju8MqJihn6vym8PrLvtuf5bbczj=kUwQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and lookup
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 1:32 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 6/2/2018 12:38 AM, Duy Nguyen wrote:
>>
>> On Thu, May 24, 2018 at 6:25 PM, Derrick Stolee <dstolee@microsoft.com>
>> wrote:
>>>
>>> +               if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
>>> +                       graph_report("commit-graph has incorrect OID
>>> order: %s then %s",
>>> +                                    oid_to_hex(&prev_oid),
>>> +                                    oid_to_hex(&cur_oid));
>>
>> Should these strings be marked for translation with _()?
>
> I've been asking myself "Is this message helpful to anyone other than a Git
> developer?" and for this series the only one that is helpful to an end-user
> is the message about the final hash. If the hash is correct, but these other
> messages appear, then there is a bug in the code that wrote the file.
> Otherwise, file corruption is more likely and the correct course of action
> is to delete and rebuild.

Dev-only strings like this are typically prefixed with "BUG:" or
"internal error:" (unless BUG() is a better choice). Git is
unfortunately not fully i18n-ized and devs from time to time still
forget to mark string for translations when appropriate, including me.
Because of this, we still have to slowly scan through the code base
and mark more strings for translation. Something to say clearly "not
translatable on purpose" would help a lot. If "BUG:" and friends are
too much noise, a /* no translate */ comment or some other form could
also help.

But your explanation to me still sounds like corrupted file in some
form, which should be translated unless it's too cryptic. commit-graph
format may be available in non-English languages and people can still
try to figure out the problem without relying entirely on git
developers.
-- 
Duy
