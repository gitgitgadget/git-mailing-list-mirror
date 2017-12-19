Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C371F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdLSWdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:33:20 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:42808 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdLSWdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:33:19 -0500
Received: by mail-qk0-f179.google.com with SMTP id a193so15844622qkc.9
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=84jHUyWiS7I3nj8Auxoaz7Yayboe2UatFhxnKC0zYDA=;
        b=FHvcT9bNbToNkYkC2su1X0JI+F7FqDdMqvSW9mK2nEqpDMva1AtflT8iypnPHooFah
         /KJ64Mvww+hwrXcH3I7ENdoOvhan4XhOuPf/kGuIfYw9iC574CjExywbRyINwm18xi41
         Bqo5Fm8OD5y2VZVLMNgPMmjdE3XKFI/ROC1676MgREhzAWXx8VfRehzMSEYIZJfcyb0B
         gF3vas0/J5mqkcxLrr+vqHTCAoy/+Hpo21GvcndjGt0A1QOgS9jmnlF2JQZWQQRDDeWd
         JdOIlxkx6YjM8vVZa4ufxb3l44QUs/LtLls8NtDuUciqsvUfTWXf4ouk9YWk+k1Ts+ii
         NOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=84jHUyWiS7I3nj8Auxoaz7Yayboe2UatFhxnKC0zYDA=;
        b=CnlSyqgodDt94M2iS3IZtSR4F+m6D66ucH1RgXswsR+D2PkcyWkLNbfuWffQlyrI1d
         gbvyu/uEleoQa/VY6GcBwNyRGP/9mixOzvWI+dT5jCo/bDUp2sNtw74QCN9FvXZ/0Prp
         yNvnJ3MFQmaw6sYMBX/7bLJqN7meqf56COhEN049V8dUY4KJJGqPqVYacTIbBH4FBUtX
         9ge90oR4xf5+s1EuNHpryY1WHQYLj/Fw3+mR0mr96rdHs2xai17kO+hGg+7NXAHhMSoI
         S53jQa+iU7BlN7wsSq72V5AcYJRNfGSUFp84pJ1r7Bp/koIvumAPvXWgkx/hn5IIsi4n
         JS7A==
X-Gm-Message-State: AKGB3mJqqNNuJrkPNhle0qVMBATmNe+6bFm4DgcsYw6H7bs7ZecqsX+u
        bBSuDgLwH/qtgi6HIvPcNqrYdaETk7t3gFbiIsi9fVbLlzs=
X-Google-Smtp-Source: ACJfBouAkp/Vh1DRTjUFb3uBy8ryXUFMixCSWm7vleGj2obrdCeDlLKsKRSGsBYnOaMNkGWaJjZzQ7FhlTX8qp3vOXI=
X-Received: by 10.55.27.104 with SMTP id b101mr7248577qkb.353.1513722798763;
 Tue, 19 Dec 2017 14:33:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 19 Dec 2017 14:33:18 -0800 (PST)
In-Reply-To: <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Dec 2017 14:33:18 -0800
Message-ID: <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     arurke@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I tried reproducing the issue (based on the `next` branch, not 2.15,
>> but I do not recall any changes in the submodule area lately), and
>> could not come up with a reproduction recipe,...
>
> I do not offhand recall anything; the closest I can think of is the
> three-patch series <20171016135623.GA12756@book.hvoigt.net> that
> taught the on-demand recursive fetch to pay attention to the location
> in the superproject tree a submodule is bound to.

I tried the same test on 2.15 and cannot reproduce there either.

>
>     4b4acedd61 submodule: simplify decision tree whether to or not to fetch
>     c68f837576 implement fetching of moved submodules
>     01ce12252c fetch: add test to make sure we stay backwards compatible
>
> But IIRC, "submodule update" uses a separate codepath?

Yes, any portion of git-submodule.sh that calls out to C is going
through the submodule--helper. I want to revive the port of that
shell script to C again.

The "submodule update" uses the submodule helper to obtain
the list of submodules and then does a "git -C $sub fetch" in there.

Stefan
