Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6FD20248
	for <e@80x24.org>; Wed, 20 Mar 2019 22:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCTWfw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 18:35:52 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37388 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCTWfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 18:35:52 -0400
Received: by mail-ed1-f52.google.com with SMTP id v21so3426839edq.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9slfhfKJHkPSVa4v6xXsH8D/6oIdabL4vdcV1PXhcao=;
        b=uSfU6u+KDDRLajzxHH72podDXrLT5Rr9tvYQglDhPxH+Zck78cSfurIIp/MOe30gGJ
         YwEOQgcTTsCrUNBYHPxrIm/dfMqC3+1hBqNYEeKfHyHtbpRTYprddHlA3tfiSudHue+i
         XwKVzAypMGO0LmoN6Bvmh6nr8eH0Q9+ko4e1WVSUSopXyAcVI/U6TpUKr1R5fbrO/jZR
         upKvrv/A+fWxw3RnlAW6VhJSWgtf85xujyxwxfc9zlPkuvUu2uyoPVgP/QlFSPH65ug1
         /pU1Uf/8SDknpIWcBHOiuvtSDi1ECSKplS4XJvFiHyU8ksEp1w9v/p3zmbNAUFiHSiov
         jXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9slfhfKJHkPSVa4v6xXsH8D/6oIdabL4vdcV1PXhcao=;
        b=X0UP3E9jxhZMB8/3zponr0PB+lunD1P1qwjltzl0fNSinliefk6lJH748X9b48xpMO
         w8aJqRqJCbo2vi5jhMRkDHxPmDhzveMp0rjoTlva1GPx8/HfhToxV5uL6879/mmL/l07
         ECeZMqwetoEsIDjjfOUF2nE9X1zORaENFI7RT2RABbQN/FAHxLykOt4QafOsq3Xlj+WT
         HvWpDtFSkJuiFhO2bS4JU8ejfTMBmtAS85ZDA+aSBPFQtwrjSAxtl4CVznUNJ9E6AIt3
         0EAQSXQuDZyC4g/n1QDD4YY+/20DWgYNmxStOpp7dhfX+esKqDoIKONwrXDt5g9VSzPj
         Kjdg==
X-Gm-Message-State: APjAAAXud1DWpgpSpiovhYhGHY2FvcNnInqNGtRD88GjI6ae1KsLlRBD
        BjHEtKl0H5SIrSgI4Q7kl9h2d5xZ
X-Google-Smtp-Source: APXvYqxhTe0uuUES68w00n0gJyUmD9sbSJv/RWfeDcQxlgLjRYbehhQxXv9TWv1A0psbynpRKehqxw==
X-Received: by 2002:a17:906:905:: with SMTP id i5mr343537ejd.23.1553121350107;
        Wed, 20 Mar 2019 15:35:50 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l26sm642836eja.29.2019.03.20.15.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:35:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     git@vger.kernel.org, Santiago Torres <santiago@nyu.edu>
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
References: <875zsdu41d.fsf@fifthhorseman.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <875zsdu41d.fsf@fifthhorseman.net>
Date:   Wed, 20 Mar 2019 23:35:48 +0100
Message-ID: <8736nhdvi3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 20 2019, Daniel Kahn Gillmor wrote:

> Hi git folks--
>
> I understand that git tags can be easily renamed.  for example:
>
>     git tag push origin refs/tags/v0.0.3:refs/tags/v2.3.4
>
> However, for tags signed with any recent version of git, the tag name is
> also included in the signed material:
>
>     0 dkg@test:~$ git tag -v v0.0.3
>     object 8ae6a246bef5b5eb0684e9fc1c933a4f8441dadd
>     type commit
>     tag v0.0.3
>     tagger Daniel Kahn Gillmor <dkg@fifthhorseman.net> 1528706225 +0200
>
>     this is my tag message
>     gpg: Signature made Mon 11 Jun 2018 04:37:05 AM EDT
>     gpg:                using Ed25519 key C90E6D36200A1B922A1509E77618196529AE5FF8
>     gpg: Good signature from "Daniel Kahn Gillmor <dkg@fifthhorseman.net>" [ultimate]
>     Primary key fingerprint: C4BC 2DDB 38CC E964 85EB  E9C2 F206 9117 9038 E5C6
>     0 dkg@test:~$
>
> But git tag doesn't verify that the internal name is the same as the
> external name (note that it still returns an exit code of zero):
>
>     0 dkg@test:~$ git tag -v v2.3.4
>     object 8ae6a246bef5b5eb0684e9fc1c933a4f8441dadd
>     type commit
>     tag v0.0.3
>     tagger Daniel Kahn Gillmor <dkg@fifthhorseman.net> 1528706225 +0200
>
>     this is my tag message
>     gpg: Signature made Mon 11 Jun 2018 04:37:05 AM EDT
>     gpg:                using Ed25519 key C90E6D36200A1B922A1509E77618196529AE5FF8
>     gpg: Good signature from "Daniel Kahn Gillmor <dkg@fifthhorseman.net>" [ultimate]
>     Primary key fingerprint: C4BC 2DDB 38CC E964 85EB  E9C2 F206 9117 9038 E5C6
>     0 dkg@test:~$

I'm sympathetic to the whole problem, but don't have anything to add to
t he thread Santiago linked to. Except...

> This seems troublesome, as I expect there are many scripts that rely on
> the tag name and the return code of "git tag -v" to assert that this is
> a correct tag.  Anyone in control of the above repository could pass off
> an old tag (or indeed, a tag from an entirely different project that
> happens to be signed by the same author) as whatever version they wanted
> to, and convince automated scripts that work with new versions to
> "upgrade".
>
> I think "git tag -v" should be more strict about what it needs to "pass"
> a verification.

... just a point of clarification on the "a tag from an entirely
different project" part of this.

Maybe I'm missing something, but it doesn't seem like your proposed
solution helps much with *that* threat model as you've described it.

If all I'm doing is blindly slurping down one out of a bunch of
repositories you commit to and tag releases in, sorting the tags, and
getting the latest one you (dkg@fifthhorseman.net) signed, I'm still
mostly open to this problem.

The only thing that'll change is that you can't fool me if I'm looking
at whatever project you happen to contribute to that has the highest tag
version across *all* projects you contribute to.

But e.g. if you've signed a v1.00 in foo.git, but also maintain bar.git
and have a v2.00 there, I can be fooled in foo.git with your proposed
change by having the v2.00 bar.git tag pushed to it (just, with the
proposed change, not the other way around).

It *does* help with the "pass of an old tag [from the same repository]"
problem, which I'd expect would realistically be the only threat model
that matters (forcing a downgrade to an old buggy version), whereas some
entirely different project is likely going to be next fed to some
project-specific build infrastructure and then won't even build.

*but*

I wonder if there's a more general fix to be found here that'll have
nothing to do with GPG or signed tags per-se. A lot of people have this
"given tags in the repo, what's the latest one?" problem. I think
they'll mostly use the --sort option now, maybe some variant of that
which for each <older>/<newer> tag in the chain also checked:

    git merge-base --is-ancestor <older> <newer>

That would serve as a check for such rouge tags, even if none of them
were signed, and a "they must be signed" option could be added, along
with "start walking from here".

It wouldn't help with cases where you legitimately *do* want to re-tag
an old version (for a revert), but in some cases tagging always moves
forward in history (always newer commits).

Just food for thought...
