Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C5520954
	for <e@80x24.org>; Mon,  4 Dec 2017 20:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdLDUCi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 15:02:38 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34175 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdLDUCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 15:02:37 -0500
Received: by mail-qt0-f172.google.com with SMTP id 33so23932346qtv.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GRPLnXr7jude4Vq8xX2NwSigRKEquqpYVLELPwXOzhU=;
        b=kRufi0Rt0o7AZCVHZWR/7ca/2owECu0bBgeSO/bJlskYRiZ7XwTwFklnTjk1xACUSa
         VFinJCv81SUWUuSsNi+EDcGJUFD4ndKc/UuX66QtjtJH30068E3BlG69Nn1LMKyxWrPL
         J/BAeshO9KFoPyBnQo+qFyY8J+66G/CQ3+m7ifPcpOulGwK5vn4XR7hnYj9lUY6SCLfz
         03Kh+IGQiVtWoqhpWonfcATS79vc5KZD/65+EVxQ7He4TTFIP/xIN71JZ6Sn1wOuKQfg
         WfZoSOPEwuud8lS2QLbETQvC26RrxRkZWgBnj2oWbyfL8+qZ5DBynM3aaecMiriilksK
         ohcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GRPLnXr7jude4Vq8xX2NwSigRKEquqpYVLELPwXOzhU=;
        b=QwiDF5lMaTP79AWanqKWR7/BMKPXZG89DRuBJ89TcsPiIp0sVfzmp7IurM1RttyIPv
         o2jvM/69nAJlRWBHaOrkxOQj+lr0wRI2rt+sVEmXBS12VYPBe+B9TB/JVHy/fUeTVs1+
         4vjxg3jrxKQYVxreOix+CWlGBVuIcmOXqTnbJLvX2eIyL/AR6SEsjoXxGYxpmk2zfEc7
         zeNKuosui9BurBnnK8c0LLFndjRagCUpZo+GZ7HzPzcS3y3JUJqzXysvVBk666xP5YtB
         glZ2w179Gx2YfYCcaN127z1kTH7e2paNCIZn+NZPmwl+SAYD5NMyeROXNCrLnbhCbQ4E
         Z5hA==
X-Gm-Message-State: AKGB3mKxsRJwocozxo9QM5z7OQLcrdHyowyHCA+mjjJpoFMp2XeHGCTs
        D1GWscQ1ghl3Kw22FMkZ7ViH22W44FYZq/dLrIKigQ==
X-Google-Smtp-Source: AGs4zMYOo51oER7Z+Pqa1w52QykzaWHa8sag1coA6QeYBiVp+l1EkF/v72u8CkbNFSOknlcXbShPIaeKMvUGVZvXBd4=
X-Received: by 10.200.36.105 with SMTP id d38mr102468qtd.180.1512417756672;
 Mon, 04 Dec 2017 12:02:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 4 Dec 2017 12:02:36 -0800 (PST)
In-Reply-To: <20171201214709.GA61710@google.com>
References: <CAN0XMOJnQX-gSnpHaiJUYr4X4-WT91oT3Xv3gDtKYjX7J3ObVw@mail.gmail.com>
 <20171201214709.GA61710@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 4 Dec 2017 12:02:36 -0800
Message-ID: <CAGZ79kaPFMQicmfhaWZ_BRyuSXCwTMYX_Jwk_aGSJDFr-_=xzg@mail.gmail.com>
Subject: Re: git-clone ignores submodule.recurse configuration
To:     Brandon Williams <bmwill@google.com>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 1, 2017 at 1:47 PM, Brandon Williams <bmwill@google.com> wrote:
> On 12/01, Ralf Thielow wrote:
>> Today I played around a bit with git submodules and noticed
>> that the very handy configuration "submodule.recurse" is not
>> working for the git-clone command.

The rationale here is that submodule.recursive ought to make your
conglomerate of repositories (superproject + some submodules)
look and feel like one giant repository.  Thinking further this sounds
like a user wants to set it globally, hence it may be expected to
work for fresh clones, too.

However at clone time, we don't know which submodules the
user wants. The first submodule recursive switches were an
all or nothing, but I think we need a better selection there.
For fetch there is an "only-those-needed" selection as
"on-demand". Similar for push.

For clone we expected the user wanting to specify which
submodules are interesting:

  git clone --recurse-submodule=<pathspec>

(Note to self: the `[=<pathspec]` part is deep down in the
man page, not in the synopsis, we may want to put that
more prominently there)

Maybe when submodule.recursive is set, we should assume
a pathspec of "." (everything), also see to `submodule.active`,
which is set using the argument from git-clone.

>> "git help config" tells me that submodule.recurse affects
>> all commands that have a --recurse-submodules option.
>> git-clone seems to be an exception which is also mentioned in
>> a workflow example in Documentation/gitsubmodules.txt that
>> says:
>>
>>   # Unlike the other commands below clone still needs
>>   # its own recurse flag:
>>   git clone --recurse <URL> <directory>
>>   cd <directory>
>>
>> So this seems to be a known issue. Is someone already
>> working on this or has a plan to do it? Or is there a reason
>> not doing this for git-clone but for git-pull?
>
> When we introduced the "submodule.recurse" config we explicitly had it
> not work with clone because a recursive clone ends up pulling data from
> other sources aside from the URL the user explicitly provides.
> Historically there have been a number of security related bugs with
> respect to cloning submodules so we felt it was best to require a
> recursive clone to be requested explicitly, at least for the time being.
>
> --
> Brandon Williams
