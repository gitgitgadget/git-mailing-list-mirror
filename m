Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BEB51FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 08:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbcL1IDS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 03:03:18 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33778 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbcL1IDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 03:03:17 -0500
Received: by mail-yw0-f178.google.com with SMTP id r204so183374877ywb.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 00:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OT3WhbIsWYxJuuJWBrkYe079sX229hZyShxjovJR1vs=;
        b=CY3IZPPaoGKScJxn34Lm9oftskOtKv9+sw91ifu5QaBN+gdssoKIibfl++k7C9G6ZH
         AZV+m6lyf3sGC5dtWypYzUJ+bgPuUssa/0OnwSPYcX8Ly5uYGFka5CceXijGLy0qtOrc
         w6+s8BGlANF8uFbkG1X35d4P5QjXNtn7dOXdV3Ys0hAB2Cn13Dsk1qTgupM9eseJASgO
         Y/b2hxPmViepUPHIlvv6NKDAiuMpgKt1gQ8tUbubPyDQnu7Ko+7zJDfUaZBwUcgh1ywu
         WyoE38//GSg/3gIp1QGEz92v70s1o65zrl3xOjoCq2ChpjXzi5UoU8+4MkYjjGS8k8AU
         ouKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OT3WhbIsWYxJuuJWBrkYe079sX229hZyShxjovJR1vs=;
        b=qCk/jv4knkh7vkPg2llJWx4oRTUWVhgKZd7HS4oAblEpfoByX/09fVa4iDtm6TWleY
         0ixHd4zG9vY9UU14gevoEOJAsxVnhFVuBh1KQGZyw4Hq3LTDwoBZ8PdgYf4VZZu15MVw
         Cr7XO7fC6jrcVhMCR6g25xDG4gTZnJvNnyxsy1DPOSnkbflTmhzCYt6jlLDH/hARTD9H
         LHhA5sjPGICeLQHUAC1rJ1l7IZiNYYZ5hIFZkQOW4Vvgbxpt04w3XPj6QkG7DsmQ6m40
         /jhgnu6IYuYTQUzmYTfPjO3g0/wYq0W2DCgRKlOa1SOunS7FAUQja1EOx5Ky+lf+tYl+
         lEfw==
X-Gm-Message-State: AIkVDXKQNuuOcuHx5cLjerW+q3OIvACO94+sgX00NFEEn8SZnzie5d2hN93HBUuKLehNoYJO/yA5/4qG2qWOMQ==
X-Received: by 10.129.46.133 with SMTP id u127mr28113812ywu.94.1482911793033;
 Tue, 27 Dec 2016 23:56:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Tue, 27 Dec 2016 23:56:02 -0800 (PST)
In-Reply-To: <xmqqtw9p6phx.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-12-Karthik.188@gmail.com>
 <xmqqtw9p6phx.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 28 Dec 2016 13:26:02 +0530
Message-ID: <CAOLa=ZR2VF5mEf83A0pmkdAVLPxhUaBhWo=SVjOAUyjRR=QzjA@mail.gmail.com>
Subject: Re: [PATCH v9 11/20] ref-filter: introduce refname_atom_parser()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 2:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +symref::
>> +     The ref which the given symbolic ref refers to. If not a
>> +     symbolic ref, nothing is printed. Respects the `:short` and
>> +     `:strip` options in the same way as `refname` above.
>> +
>
> I am slightly unhappy with this name.  If we had an atom that lets
> you ask "Is this a symref?" and yields "" or "->", it could also be
> called symref, and we would name it "is_symref" or something to
> disambiguate it.  Then it is only fair to give this one that lets
> you ask "What does this symref point at?" a bit more specific name,
> like "symref_target" or something.
>
> But probably I am worried too much.  "is_symref", if necessary, can
> be written as "%(if:notequals=)%(symref)%(then)...%(else)...%(end)"
> and it is not likely that it would be used often, so let's keep it
> as-is.

You're probably right about it not being the right name, since symref doesn't
indicate that the atom will print the ref being pointed to, but the
name 'symref'
is short and I guess its easily understandable.

-- 
Regards,
Karthik Nayak
