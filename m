Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6EB20281
	for <e@80x24.org>; Mon,  2 Oct 2017 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdJBWIt (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 18:08:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34027 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBWIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 18:08:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id g65so6972701pfe.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTH++C49CkpD+E/uiURb3Xzyaguj5MXJXChwIbqJp7s=;
        b=SfdWTRgippgan/844rFZeSguZhsKulK04VmxnSBfBBzF++6nbp7Q75zXn4+Q8DsItO
         x4SAK51EIVjpuY2dnCnN+yM8GS7k45/sO2fWil3Bb7WsFkyAjyNZp47EVq4uXIgQq51E
         lU661vS0ha2BC919YGszm8HFVRvygjrqVjpEb8VyQzx/UJbz2/duCvcyOdDWecpToqmg
         iMt7uJmHjgAud7KKt05khEYCBUd8zPCO7bq0zcBcMUFds7+vYLjiPA/nfnE2Ar9V+PO/
         YZe6amxtF6tpF5x9LASALEM9ezIARWBeNeiz8BZ+ghZY4GRLuapsU0OWsOTKLFASYg4+
         n7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTH++C49CkpD+E/uiURb3Xzyaguj5MXJXChwIbqJp7s=;
        b=RmLOX1eseJhJMix0E9vxdlou57asLjNSIhEH/jLVE6vBPfE7Hnlp0x+Qf1B7WJzkI1
         k6XWHfvIqFtGADJAS3w2K3+2Nn2f/GZFeaadBCKby+3iw8UxKA+GIDbavhMjxznnmTdD
         yBqET21i5AgY95QhHvpdo5K5u40ysR6od99W9aIZZh7a+IA56ThDwgvRW5WUR1pORkbG
         dv6sHx2+fk3owdvUkAtfZSpMy5rJtLDHYqsddOjKzQoVU/W7EcMN7C2JQUbewNz4/RKw
         awmqXAf2DStJV4mJA7+E0fQAyNys0RyHAbjBAVxKdz2l5kpvVWG3gQs2hgS+v2WQdIjD
         udDQ==
X-Gm-Message-State: AHPjjUgw4eGYaFyB7Sz+Mg+PjUtfOk7qpnTabiLXFT62LaWmZjgTfZgn
        edn5k+iWZQWY8ySLUjL41FE=
X-Google-Smtp-Source: AOwi7QAd4WPqt74x8q0AR3EK4oVcvr2Oxn6WlFhBTyquGfIP8jXl8aGwhLzvJXWtzdz/o/h0y7qKXw==
X-Received: by 10.98.223.76 with SMTP id u73mr15886171pfg.234.1506982127531;
        Mon, 02 Oct 2017 15:08:47 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id l85sm18087255pfg.155.2017.10.02.15.08.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 15:08:46 -0700 (PDT)
Date:   Mon, 2 Oct 2017 15:08:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thadeus Fleming <thadeus.j.fleming@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: git submodule add fails when using both --branch and --depth
Message-ID: <20171002220844.GQ19555@aiede.mtv.corp.google.com>
References: <CAA4Wa2sVddG_SS70Dy_womGLKW0ipAjsxR4g+yjMKscjErRjvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA4Wa2sVddG_SS70Dy_womGLKW0ipAjsxR4g+yjMKscjErRjvQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thadeus Fleming wrote:

> I'm running git 2.14.2 on Ubuntu 16.04.
>
> Compare the behavior of
>
>> git clone --branch pu --depth 1 https://github.com/git/git git-pu
>
> which clones only the latest commit of the pu branch and

Yes.

>> mkdir tmp && cd tmp && git init
>> git submodule add --branch pu --depth 1 https://github.com/git/git \
>  git-pu
>
> which gives the error
>
> fatal: 'origin/pu' is not a commit and a branch 'pu' cannot be created from it
> Unable to checkout submodule 'git-pu'

As a side note (you are using "git submodule add --depth", not "git
submodule update --depth"), I suspect that "submodule update --depth"
may not always do what people expect.

With add --depth, I agree with your expectation and after your fix
everything should work fine.  But with update --depth, consider the
following sequence of steps:

 1. I create a repository "super" with submodule "sub" and publish
    both.

 2. I make a couple commits to "sub" and a commit to "super" making
    use of those changes and want to publish them.

 3. I use "git push --recurse-submodules" to publish my commits to
    "sub" and "super":

    a. First it pushes to "sub".

    b. Then it pushes to "super".

Between steps 3(a) and 3(b), a person can still "git clone
--recurse-submodules" the "super" repository.  The repository "super"
does not have my change yet and "sub" does, but that is not a problem,
since commands like "git checkout --recurse-submodules" and "git
submodule update" know to check out the commit *before* my change in
the submodule.

But between steps 3(a) and 3(b), "git submodule update --depth=1"
would not work.  It would fetch the submodule with depth 1 and then
try to check out a commit that is deeper in history.

So I think there's more thinking needed there.

That's all a tangent to your report about add --depth, though.

Thanks,
Jonathan
