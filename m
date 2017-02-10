Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710071FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdBJWbe (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:31:34 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35253 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdBJWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:31:33 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so1284759pfx.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+Cqj4ZVqj81R4hKq5c3Zzz4skUJ79E8ChICg/JL2lQY=;
        b=knpzYoDoZ24etY5mQ4tMCz2VuAHGZrSZ6WdPAjSBQ2F4/ZRCf2QUPgCxgU0qwtpbc+
         wAFFmtsU31miJ3Bd/7Z1cLLzAK4kqRjx95Ryu9NjPkQVV72xYWU3VKutW+8bEYT1GHQU
         min6Aha8pQog8xQs9tBfgKNCZOfqx30jqRjEBwPIUc+UfjwV7daK/Zx+twUin2VLLRdn
         BAu05GLmpMkWUpnygNeop634N0xNLnZdrtACiLGw9bsvTzeiJoCeUh1ViUhQ83oByZsv
         B3pEzscefjB6+bJwocRgcmSZRxyN8utS01Hdx2y25D54BRmkiV1q0hHQZ8ob8L6mNPmg
         KG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+Cqj4ZVqj81R4hKq5c3Zzz4skUJ79E8ChICg/JL2lQY=;
        b=ekJNmP/uZE70lFHPaXwz67ENskFrWno5tLhD4R1lypSxGDCfFVPjrrICJmeLUQncmd
         2iHzsqYEHIrlIeWjybZh14bPcf+6my/65vnIQfQNrfOXnPUYraG7dbKZELP572xx0Fn9
         hRnaChOj45IdJ0u+vpDYs1bv+WYF5GuLOxbI3//qt/yiFe55r+JrTi2AYFq8lNpWbe0j
         Ya/MCvyC8VHFpZYv7ediV2WrBk9z0iZDgk5DFO8C/ApjDHzxNPScVw02xOL//TC3dEgj
         MbvUKzz0c9B+BENizAq1crQBK/EwWhzastWChxJoy7M5uFMFhenObgv8zEPLN+cmZF+W
         5XKA==
X-Gm-Message-State: AMke39mJ5MsTS6Zm4p2aMorPtba70A+hun3DQlQrt2tFsZD8n54IImof39GaxiDPdZgs/w==
X-Received: by 10.99.247.83 with SMTP id f19mr13347276pgk.158.1486765892694;
        Fri, 10 Feb 2017 14:31:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id z70sm7479032pff.26.2017.02.10.14.31.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:31:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fuzzy patch application
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
        <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
        <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
        <20170210214850.2ok62xdmemgotwnt@sigill.intra.peff.net>
Date:   Fri, 10 Feb 2017 14:31:31 -0800
In-Reply-To: <20170210214850.2ok62xdmemgotwnt@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 10 Feb 2017 16:48:51 -0500")
Message-ID: <xmqqy3xdisos.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I dunno. I always use it, but I'm not sure if there are any downsides,
> aside from a little extra processing time. It does have some
> incompatibilities with other options. And I think it kicks in rename
> detection (but I might be mis-remembering another feature). That could
> be surprising, I guess.
>
> The original dates all the way back to 47f0b6d5d (Fall back to three-way
> merge when applying a patch., 2005-10-06), but I don't see any rationale
> for not making it the default. Junio probably could give a better
> answer.

Nothing deep.  Just being cautious by not to enable extra frills by
default, making it strictly o-p-t i-n.  As that was a strict fall
back (i.e. there was no "if we are going to fall back, we need to
spend extra cycles to do this extra preparation before we attempt
the regular application"), extra-processing cost was not a concern,
at least back I wrote it the first time.  I do not offhand know if
that still holds in the current one that was rewritten in C.

Making "am -3" default may also scare users who are not exactly
comfortable with reading "git diff" output during a conflicted merge
and resolving a conflict, but other than that there shouldn't be any
downside.

