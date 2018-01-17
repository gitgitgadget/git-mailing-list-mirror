Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5311F406
	for <e@80x24.org>; Wed, 17 Jan 2018 23:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeAQXmN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 18:42:13 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:41509 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbeAQXmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 18:42:12 -0500
Received: by mail-it0-f48.google.com with SMTP id b77so11338328itd.0;
        Wed, 17 Jan 2018 15:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=i9IpxsUGeM7Q75rjs5UTeNO1P8wenXAUBp6BQqPE3ck=;
        b=KMFefd94VZwV8kMuz51nQYtYOeyObGFewShZQI/YBwO3mDGvxdLQWwkOBApJdh7i2s
         76Ybv5AupogpAMMpcBy2AZmtS1JIQGvwgSRg7rL6BK7yH7UP1Dmq05uN8Bl6U+R7gRar
         7GFvuK8GEYWa9CmJoBzGwv/+c/BRLLpuEOClLhubcKHOEN1b6R9jRQCllz93NVuOzYRH
         3yIZV1/zpNDTiAhTGZClW51qlxmbj9ZZ8TsksFbSAY0DVHgpnCVi1VfNT9qnA63Amfu8
         YIhRAGaJR50zyB+hZLnG+HA+zQTwTtK/YZm5jaN+0+hB4r8lN988PF4+qiRn2XH+ChRA
         u3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=i9IpxsUGeM7Q75rjs5UTeNO1P8wenXAUBp6BQqPE3ck=;
        b=fz6LfP0HqzNnFrp4ahtb8zhtGVhQ4WSbPi0JCscnDRnwC48fz0Vumi7ko9B4W9itv6
         CJBXqbKVFIySu6W1jQpRlD2pmuj3YlTt9noR0qjzw6rK2RQE5izCHl8Wxg83ENOMG4Ep
         J/ix32jHmneLFL5UwEow1CxguMLfxrNIMaAmcKVgdlkC47NLkD59PipP5WcEMUkbkpwE
         AZBljO/ZyAnOppIFAmHM0rwrset6hrqbsW3ztZQ4JAfdIDTGVbYQf/RVP0DPjcsHQP+a
         3R2CaRA5fMS4qEWBm3q0C0n2YK/S6lznalsinG0gIjFvvNUFy/Q4AyZ9YmJ4xvggx6Mo
         RF6g==
X-Gm-Message-State: AKwxytfEksE/FgTvDIPJ79OVJVuGG+7PXwAgU2uRaZz709ovDLsJpoE5
        vRta0mVjuzGMgsnAQB6g5eQQb8mGGDe4sYfpmfo=
X-Google-Smtp-Source: ACJfBovxii7vZEQ1t95SFmuDvaAQpJ6D7wbXHsLv2MWxuWz5kBsYYIvbYjeRc40YICVG2L9QwuDAps/89/XTwOf7qjw=
X-Received: by 10.36.204.85 with SMTP id x82mr23076055itf.21.1516232531360;
 Wed, 17 Jan 2018 15:42:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.147 with HTTP; Wed, 17 Jan 2018 15:42:10 -0800 (PST)
In-Reply-To: <87efmohy8s.fsf@evledraar.gmail.com>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <87efmohy8s.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jan 2018 15:42:10 -0800
X-Google-Sender-Auth: pvipeEzlO12E2hpbfDoC7CW9YYw
Message-ID: <CA+55aFyXn-DMhkTFNmHa8QgLYx6Fb0Jr+kkr5v4mRhyT7Pvx=A@mail.gmail.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Roberto Tyley <roberto.tyley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 3:16 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Or does overall FS activity and raw throughput (e.g. with an ISO copy)
> matter more than general FS contention?

Traditionally, yes.

Also note that none of this is about "throughput". It's about waiting
for a second or two when you do a simple "git commit" or similar.

Also, hardware has changed. I haven't used a rotational disk in about
10 years now, and I don't worry about latencies so much more.

The fact that you get ~100k iops indicates that you probably aren't
using those stupid platters of rust either. So I doubt you can even
trigger the bad cases.

                Linus
