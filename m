Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEC6209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbcLMUXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:23:00 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36751 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbcLMUW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:22:59 -0500
Received: by mail-qk0-f173.google.com with SMTP id n21so128903757qka.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QVRiLz25Fdb57a5CiVBWRPrjr/nDufozo9uNkXyDx5o=;
        b=eyd3kr4/uteLpG6GWwN/XVYBaHo6tfz6A+unkrp1UBsWocsYfIZIg3kurQ8127BWOQ
         3TzHl8E7VE6EivLZIsMmLX54y+qXSd76FS/9g5KRwR61TSZTepdXIBzxGogtu0Ti+xL0
         cYWElV57xqlUOH8lj4cSx9NPJJ9r1/WRCC6YXGyiNlr9+VvMHLxQqwK82X+Sgq10v/4p
         mFUj2kwim93IoTBXBd3Lw8ivhfy6CRi/lAfVVRFQ7EQ9AhCRbvP7Cx4mEz+2PfWQzc6+
         EvNPxi3TYhQA1wFnRZuMJe2qsELroj/7JDzhsUX7NX0NOEQEsnSmSeCHEESDg/ytO5vS
         5Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QVRiLz25Fdb57a5CiVBWRPrjr/nDufozo9uNkXyDx5o=;
        b=GG/5kSB2Y9k+xK2unkkSt1Ioa3aiU+Z3kLGSSI+V2ciIw6SFHl4H9ehtywAEwyITh7
         1Cmf5UowAN5mobY4fG3w1OxvRMdoPCV0yIxZAjJLtS+AYy1GVru6Y6T7mEMZ/rWfiVr5
         qNTmWvDD8XFS3kyXq/Y/AtpOlJYU26S53FBjdZR7sZB/ZDzcof09u9K57SAQp2DJjEq0
         s6vFzS6PwW1NOgoQbn3SH3oQc5gaVhk8bE4fp2FhFxBCmdF8Gf2p9lRd1OgmNCKgNOwF
         bwfkyB1FoOoNpGYxsSdBGL2FSHwqWSXZnwcD3VH6DUsdq1BFW/PVOybaqhklbJkAGAgD
         sUnQ==
X-Gm-Message-State: AKaTC020LkJ5/t844QjFqiWxO8pGohVEa5FZDPXO52WHhGk4Ef7ZNjiA8/xTw3E0gUfccL4Z5B3wuOs8IjqvDahA
X-Received: by 10.55.43.65 with SMTP id r62mr7792351qkh.53.1481660573517; Tue,
 13 Dec 2016 12:22:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 12:22:52 -0800 (PST)
In-Reply-To: <CAGZ79kYM_3NWyRfk42=EshMYVZ=DSWRtn4RU4jkUE7v1EN6ngg@mail.gmail.com>
References: <20161213014055.14268-1-sbeller@google.com> <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
 <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
 <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com> <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
 <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com>
 <xmqq60mn3937.fsf@gitster.mtv.corp.google.com> <CAGZ79kYM_3NWyRfk42=EshMYVZ=DSWRtn4RU4jkUE7v1EN6ngg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 12:22:52 -0800
Message-ID: <CAGZ79kb=-hUi+NqSa5v9qqKRfVW-Qsf_8Wsbi+hcYTQR5zyzBQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 12:09 PM, Stefan Beller <sbeller@google.com> wrote:
>
> So I will reroll it with "absorb" fixing some nits pointed out by David?

I got confused there, Davids nits are for this series, the absorb series itself
doesn't seem to have nits.

So I'll just reroll this series on top of the currently
sb/submodule-embed-gitdir (which you originally noted to be better renamed to
submodule-absorb-gitdir) merged with t3600-cleanup.

Thanks,
Stefan
