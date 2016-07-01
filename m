Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978222018A
	for <e@80x24.org>; Fri,  1 Jul 2016 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbcGAPWX (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 11:22:23 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36350 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcGAPWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2016 11:22:22 -0400
Received: by mail-it0-f44.google.com with SMTP id a5so20828406ita.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 08:22:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E9aMzbJDnNwBfNxGLBAGRLuHXHvVF7Ft9rnjirXYj9E=;
        b=QQH9wYUusBt353SFX/xfEllyVnfxwAh2R9V8u0KblL/7UtHzxFj6EVE2hoNF5sg0Uv
         xSS9FOeUMQNi0c2Y4vNjRkGUJzk353XPz0QEPKXojphDwi2KqC1gh9GKJFhsdYJDBDnf
         b1Oj0sLXrfBFhvRfruSkTzvDAg/ErsWbveuhx5j7w7rPw9JQpGPnHxOjh2SyE5IPGPKB
         Agg+tMhvMt2C235R7OHMvpbt+1ll6WLdBJ2wON3ls2WmoEHs8yEyxzOMEcI6n93YiEYq
         2yYED0u79RL4uQucCciV2niDMXXB6eYiHbm+CXAkqZBa2KSJRfoQG9IdR5N6VaC6PCis
         d2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E9aMzbJDnNwBfNxGLBAGRLuHXHvVF7Ft9rnjirXYj9E=;
        b=U3DRy+whkUw+e2xRl4NVjPb6149iePG162oL9+GxxEj5irlmD5UUmuR1SLSJJf1YG7
         14HvhK1FymzqkXfaHLrXVFTmWqGrCjEMe4y+KqPVTG322nF7vjRStIoPMpyiSsODFO7f
         x2XdsTHyOMFkYfeSBIGJXbLN20SqL3NgYdss7mfmfER/mti8QdJMlgiLZSM8IG6T/tA8
         TgMTG0TvVJFUlF6V8jvqRo2t2J76631++LK7JfKqVQJxtSm01G8Sa9VTtWJRlSWJrQh0
         bSSqeKWQtwer6kAuUH+aornmRBYSQ3HbO5Xu8g1bcdc+N4wUgVfPuR6bf+3IiNTmv9cw
         5Gzw==
X-Gm-Message-State: ALyK8tIj4Ks815NveNKH8EwSw9HTrksNaHVtL4TcekMGDVcHPeGKqbK8YjGwPLHWZZ3ND4+mVNs4SUDUsTw9hQ==
X-Received: by 10.36.81.15 with SMTP id s15mr61269ita.57.1467386037193; Fri,
 01 Jul 2016 08:13:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 1 Jul 2016 08:13:27 -0700 (PDT)
In-Reply-To: <a7d7d959-1189-8170-04f4-ab097202ff45@drmicha.warpmail.net>
References: <20160630163942.8353-1-pclouds@gmail.com> <20160701063129.GC5358@sigill.intra.peff.net>
 <a7d7d959-1189-8170-04f4-ab097202ff45@drmicha.warpmail.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 1 Jul 2016 17:13:27 +0200
Message-ID: <CACsJy8Df29zR4bJynHvwOFQobVS8X-08D9K1UPs7QYXd_bkCCg@mail.gmail.com>
Subject: Re: [PATCH] log: decorate HEAD -> branch with the same color for
 branch and HEAD
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, j.cretel@umail.ucc.ie
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 4:20 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jeff King venit, vidit, dixit 01.07.2016 08:31:
>> On Thu, Jun 30, 2016 at 06:39:42PM +0200, Nguyễn Thái Ngọc Duy wrote:
>>
>>> Commit 76c61fb (log: decorate HEAD with branch name under
>>> --decorate=full, too - 2015-05-13) adds "HEAD -> branch" decoration to
>>> show current branch vs detached HEAD. The sign of whether HEAD is
>>> detached or not is "->" (vs ", "). It's too subtle for my poor
>>> eyes. If color is used, we can make the branch name's color the same
>>> as HEAD to visually emphasize that it's the current branch.
>>
>> Hmm. I think I like this, as it uses color to make the grouping between
>> HEAD and its referent more clear.
>>
>> We do already use colors to indicate "type", though. Which means:
>>
>>   1. The branch now uses the "symref" color. Probably OK, as that is the
>>      point of the grouping (I wonder if the "->" in the middle should
>>      match in color, too).
>>
>>   2. We used to color based on current_and_HEAD->type, but now that
>>      information isn't conveyed. However, can this really ever have been
>>      anything _except_ a branch?
>>
>> -Peff
>>
>
> So, I rechecked, and I'm afraid I don't like the proposal.


How about a middle ground: change color of the arrow (easier to catch
eyes) and leave the associated branch alone.

>
> Currently, we have a clear color code that colors refs according their
> type (local branch, remote branch, tag, symref). This also corresponds
> to status colors, for example.
>
> Under the proposal, a checked out branch would not be colored like a
> local branch - note that back then, the result of the discussion was:
>
> - If a branch foo is checked out, do not decorate by "foo", but amend
> the HEAD decoration with "foo" and a symbol that denotes the connection.
>
> So, "HEAD -> foo" is an intentional union of two decorations.
>
> I wouldn't mind changing the color of "- > foo" if it were just an
> addition to "HEAD", but it is not - it's the decoration by the local
> branch foo.
>
> With git branch, we use "*" as a symbol for the checked out branch...
>
> Michael



-- 
Duy
