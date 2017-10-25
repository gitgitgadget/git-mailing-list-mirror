Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254D91FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdJYEHO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:07:14 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:56569 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdJYEHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:07:13 -0400
Received: by mail-qk0-f195.google.com with SMTP id l194so28954724qke.13
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jLM5iJEaD7j/oTy0wZMzMdC8argqHmR/tGZ1Q9tATu8=;
        b=cA9hfmNsee+1yMrJxxPVvt/kbVp7K1dooC1y02hcvCv8g1/OPeGALm2giYwPIYFFF4
         BcdFuW8fvUfk3rIIbaerVtgSoRmKwoZmTvCNJKzZ6e9J3vkJOlMjO6Vbf9J1YAt1f8PL
         5Pi0yqx116ShQJZ3rY6ZaTn2MHOmZL+0o4LFsqpMq1oKlYvceez9ms5VpMSMpDfPnCSo
         MgWXhYzVpUVpt4fgoyFZw0+C+1lvmiRhgs0OLGoR662o3zEx1m9aVuwyQNLmQVweNJSZ
         qrkDxfDw3WE/b+Y4/6Z+iGc3Yfh8N1JxUKRRvcEcc5jbp2eRtdGdJpBqVBn4ce4u7yLv
         oC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jLM5iJEaD7j/oTy0wZMzMdC8argqHmR/tGZ1Q9tATu8=;
        b=aBbAq+lZLZiqS0s4/JF5LIoP+/M+1b4WuGzLDsaEJYCzfglyHiWJRj/WIX/okMvN9M
         N76+M23TkYKpEDCceZU2VhjaoEkCMc/2uT0Zx/bEsAPrTMQykYdDTkR9hEACx/rw45L8
         UOi9p2+cVXm1/pMyr1MKE64YnJEdAGrKYqRbtqfxnXR4GvsDHFdtazcT7TPQ3vhUEAKg
         puDBOOpyLvyovIHlugm8VaZg+nWMVRMQ5bVEP8VkBCmEr0uBHT7dHPmkOsIuMjultZlB
         lc6M7PbnbITzgSuS8InFkCOE6u5YpUN8b35yeWhtuhRq1wuoX8qJvluQmE0oK+YF+9np
         saYA==
X-Gm-Message-State: AMCzsaU1omlkpkj1W3L86Zwu3p3v9IZxlzDnQkyDzzCzIt37OnPjDZvv
        lOtug4xq56LS9OnPQeQapxOiW8N6k1wRxPMcPoE=
X-Google-Smtp-Source: ABhQp+SE0Zll3QxNSdgqvCKdDCnJnfuhaIjOMOzCEfOH8JL2r1Qn5JwVU+LfoWDBrDPXtKPLt4ZWOfSamXnSYI6WxCQ=
X-Received: by 10.55.48.142 with SMTP id w136mr1192865qkw.147.1508904432525;
 Tue, 24 Oct 2017 21:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 24 Oct 2017 21:07:12 -0700 (PDT)
In-Reply-To: <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com> <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
 <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
 <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
 <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net> <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Oct 2017 00:07:12 -0400
X-Google-Sender-Auth: _mUB54LIqXI5SkKdKOnY-dYBq08
Message-ID: <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrey Okoshkin <a.okoshkin@samsung.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 9:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> I definitely agree with the sentiment that as few things as possible
>> should happen between calling getenv() and using its result. I've seen
>> real bugs there from unexpected invalidation of the static buffer.
>
> Sure.  I do not think we mind xstrdup()ing the result and freeing
> after we are done, though ;-)

More specifically, xstrdup_or_null(getenv(...)), if that route is chosen.
