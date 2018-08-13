Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958B61F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeHMXbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:31:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36161 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbeHMXbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:31:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so15411452wro.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TqoTNSXkKw53PfNQs8cCy/7nLKvBMFFWqNp9oQOUc1s=;
        b=K/CnRRST6fGlULQT8NzyO1FGZypySOHvwODI2GPGwIB6MsMdwcogTlM9jhuoyC+VYd
         FiW1iPGVoator4ug2faQCA0UjwBGQ0s5+dBTUUf8e2f88zAYXv0Mhi2OdKdK+Gn5jvik
         juyiU1WnMDn5KYJW+c6sPBvjK/8NkuX58e633POUEv2vPBCIKQWJhdgfsHSLYP3Zh7IB
         Jkis3Do/ftUrYTFUSHkgry2m1or+K14cIYp/WkFaCmyhS+BoHrvx/AeMRrxq2ecP0fTC
         t265qY0+PyKMHGqspf3KXhY5nE3yQ/1LcFISKaAWtCvBP3k8wnMVrdybsBpoeEdTKXHL
         m/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TqoTNSXkKw53PfNQs8cCy/7nLKvBMFFWqNp9oQOUc1s=;
        b=E8cU0xDWC32uA1x5Bo8eVRMpgx6MDQF46DftjCX+EOGA7asuE8Cqt7YIg7/6XGWG0l
         cbXTaAwW09p3JzPpeSJhqz+NmcjmQYlS0qveFiRCiON7qrrgi4Q3qeddS1BqcAaA5ytb
         +SKNP9hEU7pza7gTp3kjwOVXeR1IFE5YTOcZtWm/KWMb5rkYlJbSIuU3lQ7TjeYw7V39
         BWzKyB5kC7UMfJO8gH6zkEm51SrmfG8bDmPpZUqR+s2/dvrBF2nCeQCJLJtgpb8Xkhba
         uwaFTv90C4WwuVmH/02Gzu9az/a81ueiCYDdToeKo8LD4+IQCLFlgClGXaHCtQrO3aof
         t1oA==
X-Gm-Message-State: AOUpUlHGfDkPwprjZYJQvIq/1mMOUSF2SI/TixC50xn3E79dq5GPd1L9
        dP1WfAUYoTIhlMQBa/AyS48=
X-Google-Smtp-Source: AA+uWPwYqNMOGuH38BFTkyLGjjOW2tt+YfHzB0lq0axdrOCpULms+d6sX1Jq3jTeUBxvGrU1/17MXQ==
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr11672664wrh.267.1534193236383;
        Mon, 13 Aug 2018 13:47:16 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id f132-v6sm12854044wme.24.2018.08.13.13.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:47:15 -0700 (PDT)
Date:   Mon, 13 Aug 2018 21:47:14 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/21] Add range-diff, a tbdiff lookalike
Message-ID: <20180813204714.GI2734@hank.intra.tgummerer.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
 <pull.1.v6.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1808131337360.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808131337360.71@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/13, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 13 Aug 2018, Johannes Schindelin via GitGitGadget wrote:
> 
> > The incredibly useful git-tbdiff [https://github.com/trast/tbdiff] tool to
> > compare patch series (say, to see what changed between two iterations sent
> > to the Git mailing list) is slightly less useful for this developer due to
> > the fact that it requires the hungarian and numpy Python packages which are
> > for some reason really hard to build in MSYS2. So hard that I even had to
> > give up, because it was simply easier to re-implement the whole shebang as a
> > builtin command.
> > 
> > The project at https://github.com/trast/tbdiff seems to be dormant, anyway.
> > Funny (and true) story: I looked at the open Pull Requests to see how active
> > that project is, only to find to my surprise that I had submitted one in
> > August 2015, and that it was still unanswered let alone merged.
> > 
> > While at it, I forward-ported AEvar's patch to force --decorate=no because 
> > git -p tbdiff would fail otherwise.
> > 
> > Side note: I work on implementing range-diff not only to make life easier
> > for reviewers who have to suffer through v2, v3, ... of my patch series, but
> > also to verify my changes before submitting a new iteration. And also, maybe
> > even more importantly, I plan to use it to verify my merging-rebases of Git
> > for Windows (for which I previously used to redirect the
> > pre-rebase/post-rebase diffs vs upstream and then compare them using git
> > diff --no-index). And of course any interested person can see what changes
> > were necessary e.g. in the merging-rebase of Git for Windows onto v2.17.0 by
> > running a command like:
> > 
> >         base=^{/Start.the.merging-rebase}
> >         tag=v2.17.0.windows.1
> >         pre=$tag$base^2
> >         git range-diff $pre$base..$pre $tag$base..$tag
> > 
> > The command uses what it calls the "dual color mode" (can be disabled via 
> > --no-dual-color) which helps identifying what actually changed: it prefixes
> > lines with a - (and red background) that correspond to the first commit
> > range, and with a + (and green background) that correspond to the second
> > range. The rest of the lines will be colored according to the original
> > diffs.
> 
> Changes since v5:
> 
> - Fixed the bug (introduced in v5) where a dashdash would not be handled
>   appropriately.

Thanks!  I've read through all the patches (and the range-diff :))
again and played around a bit with the newest version, and I think
this is ready for 'next'.

While playing around with it I did find one error message that reads
slightly odd, but it's still understandable, so I'm not sure it's
worth worrying about now (we can always improve it on top):

     $ ./git range-diff -- js/range-diff-v4...HEADt
    fatal: ambiguous argument 'HEADt..js/range-diff-v4': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    error: could not parse log for 'HEADt..js/range-diff-v4'


> [...]
