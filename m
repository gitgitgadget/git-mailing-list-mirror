Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D417A1F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 08:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeC0I6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 04:58:22 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:39720 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeC0I6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 04:58:20 -0400
Received: by mail-qt0-f178.google.com with SMTP id v11so22883857qtj.6
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cb2Jga62bQebp84MCpMv+uXyFWMpwxjhLkZjkqKwNOc=;
        b=NDyX41ufkaH1OKusMCprNIPYpNfe1kFlgLGL+70B32UoDehY/HDSDriDRCVpmXwqy9
         2TvJXmavJeP/IRx+YcYZPfPFOQ4OvxdietoWHU1F9b/HKw4MsorYFoNKKLWWZLWRoVVM
         0kWxZr2j+NiXPp4Oe4YFdJX1rWLgPpRDPtG6rGVmOPCl/lDAVbniI8rJJwv/bVRgEXYO
         UCcd29BXIQCYx74hxzuF5InM/34n8zjjg6NwpbOjsrNuLN2ZYaT5L8IF4J1+GykF4tez
         WapLFoqtMb3KFU988syuqsQ+3qVdx/abs6pewW1Wwfc5Sa9r5Oe6lHet9q7dZLdVGr2i
         X1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cb2Jga62bQebp84MCpMv+uXyFWMpwxjhLkZjkqKwNOc=;
        b=sCEHlqVbfJ9YXmnQvdeT4xx3BIRYwJZAe+JbLW3nO1xYi0q753anwFO6nfDG9ImjJx
         2VC7ZilPgRU5urK1zNNUHm/WDS7KcYQjkSaEJ36rt8+OG6uXB2Bemei5p3YIlk8JdLhp
         CmdS4sb/BeIiRIxO/G+eKuXhvGAbSg5uSlTVgQPYlCsvzIrQ+WmnwwaydscM2HvEA2zB
         GqWAt1b82kq3rNqB4egEzhacJU1jlcCZP5ebOFFc9MZNx5RmujtwfVKZVc1E+NtYy2N6
         Cj6SxgSU3Eqm879GxaGVAFT6PRdInOwyijL2M1Lyw4anPHBQipJZHBMteCrdTh8QDu2x
         wsnA==
X-Gm-Message-State: AElRT7Gzh8jr1qUQYcW3AYwdlqK2bat3kXrJpa2CtIpeImpcVWxCd3RN
        1isdw9n31U1Qdg7LRPAr4YsflRokcsnSiR5Jod0=
X-Google-Smtp-Source: AG47ELtYbpchLmqj3B6Sjyx6cUoMGfUGn75kY9i213uWNGLuULr7MoX95p1KebGs4jJnJv1iUN6g/eNm9lJVxcIACKI=
X-Received: by 10.200.1.2 with SMTP id e2mr57626936qtg.121.1522141099991; Tue,
 27 Mar 2018 01:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 27 Mar 2018 01:58:19 -0700 (PDT)
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com> <20180325134947.25828-1-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Mar 2018 04:58:19 -0400
X-Google-Sender-Auth: vQ4e3RCIf_slIjv6ciEjUaInfrg
Message-ID: <CAPig+cSS2T-CweGtfO1vm=cskS91hLCHBoOhDuoqHAzg=27WbA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Thanks Eric for the review of the previous round and Duy and Junio for
> additional comments.
> This round should address all of Eric's comments from the previous round.

Thanks, it appears to cover my review comments from the previous
round. I do have some additional comments on this round (which I could
have raised with the previous round if I had thought of them at the
time).

> As explained in more detail in a reply to the review comment directly,
> I did not add an enum to 'struct add_opts', for 'force_new_branch' and
> 'checkout_existing_branch', but instead removed 'force_new_branch'
> from the struct as it's not required.

Makes sense. In fact, I had thoughts along these lines during your
previous dwim-ery series. See my comments on patch 3/6.

> The rest of the updates are mainly in the user facing messages,
> documentation and one added test.
> Interdiff below:

The interdiff looks sane. Unfortunately, due to UI regressions, I'm
having second thoughts about whether this series is going in the right
direction. See my comments on patch 2/6.
