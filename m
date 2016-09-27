Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0878209A6
	for <e@80x24.org>; Tue, 27 Sep 2016 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbcI0RqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:46:02 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36091 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933854AbcI0RqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:46:01 -0400
Received: by mail-io0-f169.google.com with SMTP id m79so23507931ioo.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zy6sAFuk1aKeJAvqyOC/3tVvDBU0/KibpY/NfcaHfw4=;
        b=n49bYuAxbzcT7TARPgJq913Vxw6PFNDERGBoAB7exMN2SCz4KhP2yfFQ9cGVohqYCb
         maF3zoNjrEgqGVMV9+Lo3uQFnheCUERdf8avHhccaiiuyUXFrb5y87Jvu3G5X+F8ZjnP
         wXQRuK6jFOpteovzwyqFtTfkh4KLsErtcDvoDbgYHMZ02g695QYuK5a7TKN8w6CK5BVw
         aYTpv4uIsq5ZptiHZIHE0kg/nT6++ds+8e2WGcEfklD6JEIYr1hXc5m24I+jXfnGJSiM
         hZ6YqnhxdQ21c6YEU6goz58DBHLd7MR3HDsSgnBbd1abfVTGCAtNA9wCbwvDuaJw3qgH
         OYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zy6sAFuk1aKeJAvqyOC/3tVvDBU0/KibpY/NfcaHfw4=;
        b=IBxjx6zieKGAQg3fKS0UVtrv9bTzQWGezZME8rtWzE+KIMb/7HR+ZBEOr6pWhpyYAI
         AbB5qqZIsFjebQCqW8X/jP0k4OFZ9JUTVOrRI7wJGari5v5kgqEtDKnZLVZ2dn4SEE1w
         qPvh0IWzk6WkDxPAQYhqRe+gQDpkf8ttL3nqYEvOa91S0bvmFfu048Iedi0IfRvrQTFH
         CLQTJU1+mU+etjVOKog9WkuoJe62DwnWMq6hAFQxWQTzlAiA1geuc5OU/B2KX8m45uk+
         iX/KWBhiQVKNkebXFBb8eeR7RkI+8bYwEOce/7/R+dpm/0sb/cAucWF6a3muznJpCCxO
         W84g==
X-Gm-Message-State: AE9vXwNsXkSrx1EAMnA8aXD0DlpX8yercaXysUmLEr28OaN6p+FpkD8amRhxFSI6Olv5tLI/sdctMj/rMdpHiHOh
X-Received: by 10.107.153.129 with SMTP id b123mr33916679ioe.160.1474998359936;
 Tue, 27 Sep 2016 10:45:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 27 Sep 2016 10:45:59 -0700 (PDT)
In-Reply-To: <CAGHpTB+XOxMh=o_dKGx-j2P15zsmcMn0MB7BuKFksOn4O_FXYw@mail.gmail.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
 <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com> <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
 <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
 <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com>
 <xmqqmviupcpx.fsf@gitster.mtv.corp.google.com> <CAGHpTBLPvQDD4hhMKiOFdhxug-joi-38mNozuzm3=EJCnS9UEA@mail.gmail.com>
 <xmqqd1jpqp7p.fsf@gitster.mtv.corp.google.com> <CAGHpTB+XOxMh=o_dKGx-j2P15zsmcMn0MB7BuKFksOn4O_FXYw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Sep 2016 10:45:59 -0700
Message-ID: <CAGZ79kYYUNf7AvpQu=NzrujM6pCdBK_JunZhC-CxPkfRcNDL6g@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 10:23 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> On Tue, Sep 27, 2016 at 7:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Orgad Shaneh <orgads@gmail.com> writes:
>>
>>> On Tue, Sep 27, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Orgad Shaneh <orgads@gmail.com> writes:
>>>>
>>> I actually see that there is a problem with it:
>>> https://github.com/git-for-windows/git/issues/761
>>>
>>> I'll try to revise it and resubmit.
>>
>> Are you by chance volunteering to be git-gui maintainer?
>
> No way, sorry. I don't speak TCL at all. Every change is a true pain... ;)

I considered stepping up as an interim maintainer briefly, but this is
the exact reason
on why I punted.

Looking at e.g. `git diff --stat gitgui-0.19.0..gitgui-0.20.0` (which
is 16 month apart),
the workload seems to be very light, so I would not have concerns
w.r.t. time spent.

Stepping back a bit and asking "What does a maintainer do?" I think knowing the
language very well is not the top point, but rather looking at the design,
maintainability of proposed solutions as well as long term well being
of the project
is what makes a good maintainer.

That said I could step up as a maintainer, but for each patch I"d ask
the contributor to
find a reviewer who knows tcl well, as that is a part that I cannot
cover. And from a
contributors perspective this seems to be discouraging.

Stefan

>
> - Orgad
