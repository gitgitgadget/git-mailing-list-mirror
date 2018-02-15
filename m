Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9CD1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164142AbeBOVrE (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:47:04 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:39073 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163782AbeBOVrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:47:03 -0500
Received: by mail-lf0-f53.google.com with SMTP id h78so1547488lfg.6
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6aD/4L5DSPqxRvQfeqK3nSBFkyCUI+bxuGNtoL/BKWw=;
        b=sltL3xhVlRBMnhH6KVS+2TrYG5L3LHunsH26st0SNNTNntePrvgTZcwiWxpgt/n7FE
         UjRRi9vBg1Mq0dn3wLXW3N9PXKBtwjJKirYQUICYCsgO+dOZNdCFKPihYecJHMDg/9Cn
         7wMETbOnX4pxue0+gCKcMOM7olsnWs2UaSfw0ZHWHEmRHG8Fvmhj8P1EC1XBTwpmYteo
         dZmDs56p6p4jkKxTpYNf37fFLoeD0uwIqJ5PLE/eEAw7fjGPV9hb6eAUlN0JUBbklGYU
         EjtzbCEiWpz6f4m8poh+C46QqUFF5Ji3LT5pt9awegCFK+l9Bg2kQ5j8Qrcu0KkSwvnx
         Db8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6aD/4L5DSPqxRvQfeqK3nSBFkyCUI+bxuGNtoL/BKWw=;
        b=Xok6qoJbeNN095LdqIRRH2glfUu3L/0xdhXXx0y+yKuk4A61Q0S1ySROxRAcHuAWJ8
         dq9EPlNj84r13s0K3BMVzCZJWimDHBJTGrASM93x3iG1PG+Llp91TFa4DoR74dOpRh9T
         d+XuEm5gSQ5XehdGcOe2wJ2ge1vn+fmD8yeRMeyL7NP8FYLwhxeNRDPGx3jTnXkYd6Fw
         Unvz32uN9xOqNC0pS7pfrABpQ6AD2psyWYVhOTtmDDKlmGMbGRY7ShLZKU+uRfedDh6k
         Qvamw0N0V2+ENSNIQU84G5ZKR5G/SpmmOq3TJkspr1nOHeBDT23AJ6bfppVHoxJP7DGN
         mxLg==
X-Gm-Message-State: APf1xPD5e9XsZR6f+84dAH1rHeN/WUlB/fnseqSYsZzG4slYMEKP2oZh
        SRwSDb/TqshCDlesyvSGwz3cg867f7OzGy3+yzM=
X-Google-Smtp-Source: AH8x224QtXWYmCLnoigIfnsqr/9eJ+450hI8jnCEx9BSBitsuuowrBrNTngQGV8KiguoK4kDmhpgrpJwxIUipp2upfk=
X-Received: by 10.25.44.147 with SMTP id s141mr2638570lfs.15.1518731222205;
 Thu, 15 Feb 2018 13:47:02 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.114.19 with HTTP; Thu, 15 Feb 2018 13:47:01 -0800 (PST)
In-Reply-To: <xmqqvaey83my.fsf@gitster-ct.c.googlers.com>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de> <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de> <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com> <xmqqvaey83my.fsf@gitster-ct.c.googlers.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 15 Feb 2018 15:47:01 -0600
X-Google-Sender-Auth: tOJT1hbHamBt9kmw36jAIfG26Gw
Message-ID: <CAHd499C0+L5TgdaL_gBSfr54Mhx+8pGZun1ex8-YTkhUEi+k_w@mail.gmail.com>
Subject: Re: Line ending normalization doesn't work as expected
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think the message you are referring to is a tangent that discusses
> how it was done in the old world, with issues that come from the
> fact that with such an approach the paths are first removed from the
> index and then added afresh to the index, which can lose cases and
> executable bits when working on a filesystem that does not retain
> enough information.
>
> The way in the new world is to use "add --renormalize" which was
> added at 9472935d ("add: introduce "--renormalize"", 2017-11-16), I
> think.

Oh I didn't realize someone actually did it. If so, that's awesome.
Thanks Junio!
