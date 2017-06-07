Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4CC1F8CF
	for <e@80x24.org>; Wed,  7 Jun 2017 01:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdFGBJ5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 21:09:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33543 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdFGBJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 21:09:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so25847066pfe.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 18:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=09nCeHzKlj/+vQHgtoPfdvn71XHp1j9n0rAiMXxco/U=;
        b=GYL3R/V9YcnrutIpfOofKm3rfI2785YngLn/voMLvdTmME7oD+km+n47gDGajDw/Xr
         RryJouEIATVEcMaYEOMbxfnhATGcwW0BEInslIjwr+8hYV+F6RVzgWwFc9/q57CoaHMr
         /zgqTTicRJZuGaQP5gvtibJcHWiLM6XuNjruwN9u+Pg/TfFGvs6Ii9yQQVkZ4ayLRScl
         /+T0SWd3eTHZcUO6jutM09ZGS/1Y5dMOWHqLNh6aQuoyxo/NL6O99d3lt/q2bBxO45EQ
         986UxxFBNDlQK+jE6bQiEhEBCllRI3aPdlkvQZDaNtuI22hHiESSHOZc8lxyQvFhD6eV
         zWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=09nCeHzKlj/+vQHgtoPfdvn71XHp1j9n0rAiMXxco/U=;
        b=qcqj17VsV1n3mv7I2NHaCDkmW8QJ/mw9skUCSexSjl16yZ4hFySmQJ5Skd2Wg1gZUV
         CldGQLtDl4E+WADt0hL/kB7ja1mxt4d9uNARE4JW8OtGTh+85QJUxgC4Z/KHNbR7TQle
         5MC1+dIHHDeozHQtKd5ktQ4zcA3KsZ8mCAKk7jw/Mp03bKpLRF44UUr4Q1LUVduQrnf5
         ZPSModZhSCHMGzQu4z4La0ioasxeu2KAXtXVAG0TXisSZ1UBtHq1yy0HHm+uwaUQ+Sbq
         crGRglIFV0G0NuRTMNn0QT45FooQxo9YRscIhmjPYepZFq5F3MVbombm3mif/rnnY0JY
         RhCw==
X-Gm-Message-State: AODbwcDyPXZPXZkQHo0zm1CgdUtp/JFiH+ZQy9zl9QMn9f0toWiVAg9J
        ts6NkpbPOqJZiQ==
X-Received: by 10.98.12.19 with SMTP id u19mr21779411pfi.47.1496797795379;
        Tue, 06 Jun 2017 18:09:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:411:1ad6:6716:25ff])
        by smtp.gmail.com with ESMTPSA id f72sm138134pfe.4.2017.06.06.18.09.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 18:09:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for console output
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170531104213.16944-3-phillip.wood@talktalk.net>
        <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
        <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
        <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
        <20170602175455.GA30988@aiede.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
        <20170606224524.GC21733@aiede.mtv.corp.google.com>
Date:   Wed, 07 Jun 2017 10:09:51 +0900
In-Reply-To: <20170606224524.GC21733@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 6 Jun 2017 15:45:24 -0700")
Message-ID: <xmqqwp8o7gdc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> 3) the only person who could make that call is Junio
>
> I strongly disagree with this.

If it helps, I _can_ make any set of declarations to make it sound
more official, e.g. (the remainder of) June is the "make sure our
tests are ready" month where we try to eradiate uchar[20] by
advancing the object-id effort, replace EMPTY_TREE_SHA1_HEX and
friends with EMPTY_TREE_OID_HEX, add a build-time configuration that
allows us to build a Git binary that uses a phony hash e.g. ~sha1
truncated to 16 bytes, and build Git with such a configuration and
then run tests, and we concentrate on this effort without adding new
things until we make the tests pass.

And make similar declarations for the remainder of the year.

But the actual input for formulating what each step does and the
timeline we aim for needs to come from the list wisdom; it won't
have much impact if the project's official declaration is not
followed-thru, and a unilateral declaration that is pulled out of
thin-air likely will not be.

> I am happy to solicit more input from security researchers, though,
> and your suggestion to do so is good advice.

One good thing is that we can prepare the framework to adopt a new
hash before knowing what the exact hash function is; crypto-minded
folks can work on the hash selection in parallel without waiting for
the framework to become ready.  And I do agree with Dscho that
having crypto experts would be very helpful for the latter.
