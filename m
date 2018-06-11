Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10C91F403
	for <e@80x24.org>; Mon, 11 Jun 2018 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933360AbeFKSEV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 14:04:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39056 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeFKSEU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 14:04:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so21357145wrn.6
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qv2/I7E+GxE3UeTI6xz3szz+Aov8UFKe5HqKAACpFHo=;
        b=lvtohY2sokJIJ6YYZTT1elRFbbxmVbEemVNNYIv3inRq0q/CuEADvtj2Tym29SlMoa
         SUFSrVhGJPmXYgsKAoTQ+OXs/D2LJiP9kQ3Vm4nNZroQObOCt1ZqIiJjxzYQQC8tZMKl
         cpvEhe+6zcG7JahNTY/Kx+IAnHqnlVv6GiwSARWnGDc8a09XhIfsOAtQbSaU9A/+qewW
         jcahg9YlnI6aK6BUL/eZruus6gch2XbRoAPsuE+QAUOQ0gc14TLxLIu7r34iTZQFUIhb
         npWAlvvRDJoDVK954yZjgasBF/DLaVmN/ZyrW0/OdfH9QlexULvXfYbYA4XQMV942ZAR
         79eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qv2/I7E+GxE3UeTI6xz3szz+Aov8UFKe5HqKAACpFHo=;
        b=AQdCztD5r3VSQhjyb+mNUlQOo9WemFTINAbOghLJceDzeaoWWlTOCf7fuW3hCziydO
         gsuvP3p3U66AlCHbGUHi62uVCYsjtOUuXy1928ClqvPJ4jOX/fHUn3ZFUxDuSoV9+6Rw
         EGbhPLk3hap0TBD447q2q7GqN77GvT1IyH5Ej9SZve+iOlqW1rwQw+hsuc3vZn4RKNh4
         tYMAJ5ubXNguhUl89O1AFkauX1xo+E8bdtsyT1r2IroPb77kUkaT9KQ/BW/e3vXm2CZe
         CjcGbuy3RQYpB/W+/okQmsBA3I3LNStF5br6mKOtI/6UpZdWvBplVQwP4Rd0hkWce9KZ
         Y4Cw==
X-Gm-Message-State: APt69E2aNqiOk7QOpw9CCx/DjRlaEzz7bmWgbuzE7/jEol+4Th2uMdHW
        8iOzPoqXYljWj+96U2tYRSs=
X-Google-Smtp-Source: ADUXVKLCIoX5Aih7Ch/JhAAHkZT7US5MV7V6oMTnMn1N0yyWIOjox0uz8VmAyZRe+ClZ6MRL5z8/Ng==
X-Received: by 2002:adf:b839:: with SMTP id h54-v6mr187918wrf.36.1528740258804;
        Mon, 11 Jun 2018 11:04:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f17-v6sm11328871wmc.2.2018.06.11.11.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:04:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     newren@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] merge-submodule: reduce output verbosity
References: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
        <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
        <20180611173128.9917-1-leif.middelschulte@gmail.com>
Date:   Mon, 11 Jun 2018 11:04:17 -0700
In-Reply-To: <20180611173128.9917-1-leif.middelschulte@gmail.com> (Leif
        Middelschulte's message of "Mon, 11 Jun 2018 19:31:28 +0200")
Message-ID: <xmqqr2ldb3oe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leif Middelschulte <leif.middelschulte@gmail.com> writes:

> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>
> The output shall behave more similar to ordinary file merges' output to provide
> a more consistent user experience.
>
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
> ---
>  merge-recursive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, both.  Very much appreciated.

>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index ac27abbd4..5eb907f46 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1208,7 +1208,7 @@ static int merge_submodule(struct merge_options *o,
>  			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
>  			output_commit_title(o, commit_b);
>  		} else if (show(o, 2))
> -			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
> +			output(o, 2, _("Fast-forwarding submodule %s"), path);
>  		else
>  			; /* no output */
>  
> @@ -1220,7 +1220,7 @@ static int merge_submodule(struct merge_options *o,
>  			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
>  			output_commit_title(o, commit_a);
>  		} else if (show(o, 2))
> -			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
> +			output(o, 2, _("Fast-forwarding submodule %s"), path);
>  		else
>  			; /* no output */
