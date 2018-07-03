Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF911F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbeGCSdW convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 3 Jul 2018 14:33:22 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33688 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeGCSdW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:33:22 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so1115845ybb.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/KnN2xgMYqZ5pnR7xK6vtNEHLZZlG2bcrLyeBg3VVM=;
        b=L4nMIpqjoE+/lelUjsmxV/4HDfBPYxwEyxkwvoV72QHXlDHMmkKU4gzZ0U2/15A5Jo
         MRGIa2CXQ1u83wtO4OxNiGfbNCw5yYYDjPAGlb7SMjgDA4hLL/9QX60SuxepUY+lwMxW
         eYUDi/sO+3oagELe5PkTmzp3YmQ/eBCCkjUAk5VCtoVAheuFakXJC2ZCkp+lc+9QIO8D
         awALB/pjofzCymt4aldR+q4V5BP9IepxKURxY5uINoLCrLcteabsHiTSEXXd4rWhrciX
         2XP62yO7CrsmUhi/vammu7WGkH3j0G677a0qifM1N7VDYJ5abvKEse8qbC3ny/3QLf0f
         3qGA==
X-Gm-Message-State: APt69E3eR9VRw6ND8ckYw2VSenE224INWuacEFZuWPShsSf1bmttXo8n
        fD61iwIrV3+uW8eZvql6+N3Kkv00Sg9HPcU4zgM=
X-Google-Smtp-Source: AAOMgpcjuLWl0MUGzIIf8E4MK8ycZikvwgUGULS626Gkf5yPSGuhTQ4VKanHv49G+yr5V39zQkTwh3c90+5uSP+BS3g=
X-Received: by 2002:a25:9b03:: with SMTP id y3-v6mr3829841ybn.194.1530642801355;
 Tue, 03 Jul 2018 11:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com> <CABPp-BE=2nzEG=X0Jv3++J3Yo3H0yfJ9vd4pDYYBw5fpzDYc_g@mail.gmail.com>
In-Reply-To: <CABPp-BE=2nzEG=X0Jv3++J3Yo3H0yfJ9vd4pDYYBw5fpzDYc_g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Jul 2018 14:33:10 -0400
Message-ID: <CAPig+cQkfFv2+FscnVj3gdLAgeQL8k+vCykES6ZVz-8Uq-nFqA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 2:31 PM Elijah Newren <newren@gmail.com> wrote:
> On Thu, Jun 28, 2018 at 2:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > * ds/multi-pack-index (2018-06-25) 24 commits
>
> pu fails to build for me (with the standard 'make DEVELOPER=1 ...'),
> and it appears to come from this series:
>
> midx.c:567:15: error: ‘write_midx_pack_lookup’ defined but not used
> [-Werror=unused-function]
>  static size_t write_midx_pack_lookup(struct hashfile *f,
>
> It looks like the use of this function was removed in v2 of your
> series, but the function itself was left behind?  Could you take a
> look?

Also reported here [1].

[1]: https://public-inbox.org/git/CAPig+cRWwTAFRJOwQOi4USk5UZke=2sz_JVDh3+XRKCcBGD5ow@mail.gmail.com/
