Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2D8207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 04:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbcI3ESJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 00:18:09 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33465 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbcI3ESH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 00:18:07 -0400
Received: by mail-oi0-f44.google.com with SMTP id r126so117002851oib.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 21:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DtBNbh6PUK4i5z/+vGJ7wYl69n8r3b1vtgWEHdRxe7Q=;
        b=pg6Oxaw5qGuGWWGTRp87q8UpDM0dpBsg86ZQ/I/4OUHMGVdiTryG9QLakeziN7Lyfc
         lMxNtJq0X2vP7lhLJhZVO0VJhJWZ8kCcWjNEdzFol0Sw0VL+WNgbA95eYPIfx00zO7Ry
         YvTNZ7yLZg5KOP/h3T6gJsRhuJsKT1wL4E+E5Kw5izJHg3wYC2/DlBHI2DuIi4A1o4kl
         eAahf6i5bUc2I8UzsNqKxHtOVZM4gHJPkV6dhhBlXujAAWqS2C5l0r3ajlA6zVwydtkz
         tQv/E6Cv7I29J04Z6dISZxF+ym561bPVXMJcY7m9he/zMv5tJpAyuv/R2DyWBciVxEBc
         F80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DtBNbh6PUK4i5z/+vGJ7wYl69n8r3b1vtgWEHdRxe7Q=;
        b=SB3O9Q4Mvxu9NIfu4SAvS5qeqLac3TAfL19r3FBh6YFst2rviiBFz6gYHpp4QdnKXB
         bEeAAEzFM4zT6vqq/RUXYXzygzUgF+7k38E0yVLMOlibvSNHgsiYOZFb3LU7Zr2b0tcb
         kaAVnON4I4cnLb7dCMo3lwsItTipgoEYvqWTOMnHbMBTQrVYIy6JxuP3IIELyjf78ZBq
         XYRcmZ2n33qfZHtR9CzTRKDETqPZx7kAQLaxWIeksAZqavKUaeMGfpyATC0wbhUHObjF
         AoHlwQ2yHao7DI3r0yqZzzr3tpMRRvgVnR8lrjYmEpwsFgrxfdlkYj++CbxZQOmfTNqi
         zSHg==
X-Gm-Message-State: AA6/9Rm7uc5n9K0Wa5ojGg8CPzOcWo/4dyAxsj4CbORgnApQrazJ7Kzpb8bkCd+aYAtsKdx74ByE09qQtHwwiA==
X-Received: by 10.157.12.247 with SMTP id o52mr3709062otd.222.1475209087139;
 Thu, 29 Sep 2016 21:18:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 21:18:06 -0700 (PDT)
In-Reply-To: <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
 <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com> <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 21:18:06 -0700
X-Google-Sender-Auth: CQX9R-C0KH1Kslp2XU7YevL1-Xo
Message-ID: <CA+55aFw4=tGQZd0QO_8Zzs0AqPCpew_Wvnwft-JP2OzFbask8w@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 9:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> A quick and dirty fix for it may look like this.

Crossed emails.

Indeed, I just solved the builtin/rev-parse.c thing slightly differently.

And you found another failure in the diff code similarly not liking
the negative DEFAULT_ABBREV.  There are probably other things like
that.

              Linus
