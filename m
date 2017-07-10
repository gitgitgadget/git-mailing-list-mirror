Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118B620357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbdGJWmR (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:42:17 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35753 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754106AbdGJWmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:42:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so14294748pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FXcdbpJ/QmkQSHAXAjLGldu6VRPhbeD968BAVX2+Ybs=;
        b=EV10+oHK1D2piqn1CqcRg9hdGGOabENnS6XuUKyJj6oLOkm5hW/EnvAOlcAWr7i5D7
         u3YRY1P8eF1/AIMGV6XbhpXe+KA8hk99Hwndivudew8z6fiFtI+s4YqWgCWr9we0S5i0
         dRbj+99ldQDvnUPnLGQ1lJ21T8eNPZtrlhdNL6kUHgKSeKx4nTJ3RiyF3rDDW8Vgzq68
         nU3pS2IevbxLOk9wEeQBfEC2TbyGYoBZpyEXN93FFmQ9P0Uz3Kt8yrokeoeMgM2BE4xj
         g7u7jI+VQtHjTNkwln5GUlkWhAQDzDW5MZ6T1LHU75KVBs4ltrZb3B6b++BQlBBOC/fA
         rZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FXcdbpJ/QmkQSHAXAjLGldu6VRPhbeD968BAVX2+Ybs=;
        b=q8S14KAhYqI/yiKRayrCma8wV7ySowmIOaENf9tCAtGex5nqiwp33JR4g2BmGMdkAG
         9jh+bsb2Z9ypOGdoerbSIAls7ae1m1EQTc9cP+DKXXyNshWfTumv8z6gsGlnMdNdzAAI
         hptnES/ZxJAWfn4koF5GZeOGazN9L9L3VWWCIjVRMOYFjmjlr9C9ZnNY1ki3Sc8+uazt
         23Jwz9O/99/RA0c+G36dTZ3Sx/wyh/crB7raPDYWqVejGiJknTkEbTpno1eyAG2Qo+XP
         5AWHOjNko/ZZiClef3AZRlURRIpaxhsxIjjvzaYPXRnrg07jmD5LCCVy4Uz7TBxaUsDz
         XhSw==
X-Gm-Message-State: AIVw111m0Nf3hHgQfjUh+DxT2qUpMb1mIefo388CTE4eVFlZUfY9FLoX
        9mIpyj+SiSby0Y8SIUk=
X-Received: by 10.98.141.23 with SMTP id z23mr46926073pfd.34.1499726536011;
        Mon, 10 Jul 2017 15:42:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id s15sm25086065pgo.48.2017.07.10.15.42.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:42:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
References: <cover.1499723297.git.martin.agren@gmail.com>
Date:   Mon, 10 Jul 2017 15:42:14 -0700
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 10 Jul 2017 23:55:13 +0200")
Message-ID: <xmqqpod752yh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Using, e.g., `git -c pager.tag tag -a new-tag` results in errors
> such as "Vim: Warning: Output is not to a terminal" and a garbled
> terminal. A user who makes use of `git tag -a` and `git tag -l`
> will probably choose not to configure `pager.tag` or to set it to
> "no", so that `git tag -a` will actually work, at the cost of not
> getting the pager with `git tag -l`.
>
> In the discussion at [1], it was brought up that 1) the individual
> builtins should be in charge of setting up the paging (as opposed
> to git.c which has no knowledge about what the command is about to
> do) and that 2) there could then be a configuration
> `pager.tag.list` to address the specific problem of `git tag`.
>
> This is an attempt to implement something like that. I decided to
> let `pager.tag.list` fall back to `pager.tag` before falling back
> to "on". The default for `pager.tag` is still "off". I can see how
> that might seem confusing. However, my argument is that it would
> be awkward for `git tag -l` to ignore `pager.tag` -- we are after
> all running a subcommand of `git tag`. Also, this avoids a
> regression for someone who has set `pager.tag` and uses `git tag
> -l`.
>
> I am not moving all builtins to handling the pager on their own,
> but instead introduce a flag IGNORE_PAGER_CONFIG and use it only
> with the tag builtin. That means there's another flag to reason
> about, but it avoids moving all builtins to handling the paging
> themselves just to make one of them do something more "clever".

All of the above smells like taking us in a sensible direction.  I
agree with these design decisions described in the above, i.e.
'pager.tag.list falling back to pager.tag', making this an opt-in to
make code transition easier.

Even though it is purely internal thing, IGNORE_PAGER_CONFIG
probably is a bit confusion-inducing name.  After all, the
subcommand specific configuration is not being ignored---we are
merely delaying our reaction to it---instead of acting on it inside
git.c without giving the subcommand a chance to make a decision, we
are still letting (and we do expect) the subcommand to react to it.

But that is a fairly minor thing we can fix.

> A review would be much appreciated. Comments on the way I
> structured the series would be just as welcome as ones on the
> final result.

I see you CC'ed Peff who's passionate in this area, so these patches
are in good hands already ;-) I briefly skimmed your patches myself,
and did not spot anything glaringly wrong.

Thanks.
