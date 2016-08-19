Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C061F859
	for <e@80x24.org>; Fri, 19 Aug 2016 16:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbcHSQ4j (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 12:56:39 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34481 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754103AbcHSQ4h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 12:56:37 -0400
Received: by mail-io0-f181.google.com with SMTP id q83so54125602iod.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bFRZGQItOI1IFpMP7JyieJ5PVKJiQIc1BGtqgKJW7tw=;
        b=Rgcs0pHj5tdVfCmuR8DsKD5S+fTceiKRyamB0FN269Gpdrg4pa6CXZ+lcUhSJJG/wr
         kQKxaOOKgRABIy7lznGB5hw6yaemyBcNCyhwzc3+ZOVgYyOqaT4hBEt/sjIXAxgNUy4m
         eZi0BO3oGw4Jjw0OgG/EFEfRRD3BkPOMKN8luKsR8oJqZmnqo4bAN8eq3IJwPQsmVTOa
         U/Ui/ZbbXGksesidFxeFGOxG0qi+obX7VvN9EDtGsnUP9Bzrdn4BWY8IViUyTie+Tk9o
         50lXM8oLyZhy5i8G5nIS1glnN64/AZHqdoQi+EMbTpggAb3wpeTkujxteRJ/tLpE8JWJ
         RNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bFRZGQItOI1IFpMP7JyieJ5PVKJiQIc1BGtqgKJW7tw=;
        b=jIMzBMCx0iqzldwgcY3mNGz2la8RsRdVJ6QgldMtls6oYuJcdTdSb1Dp6TS+FPP4yZ
         cfAhMJbHcVogrweMDcwCDE+t8FBON2lFrs/QLtffs9ePevzxxwIsVrWoG9Rk0eNOm01q
         09RHV0WyEo32GUIiMd4/N75BnMJWDamFbpISbQul9H4/2QkB6ByeuLTWJI/E/+501wZU
         COlzAAl3pr+r8p/QVQrDh7oNn8eLTv7ja954/PkXqdbFFZAFnbYhRzE0Rxao9FAD+PF1
         pvfoD65/Jhgn9sgOs7mHSmjVBF3OBwXJkjqxalwng7zT+YvugaYVQBqzFSVCQLn4eiw/
         Pg6A==
X-Gm-Message-State: AEkoouv7nsGttsfV18dVzyKldxcBWPc469lZ8PsnELqWtusBGXCaeczXIuHIe7OX0GrBAg9itpXwVABOr4MO3DTy
X-Received: by 10.107.178.129 with SMTP id b123mr11354255iof.83.1471625755262;
 Fri, 19 Aug 2016 09:55:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 19 Aug 2016 09:55:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608191720040.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Aug 2016 09:55:54 -0700
Message-ID: <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Wong <e@80x24.org>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was not my intend to start this discussion again with my initial email.
I rather wanted to point out how I make progress in doing my own
tooling.

I mean if email works well for Junio (both as a maintainer as
well as a contributor) and Jeff as a contributor, then I can adapt
my workflow to that, because these two have brought in
8300 of 33000 non merge patches. (i.e. they had 25% of the
patches over the life time of the project and are with the project
longer than others IIUC). So why would I demand they change
their style just to accommodate one newcomer like me?

>
>> I see a choice of mail client as no different than a choice of
>> text editor.  Neither my mail client or text editor is heavily
>> customized.  The key feature I rely on from both tools is piping
>> data to external commands.
>
> There you go. That key feature seems to be unavailable in the most
> wide-spread email client: Outlook. So by not restricting the choice you
> should make it possible to use that mail client, too, right?

Well I think this data piping is essential to any workflow. Even if were to
abandon email completely and roll our own communications protocol,
one of the first things added would be an API to "use your own text editor".

In my case git-send-email works well for the sending direction without a lot
of custom tooling (read: none apart from the initial configuration).

>
> We do not even have a section on Outlook in our SubmittingPatches.

"You can write one? Pretty please?"
would be the canonical answer. ;)

>
> Okay, if not the most popular mail client, then web mail? Nope, nope,
> nope. No piping *at all* to external commands from there.
>
> So you basically slam the door shut on the vast majority of email users.
>
> That is not leaving much choice to the users in my book.
>
>> OTOH, today, I see people using git aliases all the time which
>> look more like ASM instructions than user commands.
>
> I see this as a completely different beast. Aliases help users accelerate
> their personal workflow. Whereas anybody who is already willing to
> contribute to Git *must* go through that non-personal workflow we impose:
> paste the diff in a very specific format into the mail, and don't you dare
> use a mail client that mangles whitespace (which is, like, pretty much
> every single popular mail client out there).

Maybe we should invent a patch format that copes with broken whitespace?
(git-format-patch --allow-broken-whitespace), e.g. replace a tab by
"-_______" (not exactly 8 chars, but stopping at the columns 8, 16, 24 etc)
git am/apply would need to know about the unbreaking the white space, too.

>
> So *allowing* users to configure their own aliases, and *forcing* them to
> figure out how to transport patches through a medium hostile to patches,
> is pretty much two diametrically opposed things.

I think the point was that people carelessly expose their aliases in e.g. their
blogs. (e.g. "to do <foo> you just need to git a <file> &&git ci &&
git rr", which
leaves others just guessing? It certainly feels similar to not knowing how to
configure your email client?)

>
>> Users ought to be able to pick, choose, and replace tools as
>> they wish as long as an interchange format remains stable
>> and widely-supported.
>
> Right. Let's talk about the interchange format called mails, for the data
> called patches. Is it stable and widely-supported?

It is stable as it has been around for years and you can choose whether you
use git apply or the patch utility. It is widely supported as it is raw text so
it can be used across different platforms. However it doesn't cope well with
email, as email modifies text sometimes such as mangling white spaces.

>
> Can users really pick and choose the tools they like most to send patches
> to the Git project? Like, the Outlook client? Or the GMail client?

Of course, see[1] ;)
[1] https://public-inbox.org/git/CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com/

Thanks,
Stefan
