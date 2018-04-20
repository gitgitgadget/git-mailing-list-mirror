Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736FB1F424
	for <e@80x24.org>; Fri, 20 Apr 2018 11:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754607AbeDTLlc (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 07:41:32 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38131 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTLlb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 07:41:31 -0400
Received: by mail-wr0-f172.google.com with SMTP id h3-v6so22189222wrh.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OUCFp6gcyCxH8ou/l9mUlmoXZlP5duFFae1Qd3wzars=;
        b=lkZ0uz/n43fWlaCe9IRI7cLyIHbDQfBEPcjtTTDG9IrAXhy+I17oHbpQ9tx4iLG9gH
         iN4fOqWNFVyDjwnQsqOG4gjlt66PDkaydx8aMshRXpBQdjb+O8F7335aRxAgn6y1PaV6
         BVlL91I2UvL5UQNpOxbZFznhQkMeKEfpxeA3kQxukZvWUDu+wnCSHF420L9IBNnrKnVe
         7HR8Jjpe0+vbgGa4z2EBfVgXuL2xPUPfLjo3he/7DtZFxr+uyjx3ZUO3Mb7C2VaAXkZw
         /NQOSBwQ60RCU177Mdn9QbRWdAF4TLcr3ce7L9PuOZyf84HTJ5Bi/x8Ivj2QTL24AIkY
         ZJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OUCFp6gcyCxH8ou/l9mUlmoXZlP5duFFae1Qd3wzars=;
        b=Siwp6MMUtfn+DYQFryt1qnx6qLcLXfy627eQOTxENRG/t1KcBFWm/GR+40GeiKYa9K
         7poJpc4/OP46/pJYq7GVtxKDP5IkbkBeWvYSHoMBqgQZV+0LidTq1jUTUA5/fj9H+7xJ
         WVdf2fzwvwF2rmfD97ufy7EQ9Hac74SF+cWIB9MoGzzW+MHIbscDvYOsFYV6ocLHxEVg
         1zSxvX6oIUTO28PvKyPK4mG5j6xdWPTd3Uiru484LGrfJDSP14OiPJrSSYhNb4ia8BMP
         8T2JwPOUJbxm6P+1tyTAAr1/QNs27OBgG/rcDO2FD9kxkYTVM0CpZj9WJZgfBuN1LC2l
         n28Q==
X-Gm-Message-State: ALQs6tCWS9SsdyqwEtGKbMHyb4IawyITjM5Rw5eb1HN2/0m5pVxsmjR9
        WtuVDOfWZ6CZH/tqKznsCZc=
X-Google-Smtp-Source: AB8JxZrDVY+xlLCBXzjCnVVmaLqOZKe3NZJt+LF3qi4DNnfXkHQn+dum3rtKvGPJnt/OWfo6KM/YNw==
X-Received: by 10.28.8.143 with SMTP id 137mr1643544wmi.54.1524224489833;
        Fri, 20 Apr 2018 04:41:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id p25sm1076115wmi.14.2018.04.20.04.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 04:41:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrew Ducker <andrew_ducker@standardlife.com>
Cc:     'Bryan Turner' <bturner@atlassian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug Report - Pull remote branch does not retrieve new tags
References: <adc410f016e8405fb81fa92e45675e2a@standardlife.com> <CAGyf7-G7GDX6DtpAqQvQ-8Rwad1VS6_xdDw_Rt_p5kT-C7dFZA@mail.gmail.com> <f41243c52aff4001801d58dee1c5ccb6@standardlife.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <f41243c52aff4001801d58dee1c5ccb6@standardlife.com>
Date:   Fri, 20 Apr 2018 13:41:26 +0200
Message-ID: <87k1t2ds0p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 20 2018, Andrew Ducker wrote:

> Thanks Bryan, that does clear it up a bit.
>
> The reason that this came up is that Visual Studio Code has switched from "git pull" to "git pull remote branch" when the "sync" button is clicked, and this has meant that tags are no longer being fetched.
>
> What _does_ seem to work is adding "--tags" on the end of the git pull.  But this isn't actually in the documentation[1], and I'm a bit nervous that this is mid-deprecation.
>
> Is "--tags" going away shortly?  Or are they ok to depend on this?
>
> The bug is at https://github.com/Microsoft/vscode/issues/48211 if anyone wants to chime in with advice over there :-)

It's in the documentation, it's just in the git-fetch documentation, and
the git-pull docs say:

    More precisely, git pull runs git fetch with the given parameters

So --tags is not going away, however using --tags is likely not the
right thing either, because it'll also get tags that don't point to any
of the refs being tracked as the docs explain, which isn't what was
happening with "git pull".

As to what VS /should/ be doing, I have no idea because I don't know why
they switched away from "git pull" to "git pull remote branch" in the
first place. Maybe they'd like to clone with --single-branch?

Unfortunately there's no way to replicate that on an existing repo
without re-cloning, as my
https://public-inbox.org/git/874lkuvtve.fsf@evledraar.gmail.com/
explains.

>
>> -----Original Message-----
>> From: Bryan Turner [mailto:bturner@atlassian.com]V
>> Sent: 19 April 2018 23:14
>> To: Andrew Ducker
>> Cc: git@vger.kernel.org
>> Subject: Re: Bug Report - Pull remote branch does not retrieve new tags
>>
>> Andrew,
>>
>> On Thu, Apr 19, 2018 at 6:55 AM, Andrew Ducker
>> <andrew_ducker@standardlife.com> wrote:
>> >
>> > What happens:
>> > When I create a new tag on the remote (changing nothing else)
>> > "git pull origin master" produces the following:
>> >   From git.internal.company.com:team/testrepo
>> >    * branch            master     -> FETCH_HEAD
>> >   Already up-to-date.
>> >
>> > If I instead do a "git pull" I get:
>> >   From git.internal.company.com:team/testrepo
>> >    * [new tag]         Testing11  -> Testing11
>> >   Already up-to-date.
>> >
>> > What I think should happen:
>> > The "git pull origin master" should retrieve the tag.
>> >
>> > This is with 2.16.2.windows.1, but also occurred on my previously installed
>> version (2.12.2.windows.2)
>> >
>> > My understanding is that "git pull" and "git pull $repo $currentbranch"
>> should function identically.
>> >
>> > Is this a bug, or am I misunderstanding the manual page?
>>
>> Looks like a misunderstanding, to me. Perhaps I can help clarify.
>>
>> "git pull" without arguments fetches from the "origin" repository
>> using the configured "fetch" refspecs, which typically looks something
>> like "fetch = +refs/heads/*:refs/remotes/origin/*". It _doesn't_
>> actually fetch all tags, but any tag referencing any object/commit
>> included in the branches is brought along for the ride. This is
>> documented on "git pull":
>>
>> --no-tags
>>
>>     By default, tags that point at objects that are downloaded from
>> the remote repository are fetched and stored locally. This option
>> disables this automatic tag following. The default behavior for a
>> remote may be specified with the remote.<name>.tagOpt setting. See
>> git-config(1).
>>
>> By comparison, on your "git pull $repo $currentBranch", what you're
>> calling "$currentBranch" is actually "[<refspec>...]" from the
>> documentation. In other words, by passing "master", you've told "git
>> pull" to fetch _nothing but "master"_, ignoring the configured
>> refspec(s). Additionally, since you haven't told "git pull" where to
>> _put_ "master" once it's fetched, it writes it to "FETCH_HEAD". If you
>> have a tracking branch setup, "git pull origin master" will also
>> update the tracking branch. For example, the same command for me
>> produces:
>>
>> $ git pull origin master
>> From ...
>>  * branch                    master     -> FETCH_HEAD
>>    aca5eb0fef5..ad484477508  master     -> origin/master
>>
>> As you can see, both FETCH_HEAD and origin/master were updated, since
>> my local "master" tracks "origin"'s "master":
>>
>> [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>>
>> Hope this helps!
>> Bryan
> Confidentiality - This email is confidential.
> Not meant for you? - If you don't think this email is meant for you, please let us know. Do not copy or forward the information it contains, and delete this email from your system.
> Views expressed - Any personal views or opinions expressed in this email are the sender's, and do not necessarily reflect the views of Standard Life Aberdeen group.
> Monitoring - We filter and monitor emails to protect our systems and to keep them running smoothly.
> Emailing us - Email isn't a secure form of communication. If you want to send us confidential information please send it by post. However, if you do communicate with us by email on any subject, you are giving us permission to email you back.
> Phoning us - Calls may be monitored and/or recorded to protect both you and us and help with our training. Call charges will vary.
> Standard Life Aberdeen group - Standard Life Aberdeen group comprises Standard Life Aberdeen plc and its subsidiaries. For more information on Standard Life Aberdeen group visit our website http://www.standardlifeaberdeen.com/.
> Standard Life Aberdeen plc (SC286832), Standard Life Assurance Limited (SC286833) and Standard Life Employee Services Limited (SC271355) are all registered in Scotland at Standard Life House, 30 Lothian Road, Edinburgh EH1 2DH. Standard Life Assurance Limited is authorised by the Prudential Regulation Authority and regulated by the Financial Conduct Authority and the Prudential Regulation Authority.
> For more information on Standard Life Assurance limited visit our website http://www.standardlife.co.uk
