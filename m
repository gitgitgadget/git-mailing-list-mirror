Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCF92095E
	for <e@80x24.org>; Sat, 25 Mar 2017 12:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdCYMIB (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 08:08:01 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:34316 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdCYMIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 08:08:00 -0400
Received: by mail-ot0-f175.google.com with SMTP id a5so7634469oth.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kfJEqE1MxNf8MsRsK7j3QJFGSvCOiCLfT12LTX5GHUA=;
        b=JDINCFc5kADdVaopnsbBjf2TlTgQLWvo+sOBi3fouQ+O38QwGNXl0Z+83Y8u9XxJL7
         rztBBYYyi2hKborR0S2pNoPuyVKm5S5XwMg9oIkpU3bwN5REn0JDHtF8Cqp4FgY6tKY3
         To5fp6nzNrm9qQZal0ai4PuDZWtu2yF3xO/DqFZbM0YnC9WpsCcgpZdKC8txr3pC/ZIN
         x5NxcmZi2LK3rKjvPX2O/104j96k85htOJ145MACGTuZLbmhqRlS8N2WauYFNA0i+e/5
         bZj9QORAlJZ/Q1MzL6RiivVen72P+jgZhQt3d2fJI/8oZ3LyJxo870CxMlN42+PtVh4G
         Vvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kfJEqE1MxNf8MsRsK7j3QJFGSvCOiCLfT12LTX5GHUA=;
        b=lYkyQJeEdacDIppKXlZseuSCrBWdTC8sSigDhMCr4U7Y11HdPFcsf7DqTlqomFCIXU
         yIkcxIAsg/sRxx8AI7PSfk5d3rGY5kaM/bUHVpYa4XxpKImoO8PcuE8cKeMPALeWrqP/
         3FUj8skQigI8VtBqWAsnGWaghuoCO5KTm3clojyAmSk9Cbv+Ekp5iUriVtX1WQYyquPw
         PC0n5MErNvLoB8OOt65LHSy8VE9GiJ+7tHteVhGSxeUdjNy1ZcT371ktazMjMdmg5Au7
         4rot9Q0kwFZpfTLIQXm7QBUHb/gPr4W2grDKtIBwZhnaeC1sA/AC4ISs7Us1SqJ5Lonv
         tSRQ==
X-Gm-Message-State: AFeK/H259cVS6HAXRLY2sFMgsz52j58s2pV+VJx2R3RUdIxVkMWo87A2gWHORt4qNPN6OkTGoiVZIr2bIH2xjw==
X-Received: by 10.157.46.10 with SMTP id q10mr7679603otb.28.1490443679225;
 Sat, 25 Mar 2017 05:07:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 05:07:28 -0700 (PDT)
In-Reply-To: <xmqqd1d7ev2q.fsf@gitster.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com> <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com> <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
 <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com> <3c16aea8-be53-ef41-d43f-7b4e8ca15d7d@drmicha.warpmail.net>
 <xmqqd1d7ev2q.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 19:07:28 +0700
Message-ID: <CACsJy8BNYmYarZqnERhsO8LDxdsMsviUMs3Co6C4Ed7W9OvDJQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Are we at a point where we can still rename the new feature at least? If
>> yes, and keeping everything else is mandatory, than "workspace" or
>> "working space" may be a serious contender for naming the new thing.
>
> I do not have a good answer to the first question, but workspace
> does sound like a good name for what this feature is trying to
> achieve.
>

Now is not too late to rename the command from worktree to workspace
(and keep "worktree" as an alias that will be eventually deleted).
Should we do it? I would keep file names, function names... unchanged
though, not worth the amount of new conflicts.
-- 
Duy
