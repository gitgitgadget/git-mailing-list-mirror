Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959A420248
	for <e@80x24.org>; Sun, 14 Apr 2019 03:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDNDyy (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 23:54:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDNDyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 23:54:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so17085875wrn.11
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TzKEHRZGzMo0Mh3CYoWSwo+ZUlAm88XhaUHtU4Rukh0=;
        b=iQzCEHsWlMvLp1xs6L4fgPqCidLFQ+pyYEkuNHtE9g/UsLUmkqKIuBd7pi2zmdWGCn
         T2NoBcj+rzHJQPRwtN+7WIf8vw2cggW/gNB5TsHY3Gf1y2XBb6wx335nLxRI2fezqEEz
         FDD/4yKLcwsoxa/8c5/6DAwy7tHrf2t8clPLi63qbenwSmPDMZwhPp+GuGdnmsHw1VF5
         tLs9EdhDJ+ScWhnhFrNxj0SySE7ifJBUskMihl/JEGWSszZb9UM1AFmZSC3C0WnKAJxK
         ogIVvivtr7xMfqfhmt0uQ5/IQtbiJ9HsmckvkJso3fDFO12siKDStl+39XVhsP2MW+8q
         GqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TzKEHRZGzMo0Mh3CYoWSwo+ZUlAm88XhaUHtU4Rukh0=;
        b=JOEVP+kp+08S+rxBC1YANorzjltKtpwouHNllWrVTNFWK1vqfC8joMmdL+lagRFUXC
         Nb08nxg0oCnzGepcbAR6K7UrU805cPcYt4cA3kVWfQ9syMqZY2EmuKw9hOJVeGU8CrWx
         Vw/UlafOWlnK9QsG9DqOqY3ML+Ecus9LwsG+QEPbh/nnGrzqpB/DdoLtqXiZcEv3x4g4
         Eyezfd5wGRHhomZPYOlhkJEJNNTSiJYsIr0MqZKr+r9swpwpjeQNpIVrgkWV+u3PIGmv
         DvmO988FJzqDOIbCkRyZlIBfSNAMVgh8Cbk+eUtNfC/CiqRRWU0mjQJNBEZjT1tFkqJ0
         ecjA==
X-Gm-Message-State: APjAAAVIkX06RVYaAnTISyP7DgK40xh4MuaUfXYSlrocZmBCw9hM3PrP
        xXyiIxnR6qiMMNvUf6CiZ30=
X-Google-Smtp-Source: APXvYqwB33aZWCFFpaYn+XQhTcLhmiwJI5phD/5lfdx8ZubKpzPgHZ8Cb0ir6oUbdrIYThUyCOGdjQ==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr42129142wrs.121.1555214091831;
        Sat, 13 Apr 2019 20:54:51 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t81sm26821878wmb.5.2019.04.13.20.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 20:54:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v6 6/6] blame: use a fingerprint heuristic to match ignored lines
References: <20190410162409.117264-1-brho@google.com>
        <20190410162409.117264-7-brho@google.com>
Date:   Sun, 14 Apr 2019 12:54:50 +0900
In-Reply-To: <20190410162409.117264-7-brho@google.com> (Barret Rhoden's
        message of "Wed, 10 Apr 2019 12:24:09 -0400")
Message-ID: <xmqqk1fxw8ad.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> This replaces the heuristic used to identify lines from ignored commits
> with one that finds likely candidate lines in the parent's version of
> the file.
>
> The old heuristic simply assigned lines in the target to the same line
> number (plus offset) in the parent.  The new function uses a
> fingerprinting algorithm to detect similarity between lines.
>
> The fingerprint code and the idea to use them for blame came from
> Michael Platings <michael@platin.gs>.
>
> For each line changed in the target, i.e. in a blame_entry touched by a
> target's diff, guess_line_blames() finds the best line in the parent,
> above a magic threshold.  Ties are broken by proximity of the parent
> line number to the target's line.
>
> We actually make two passes.  The first pass checks in the diff chunk
> associated with the blame entry - specifically from blame_chunk().
> Often times, those diff chunks are small; any 'context' in a normal diff
> chunk is broken up into multiple calls to blame_chunk().  We make a
> second pass over the entire parent, with a slightly higher threshold.

Two thoughts.

 - Unless the 'old heuristic' is still available as an option after
   this step, a series that first begins with the 'old heuristic'
   and then later replaces it with the 'new heuristic' feels
   somewhat wasteful of reviewer resources, as the 'old heuristic'
   does not contribute an iota to the end result.

   It is OK while the series is still in RFC/WIP stage, though.  But
   because I got an impression that this is close to completion, so...

 - I wonder if the hash used here can replace what is used in
   diffcore-delta.c as an improvement (or obviously vice versa), as
   using two (or more) ad-hoc fingerprinting function without having
   a clear reason why we need two instead of a unified one feels
   like a bad idea.

