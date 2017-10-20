Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FC21FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 20:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbdJTUpd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 16:45:33 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:53169 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdJTUpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 16:45:32 -0400
Received: by mail-qt0-f177.google.com with SMTP id 31so19986228qtz.9
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=59ey5/3pvpVAPAenY9xFeza7X2T1pC9T6ACMJIf38dU=;
        b=BDgfajdXsFT7itYaRQ7JAisW5BMmhmEKGdJ6Z2kII0aEg2WdLSpwmwPXX/AgHFPah8
         NY+o1yemUCt6w9wfQ6V6xa/auxl8A9JdcSzDPSDleC5GVz/7gm228kL7uQHeG8JzpDmk
         udo1sUpITj0Zf/CLKu0UG2h1ydMtMQzHUpOsYbp6LINVFBclWLK/vNmbaSS92otQQk8h
         LBYlPEuVe0xn6Co1Q7nxUzcneGXDutAQ7wr/53kD7lTkZ06tWQ+oqEbSwvqugGv9lhsW
         DJjCCdsaIpT4dKsqGmdTsMDY3u1MryEsgXHnK7IsK5HqGyGVRmFZO6dHg5hDjnIbk0zQ
         3C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=59ey5/3pvpVAPAenY9xFeza7X2T1pC9T6ACMJIf38dU=;
        b=sKpZxmG4bIqlwlS+d9JVN0u9Pt3mpr2R4kcwGCJ5ivJTJ1F4YAaT1TiONS7tiDThbf
         FQgvl+5JusKZFTQAAM+OxO1QB4Ga99Ke/JxR0CP5VgKTVUrU42dENsQxbPL1qyNIbiPk
         hbuHBCv4TkX8p/hb5kxLQ52Qhy+fS8FCQRNlreYUc6CHEuWWuURwErRokvD8g4Zcg2rO
         Lr29xPeiwfTBwMaRrX+v5Oo0HJCFTePyAhDK5B21WNvj5VU8KD6UxDqkWFal6dMuDTj7
         mXixIXzDYE4DPcgubKWMfC/HdeY1KH7KImlOhiwolLpZ/KUy7x3wAv6rItGIua2BNnM8
         QVjg==
X-Gm-Message-State: AMCzsaX4Bchg90X68R2FCdiI0uXCtKm79TI1kkgzXG5/+2+FI6rVpYzS
        7WiunGpR9FjXSMe2Wz36dL5se5MrpIG2yCmv7nZivA==
X-Google-Smtp-Source: ABhQp+QNqn8IV1iw4oE+aMQMD2zdWykJJqaEGwXgAD4wzOlzKufPq46hs/IxNTHD0zqc13R1MboxWQy0bPuybALh3cU=
X-Received: by 10.237.34.201 with SMTP id q9mr9438686qtc.198.1508532331782;
 Fri, 20 Oct 2017 13:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 13:45:31 -0700 (PDT)
In-Reply-To: <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net> <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
 <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 13:45:31 -0700
Message-ID: <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 11:04 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 19, 2017 at 10:27:28PM -0700, Stefan Beller wrote:
>
>> > If my analysis above is correct, then it's already fixed. You just had
>> > leftover corruption.
>>
>> Well fetching yesterday worked and the commit in question is from
>> 8/23, the merge  8a044c7f1d56cef657be342e40de0795d688e882
>> occurred 9/18, so I suspect there is something else at play.
>> (I do not remember having a gc between yesterday and today.
>> Though maybe one in the background?)
>
> Even a gc between yesterday and today should have used the new code,
> which would have been safe. So yeah, maybe it is something else
> entirely.

Oh, yeah.

>
>> I am curious how you can have a worktree owned by multiple
>> repositories [1] (?).
>
> Sorry, I forgot my footnote. I saw this with my "ci" script:
>
>   https://github.com/peff/git/blob/7905ff395adecdd2bb7ab045a24223dfb103e0e9/ci
>
> I check out the contents of my "meta" branch as "Meta", and it contains
> that script. It basically just waits for ref updates, then walks over
> all the commits and runs "make test" on them in the background (caching
> the results, thanks to the git-test[1] script). So I kick off "Meta/ci"
> in a terminal and forget about it, and magically it builds my commits in
> the background as I work.
>
> It operates in a worktree inside the Meta directory (Meta/tmp-ci), so as
> not to disturb what I'm doing. So far so good.
>
> But I actually have _two_ clones of Git on my system. One on which I do
> most of my work, and then the other which has the fork we use in
> production at GitHub. I symlink the Meta directory from the first into
> the latter, which means they both see the same worktree directory. And
> somehow running "Meta/ci" in the second corrupted things.
>
> I can get some funniness now, but I think it's mostly caused by the
> script being confused about the worktree existing but not having access
> to our branches. That's not a corruption, just a confusion. I _think_ I
> had a bogus HEAD in the worktree at one point, but I may be
> mis-remembering. I can't seem to trigger it now.

Thanks for these insights.

I played around with Meta a bit, but I did not feel it would enhance
my workflow enough as I am not involved with any maintainance
of git using git.

The git-test from Michael sounds intriguing. Initially I put off using
it as I had my main working dir (or rather test dir) on a spinning
disk, still. Now I test in memory only, which is a lot faster, so I could
try if git-test can keep up with my local commit pace.

Thanks,
Stefan
