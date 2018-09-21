Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B372A1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 02:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbeIUIED convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 21 Sep 2018 04:04:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46363 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUIEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 04:04:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id l194-v6so3371127qke.13
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 19:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ywdFj2abImt7vAIjxWuwzr4jCML1IzQMraR6GU3F+4o=;
        b=tmgtntwXthVyVgmJWeI8v0KrFXGq5+xviEq5NKFW3TwGBE6sO9woKBnq+o5CT4FK6j
         EvPp9t3p/MIhZpK5HavrJYtIHbliIcb6ck+THpDaKk7ZsMMXriKyq1J6ZlaIewA9+mp0
         GiGm5VFw6Mra1gH/qZfYlxAIoZl0rMYBNYOues7cdT7jbWoQ9WEYhf3+q1Uw0UHK7wy0
         OiHX5kXZxI+OgoeNy3sWfiUp33oL0V/5ICThVg1ma0ytJDbjOEuNPjV6Zq2Xu1yIijL/
         o864NxKND6mcakbA8Bo9X6GpJO/JksCN4vUzT0K93Ckt610Hk+UWN+yyT1RdSC+82Fs4
         m1Zw==
X-Gm-Message-State: APzg51AixNvs49TKKMjNO21jHdPYyVxnh1fWhuL8KaUn9UY2ZeCvZpep
        yUiMFEl4IhsNPnEA4eTqFyAvfJFelJTLqPSS7wM=
X-Google-Smtp-Source: ANB0Vda7CYjax+MiSoWfpJkyZtzjAtuWp03p9ZatlmG2E9/hTO1Pj3AzqSxdbYFMF2ue9sGdPau/Om56FYHs9jBoRq0=
X-Received: by 2002:a37:455:: with SMTP id 82-v6mr8069408qke.26.1537496249266;
 Thu, 20 Sep 2018 19:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180919141016.27930-1-avarab@gmail.com>
In-Reply-To: <20180919141016.27930-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Sep 2018 22:17:17 -0400
Message-ID: <CAPig+cSP6mSKYoEMwaSZjZTj-kiQUHukjPUXVh3tv8ySVtJd6A@mail.gmail.com>
Subject: Re: [PATCH] reflog expire: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 10:10 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Before this change the "git reflog expire" command didn't report any
> progress. This is the second command (after "pack-refs --all --prune")
> that the "gc" command will run.
> [...]
> That may just be some artifact of the repositories I've tested, but I
> suspect It'll be true in general. As the callstack above shows, in

s/It'll/it'll/

> order to guarantee that we don't do that we'd need to pass some
> "progress" variable through 10 levels of functions, many of which are
> "for_each" callback functions with void* cb_data.
