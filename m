Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC1320968
	for <e@80x24.org>; Thu, 22 Dec 2016 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965876AbcLVVqu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:46:50 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34697 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbcLVVqt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:46:49 -0500
Received: by mail-yw0-f170.google.com with SMTP id t125so121534373ywc.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 13:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TpaFfYwc9F69IP/NubNKoxxzLsE5XxBi7a4FjMEGRLM=;
        b=cYLY3vFR1KTgSsaNhZ6Gae808e94/VlSt5gzIhexk82QNBPzLJzFQ/krQ+VlrqqXc4
         Lm5KIV+Onl7tlpzwd6GwN6H0nG5+lbAI+um7tVdeIWNBbfS0jA2RXwbyknI1Phy03DLU
         RqaKKI+2DIrXKG1QO7TifT1Ygv+dHQG6ZK+Ybz8Jur9xUm+st2znBzL8tFMaN1nYT8kl
         cm2ASbCrqwnJxJGT8leH6uZVYh453X0n2hLbbrq+uNsecR2Sd0R5NraH3zHaz8JYKAZk
         tEWbcMXFbCYaDHrGkRFjam/Qb+zn3HuH+24gid3ru4bXkcnV75jD2t1urGo7XnjhOLuI
         j3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TpaFfYwc9F69IP/NubNKoxxzLsE5XxBi7a4FjMEGRLM=;
        b=k/IlqzEXxYeSFJZOsToMI8k3BczXe1uwb3v1nRP0YB+z0dlGxDtOJ+PZLumvAfmy3f
         IaegwWitYIWUJBzhs/9sAFwgQReLVSAd4XF0DM3sIZnUCXaTgBLBUJXHyhyy79aRwa91
         baoKDw+AXJwA4+rDZC9DajjhYQoNbFNVTdlvNYvLUGmUFahGe78DtVHC8pq2VGCMN7dV
         k57SOz/8O7yp3O00bjir7DdMwCpZWv1y8mtkATwIolqhsxSej9eHEoZ+fWbaIepzxKt/
         kZM4v4Ajn4ZxO31JErAotQhqRyfQyjtUnEjTKt/JgmqJI5hoXf9afkKRtkpHcDFvqL6l
         TMcw==
X-Gm-Message-State: AIkVDXLhvz+wwZjfPCvzXcG4WCNHH8vSFo0xbIlm76wBZabPwkRhGIQuKUbiTDFH2kPIpC/qe3ZAIF7kXuwoEg==
X-Received: by 10.13.250.3 with SMTP id k3mr9131648ywf.276.1482443209046; Thu,
 22 Dec 2016 13:46:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Thu, 22 Dec 2016 13:46:28 -0800 (PST)
In-Reply-To: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
References: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 22 Dec 2016 13:46:28 -0800
Message-ID: <CA+P7+xpdKEoNY_cgY4g3bMVZe0p-2bYT4Y-3nYyd0O03iD1nZg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Making_it_possible_to_do_=E2=80=9Cgit_push_origin=E2=80=9D_i?=
        =?UTF-8?Q?nstead_of_=E2=80=9Cgit_push_origin_=3Cbranch=3E=E2=80=9D=2C_without_having_to_?=
        =?UTF-8?Q?one=2Dtime_prepare_each_branch_for_it?=
To:     Stefan Monov <logixoul@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 1:14 PM, Stefan Monov <logixoul@gmail.com> wrote:
> Hi.
>
> I'd like to use just:
>
>     git push
>
> or at most:
>
>     git push origin
>
> rather than having to first check which is the active branch with `git
> branch --list`, then type:
>
>     git push origin <branch>
>
> At [1] and [2] I've seen that if I do this once:
>
>     git push -u origin <branch>
>
> then from then on I can use just `git push` _for that branch_.
> However, I don't want to do this "setup" step for each branch, because
> it's extra work that I also may forget to do.
>
> Why is this "setup" step necessary and can I avoid it?
>
> Thanks,
> Stefan
>
> [1] http://stackoverflow.com/q/19312622
> [2] http://stackoverflow.com/q/6529136


Try setting "push.default" configuration setting, see "git help
config" and search for push.default

I *think* what you want is "push.default = current" but you should
read up on each option.

Thanks,
Jake
