Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65194207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 00:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbcI3AUu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 20:20:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32916 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935085AbcI3AUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 20:20:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id w11so6141477oia.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=STXaw8gkGPC4By4vsVbvKHurPysC8sm32bEMOP+Wc+w=;
        b=r0XyyKFh5l+033QYIsU5NtpeK716ksA+F8MkVwmBV+OgmktX8nzMm7dgLdnLWQTMjS
         /xTf1IgDQS7KcitjGV8GN16Sk5fRBIMhpOY5VnzE4u/QTohZfVs99To8kaa8uPSw7bBa
         DRYaHkGHR3Xf93TFMkyXcNcIo7t1NFXGLFl8w5dYfrJaez4AmhKSIQTXRo90Nc+jp6te
         8CGF3Eq38QvbJG3EE0605JShdzY5Z1WBtSdNerJWDRAM4oto2i21QrVwralJ6myd4YKJ
         JUrPBElxQ+O/yj88Marss6RHTGDHinn6b0LxQmuifF00WHwRr7FQUK2CnPtuavNzoPze
         sRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=STXaw8gkGPC4By4vsVbvKHurPysC8sm32bEMOP+Wc+w=;
        b=h6OH+v4sjC8f9q0uGw8qSahpVKXDJhNCLGAVyif05j0M6h+bOElDyWNlFmJaVjwxiz
         xQ8eMYIQta7LHOYSXuVCjJAAKHdLs84AWu2FBRc2tE+FmVoDXa6Am1JV+UKPsSMs2+iV
         txk6tavhOuJA9bPGSrIRCBYOnUaiHN/WpmeGaLd8ZXlUkPaeGSCv4WoRy6H6d9TxJV2l
         2X7zMrjGjRTjBNxYsGJI+j/Er9NN5zYCGQQYRk6RanFWqp3T4dN/2xyDzIhphfxosV28
         ZptEsHzICdFC7vMbVrUi7wXKfTdOZoXglFiZs8stZPNVSM9I9x5gQNaLCEmZCb71FKrt
         p9Kw==
X-Gm-Message-State: AA6/9RmB1qKejX1kUUv7BxL8J7+Q9PLrl9/BfsrFc1FTQyuGHXlxMYBQiC7C4Faqz912E6IofnG9MFGlpuRaXQ==
X-Received: by 10.202.4.21 with SMTP id 21mr3980449oie.91.1475194848186; Thu,
 29 Sep 2016 17:20:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 17:20:47 -0700 (PDT)
In-Reply-To: <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 17:20:47 -0700
X-Google-Sender-Auth: ut8G9Ujx8jYT5g1ewwZWbFe0pr8
Message-ID: <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 4:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> One thing that worries me is if we are ready to start accessing the
> object store in all codepaths when we ask for DEFAULT_ABBREV.

Yes. That was my main worry too. I also looked at just doing an explicit

     if (abbrev_commit && default_abbrev < 0)
          default_abbrev = get_default_abbrev();

and in many ways that would be nicer exactly because the point where
this happens is then explicit, instead of being hidden behind that
macro that may end up being done in random places.

But it wasn't entirely obvious which all paths would need that
initialization either, so on the whole it was very much a "six of one,
half a dozen of the other" thing.

As you say, my original patch had neither of those issues. It just
stupidly re-did the loop over and over, and maybe the right thing to
do is to have that original code, but just short-circuit the "over and
over" behavior by just resetting default_abbrev to the value we do
find.

              Linus
