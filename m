Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD741FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 11:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbcLILdl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 06:33:41 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:32848 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbcLILdk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 06:33:40 -0500
Received: by mail-io0-f172.google.com with SMTP id d9so51323934ioe.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 03:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2EabwVJpbMs8WR1lnXC5kXO4I1SR1dJI8Opr87kB2XQ=;
        b=YiV3MhS4AwhuZ2AF3pDIAYhKQkafruB4Q6UVe5ykPfVI1URubgMY3hoXnVNZyOp4Wb
         r+RQbD16RcJSTS0G9tX+X5J1VX6CZgAUxTCTYkgSLvXjYlXwnaenIj3/fKSk7NNEIGe/
         6Emk89HZu3436T0ixC2aqAbPg1xy84UWO3YgghOzMeUsMZ4mzyBt3GPCHQTHxRQkhDch
         5L61NrLbLWh6dXxd1SgRw/tdZxFZleNiqZS3K2vXiVkLCHTS/KK2jYdwxtVICnNqr3t1
         +FadFYr17eXlXCxsyURtpOWPRy8+oB0hBEnxlu0m7P+g++JBSzj6zwB9KzccoP4Fdwjn
         qH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2EabwVJpbMs8WR1lnXC5kXO4I1SR1dJI8Opr87kB2XQ=;
        b=TQLJxYy9iJ3/vTqV09Ul0ifvkKhdFHSYu3eT/BRVL7n6A8EpIf07X9HeVWwd/2ciyi
         PfqV2B7XpChM/D4B4uC1oF8Rcz60Ty+5w2riNh9YZ4cY63WnqpYbEMGZj0DmTfGPaKxh
         fKF+QxcC+PAjWtagZhv2+d/d5a5S0Gh4T1Slhw798Ej5kMhFs9FBwjcHHVMGOXA28j2U
         brBrhXNLqssA0J5CdXvm4Wz6VklTc+eSunA6bnj3GqR8aHwfMDokNgZvHDNMupMyyn6y
         ftC1Sh8F793w2O4pT32+o5XBuTfMIDISTA5/zOX1pGC7lp+O0XOc8BESMJ7vF3BlPtuS
         r96w==
X-Gm-Message-State: AKaTC00FZeARuQt3n/clcWQ3fI7b3d+OV2giFAcdVBzvsjq2cC7UVF4D2w2pV9byT6/ibBMtvSGhFuc9GDaq8Q==
X-Received: by 10.36.184.194 with SMTP id m185mr6189319ite.3.1481283219518;
 Fri, 09 Dec 2016 03:33:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 03:33:08 -0800 (PST)
In-Reply-To: <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com> <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
 <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 18:33:08 +0700
Message-ID: <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 3:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
>
>> [1] By the way: git cherry-pick --quit, git rebase --forget ...
>> different wording for the same thing makes things unintuitive.
>
> It is not too late to STOP "--forget" from getting added to "rebase"
> and give it a better name.

Having the same operation with different names only increases git
reputation of bad/inconsistent UI. Either forget is renamed to quit,
or vice versa. I prefer forget, but the decision is yours and the
community's. So I'm sending two patches to rename in either direction.
You can pick one.
-- 
Duy
