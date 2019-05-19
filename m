Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B071F4B6
	for <e@80x24.org>; Sun, 19 May 2019 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfESW2e (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 18:28:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54686 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfESW2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 18:28:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so11377103wml.4
        for <git@vger.kernel.org>; Sun, 19 May 2019 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7merDfQD7nV71h/fi/QbEHXv4D2MTtSPPGP4vI6JxYA=;
        b=Fn2QRJ6QfsUK/mNhviiJOI7fOwHvk/dU/FM9wPFydzyHyIBVY6v4Mcl1VvZ3+QXtfu
         TPcIiB9duTa/Y0EoDoWYUYSg2LfTXlp0uPyAAdqtR9rOIQI3KRVBrAOw/2javVEj/YD9
         /GDPcJVmyGd6pDeMjqaRJwmVxiABOHsYDbHUr7p3jmJngiSwwH0zL/PJEsi1vx45sJtU
         4hsA5RQPIbZ1pRKOsriQ+nLpLLkCTvEGtIgZ1hIaqRde1nH7A4vNh8wUMapGoXO26Ds1
         9xUwtKUeeaWkQj26SueO80ShqehLMQ0z36ka1jTJ+h5Yc73jMPDXMT9GROXJtjGLh4C0
         G7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=7merDfQD7nV71h/fi/QbEHXv4D2MTtSPPGP4vI6JxYA=;
        b=lEL7g2kXpVXKn/ABsnnygZAIat74LJrFVywLI17nz3BaC+UGFEXbzX78UfRME7net5
         ToqxMUo/woW83MoF+IzI8TM9SrlLYiJwmNIi1IwBr1NnNyYGnLx8bZ5ZCnJ52WdQew7X
         OM1Vk/O9mqsr0873XOeuTqJ5+XDr6+Nggea34+OOXvaM6Zmmn44zineWuWsoc/URXurE
         CbSPbjEnJuU1Ba/EXd7y9uaqSASGThrvflx3d9Fd66K4N7yadiqOa3cwsZz0DzrWKJWi
         ER4wE+0PqPH20PcHZXH4Z08WYjJ1rU0hPQPGuo8dPlnevr/GIZ08yQVVnUE8sEotxCTh
         7SDA==
X-Gm-Message-State: APjAAAUUt/y37+jXbkGsXp41QTLY+fCP9JCe1WPbYh0V5b4dwd9jX/aB
        5GgprHpyYGfI1R0RRfZY3zg=
X-Google-Smtp-Source: APXvYqwoN04rzLAvH6Cvs2TLvppq30hRQ6B/cWBVXCW8cbB0FqE8tJKjkIDqJqnJHTR4P8vyVskgiA==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr10410613wmc.44.1558304911999;
        Sun, 19 May 2019 15:28:31 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn3.neoplus.adsl.tpnet.pl. [83.21.181.3])
        by smtp.gmail.com with ESMTPSA id x6sm23583511wru.36.2019.05.19.15.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 15:28:31 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        Kacper Kornet <draenog@pld-linux.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Revision walking, commit dates, slop
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <20190518120140.GB951@szeder.dev>
Date:   Mon, 20 May 2019 00:28:28 +0200
In-Reply-To: <20190518120140.GB951@szeder.dev> ("SZEDER \=\?utf-8\?Q\?G\=C3\=A1b\?\=
 \=\?utf-8\?Q\?or\=22's\?\= message of
        "Sat, 18 May 2019 14:01:40 +0200")
Message-ID: <8636laqdtf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> On Sat, May 18, 2019 at 01:17:06PM +0900, Mike Hommey wrote:
>> On Sat, May 18, 2019 at 12:58:28PM +0900, Mike Hommey wrote:
>>> On Sat, May 18, 2019 at 03:50:05AM +0200, SZEDER G=C3=A1bor wrote:
>>>> On Sat, May 18, 2019 at 09:54:12AM +0900, Mike Hommey wrote:
[...]
>>>>> There are established corner cases, where in a repo where commit dates
>>>>> are not monotonically increasing, revision walking can go horribly
>>>>> wrong. This was discussed in the past in e.g.
>>>>> https://public-inbox.org/git/20150521061553.GA29269@glandium.org/
>>>>>=20
>>>>> The only (simple) workable way, given the current algorithm, to get an
>>>>> accurate view off rev-list is to essentially make slop infinite. This
>>>>> works fine, at the expense of runtime.
>>>>>=20
>>>>> Now, ignoring any modification for the above, I'm hitting another cor=
ner
>>>>> case in some other "weird" history, where I have 500k commits all with
>>>>> the same date. With such a commit dag, something as trivial as
>>>>> `git rev-list HEAD~..HEAD` goes through all commits from the root com=
mit
>>>>> to HEAD, which takes multiple seconds, when the (obvious) output is o=
ne
>>>>> commit.
[...]
>>>> All the above is without commit-graph, I presume?  If so, then you
>>>> should give it a try, as it might bring immediate help in your
>>>> pathological repo.  With 5k commit in the same second (enforced via
>>>> 'export GIT_COMMITTER_DATE=3D$(date); for i in {1..5000} ...') I get:
>>>>=20
>>>>   $ best-of-five -q git rev-list HEAD~..HEAD
>>>>   0.069
>>>>   $ git commit-graph write --reachableComputing commit graph generation
>>>>   numbers: 100% (5000/5000), done.
>>>>   $ best-of-five -q git rev-list HEAD~..HEAD
>>>>   0.004
>>>=20
>>> I'm not observing any difference from using commit-graph, whether in
>>> time or in the number of commits that are looked at in limit_list().
>>=20
>> -c core.commitGraph=3Dtrue does make a difference in time, but not in the
>> number of commits looked at in limit_list(). So it's only faster because
>> each iteration of the loop is faster. It means it's still dependent on
>> the depth of the dag, and the larger the repo will grow, the slower it
>> will get.
>
> Oh, indeed.  Well, at least you'll waste about an order of magnitude
> less processor time until you figure out how to fix it :)
>
> Btw, once upon a time this was fast, but it became slow with commit
> c19d1b4e84 (Fix revision walk for commits with the same dates,
> 2013-03-22).

This might be related to the fact, that with generation numbers v1
(i.e. topological levels) there were cases when using those generation
numbers for ordering caused performance regressions (e.g. for some parts
of Linux kernel history).

There was an idea of replacing them with generation numbers v2 [1],
which if I remember correctly was chosen to be corrected date (that is,
committer date or one more than maximum of dates of parents).  This is
incompatibile change; it turned out however that while commit-graph
format is versioned, unfortunately Git fails hard if commit-graph
version is too new, instead of falling back to not using commit graph.

[1]: https://github.com/derrickstolee/gen-test

Stolee, could you tell us what is the current status on generation
numbers v2?  Thanks in advance.

Best,
--
Jakub Nar=C4=99bski
