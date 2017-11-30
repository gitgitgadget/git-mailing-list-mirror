Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E731420C11
	for <e@80x24.org>; Thu, 30 Nov 2017 23:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbdK3Xps (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 18:45:48 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40466 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdK3Xpq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 18:45:46 -0500
Received: by mail-vk0-f67.google.com with SMTP id w190so4526454vkd.7
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 15:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JcBz5bLUZVhfl5AdTJqzsc7boMtDN01BGna5s7QAvYM=;
        b=QtjtUgcdMXanX28AKMdwFaa4w9IAI6nE3qvY1eB8WCV15L1xyTv5BwTfM0X/u33bz3
         Y1RFdpKs0BCz5CDPKXG7Ro2b6rD0mH1PVwH+e+rxxhqVCGfDdtLGE8Bw4OpeToCeyyMi
         VMUrkIwjRimzQtPv55BMOkxYaSMAc8Hz3S3PFMptCtKNo0ZFUgFbVxY/UXIvzRShG+/0
         DHDvtHJzdnZFDm1RhB2jnP7MKi/0aVCAokUUMDI8wZS5rzXk7K3+7higx68DmI8RTszJ
         Hg0SDvvV24TXsEO/i/yPyAbiaYSs7beDv9aTx9wRSH6eOdBA8lKP5SF2ON/6wZmOMsA5
         Tk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JcBz5bLUZVhfl5AdTJqzsc7boMtDN01BGna5s7QAvYM=;
        b=hgnxlss3qOwaA77qVdfJRS3Kj5OOzVEg5do5ijA8a0jxwnGP0Jzn/1cTN3yV1pq7AA
         853fpEf2atsbCI8D4ezyhh9TDxz79oYvGucuh322YqKF5ScpT+RVANc5q4ZgmckcGR2/
         w2zaT1AoxcMNyxyPK8tXNPmctFo7KWf+38+D4tqtoGSWn2DZ/mYAptd0n4Wh1f96G008
         ztVD1VzpGB3ihIYqt/2Y6HAMnRMUGIsMeKeVdNcv57yEoISpPesSk2WJ6WeBPn7jWbvl
         ySeKTYXl3zz+zO251AuwlxincQHvob8FktqGne56jMiBBxpnV+K0uy77vGjgHUkOnubM
         hjmQ==
X-Gm-Message-State: AKGB3mJptx0azKMyIQVGblKvSWbA5Tc0yX7/32MgwlH8yce6WnYMsJIi
        T/uWcPf5GQ8K1oy218fTs/YQj3/Mv+CR8r24ypQ=
X-Google-Smtp-Source: AGs4zMaQ2uk4bKbKcGW1LVeCPKApoSc3DehcupS27RZ4N+z9SZD/31mCGmsu5bBDMOpUvmvtkFQRAVgddNKmSldACFk=
X-Received: by 10.31.9.147 with SMTP id 141mr3297060vkj.119.1512085546090;
 Thu, 30 Nov 2017 15:45:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Thu, 30 Nov 2017 15:45:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1711300250320.6482@virtualbox>
References: <20171130010811.17369-1-szeder.dev@gmail.com> <alpine.DEB.2.21.1.1711300250320.6482@virtualbox>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 1 Dec 2017 00:45:45 +0100
Message-ID: <CAM0VKjnpUNhMJk6wk1prtvr2SjOuhMLKWQ7zf8S6w-0yfD5WcQ@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: fix reading files with windows line endings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Robert Abel <rabel@robertabel.eu>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 2:51 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 30 Nov 2017, SZEDER G=C3=A1bor wrote:
>
>> > > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/g=
it-prompt.sh
>> > > index c6cbef38c2..71a64e7959 100644
>> > > --- a/contrib/completion/git-prompt.sh
>> > > +++ b/contrib/completion/git-prompt.sh
>> > > @@ -282,7 +282,7 @@ __git_eread ()
>> > >  {
>> > >   local f=3D"$1"
>> > >   shift
>> > > - test -r "$f" && read "$@" <"$f"
>> > > + test -r "$f" && read "$@" <"$f" && export $@=3D"${!@%$'\r'}"
>>
>> I don't think that export is necessary here.
>>
>> > As far as I understand, $'\r' is a Bash-only construct, and this file
>> > (git-prompt.sh) is targeting other Unix shells, too.
>>
>> The only other shell the prompt (and completion) script is targeting
>> is ZSH, and ZSH understands this construct.  We already use this
>> construct to set IFS in several places in both scripts for a long
>> time, so it should be fine here, too.
>
> That's good to know! I should have `git grep`ped...
>
> Sorry for the noise,

No, no, your concern is justified, you just happened to pick the wrong
construct :)

It's the ${!var} indirect expansion construct that ZSH doesn't know, it
uses a different syntax for that.


G=C3=A1bor
