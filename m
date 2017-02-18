Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F09C201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 19:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbdBRT73 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 14:59:29 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33960 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdBRT72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 14:59:28 -0500
Received: by mail-lf0-f47.google.com with SMTP id o140so20888835lff.1
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 11:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xozX8izWYbTS6og1CyB8AbyFhlLq/wPczHnr0p/Li1w=;
        b=VL7k/fBxIgMyYWc94h2J3/CxAC4gRmzaJn8jyxQjqAvKlkJg9fwEEn32vfKHNdGiKM
         aY/Lsoxtju9tt4Vahcg8hG1442f/WoYNDIRoIQLzcTltgOweDLpTRVOu1ZJjzhLtcgBv
         PcGZwKcbLc0Kd8SlbfmHW6qBID8rWCmZW0G3luWHpmlvRrQb//7fb/M4t7DMI5yapyEH
         rByfftCpbpFDHdJPcOyMST/lpX+r08F6Trn00MnoQKhAfROqC/ZKshp4LbJzc6bRsVIL
         dJPIXSCU8R9cLO6YDrtK7qps4M0DalJK+6uuHMxihf7qahpnnIEiailhhXoT2gp1K/+M
         6iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xozX8izWYbTS6og1CyB8AbyFhlLq/wPczHnr0p/Li1w=;
        b=ROvl4gaEK7AlaTmz8wdMdS5cjytYpt9Q4wE3HaR/xsonZDuhH6CMoh3NYOUh51JJTO
         e7/jIE6MOm+U42ZC6ROtvjTCYrLdAxD0gAzZy8AiKXRQkb4S/F7nFU53pzGggw9y9I4D
         THCrzoqQ5Ts5fsMaY3G9Uy+ozohfKiLW7xFSfMlUxcVCmZxaQVZfGdqRiPzYKNupzGSV
         F6gQWqYQNEWTCXfg16JAGakhIEP9O2ncvfGQ2043eJ8u4LUyjx/6MfTnneUMY/lQnaOy
         AAeoJjepWabe84XwKmy1dBmc1P6oi0VBhHno9A1suiOQpVa41rgK5EVYdiRD7oTt5TZJ
         5n7A==
X-Gm-Message-State: AMke39nFP+ZCm884azNVhlsLTzJ9H5KGbOBo2qIbBE3bGrJPWnjzaFTfSTDdvQms0ZSQbh09XtbTBeJSLK0fKw==
X-Received: by 10.25.67.83 with SMTP id m19mr3387335lfj.24.1487447939690; Sat,
 18 Feb 2017 11:58:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.204 with HTTP; Sat, 18 Feb 2017 11:58:59 -0800 (PST)
In-Reply-To: <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Feb 2017 20:58:59 +0100
Message-ID: <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2017 at 7:36 PM, Alex Hoffman <spec@gal.ro> wrote:
>> But this is not how Git works. Git computes graph differences, i.e., it
>> subtracts from the commits reachable from v.bad those that are reachable
>> from v.good. This leaves more than just those on some path from v.good to
>> v.bad. And it should work this way. Consider this history:
>>
>> --o--o--o--G--X
>>    \           \
>>     x--x--x--x--X--B--
>>
>> When you find B bad and G good, than any one of the x or X may have
>> introduced the breakage, not just one of the X.
>>
>
> Thank you for clarifying how git bisect works. How did you find that
> out? Did you check the source code? If that is not documented in the
> man page may be it worth documenting it in order to avoid future
> confusion for other users.

At the end of the git-bisect man page (in the SEE ALSO section) there
is a link to https://github.com/git/git/blob/master/Documentation/git-bisect-lk2009.txt
which has a lot of details about how bisect works.

> Let's consider your example with distinct names for nodes:
>
> --o1--o2--o3--G--X1
>     \                \
>      x1--x2--x3--x4--X1--B--
>
> It makes sense that git bisect is expecting a single transition, as
> this is a precondition for a binary search to work. My definition of
> "the transition" is a commit with at least one of its parents as a
> good version, but the commit itself a bad version.

What if a commit C has one good parent A and one bad parent B?
Isn't it more likely that the first bad commit is B instead of C?

> I hope we agree
> that git bisect's mission is to search for this transition (as I
> suppose that most of people need such a functionality from git, if not
> exactly from git bisect).

The goal is to find the first bad commit, which is a commit that has
only good parents.

> How could be x1 or x3 be the transition, if
> chances are that o1 is not a good version?

As o1 is an ancestor of G, then o1 is considered good by the bisect algorithm.
If it was bad, it would means that there is a transition from bad to
good between o1 and G.
But when a good commit is an ancestor of the bad commit, git bisect
makes the assumption that there is no transition from bad to good in
the graph.

> Of course it would make
> sense to me if bisect would check o1 whether good and only then to
> check also x1-x3, but this is not what git makes (at least not in my
> initial example).
>
> If you consider that git bisect's mission is different from finding
> the transition, could you please explain what exact commit git bisect
> is supposed to return (ideally with terms from the graph theory) and
> when it makes sense to return that? Because I do not see any sense in
> looking in the path x1-x3 without knowing that those commits may be a
> transition.

I hope it makes sense with the above explanations.

>> Oh, IMO git bisect was well thought through. If it considered just paths
>> from good to bad, it would not given the correct answer. See the example
>> history above. Bisect authors would not have deemed that sufficiently good
>
> You definitely convinced me that git MUST search more than only in the
> paths between good and bad commits, as the good commit G does not have
> to be the first good commit (thank you for that). My problem/confusion
> is that it returns something that does not make sense to me, because
> it does not make sure it returns a transition.

git bisect makes some assumptions that are true most of the time, so
in practice it works well most of the time.
