Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227EE205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 17:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934903AbdAKRPa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 12:15:30 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:36832 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934888AbdAKRP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 12:15:29 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so67178650itd.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TE1J8DqTcS2hVz+t4kERHxmE++aSgEJ0qPSbYUYGFPs=;
        b=i/87hKtmxagza2s+/rngfEHoEKbi4pE4zvpXW4fFY1Gnh03ATyG7JxZXWu0UMvH1fD
         /a45QS/nKqPufiqg6iaNRkZlds2UiYJqxyES1kppWIKdutYnRmCZdIuEzwuThW9m6k3r
         ievFDQewpdtS+8kWs+ncsTN/0FVar0SXpEs61ZQWZ6t9/UsgB7UqSH7oiNQrEoiwl8m8
         /oOqPpdN2mHufR2P4d7SjufxVZ0SA8sB5uIM8eRVksTit4nRkP9W+MFknadr9kjvkyRn
         3p1HG5JuR5LbhDmGu2uraNwwbQsNXvlNTmPlylzh3iS1nW/HK0cw4cp7dTa/8fhPFs/b
         M2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TE1J8DqTcS2hVz+t4kERHxmE++aSgEJ0qPSbYUYGFPs=;
        b=cpa1FfcByGF7rwcf3PsLUlpjUHzxjG7H9MZBQ3dsA6Xip2lBS0gGwgrHptOx2uqNMY
         H2DqIBjTh+MbzXIkUvSmUhfia1FjgsUo9EdPtQhZ3ahh6FWvNA30De51wQVDpinxlVMr
         UJdjtF27U3RIcqwc6x1rNPql6eSooosotxR5IYh8iLhxGlOBNsN01H7FEKobq6P7aLjr
         KuVXjFSgdipL5po6722x/pGaTstovzoeLMgE/mdY2TtYAHfA+A8g8B17tcdBgfYc1O/4
         r+hKc9IkFQVYQ8rfO+g6SMdQUt8SbcPMMLGtY5bVQHmOKrlU30sCDncUfpDVUcnEKsmk
         EP0w==
X-Gm-Message-State: AIkVDXLwl4JFmlTgRFKTr3KJtyLKEJCRzr2+eCXfoQsSKcCp4aGq6OU0WFsHI5AE6TrwF50q3AyVOmTZJCqSLdC1
X-Received: by 10.36.169.12 with SMTP id r12mr9467557ite.69.1484154923504;
 Wed, 11 Jan 2017 09:15:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 11 Jan 2017 09:15:22 -0800 (PST)
In-Reply-To: <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net> <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net> <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Jan 2017 09:15:22 -0800
Message-ID: <CAGZ79kYVFbaMy1_-6qqe9zYQyktE2-7xu1Zz_qyeLWK=scgFKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 3:37 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 10, 2017 at 10:28:42AM -0800, Stefan Beller wrote:
>
>> > And then presumably that mix would gradually move to 100% consistency as
>> > more messages are translated. But the implicit question is: are there
>> > die() messages that should never be translated? I'm not sure.
>>
>> I would assume any plumbing command is not localizing?
>> Because in plumbing land, (easily scriptable) you may find
>> a grep on the output/stderr for a certain condition?
>
> That's the assumption I'm challenging. Certainly the behavior and
> certain aspects of the output of a plumbing command should remain the
> same over time. But error messages to stderr?

In an ideal world that assumption would hold true and any machine
readable information from the plumbing commands are on stdout and
nobody in their sane mind would ever try to parse stderr.

There is no easy way to check though except auditing all the code.
Having pointed out some string handling mistakes in the prior email,
my confidence is not high that plumbing commands are that strict about
separating useful machine output and errors for human consumption.

>
> It seems like they should be translated, because plumbing invoked on
> behalf of porcelain scripts is going to send its stderr directly to the
> user.

Well that could be solved, c.f. unpack-trees.c lines 15-55.

As another data point (coming from that area of strings):
If you grep for these plumbing strings in the project,
i.e.
$ git grep "would be overwritten by merge. Cannot merge"
$ git grep "not uptodate. Cannot merge."
...

you only find the occurrence in the  unpack-trees.c lines 15-55,
which means our test suite at least doesn't grep for error messages
but relies on the exit code of plumbing commands(?!)

>
>> To find a good example, "git grep die" giving me some food of though:
>>
>> die_errno(..) should always take a string marked up for translation,
>> because the errno string is translated?
>
> Yes, I would think die_errno() is a no-brainer for translation, since
> the strerror() will be translated.
>
>>     apply.c:                die(_("internal error"));
>>
>> That is funny, too. I think we should substitute that with
>>
>>     die("BUG: untranslated, but what went wrong instead")
>
> Yep. We did not consistently use "BUG:" in the early days. I would say
> that "BUG" lines do not need to be translated. The point is that nobody
> should ever see them, so it seems like there is little point in giving
> extra work to translators.
>
> -Peff
