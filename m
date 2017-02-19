Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADCD201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdBSLcF (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:32:05 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36756 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdBSLcE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:32:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so9653469wmd.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9m7BFa0UHVoSZ+UA7K44aAtkAKzu1FCV/hPZ2B+mh6k=;
        b=U1AC+RN9rlUrLQumfU9S19kw0Drjosbgwm0cidAfSxAoKy90ZN2GFScFzZTmXfNtna
         yhnfg8cAukq0pYzsPasYs06CMQNYzNHarEdNeB+SBG1xdOYf3fazPdE1zUEQc8VChFMD
         gRwrQO1KoRjU9MjnjWk9V2JpDvpP0NrdGILh1c65hJkOAzgUr+J6fuWwRdhwJAd0beGz
         QjA1eIrf8y54xpuRCLEYBIaxnqY8BjjvY/kI9sODNnzi3YqZeSBMSXG6xJBKXdzwCd6I
         58+08l0wT1dKGkC04TmgCv9SVIz+ooUiPKVLSONstIuFJE88LeLwNprQ++0rApGpyvJH
         c0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9m7BFa0UHVoSZ+UA7K44aAtkAKzu1FCV/hPZ2B+mh6k=;
        b=Esn/uFzTkuGHVHmU2aIyhlj+nzgMB3hfu5bkBjJDDjtOWUGzwigx/HkwIAaNcILbpk
         L1knU31QLVuMz0ufiyjICYIqb1B6NKaJStxMn5kW5PEna5UoNgQU4dpYSdWcXpVp71eT
         8Hm7M9jc+x3WiozOD/RJhPHSFM4sTQ2716aMOCrxMf8BKhGH8qY6aTycDwAcWb7EBPPB
         7vfCGjLYKdEpWRqF7nvEgAHwxo2aI1HZPGdfu1x8Gr0w7ljd10uo9VhKCK/ZsA8lmqNB
         A7iktNOqw/sRmj9k7MMtYfkP6wOFTkkVXSQZ+ZqpeSyeXWGpLjETaktDcOspL1tgciT0
         KY7w==
X-Gm-Message-State: AMke39k+u9emR2bF1AJyiLOvwxcHl2skmS+JnR/iXSm05vGGcfaDAQ1kGbYfNDlnOuyFtJ1/3yGUggB4qzawrQ==
X-Received: by 10.28.217.83 with SMTP id q80mr12897667wmg.58.1487503922164;
 Sun, 19 Feb 2017 03:32:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Sun, 19 Feb 2017 03:32:01 -0800 (PST)
X-Originating-IP: [77.178.200.206]
In-Reply-To: <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
From:   Alex Hoffman <spec@gal.ro>
Date:   Sun, 19 Feb 2017 12:32:01 +0100
X-Google-Sender-Auth: vRjnBBmoozRv--m-_ByOoAJxMxE
Message-ID: <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> At the end of the git-bisect man page (in the SEE ALSO section) there
> is a link to https://github.com/git/git/blob/master/Documentation/git-bisect-lk2009.txt
> which has a lot of details about how bisect works.
>

Thanks for pointing out the SEE ALSO section. I think it makes sense
to include/describe the entire algorithm in the man page itself,
although I am not sure whether the graphs would be always correctly
visually represented in the man page format.

> The goal is to find the first bad commit, which is a commit that has
> only good parents.

OK, bisect's mission is more exact than I thought, which is good. M

> As o1 is an ancestor of G, then o1 is considered good by the bisect algorithm.
> If it was bad, it would means that there is a transition from bad to
> good between o1 and G.
> But when a good commit is an ancestor of the bad commit, git bisect
> makes the assumption that there is no transition from bad to good in
> the graph.

The assumption that there is no transition from bad to good in the
graph did not hold in my example and it does not hold when a feature
was recently introduced and gets broken relative shortly afterwards.
But I consider it is easy to change the algorithm not to assume, but
rather to check it.

> git bisect makes some assumptions that are true most of the time, so
> in practice it works well most of the time.

Whatever the definition of "most of the time" everyone might have, I
think there is room for improvement. Below I am trying to make a small
change to the current algorithm in order to deal with the assumption
that sometimes does not hold (e.g in my example), by explicitly
validating the check.

> --o1--o2--o3--G--X1
>     \                \
>      x1--x2--x3--x4--X2--B--
>       \              /
>        y1--y2--y3

Step 1a. (Unchanged) keep only the commits that:

        a) are ancestor of the "bad" commit (including the "bad" commit itself),
        b) are not ancestor of a "good" commit (excluding the "good" commits).

The following graph results:
      x1--x2--x3--x4--X2--B--
       \              /
        y1--y2--y3

Step 1b. (New) Mark all root commits of the resulting graph (i.e
commits without parents) as unconfirmed (unconfirmed=node that has
only bad parents). Remove all root commits that user already confirmed
(e.g if user already marked its parent as good right before starting
bisect run). For every unconfirmed root commit check if it has any
good parents. In the example above check whether x1 has good parents.
     If the current root element has any parents and none of them is
good, we can delete all paths from it until to the next commit that
has a parent in the ancestors of GOOD. In the example above to delete
the path x1-x3 and x1-y3. Also add new resulting root commits to the
list of unconfirmed commits (commit x4).
     Otherwise mark it as confirmed.

Step2. Continue the existing algorithm.


If this improvement works (i.e you do not find any bugs in it and it
is feasible to implement, which seems to me) the following would be
its advantages:
1. An assumption less, as we explicitly check the assumption.
2. It might be quicker, because we delete parts of graph that cannot
contain transitions.
3. It returns more exact results.

VG
