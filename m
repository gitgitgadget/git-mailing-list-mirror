Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7891D1F576
	for <e@80x24.org>; Thu, 25 Jan 2018 11:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeAYLEM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 06:04:12 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:46157 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeAYLEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 06:04:10 -0500
Received: by mail-it0-f47.google.com with SMTP id c16so8800565itc.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CFIzNnQ9Q5t0kYttvxfm1bQKVBNDxRq5PaDHHQRs1dY=;
        b=qVlfRbYfGvP27L3UrKXhh+mulb2UmCpnq7cwdfvW12QYmplpedOn7ssQ8T2qpzeee2
         1bbLbaC4HGbbcnTVi+AScdnc1m7b+zKg+VALoFO8W+FCL/lg4lHjia2xbQ/U3e02PHzo
         CsIy2ojs0mFysj3psrNZTLdMkXS1lXo5RxDNO/Vpw212UhPkby97Db414DrvXTcbmlHX
         zSi5JoA146rlC868E4zfzsjBD36SlbytPWBUsRERnqHLZytwn2VVLoeYNhSCc9hMTKnr
         y914TIo5wAH8JEizsB6BPAoP1tbZ738P5vVHLcoVkp+k1yFKJHIu3c6zJ8F7qVklbwcJ
         9diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CFIzNnQ9Q5t0kYttvxfm1bQKVBNDxRq5PaDHHQRs1dY=;
        b=mAqOHBzCvR6dra2G21y+8MKchO0YcbTUsm4DH3zZVoWOdtY5/KWxQ8dyBehJV5p2RB
         vZi8L+2PBAR4AUmWjeYxBIDEdyuFt0tmS2tlTIpGqGPGT0Mmydxf0bj5aZdwPV5C62ei
         NkZCPy3wj3AK7Hi0DcblC3MoVk9NllugXFcPo7p0Bfjk0I/DTdlqwB3nZxMzYbc8GUZ2
         KpAQm2AG26F+mw4yIlh9VSICnutgs4uCcXgwvPCY8FKI/Wf4WIihRcFOhyxdm9djMxea
         0aPtK30sjorA1E6crxk5JSdOb8HUPkxGsmMbCqkz1MQcj70BL3lGG2WPAYpIpxPwzdLz
         NxgQ==
X-Gm-Message-State: AKwxytfNPorOHO3W7F8f/wst1Jxgsfsx+1whVLbjzHBL+AVZBEAJip/D
        QIKx8CfWtHz7xX55O2CisFSNX2aFjx93nllxvn0=
X-Google-Smtp-Source: AH8x224PKALFvm1GK7nSGGKDsGQBisy5NjfQ9y0GAvsWkSPlrEEtwZ/kh9m8YAJQoZ0kguqVEeq8jyzHrxuJqOlF8yo=
X-Received: by 10.36.110.85 with SMTP id w82mr12831291itc.118.1516878250128;
 Thu, 25 Jan 2018 03:04:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.38.140 with HTTP; Thu, 25 Jan 2018 03:04:09 -0800 (PST)
In-Reply-To: <25ce5341-1200-c54c-eb69-eccfcc088155@gmail.com>
References: <CAPUT4mS+p+2n85dB-iWtae+0SDkUoYA5bqtUs+6OaFchjJJeuA@mail.gmail.com>
 <25ce5341-1200-c54c-eb69-eccfcc088155@gmail.com>
From:   Dimitriy <dimitriy.ryazantcev@gmail.com>
Date:   Thu, 25 Jan 2018 13:04:09 +0200
Message-ID: <CAPUT4mTsJUd6uQRWVDwooEr4QeQa2=n1bdeJUUt3KXrT-tRDRg@mail.gmail.com>
Subject: Re: [BUG] git pull with pull.rebase and rebase.autoStash is not
 working anymore in 2.16
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah it seems like this bug. Thank you for sharing this with me.
-- 
Sincerely,
Dimitriy Ryazantcev

> Could this be the same one as reported as Git for Windows issue
> #1437[1] ("`git status` reports (non-existent) modifications after
> `git stash push`", 2018-01-20), fixed in Git for Windows v2.16.1...?
>
> Care to try it out? :)
>
> Regards, Buga
>
> [1] https://github.com/git-for-windows/git/issues/1437
