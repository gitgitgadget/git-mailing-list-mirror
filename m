Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9611F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeHaBfk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:35:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37567 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeHaBfk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:35:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so9330468wrr.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8rIXvQsZ3ktfuCPZdKPX/Ey+gLp8HsDscbQ00VhzKhU=;
        b=VqscJYRNLDhWleSj4H3KxtrgT+/waw6vitXf7ZG0tvLx96484XW8MDB3UNFN3G9FOU
         kK2M/dnk/8uhFSxLFpnlu+rK/pjKugoMSeXWTxWLStaoKuuQ4Jo5Ldi7w6yiT/qLAFET
         aLWnA7xUg1W0TArq3qzw6Lpf5lUhsYoBcaieBWPBkZP1orohaXe3skZIQKRfvNbDxt+i
         bJbpdw5tReKwk4AVURKx1p5zPypoY6yYm4vvjsbJZGVC2Qn/wf4vWAUX6I0OU7RI01h7
         mzBTexJ/wY6+85uhZsYmz7bawvOokaFI4VzmFVNl3VSSlomr5oOK3bKEaZ+6AFLKCL4u
         rpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8rIXvQsZ3ktfuCPZdKPX/Ey+gLp8HsDscbQ00VhzKhU=;
        b=PXfCfNn7ubzKkCDW8NpGygPaFo0dJpm0hn2AEUnClV0H3ilmIqSpfjfPdo6b/XvVio
         h58rTu9sRattRuC56GHzwvBDR50+2QeOWChilyA6suhTu/DyVfITR6g9rYSdHM00Wj8K
         Bf556dmcgf0BeEJGSmUGdxJKJE9VQJ9x2fiZXcI7JhNDvTQL59uS2pfQHQQtaeFmV0Cl
         XYam4mwjS9jUjJN+9TZZd791kau/P06uIzzTyVCT6AWNbN5hDnOt2oxiJWjth3xAZw5F
         EGnAWlPvw5lBxXv9WwI1exa6qMXpBPAAcNTRfmiz8O0VQ1ya4Zzi95PCkYF+wJ8yEYDm
         wyOw==
X-Gm-Message-State: APzg51BxC6stdzQiQntk/WOJlCbFU6Qrde53WLI0APJRjHco2E5j6JKy
        ZgVg3NKmkdDBywXA6zo6Xno=
X-Google-Smtp-Source: ANB0VdaA+/s/VG2k+N6dz4NOLq8qC98cX1HJWnKO/Ml9yJExzsAM0lTRML7sE24yYSNMzYJiHGUejw==
X-Received: by 2002:a5d:4a87:: with SMTP id o7-v6mr8276052wrq.132.1535664689518;
        Thu, 30 Aug 2018 14:31:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14414109wrd.13.2018.08.30.14.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 14:31:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Kristian =?utf-8?Q?H?= =?utf-8?Q?=C3=B8gsberg?= 
        <krh@redhat.com>
Subject: Re: [PATCH v4 4/6] push doc: correct lies about how push refspecs work
References: <20180813192249.27585-1-avarab@gmail.com>
        <20180830201244.25759-5-avarab@gmail.com>
Date:   Thu, 30 Aug 2018 14:31:28 -0700
In-Reply-To: <20180830201244.25759-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 30 Aug 2018 20:12:42 +0000")
Message-ID: <xmqq4lfb4k3z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +on the remote side. Whether this is allowed depends on where in
> +`refs/*` the <dst> reference lives as described in detail below. Any
> +such update does *not* attempt to merge <src> into <dst>. See EXAMPLES
> +below for details.
> ++
> +The `refs/heads/*` namespace will only accept commit objects, and only
> +if they can be fast-forwarded.
> ++
> +The `refs/tags/*` namespace will accept any kind of object (as
> +commits, trees and blobs can be tagged), and any changes to them will
> +be rejected.
> ++
> +It's possible to push any type of object to any namespace outside of
> +`refs/{tags,heads}/*`. In the case of tags and commits, these will be
> +treated as if they were the commits inside `refs/heads/*` for the
> +purposes of whether the update is allowed.
> ++
> +I.e. a fast-forward of commits and tags outside `refs/{tags,heads}/*`
> +is allowed, even in cases where what's being fast-forwarded is not a
> +commit, but a tag object which happens to point to a new commit which
> +is a fast-forward of the commit the last tag (or commit) it's
> +replacing. Replacing a tag with an entirely different tag is also
> +allowed, if it points to the same commit, as well as pushing a peeled
> +tag, i.e. pushing the commit that existing tag object points to, or a
> +new tag object which an existing commit points to.
> ++
> +Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
> +the same way as if they were inside `refs/tags/*`, any modification of
> +them will be rejected.
> ++
> +All of the rules described above about what's not allowed as an update
> +can be overridden by adding an the optional leading `+` to a refspec
> +(or using `--force` command line option). The only exception to this
> +is that no amount of forcing will make the `refs/heads/*` namespace
> +accept a non-commit object.

This, while some may find it overly long, is quite clear, compared
to the current text and to the previous rounds of this patch, and I
found it very much readable.

