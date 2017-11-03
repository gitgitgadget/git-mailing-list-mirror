Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AB1202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 06:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbdKCGz5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 02:55:57 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:47516 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbdKCGzy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 02:55:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id r196so2965978wmf.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WngErvIdyI51beliMMK3QBjr5Z72yQtawJTvXHx7XEk=;
        b=ffuzYZh23PIl/a41M7MTOOyyZneKAdJ3Oulr+oc12OaexdPNMeAzxKOzZ8JrJrYUSx
         EICVAPryAK2kSPLHdq1FWDvw5T7INIXSjuaOP3TnhBK3sSOE0kFnl+1CJIf+sIgbnvQ1
         iLgTL/9tudt5dn2PnOtXPp6rb0pd2n05YnPdbNJ38psTwIEEg5pvjj/0dN0p74kyb5h2
         pYULiawtmMv4mAOu4v8vWdgkuXRyrAJQbmtL+McO6sFSsAHV+W9FLgNfM1vdpZ7fYQ1e
         3V4WOluLPd3jWxX2bJSVAoLpavJd3kzoYMumoNo+K412zGHluuvocznXetMz1/E4ghMX
         nh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WngErvIdyI51beliMMK3QBjr5Z72yQtawJTvXHx7XEk=;
        b=pfYPtgFEjKCsdh8SBrjyd+EJvJkfw/nRe/8ZjSiJApnYN1tXcx+dH2ggdBh3htW/2F
         LklRY2d9pfjv3Mo8QauibUDSTZjjTEODet4zpKeg2niSOOSl4/bh5/Ca1uhiXaG5kjxe
         cqcyP0e1bZV39CTJPQ7NmhH7KqEoBwL4RArNUqiimpkOHtV4EXQKSyBDqalBB6Y2+0c6
         UtHJzl0O0/CMdjg2BU0wVJDpjFaJstKEzdLe7d/+MvQ4QkX+z0OFhCGpr8S3E6d/hmR6
         I1p24P4JK90Hhhs5ARAMShRLyLKD4cK86sqUiMDEamSKz1VIFUBD6kk4FONme+CZunT2
         fUOg==
X-Gm-Message-State: AMCzsaXlaRetpGXl1ZNTKBBaqORfOeFUV0smaLmgEn6xPRrbjmEcRHJJ
        e4hjfqyOFOYo97eAbDMfhTTam+In04aFi8QTzog=
X-Google-Smtp-Source: ABhQp+RbqxG1R9vuUILCYM/rlDFUx0H7t8aNvKXwjnbu24Zwcpx5een5UGfmqPjVLxhgwJPbbN2ClJGBou4v6Ufye9M=
X-Received: by 10.80.172.122 with SMTP id w55mr7390066edc.293.1509692152829;
 Thu, 02 Nov 2017 23:55:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Thu, 2 Nov 2017 23:55:32 -0700 (PDT)
In-Reply-To: <xmqqtvycos7z.fsf@gitster.mtv.corp.google.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011329300.6482@virtualbox> <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
 <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
 <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012340290.6482@virtualbox> <CA+P7+xqw9zKNUkn9P-qA57ADSB5G_7Sd0JCc6SaK6bBf9-Jhtg@mail.gmail.com>
 <xmqqtvycos7z.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 2 Nov 2017 23:55:32 -0700
Message-ID: <CA+P7+xrRgzGLFMZ+iaomQifOUXqANKD0v9XGoR+==0kVmyVL5Q@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 10:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I think both questions are valuable, the first is "which commit last
>> had this blob", the second  is "which commit first introduced this
>> blob", neither of which can always give a definitive answer. It really
>> depends on what question you're asking up front.
>
> Given that "describe" is about giving an object _a_ name that is
> plausibly useful to refer to it, it is not a good match for the
> above query that wants to know where it came from, how long it
> remains in the tree and where it ceases to be relevant.  In order to
> support that use case, a totally different and possibly more useful
> avenue would be to think how this can be hooked into "git log"
> machinery.
>
> A refresher for how "git log [--options] <pathspec>" works may be
> beneficial.  We walk history and compare the tree of the commit we
> are looking at with the tree of its parent commits.  If everything
> within <pathspec> is the same, we mark the transition between the
> parent and our commit TREESAME (other commits, i.e. the ones that
> have meaningful change within <pathspec>, are !TREESAME).  Then the
> output routine presents the set of commits that includes commits
> that are !TREESAME, within the constraints of the --options given
> (e.g. with --full-history, sides of a merge that is TREESAME may
> still be shown to preserve connectedness of the resulting graph).
>
> It is easy to imagine that we can restrict "git log" traversal with
> a "--blobchange=<blob>" option instead of (or in addition to) the
> limitation <pathspec> gives us.  Instead of treating a commit whose
> diff against its parent commit has any filepair that is different
> within <pathspec> as "!TREESAME", we can treat a commit whose diff
> against its parent commit has a filepair that has the <blob> on
> either side of the filepair as "!TREESAME" (in other words, we
> ignore a transition that is not about introducing or forgetting the
> <blob> we are looking for as an "interesting change").  That would
> give you a commit history graph in which only (and all) such commits
> that either adds or removes the <blob> in it.
>
> Hmm?

This seems quite useful in the context of figuring out how a file got
to such a state. This is useful to me, since if I know the state of a
file (ie: it's exact contents) I can determine the blob name, and then
use that to lookup where it was introduced.

Thanks,
Jake
