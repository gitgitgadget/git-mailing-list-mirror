Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472EB203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbcGUSJf (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 14:09:35 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38871 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbcGUSJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 14:09:34 -0400
Received: by mail-it0-f42.google.com with SMTP id j124so25661990ith.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 11:09:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iugome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8+AIxy1R0HjkXpmH2+ejBLRuctlbAosdZMGuE6JQfSg=;
        b=fU1Q60tOqnA4HS0mpArjTxMnV4PLD8xY7NpnbSity2fFyUvy6jg0GdzrxOKjEi8oZg
         2/5bbPDsq+jbUwyUQNbL8c2/i18T5IWWy9qTTuSOjy2hLDQF+6k+VGUItuW57pn9OoYl
         gV0JPryv6S2nv/XcnK0VqN9eIfIA2rvCGQPJ93X4z3zHxNvC3MdylgFosaArvs1M0cKr
         zwpydGJjThYyBwHXKo8+9gBSdRjAI88iz0/bJGWg2ARKh0eZOITDPaQW/MEvt0ZBnYKy
         YD9jMbGG+Xl+cXP+1Hd1fy9qW/BepXsc+YuVVqZKLguIdn0KjGYTVE/ZPmkhc8O5D7rs
         WBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8+AIxy1R0HjkXpmH2+ejBLRuctlbAosdZMGuE6JQfSg=;
        b=RVyi61f6c9vqcLtj9ITwOaZttIGUpCgFu7GiwkdwdeoleftEH4s2zeYVOJw/6ImZlT
         rjVrGTsS1NwjfW1kk3tBgJXpSg1MJ1pmYoWvmKt1SVG0/jm0+y3v6N6l7Vgy7E/bU175
         3yfl+R6BU4VBwHeKSf4glNhQcgfNbSjnzGBafg8mmm8BW3PqZhlggb+MPrZtE7NegElW
         zlhiQhDqXbhaRvlnUZHuUd1nzzavwWF3gZ1or6no2qhoSR/PxXX/lc4M29P/Plg3GusA
         MKUx0cilKPoSgB7TzNxMy3YrPUsfW4BQ63BXi5KmO8DRxgqkfcBmWVljJkrGvbOH77Mn
         F7iQ==
X-Gm-Message-State: ALyK8tJj8DzgA13YJuT9cCEpL4EPCom3eENqH0HWXKPPvagkap2ZlHhdURrZa1ClEQbasldCPRdSbxbbS1xXqQ==
X-Received: by 10.36.50.206 with SMTP id j197mr63926454ita.70.1469124573116;
 Thu, 21 Jul 2016 11:09:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.152.141 with HTTP; Thu, 21 Jul 2016 11:09:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607211724430.14111@virtualbox>
References: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com>
 <20160721052625.GA31423@gmail.com> <alpine.DEB.2.20.1607211724430.14111@virtualbox>
From:	Brett Cundal <brett.cundal@iugome.com>
Date:	Thu, 21 Jul 2016 11:09:32 -0700
Message-ID: <CAMaPC4JTerX7TSg5_M=DOztyaGUVd5_kK8cmTJuWrCekGgSodw@mail.gmail.com>
Subject: Re: [PATCH] git-subtree.sh: Use --allow-unrelated-histories when
 splitting with --rejoin
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Roberto Tyley <roberto.tyley@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[re-sending as plain-text so the list software doesn't reject as
spam... what decade is this?]

Hey,

Sorry about the empty commit message... there was one originally
(albeit not as detailed as the pull request), but I guess it got
stripped? As you have probably guessed, I have no idea how you guys do
patch submission.

I'm not currently able to spend much time getting up to speed with git
development just to submit this fix... I would have just filed a bug,
but I couldn't figure out how (I guess it's just this mailing list?)
and I figured a patch would be more useful. I had a look at writing a
test initially, but I didn't see any existing tests for 'git subtree',
and I'm not familiar with the test framework.

The case that fails is basically any usage of split --rejoin... e.g.
make a new repo, make changes to directory a, make changes to
directory b... do a 'git subtree split -P a --rejoin' and it will fail
at the end when attempting to merge the split commits back to the main
line, due to the two lines being unrelated (now disallowed by default
in git 2.9).

Hopefully I'm not just doing something wrong - I'm surprised such a
major bug has not been fixed already... I guess noone else uses
--rejoin? Anyhow, this patch fixes the issue for me.

Hope that helps,

-- Brett

On 21 July 2016 at 08:25, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi David,
>
> On Wed, 20 Jul 2016, David Aguilar wrote:
>
>> As-is, the commit itself should probably be amended to contain
>> that information [the better explanation].
>
> Definitely. Keep in mind: if this gets merged or cherry-picked elsewhere,
> the Pull Request's message is just as lost.
>
> Ciao,
> Johannes
