Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82AF920401
	for <e@80x24.org>; Wed, 21 Jun 2017 15:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdFUPER (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 11:04:17 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34029 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdFUPEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 11:04:15 -0400
Received: by mail-lf0-f48.google.com with SMTP id l13so38460276lfl.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DsS2vMiVyKj9wN6cvhPCeD04p4Qvu4kzQE0kIzTu+g8=;
        b=M5J5lI16xvKP/KgCTAunIM8ahnEk7759FrSTNT/c70w9F+DsDWJbyZndJ3iDP03NUV
         nRyyeyhSSCU3atV4TDSEf8he7raapCLfIIyYMcE3LTm3rqc2pv8N2YfKeGliQyCeC+Dw
         TI4zc3E9EzRkg4HfNRNUsPsYYntc7pdbLh4KsGsnXqS+EVhiBiPLFuLzKtSeRuHNeDxG
         TvHEACm0ciNLKzcdKNXeY9BJsiVFt5//gQJnz5y4QeBN7x/868PPh8Mhm+D4WGPFHCeW
         BdEGgIER4HbwDrm8kFQ86670wcoggDT+3/CzJdADg76EcUh9WGiHBWqwdoz7sGLKnuTU
         cf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DsS2vMiVyKj9wN6cvhPCeD04p4Qvu4kzQE0kIzTu+g8=;
        b=NUqswpkjhnSD/7Dh5026u96eN/Rv8LeuRih+GC4r1SL4rQAsUgZ+dpVgBKdx0v5cNp
         2IM4f+xfn3pt69Ksh50xpgwF3E9BijDvbppuUrzvCBXHH8+hg465v2U8zxeq3PBIRhJD
         KOr9QgeGV2hYzq851OUpuWWD3ileqH482k6cBzt0hTilhbfVAGRCNPpczNV3EiZ/Gq88
         ApnP97CI6JMMfTFW725gf/gVZiDV3mVfBCKPZB3xKvE93LliW020vW3Z3uXAD+cQus5P
         41TBO4KVsotiZUf64TMmoEtXWRDe0ve2p7tr0jaZGO0y8aOdyN+pb+nj07yaghb5w8VR
         tTVQ==
X-Gm-Message-State: AKS2vOz/6l06z0+WtuK6MZXQqWj5Owqtw0rorRbpGIN+TSyOip4DOE0w
        WfLWhgEutV3yWxWtNQQ=
X-Received: by 10.80.148.72 with SMTP id q8mr25563315eda.174.1498057454066;
        Wed, 21 Jun 2017 08:04:14 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id t27sm8338733edh.1.2017.06.21.08.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 08:04:12 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNhAy-0005dI-8L; Wed, 21 Jun 2017 17:04:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Hutt <tdhutt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
Date:   Wed, 21 Jun 2017 17:04:12 +0200
Message-ID: <87efud8jrn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 21 2017, Tim Hutt jotted:

> Hi,
>
> Currently if you want to monitor a repository for changes there are
> three options:
>
> * Polling - run a script to check for updates every 60 seconds.
> * Server side hooks
> * Web hooks (on Github, Bitbucket etc.)
>
> Unfortunately for many (most?) cases server-side hooks and web hooks
> are not suitable. They require you to both have admin access to the
> repo and have a public server available to push updates to. That is a
> huge faff when all I want to do is run some local code when a repo is
> updated (e.g. play a sound).
>
> Currently people resort to polling
> (https://stackoverflow.com/a/5199111/265521) which is just ugly. I
> would like to propose that there should be a forth option that uses a
> persistent connection to monitor the repo. It would be used something
> like this:
>
>     git watch https://github.com/git/git.git
>
> or
>
>     git watch git@github.com:git/git.git
>
> It would then print simple messages to stdout. The complexity of what
> it prints is up for debate, - it could be something as simple as
> "PUSH\n", or it could include more information, e.g. JSON-encoded
> information about the commits. I'd be happy with just "PUSH\n" though.

Insofar as this could be implemented in some standard way in Git it's
likely to have a large overlap with the "protocol v2" that keeps coming
up here on-list. You might want to search for past threads discussing
that.

> In terms of implementation, the HTTP transport could use Server-Sent
> Events, and the SSH transport can pretty much do whatever so that
> should be easy.

In case you didn't know, any of the non-trivially sized git hosting
providers (e.g. github, gitlab) provide you access over ssh, but you
can't just run any arbitrary command, it's a tiny set of whitelisted
commands. See the "git-shell" manual page (github doesn't use that exact
software, but something similar).

But overall, it would be nice to have some rationale for this approach
other than that you think polling is ugly. There's a lot of advantages
to polling for something you don't need near-instantly, e.g. imagine how
many active connections a site like GitHub would need to handle if
something like this became widely used, that's in a lot of ways harder
to scale and load balance than just having clients that poll something
that's trivially cached as static content.
