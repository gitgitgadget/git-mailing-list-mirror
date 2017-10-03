Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377F320365
	for <e@80x24.org>; Tue,  3 Oct 2017 09:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdJCJTW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 05:19:22 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:46715 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdJCJTV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 05:19:21 -0400
Received: by mail-wr0-f179.google.com with SMTP id t76so5624728wrc.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A5pUnsZNTevZozxb4zVCQ28zdTvNLJEKc4JJoJ4USRw=;
        b=DXfKo47lJRcR/6n5wX+0rl8vLtiWGrACpb51RCBwkanM3dPiODOtRrggq+IcKR0xNA
         zzcC6r0PJlR1SES3cl7OmDUEyzEhHu645ZwLCy3pEY4WW32VlzmSjYo8zVu4GRp7EpSv
         jQcN1NLV+0Tqt5SgkgsIWf7ckBJrHYur6t5iFrJ4nxvCLb6mY3LBszDLp3XsgAZ+aNIf
         VALbNEg+o5hzXjvml17qHGSrCcKrvoPM2gOWLRvv8alyZhGLMVy8Ho9NhEcBn9VqEyaH
         YnPGYO/PXLRvYlr2jLz4W0EWGHhWBs5CfEwAssWgdUvcOEzNLrwAjDl1pxJ5+5PMBC5t
         4JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A5pUnsZNTevZozxb4zVCQ28zdTvNLJEKc4JJoJ4USRw=;
        b=m0Wl3O5Puqi1jtr3cWKGPJtR9uwJDX1M4ph3mOa7WqI4cGMrRVquVH+LntrPe4xOue
         iAYP5raz2jVZNKSfFXUDgnWs08JAIQWxlrN3teRyvQFtzUaGW6Jswkz7/FODiX+oQo7+
         LvbGVfhnARjIHzIsYE0CiCZDm4vbGEJgYbjytjSGorHxjFCh+k9rwUd3Kv8+uDLTK4SG
         iee/u+hrmNx6sicneuB4jOHaa5mGFbsrFzZlTLUIv29tMCgEJLvSbwsyBlxcoLJtMBhp
         jXX/T6n5eXxkivlM8N4kCK4rLrrBVAbSL0zKX6/d35ZcFKVFypc3cS9d9wsvOXo+Fa3L
         81Hg==
X-Gm-Message-State: AHPjjUiiqdIHXd9UXIqolyB7sXYSQQ7YafmP5sNdJg9ZlZ8CLzy9WGYI
        zRiUIMNtsCFhIPqxnXsMKsOnPiCb8orXHmpxizQ=
X-Google-Smtp-Source: AOwi7QDFz/FuErrBbL4iSxOivBn9nMxVHj1FAxwHnAZNP98Pf3j3bOAgQ8IrTsISkmz7qeegLs00C9vhmcT1GwMoZAM=
X-Received: by 10.223.186.140 with SMTP id p12mr16468602wrg.235.1507022359825;
 Tue, 03 Oct 2017 02:19:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.165.129 with HTTP; Tue, 3 Oct 2017 02:18:59 -0700 (PDT)
In-Reply-To: <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20171002230017.GT19555@aiede.mtv.corp.google.com> <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com> <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
 <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com> <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
 <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com> <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
 <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com> <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
From:   Tsvi Mostovicz <ttmost@gmail.com>
Date:   Tue, 3 Oct 2017 12:18:59 +0300
Message-ID: <CAB2yay-0Z6xsL6Sp-428UHmxaUnMHObT8qb-UFG1TcMu_E8gPg@mail.gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I also don't remember why I set it, and as such I removed it.

A helpful hint as to a bad config option would've been great.
Something along the lines of "The use of color.ui = always is not
recommended", with a flag allowing you to disable said warning.

Thanks,

Tsvi
Tsvi Mostovicz
ttmost@gmail.com
www.linkedin.com/in/tsvim


On Tue, Oct 3, 2017 at 12:10 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 03, 2017 at 05:56:53PM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > Note that I'm arguing that it's a foot-gun even without scripts in the
>> > picture at all. Forget about plumbing versus porcelain. If you set
>> > color.ui to "always", you're going to get unexpected and confusing
>> > results from time to time.
>>
>> Really?
>>
>> I would think you would consistently get ANSI colored output in any
>> medium, even in files that you would later "cat" or "less -R" to
>> view.  Is that unexpected?  Those who set "always" (I am not among
>> them, of course) would expect that, I would think.
>
> Those cases might be expected. But color when piping to grep or sed are
> not. I guess you can lump those under "well, they should be using
> plumbing, of course" but I don't think that's very realistic. People do
> ad-hoc pipes in their shells all the time (well, I assume so; I
> certainly do).
>
> I don't argue that people don't have a need to write colors to a
> non-terminal. Certainly they do. I argue that setting it in your on-disk
> config is likely to have it trigger at other times when it's unexpected
> and inconvenient.
>
> I dunno. Maybe I am wrong, because certainly I never set it. We've had
> two reports on the list since v2.14.2. The motivation for the first was
> "I have no idea why I set that, and I'll switch to auto". This is the
> second.
>
> -Peff
