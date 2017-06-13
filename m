Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1BEB1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 22:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbdFMWwE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 18:52:04 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36798 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdFMWwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 18:52:03 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so74277627pff.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFNm0jM0WYHsGoMOxvqWvlVQLYy5IR+zkGr7DiwwACw=;
        b=ClzHxvxiUh9rb2woxUujXaYhsuyeLBYJXfgghen02AR3NjYIsixY5SIjVMCIhq+icZ
         +NkUQe3ddn4JAsIISc5RZ7BDESjjvGU7m5/MOcjsHdA4KfJ7W7L5fnbG7lC6hv1lPoW2
         /konA7Q7fWQzopzOhl+4dIXEDAgTJGFlzj+6NH2rTbvf05YfrhOPoqUfmYpWT46V9MVt
         ChSIW0eBAXPb/ZqvAYu4rCRanTVocd+iMFPOKd1Roed0CdzMK60Ssw+CTNeJhg0cI1im
         QJG8BeVyqjCJoeY+z64sRkuMiZfWYwHPM3BYidfiifALWkC3rMXwjcf/P+4GS+Zr9Ze3
         0SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFNm0jM0WYHsGoMOxvqWvlVQLYy5IR+zkGr7DiwwACw=;
        b=CRmIaGzEkkg6fAdW/3eP7UALMQTjkLoD0DcKgGGC1LXFiUTO1/Uk9bBAVjL054lJCX
         /AznblUxYs7edBmexyjHVdQlWzrpKjFFwbiEBHyJhgREGGZOzM/8wqvAxWvKCoaa167M
         uYfb9L9Uog/fxDE5qgpp7xBl0oSdq+WAvOPENb1uQXC3o2FjdhX2yp8d69RUtLf5m3WB
         CHrO8Iuz2tAavo6wzWvf/FNhXfoNj7I+dIvVIMpLjM5NbWdRlrnT22aJNDi5EaFY5irT
         8+yWXV/wHueYiagZ6yH+1itiGxGg9WGDDhqL3YDZYYKUx6g7ZHCqu/fCWe6zTXy3C+jV
         kJBg==
X-Gm-Message-State: AKS2vOxqdyUNK2LouiLp5PTEUoZX4yISXbdd/4LFT63xGuv3cEibxKxM
        S0QMF1iq5Ueeb8v8
X-Received: by 10.84.224.206 with SMTP id k14mr1760714pln.195.1497394322556;
        Tue, 13 Jun 2017 15:52:02 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:85a0:52c1:8d73:eb63])
        by smtp.gmail.com with ESMTPSA id d185sm23939052pgc.39.2017.06.13.15.52.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 15:52:02 -0700 (PDT)
Date:   Tue, 13 Jun 2017 15:51:58 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH] diff.c: color moved lines differently
Message-ID: <20170613155158.2454d9c7@twelve2.svl.corp.google.com>
In-Reply-To: <20170601002429.3470-1-sbeller@google.com>
References: <CAGZ79kbq3XiP8W_01FV133aMjZP9_GvpEg86N=XC2rTy24ZZGQ@mail.gmail.com>
        <20170601002429.3470-1-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 31 May 2017 17:24:29 -0700
Stefan Beller <sbeller@google.com> wrote:

> When a patch consists mostly of moving blocks of code around, it can
> be quite tedious to ensure that the blocks are moved verbatim, and not
> undesirably modified in the move. To that end, color blocks that are
> moved within the same patch differently. For example (OM, del, add,
> and NM are different colors):

[snip]

Junio asks "are we happy with these changes" [1] and my answer is, in
general, yes - this seems like a very useful feature to have, and I'm OK
with the current design.

I do feel a bit of unease at how the emitted strings are collected
without many guarantees as to their contents (e.g. whether they are full
lines or even whether they originate from the text of a file), but this
is already true for the existing code. The potential danger is that we
are now relying more on the format of these strings, but we don't plan
to do anything other than to color them, so this seems fine.

I would also prefer if there was only one coloring method, to ease
testing, but I can tolerate the current multiplicity of options.

I think there was some discussion at trying to avoid indicating that
small blocks (consisting of few non-whitespace characters) are moved,
but I think that that can be added later.

[1] https://public-inbox.org/git/CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com/

> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -231,6 +231,38 @@ ifdef::git-diff[]
>  endif::git-diff[]
>  	It is the same as `--color=never`.
>  
> +--color-moved[=<mode>]::
> +	Moved lines of code are colored differently.
> +ifdef::git-diff[]
> +	It can be changed by the `diff.colorMoved` configuration setting.
> +endif::git-diff[]
> +	The <mode> defaults to 'no' if the option is not given
> +	and to 'adjacentbounds' if the option with no mode is given.
> +	The mode must be one of:
> ++
> +--
> +no::
> +	Moved lines are not highlighted.
> +nobounds::
> +	Any line that is added in one location and was removed
> +	in another location will be colored with 'color.diff.newmoved'.
> +	Similarly 'color.diff.oldmoved' will be used for removed lines

Probably best to consistently capitalize newMoved and oldMoved.

> +static unsigned get_line_hash(struct diff_line *line, unsigned ignore_ws)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	if (ignore_ws) {
> +		strbuf_reset(&sb);
> +		get_ws_cleaned_string(line, &sb);
> +		return memhash(sb.buf, sb.len);
> +	} else {
> +		return memhash(line->line, line->len);
> +	}
> +}

Can be written without the "else".

> +test_expect_success 'move detection does not mess up colored words' '

Probably name this test "--color-moved has no effect when used with
--word-diff".
