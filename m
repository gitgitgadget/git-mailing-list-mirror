Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F23F1F576
	for <e@80x24.org>; Mon,  5 Feb 2018 10:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeBEKqZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 05:46:25 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50581 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeBEKqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 05:46:23 -0500
Received: by mail-wm0-f51.google.com with SMTP id f71so25160396wmf.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 02:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FxirBDAzpXLcIXQedWsTzuLF5cDHyU9AWXTJMtGsHOI=;
        b=V+yvfBzJ5nNP7YfklVC/FfR+2Krti8TwFv3FJRoLdf/4i2AejMUpbgHjNycr4A75G4
         wk2PrUvTCy6EFpwa65EWd3LLWqGsNEL8rzmFPOGFcqmClOIZUwAtSnaKJI8R+3LEVDPK
         FHz+AJNbljhuvogeTO9emfBAM6xWvgnVYGK92KHDbk4ZG/xjxEdSIc+RB7H1o2yq03VW
         JKGEjrRzXEd1XnFiC4Ndg9uD+phspBjNsx0hd5Ntr+6tlOnOEakv6mQeTkhc2CR3POoh
         CcmwY3xPL5B1BOGeNZWv8LX7eXjcSo6VF1Jancg7UyyiGZRSX4BxizPFMILvT7Z6Th8Y
         4yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FxirBDAzpXLcIXQedWsTzuLF5cDHyU9AWXTJMtGsHOI=;
        b=J0FlOelZrWKn9SLGTNZB3VrlLY0HKQ63PGnveEoGNl5JXFUX7zEKLjUKacaJ4Zf0HI
         B3eHCA0vgTs0ijouyUoEFxMDfZPguIjzfBWa4k2uUaRKKMxQpVEMFeD71E4wC9BqRrjj
         ads+1k9WQt9qh/eWpJ1VOeeksZAqhkwqpdwOMqi2D2HrBIpmDYT+e4+bpKtyzZyDya9g
         TkBiKqvXEzIOD87lDv5AiwkxglxaT9x65uRUow6QhsCFSNFuVV9TMX9Cy2BE1PsOMhkR
         tlH9QG382KfyVTu0BzLVYc3sR7+M2jnGD8xD7C3dUPpN9Jke2c63c70kM8SY5ac2e5J8
         9p4g==
X-Gm-Message-State: AKwxytfRoWaQ9t1Ku6XoJ8VfRmZLe7FaE4lGF4MlqfL0W2wI0FoGmleb
        SsyyFvz3lDRfZwx0KMTbRA0=
X-Google-Smtp-Source: AH8x225TQNecsKE+LcfmP0PWFJEyluWjlhyZB/oqljJoS/rQ2dsTjlOR2itVUwr0nQUxKT622WRqkQ==
X-Received: by 10.80.207.10 with SMTP id c10mr51498528edk.133.1517827582102;
        Mon, 05 Feb 2018 02:46:22 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id q6sm6867504edb.85.2018.02.05.02.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 02:46:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com> <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
Date:   Mon, 05 Feb 2018 11:46:20 +0100
Message-ID: <87y3k7lnnn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 31 2018, Eric Sunshine jotted:

> On Wed, Jan 31, 2018 at 6:05 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> This option is designed to be used by git-completion.bash. For many
>> simple cases, what we do in there is usually
>>
>>     __gitcomp "lots of completion options"
>>
>> which has to be manually updated when a new user-visible option is
>> added. With support from parse-options, we can write
>>
>>     __gitcomp "$(git command --git-completion-helper)"
>>
>> and get that list directly from the parser for free. Dangerous/Unpopular
>> options could be hidden with the new "NOCOMPLETE" flag.
>
> I wonder if this option should be named DANGEROUS rather than
> NOCOMPLETE to better reflect its intention. The reason I ask is that
> it is easy to imagine git-completion.bash some day growing a new
> configuration option to allow people to complete these "dangerous"
> options, as well, rather than us imposing, with no escape hatch, our
> idea of what should and should not complete.
>
> It's not uncommon for "bug reports" to be sent to the list stating
> that such-and-such option (say, --force) does not autocomplete. Our
> stock answer is "oh, that's a dangerous option, so you'll have to type
> it manually". If git-completion.bash gains new configuration to allow
> dangerous options, then our answer can become "oh, that's a dangerous
> option, if you really want it to complete, then enable
> GIT_COMPLETION_DANGEROUS" (or whatever).

I think we should just drop this idea of dangerous and complete things
like --force. On the same systems people use this on this will complete
--force:

    rm / --recurse --for<TAB>

So it's odd UI to be inconsistent with that. But if others disagree and
want to keep the current behavior I'd definitely turn the "complete
'dangerous'" option.
