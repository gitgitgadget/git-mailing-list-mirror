Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7B120373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbdCMUuj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:50:39 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35359 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbdCMUug (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:50:36 -0400
Received: by mail-pg0-f50.google.com with SMTP id b129so69814268pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qMS1mrSWfwa1kxV5ohCEetkNn/D9H3bx/FAcp3xTO4Y=;
        b=rAGf9UhVsifP7BuaaV+mMcuvMzqfHmJQPMopd4is7Y9hIqn5cT7AAIySoIB9r0N9ij
         B8GCcoHEPx5Y3Dz1v8eJX/BQ8DUVbhtlVfC1a3PKnExwG2NWzgyFGEL+BM9mTuzRqUga
         Bd5feWAtaCFVrtwYqDQOphBl8d6lOxdBbArOoEDDMxHMxMa0G9ekAwPQpoTabsBfMvIv
         fmZ9plry98NzR/vfsz83AqBCu0YQmBDzI21aoYSXMqIcC3duVrooMtKGJU+HB+Jh2N+U
         FU5HzE+q1F7TpvB+pUP6Nr+y11NJ7j9FhWGXuoxS47CCMpsiw0wfnLRjgKbbyesTnfgl
         /mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qMS1mrSWfwa1kxV5ohCEetkNn/D9H3bx/FAcp3xTO4Y=;
        b=sjPDJglcTU6XHhZ+3njuQ4dPi5fXwvGBDcOhb30K8UrM6DGKzg8m649Qp6Cy4ZqPOB
         QpePkehUTC2SCEMVIyvGIUf4YMSLC2bbkqxM4g1B3N494atG+U5P8pKIQ4GyVz4mEr+J
         eAU5dqEEBrveoA+QUB2oq7u1s6JRzjBB5unIdV4peVNEDD2U/Wfrq8Nt/sU3cR1uFclz
         yCzX3zwuE4tB/3Hgm1gKW/k7F05H6DNlZwAzmUFWKkhkmXa6t/nopySkzRIJWbc/10D+
         /Nh3cORTax+S3J4gxrBrA8wtvw48BAEQ8vwIJHUTVNpE6M/3b+gv8IjmVXRXwjApxwNG
         B4ZA==
X-Gm-Message-State: AMke39nqAXlqx4VEJg5XQxNR1veLqEOzXwhHWU4b+6zygH7OGFo3nGJU6sZQIe3jnsecGQHajnd0aJvNzuwtv6LV
X-Received: by 10.98.149.80 with SMTP id p77mr39569932pfd.56.1489438224754;
 Mon, 13 Mar 2017 13:50:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 13:50:24 -0700 (PDT)
In-Reply-To: <xmqqo9x7ug2j.fsf@gitster.mtv.corp.google.com>
References: <20170306205919.9713-1-sbeller@google.com> <20170309221543.15897-1-sbeller@google.com>
 <20170309221543.15897-13-sbeller@google.com> <20170309233709.GD52558@google.com>
 <xmqqo9x7ug2j.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 13:50:24 -0700
Message-ID: <CAGZ79kYGdafOc4W6_aUwvCDs5aqXKf5fwa8msQ2gq4swND69ng@mail.gmail.com>
Subject: Re: [PATCH 12/17] update submodules: add submodule_move_head
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>>> diff --git a/submodule.c b/submodule.c
>>> index 0b2596e88a..bc5fecf8c5 100644
>>> --- a/submodule.c
>>> +++ b/submodule.c
>>> @@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>>>      return ret;
>>>  }
>>>
>>> +static int submodule_has_dirty_index(const struct submodule *sub)
>>> +{
>>> +    struct child_process cp = CHILD_PROCESS_INIT;
>>> +
>>> +    prepare_submodule_repo_env_no_git_dir(&cp.env_array);
>>> +
>>> +    cp.git_cmd = 1;
>>> +    argv_array_pushl(&cp.args, "diff-index", "--quiet", \
>>> +                                    "--cached", "HEAD", NULL);
>>
>> The formatting of this line is a little odd.  Also you can drop the
>> backslash.
>
> Heh.  I think I saw and pointed out the same during the review of
> the previous round X-<.  It is a bit disappointing.

Yes. I remember having a local mixup of branches, such that I
fear I may have missed other feedback of the previous round as
well then. I do remember removing a backslash, so maybe I
got confused with another backslash as well.

I'll reroll with this fixed.

>
>>> +static void submodule_reset_index(const char *path)
>>> +{
>>> +    struct child_process cp = CHILD_PROCESS_INIT;
>>> +    prepare_submodule_repo_env_no_git_dir(&cp.env_array);
>>> +
>>> +    cp.git_cmd = 1;
>>> +    cp.no_stdin = 1;
>>> +    cp.dir = path;
>>> +
>>> +    argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
>>> +    argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
>>> +
>>> +    argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
>
> Somewhat related; will this use of --super-prefix be affected when
> we split it into two for "adjust pathspec" prefix and "adjust
> output" prefix?

Let's see how the superproject prefixing evolves and what Brandon
sends out. When the superprefix changes its meaning I'll adjust here.
