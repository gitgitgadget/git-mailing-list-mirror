Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22389202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 15:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755992AbdGKP6A (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 11:58:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35605 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755874AbdGKP56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 11:57:58 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so401964pgc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=29p5UNL3CvV33slZwGHJ/WChPXTGQ7cjyDA7pHlclf8=;
        b=nWbI6FupUqJVnmQ7hybZ9kZgEnmvlzBViN5N/i/IvrcjH05U7Nxjchr9nJrcmS4PPN
         EKeLOMS/3JTbvtvLJJUMr6tsrizugioPgk35+xPl0Ch5lCGtYiVZnfKFtfL63WE78NkT
         CljEddMowqAQvqSuKRcAEc+5a7qBFpYCP0GrnQwDU4v4Ql0z3L3BLy8jboHA9+vLVPUn
         irDAe8zg+Nu26DcHLhV2meA5BEEePD18uMMExNFvAO4lmwGf26hElmvoFBjbFC1knjlL
         r+EylbzhFqWXMu1cZxkeZVuSalSZIZSrgP1qaeKW5jWh3xulvUvUC0QdkaP05dRJp53m
         vXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=29p5UNL3CvV33slZwGHJ/WChPXTGQ7cjyDA7pHlclf8=;
        b=AeaXhUa37ef1j3kWCFXr3MFtWLdviTp0Xao+HL6UKuTzxWlFslgbVYz0H0QK/2XsGp
         iYdlhRDfPLFzYdvTAThRlJ/GQSOcaC949564n6pUNutmmyYShFshVI4cwN9ArPY0siuT
         Q1/vBygaGJ+n2bS+8W8j9I+ejzs53fpgS01OdOGGca4Xjxga5BwvG3tLDGK+mlkNdhFh
         Nst7HYgwMu1ZscIKOETHU+jRcnvFkM0KDtkJLH3Tyy6VM9RVwuFN/dz8ZTWZiJVVeU6T
         yeIEGJyluoveyJKRiV9AKgI+vPZSeYIcvdwX0fzdvogGBHY/S0B271Ey7+w/BhqEjegG
         j5Tg==
X-Gm-Message-State: AIVw113oM6hxakTXcgHyWiIyvCLA+BYwvdpYdckSoocoQkvsGH+L6c2h
        K2qiiw2JDtxwJkZrKRM=
X-Received: by 10.98.59.1 with SMTP id i1mr50293713pfa.147.1499788678097;
        Tue, 11 Jul 2017 08:57:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id c191sm948760pga.15.2017.07.11.08.57.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 08:57:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Eckersley <peter.eckersley@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Weirdness with git change detection
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
Date:   Tue, 11 Jul 2017 08:57:56 -0700
In-Reply-To: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
        (Peter Eckersley's message of "Mon, 10 Jul 2017 16:45:12 -0700")
Message-ID: <xmqqy3rv2cfv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Eckersley <peter.eckersley@gmail.com> writes:

> I have a local git repo that's in some weird state where changes
> appear to be detected by "git diff" and prevent operations like "git
> checkout" from switching branches, but those changes are not removed
> by a "git reset --hard" or "git stash".
>
> Here's an example of the behaviour, with "git reset --hard" failing to
> clear a diff in the index:
>
> https://paste.debian.net/975811/
>
> Happy to collect additional debugging information if it's useful.

Do you have any funny clean-smudge pair that do not round-trip?
