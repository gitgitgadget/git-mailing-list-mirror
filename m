Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869491FAF5
	for <e@80x24.org>; Fri,  3 Feb 2017 17:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbdBCRKt (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 12:10:49 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35881 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdBCRKs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 12:10:48 -0500
Received: by mail-lf0-f44.google.com with SMTP id z134so13454394lff.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SAq5vET15IPRkJzaHP/0+XZEe7EgIyREITy4BSBieq4=;
        b=czMniJMYTnBhCXF/dfoK02/nDjrhsFDL/LeZA++DgQKZOoApSN54iNYy9cJdxW47q2
         HvaDGGIgCt/4vgarZLnQTaWDd39ajXYferxHNIDOgZ5pNSGlya4kHTQsunJz/aJuIatG
         3EX4KIa66EnM4J3etlleLJzNhjHKYjLfljWTfq3G71l1g9xMpWp1YhhsWxajcAi57OKc
         sLxy4LEa0FGwv8W9C+P4Wd/+Kj69O5GX1QFlaVFJqKXmjIBTVM9bc6Mw3R6TtnRJYkBE
         qs0lmL/tp+bl8LI1qmklYJII9wmYDScvqU9BHr20ypYo/onBadQ7XSwIns5MbJo7+QMb
         YkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SAq5vET15IPRkJzaHP/0+XZEe7EgIyREITy4BSBieq4=;
        b=gMcOHlHlOyeKVoVNSD1eMys9Q2zPzCz4jhxJAEQbdyvbFxetRt2MiSKXZiq/KzQJL4
         u38lKP4jSCHWcj9SziM8FAuaGqqrzBM8EqaUvdXmXqalZr51fbbIGnEI0umSFkKEiYNZ
         KtNcO5rAllqbO4hJj0La2FhG4YP+hJm4c1pQQUrSFZeAbLBqRI/q/UzB1c4ShZOi5jEZ
         uJImJq95LWGfMPeT8ekWbSVg+ODa4CZJj3n5u/+DmHgc7RdKPUTnT0EvfBMewfCyxRo8
         PYRg65yosWs4Xn+VhIGHMV61bTnePFCemOtwnjwhyNxzCsefKlwsBRzjzrbtivdsJYwD
         MvZg==
X-Gm-Message-State: AIkVDXKfNxN1J18RynkjfsGpaOROujz9JYk0gkPD/RSYFkqWgN5kxuc46KuW2aYehUQ1t4Lhb+9h2/KbjArS7A==
X-Received: by 10.46.71.140 with SMTP id u134mr5924509lja.16.1486141841120;
 Fri, 03 Feb 2017 09:10:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Fri, 3 Feb 2017 09:10:20 -0800 (PST)
In-Reply-To: <CACsJy8DjqrEZ=VaZo6bn4i2r=Wr8k4ExYv48N-rDvfPO=hqpLA@mail.gmail.com>
References: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
 <CACsJy8DjqrEZ=VaZo6bn4i2r=Wr8k4ExYv48N-rDvfPO=hqpLA@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Fri, 3 Feb 2017 09:10:20 -0800
Message-ID: <CAE1pOi3ThTLSp_0ZJHto4p75Ds5NMGymHrD0ju9axCqA1+NkMA@mail.gmail.com>
Subject: Re: How to use git show's "%<(<N>[,trunc|ltrunc|mtrunc])"?
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 February 2017 at 00:06, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 3, 2017 at 12:51 AM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> Hi all,
>>
>> I'm trying to get the committer date printed in a custom fashion.
>> Using "%cI" gets me close:
>>
>> $ git show --format="%cI | %an" master | head -n 1
>> 2017-01-31T17:02:13-08:00 | Hilco Wijbenga
>>
>> I would like to get rid of the "-08:00" bit at the end of the
>> timestamp. According to the "git show" manual I should be able to use
>> "%<(<N>[,trunc|ltrunc|mtrunc])" to drop that last part.
>>
>> $ git show --format="%<(19,trunc)cI | %an" master | head -n 1
>
> You're almost there. Just insert another '%' between "trunc)" and "cI".

Thank you so much! This has been bugging me. :-) Rereading "git help
show", I guess it's implied I should do this but it very much wasn't
clear to me (obviously). I guess I'm too used to the "%19.19s" type of
approach. Maybe there should be some examples?

>> How do I get "2017-01-31T17:02:13 | Hilco Wijbenga" to be output?
>
> You'll get an ellipsis at the end though.. (i.e. 02:13... | Hilco)

Indeed, that's not very nice. I suppose I can understand the reason
for it but it mostly defeats the purpose of "trunc", doesn't it?
Luckily, Sylvie's solution does exactly what I want.
