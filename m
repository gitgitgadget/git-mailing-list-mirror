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
	by dcvr.yhbt.net (Postfix) with ESMTP id D24821F461
	for <e@80x24.org>; Mon, 20 May 2019 11:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfETLCk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 07:02:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45751 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbfETLCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 07:02:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so14028763wrq.12
        for <git@vger.kernel.org>; Mon, 20 May 2019 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9gjVTXjMaWpQSNMthErcd++V7iJkjGO9XcfcaK4OruU=;
        b=a+mytnR8pmijOSYhRKEMLn/k0MYHUMqk2C0uwNMx/W9frG9Y20XSzLaqmOgP8AgXC2
         AxeuzCZM00gGauM4aWVR30MWwi4GS5q6zb25QYtfmlI3WEkQO1kIeQ8BK5fHx7zyXtGW
         psUjrrD3Ps8c7uQkFWPcwKCUGC4biwHyusR89GoB+nC38uKuBZPqA7RR5QWQYSs+7lrI
         KVoDAhqABxN1sat9fFu9/1Zk7JtTJ0/OFVFAgC9f+xaUDnLNOAdRt/qW8TvI680hu7fu
         cqN0NMzDNOhBnl0VIwvsPVeYgQ4ZGYVs+KXXlk2tAWGHNVx13ptRtbz2wtTO5tko7nzK
         i5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=9gjVTXjMaWpQSNMthErcd++V7iJkjGO9XcfcaK4OruU=;
        b=P5jfaH1AC88X7vGvMruzNAPCmtFDYcA/qpF4l3aQCT4V98hOldrbtKjfQ2RTJKTejk
         PW+WN3DfeuyqMDEfG2gNRUhGUogdiMCgjKUY3y+uw3OciphJb9oXBpS4xSi65c7eetJW
         nT6ll/xm+2B/K7hulRHcb0Jtyc2Z2AvbxFaLuN9A1gW77r5UfJLuttHIgZS4Ly9leEpb
         E18YrO1cu2yYCid40Vv35p5EAP2AIvWljtybJd0CTm2wV0kfxmOCV3ICSar0vur8/eVQ
         oPaVWNMIPFnxK3CJRrf4pAKslt1jIALX2gl9O9i5PB53jtDxRxzUx8uHxZV3ziLLfc7c
         wD7w==
X-Gm-Message-State: APjAAAXmO7b9ULDuBLz5ik2iGkKgU4tXYsmEFg85Wm9pRWnIyEPpdzK6
        ZwM6J0ZYQz3a3IXGOum8p4JweC40a4U=
X-Google-Smtp-Source: APXvYqx4WmYmPD3ZUdQOhLGzdJds6ABd7HYPs2Lx/w7/l/u8pj9+jVlhTKdY3Ksj+nLpZ71Mxol3ag==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr28780520wrp.302.1558350158807;
        Mon, 20 May 2019 04:02:38 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egp40.neoplus.adsl.tpnet.pl. [83.21.79.40])
        by smtp.gmail.com with ESMTPSA id y18sm21772915wmd.29.2019.05.20.04.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 04:02:38 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
Date:   Mon, 20 May 2019 13:02:36 +0200
In-Reply-To: <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com> (Derrick
        Stolee's message of "Sun, 19 May 2019 21:33:08 -0400")
Message-ID: <86mujhpewj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/18/2019 12:17 AM, Mike Hommey wrote:
>> On Sat, May 18, 2019 at 12:58:28PM +0900, Mike Hommey wrote:
>>> On Sat, May 18, 2019 at 03:50:05AM +0200, SZEDER G=C3=A1bor wrote:
>>>>
>>>> All the above is without commit-graph, I presume?  If so, then you
>>>> should give it a try, as it might bring immediate help in your
>>>> pathological repo.  With 5k commit in the same second (enforced via
>>>> 'export GIT_COMMITTER_DATE=3D$(date); for i in {1..5000} ...') I get:
>>>>
>>>>   $ best-of-five -q git rev-list HEAD~..HEAD
>>>>   0.069
>>>>   $ git commit-graph write --reachableComputing commit graph generation
>>>>   numbers: 100% (5000/5000), done.
>>>>   $ best-of-five -q git rev-list HEAD~..HEAD
>>>>   0.004
>>>
>>> I'm not observing any difference from using commit-graph, whether in
>>> time or in the number of commits that are looked at in limit_list().
>>=20
>> -c core.commitGraph=3Dtrue does make a difference in time, but not in the
>> number of commits looked at in limit_list(). So it's only faster because
>> each iteration of the loop is faster. It means it's still dependent on
>> the depth of the dag, and the larger the repo will grow, the slower it
>> will get.
>
> The plan is to use the commit-graph's generation numbers for these A..B
> queries, but due to some cases when commit date is a _better_ heuristic
> than generation numbers, we have not enabled them for A..B. You'll see
> that 'git rev-list --topo-order -n 1 HEAD` will be much faster with the
> commit-graph, but adding '--topo-order' to your 'HEAD~1..HEAD' query
> should not change the time at all.
>
> See [1] for the discussion about "generation number v2" which will allow
> us to use a better heuristic in these cases.
>
> [1] https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gma=
il.com/

Are there any blockers that prevent the switch to this
"generation number v2"?

- Is it a problem with insufficient data to choose the correct numbering
  as "generation number v2' (there can be only one)?
- Is it a problem with selected "generation number v2" being
  incompatibile with gen v2, and Git failing when new version of
  commit-graph is used instead of softly just not using commit-graph?
- Or is it something else?

Best,
--
Jakub Nar=C4=99bski
