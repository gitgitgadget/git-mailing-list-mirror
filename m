Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835A81F404
	for <e@80x24.org>; Wed, 28 Mar 2018 00:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeC1AfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:35:06 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:42314 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeC1AfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:35:05 -0400
Received: by mail-yb0-f177.google.com with SMTP id d7-v6so608ybn.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HL/a1sLUKjGEwxIukSJojEw5qZogRcu57QfesRjR+8g=;
        b=UDJmJHUirFwfaIUQai889h3ihBJGEAvp7Vczk4dQwdSHG7ZD1f/l57a7oGAhO7Ri4E
         8iRBjfIwADIwL4Vd44s1q9t0KKKU3HEjqdRfCLo4wvINlCLz0KXL0nSi6DlmdqA1Rye6
         KZAYNCieyjD4RvbrJpNrdwxLh+4WG3hwIdomEG8HR21cEH4gk3jwlRiFLbvdOwHJhyjL
         YXswNk/WR4HXJMA034WC08VVtT1biBovjv0nEujVT5FVNiswrQwEcj43tb5SNiSBfptf
         uLK56dvoGRFWBOCCF3RUL0OVPSWTyCRvWseaximXXVfEhv4orUpaJvpDt+M0ozyT1mTL
         nc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HL/a1sLUKjGEwxIukSJojEw5qZogRcu57QfesRjR+8g=;
        b=nstlc02CDFyyE/yKdRWLGkUThqB1txypiT2YTheBvDd3sMpQJDfSwFZ0VmYL0CjEYM
         56eA/wmaQXQTtOi5FGR7F+k3JGnD1vC6FVSq/QgWR1qoGzBDdJD5ruhw0j6WJSsUf0R5
         sEbipRanYwEtDjnINzggWNoWgTKVvWwkmZGmsH78SST33XPxOZmwKav8SHKNF/ouFv+L
         5CGAtajv0xXPkm7eZPJXFio0aG0DfCDz1I6rFzemOCKdRD99EMSNdiAAw85kTr6x966J
         otMj6hgkTMGSzhxscMmQNwCwFgvPSQJQXUT3fcDaEs5KLU8javK886va1oq5ilEUP9oT
         aWxw==
X-Gm-Message-State: AElRT7HzXutlLzflKgSFDIQNrAcDmiJeWZGT1MMX4S/vZJuuZFAc4Ji3
        Gc8pZm2yyH9mTjEnZXe6jLTOWLnHjx2BK4kRpvhdhA==
X-Google-Smtp-Source: AIpwx48ofe+ZZnhqPmdHmehmHL5cZPBHH76k0Nk0W7BpOVC9sjT9iXQlWYwHYUtbyWHp38RWF4m2EonJtzCwgJpT7Y0=
X-Received: by 2002:a25:c713:: with SMTP id w19-v6mr915965ybe.515.1522197304547;
 Tue, 27 Mar 2018 17:35:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 17:35:04
 -0700 (PDT)
In-Reply-To: <20180327172451.34f60c483133df629b1e8ec6@google.com>
References: <20180327213918.77851-3-sbeller@google.com> <20180327225850.166523-1-jonathantanmy@google.com>
 <CAGZ79kY-E5FZRJAg6QG0DX1TzWXgo9LqJ-b7JojpkD6_BdF-wQ@mail.gmail.com> <20180327172451.34f60c483133df629b1e8ec6@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 17:35:04 -0700
Message-ID: <CAGZ79kYb_a3oXCPAyL=140pyQb=CmzSWx2wVVOcyXy2VPSLNZQ@mail.gmail.com>
Subject: Re: [PATCH] grep: remove "repo" arg from non-supporting funcs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>, seanwbehan@riseup.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 5:24 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 27 Mar 2018 16:20:25 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> On Tue, Mar 27, 2018 at 3:58 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> > As part of commit f9ee2fcdfa ("grep: recurse in-process using 'struct
>> > repository'", 2017-08-02), many functions in builtin/grep.c were
>> > converted to also take "struct repository *" arguments. Among them were
>> > grep_object() and grep_objects().
>> >
>> > However, at least grep_objects() was converted incompletely - it calls
>> > gitmodules_config_oid(), which references the_repository.
>> >
>> > But it turns out that the conversion was extraneous anyway - there has
>> > been no user-visible effect - because grep_objects() is never invoked
>> > except with the_repository.
>> >
>> > Revert the changes to grep_objects() and grep_object() (which conversion
>> > is also extraneous) to show that both these functions do not support
>> > repositories other than the_repository.
>>
>> I'd rather convert gitmodules_config_oid instead of reverting the other
>> functions into a world without an arbitrary repository object.
>
> I don't really think of it as a reversion, since grep_objects() didn't
> fully support repos other than the_repository anyway.
>
> Besides that, that's fine, but then:
>
>  (1) You would have to explain both in the gitmodules_config_oid() and
>      in this patch why "gitmodules_config_oid(...)" ->
>      "gitmodules_config_oid(repo, ...)" and "submodule_free()" ->
>      "submodule_free(repo)" are safe, since they have different behavior
>      upon first glance. (They have the same behavior only because
>      grep_objects() is always called with the_repository.) I was trying
>      to explain this in as clear a way as possible, by showing (with
>      code) that grep_objects() only works with, and is only called with,
>      the_repository.
>  (2) The code path where repo != the_repository would still never be
>      exercised, and I prefer to not have such code paths.
>
> I don't feel too strongly about (1), since they just concern commit
> messages, of which there are many valid opinions on how to write them. I
> feel a bit more strongly about (2), but can concede my point if the
> project is OK with a code path not being exercised.

Ok. I admit not having looked at the code beforehand, and I was
just arguing based on intuition. Turns out I was wrong.

I thought that we'd have to have arbitrary repos for proper submodule
recursion, but this specific code is for grepping thru given tree objects,
which for now is assumed that the user can only give trees of
the_repository and we'd error out in case of a submodule tree.
Makes sense.

In that case, I agree with your patch. Thanks for writing it.
I'll take it into the series.

Thanks,
Stefan
