Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EEC77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjE0TA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0TA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 15:00:57 -0400
Received: from forward4-smtp.messagingengine.com (forward4-smtp.messagingengine.com [66.111.4.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70791D3
        for <git@vger.kernel.org>; Sat, 27 May 2023 12:00:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailforward.nyi.internal (Postfix) with ESMTP id D4CF919415C3;
        Sat, 27 May 2023 15:00:54 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Sat, 27 May 2023 15:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685214054; x=1685300454; bh=TI/enWHmKj6b/
        8xFivALW/01CTpph+pj7jcP1H8kugE=; b=RjB3S3QrwAauYAoJaCK/HFKPEmpEW
        Nkpx8vagyWUkofCySIaoVWUzb8l23F8glzU2qRM5cgXdufWIKTrOuqwYnB4yobBF
        DftjJiZTchEdtU5V6lHK3cue1EkHfCWk3+ZkU9k5XDpGK+i9vM3ClrxMelXCTv8L
        Ubu5OtzwiNlljfbkPYpoVEU3kSt6MDeyhbgh0sTm/c+nzAOrfqBRxT6vchHo9jRe
        20v96g8AsHGO0extsTl2EXiAyPZaltIZKiAjF7VTZGZZUCFTbzMfrrf6KW6COkKg
        FGa12gHs43cL3uzYERRC0Hi117/jDeEh3lzs1KdUcEp2KD5Zhg/m9TaxQ==
X-ME-Sender: <xms:ZlNyZGfqHxyX91kgwVh8613q8SYHchuNP9JaQyC_oqXRdNNz4HnXEQ>
    <xme:ZlNyZAN0GVe2zEEkpXT2ITFP9U_e7Pz5ftCvgGMEbZEN958MANcy_0_2TxW6t6Eus
    YUuOllmnJG3Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekuddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedflfhimhcurfhrhihorhdfuceoughusghiohhushhj
    ihhmsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfeutedtveffiefhje
    etfffglefgteejudfhvdeggeevleelteelkeejfeeukeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguuhgsihhouhhsjhhimhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:ZlNyZHhvNXhGeQj0TiVP7txatxuRMGmWynW5SQHq4yHAykZxtuSfVg>
    <xmx:ZlNyZD-yaUjNpMKqFnFXSwod5ApeJBu95rEMv4IVG8PgR2qQbvY6dw>
    <xmx:ZlNyZCtDffvf7nYt8YEBHGaF-NFgn-UODkdTpw-PscVprxGrBs8B3g>
    <xmx:ZlNyZL5q316_FyeCepyctEYAavmJOXycoLJO5qO97XDIAXp1pCMK2g>
Feedback-ID: i5b2c416c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9839D1700089; Sat, 27 May 2023 15:00:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <51012e79-c6ce-41dd-9755-960e065214ef@app.fastmail.com>
In-Reply-To: <20230527173903.GB1460206@coredump.intra.peff.net>
References: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
 <20230527173903.GB1460206@coredump.intra.peff.net>
Date:   Sat, 27 May 2023 21:00:27 +0200
From:   "Jim Pryor" <dubiousjim@gmail.com>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git 2.40.1 tree-diff crashes with (glob) magic on pathspecs
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2023, at 7:39 PM, Jeff King wrote:
> On Sat, May 27, 2023 at 03:53:31PM +0200, Jim Pryor wrote:
>
>> $ git --no-pager log --oneline -- ':(glob)**/test2'
>> 
>> What did you expect to happen? (Expected behavior)
>> 
>> 13a1b11 (HEAD -> master) third commit
>> 2bacc0c second commit
>> c6eb1c1 first commit
>> 
>> What happened instead? (Actual behavior)
>> 
>> 13a1b11 (HEAD -> master) third commit
>> BUG: tree-diff.c:596: unsupported magic 8
>> error: git died of signal 6
>
> Thanks for your report. I had trouble reproducing at first, but there is
> one extra twist. By default, the command you gave produces:
>
>   $ git --no-pager log --oneline -- ':(glob)**/test2'
>   48eab09 (HEAD -> main) third commit
>   89a47e5 second commit
>
> which makes sense; we did not ask about "test", which is the path the
> original commit touched. So I guessed you might have log.follow set, and
> indeed:
>
>   $ git --no-pager log --oneline --follow -- ':(glob)**/test2'
>   48eab09 (HEAD -> main) third commit
>   BUG: tree-diff.c:596: unsupported magic 8
>   Aborted
>
> I _think_ in this case that ":(glob)" is not actually doing much. It is
> already the default that we will glob pathspecs; it is only needed to
> override "git --literal" (which changes the default to not glob).
>
> But this also seems to be wading into a spot that is not actually
> supported by --follow. The code near where the BUG() is triggered looks
> like this:
>
> static void try_to_follow_renames([...])
> {
> [...]
>         /*
>          * follow-rename code is very specific, we need exactly one
>          * path. Magic that matches more than one path is not
>          * supported.
>          */
>         GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
> #if 0
>         /*
>          * We should reject wildcards as well. Unfortunately we
>          * haven't got a reliable way to detect that 'foo\*bar' in
>          * fact has no wildcards. nowildcard_len is merely a hint for
>          * optimization. Let it slip for now until wildmatch is taught
>          * about dry-run mode and returns wildcard info.
>          */
>         if (opt->pathspec.has_wildcard)
>                 BUG("wildcards are not supported");
> #endif
>
> So follow-mode does not actually work with wildcards, but we err on the
> side of not rejecting them outright. In that sense, the simplest "fix"
> here would be to allow :(glob) to match the '#if 0' section, like:
>
> diff --git a/tree-diff.c b/tree-diff.c
> index 69031d7cba..d287079253 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -593,7 +593,8 @@ static void try_to_follow_renames(const struct 
> object_id *old_oid,
>  	 * path. Magic that matches more than one path is not
>  	 * supported.
>  	 */
> -	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
> +	GUARD_PATHSPEC(&opt->pathspec,
> +		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL | PATHSPEC_GLOB);
>  #if 0
>  	/*
>  	 * We should reject wildcards as well. Unfortunately we
>
> That would avoid the BUG() and make things work consistently. But it
> still would not produce the output you expect, because --follow simply
> does not work with wildcard pathspecs. And fixing that would presumably
> be a much bigger change (I didn't dig into it).
>
> Complicating this slightly is the fact that you didn't explicitly ask
> for --follow, but just had log.follow set. I think we automatically
> disable log.follow when there is more than one pathspec, and in theory
> we ought to do the same for actual wildcards. But maybe it would be
> enough for follow-mode to kick in, but to end up mostly ignored (which
> is what the patch above would do).
>
> (I say "mostly" because I suspect you could construct a history where
> the glob matched a literal filename, too, and the follow code gets
> confused. But outside of intentionally-constructed pathological cases,
> that seems unlikely).
>
> -Peff

Confirmed I have log.follow = true, and also GIT_NOGLOB_PATHSPECS set, thus the explicit `(glob)` magic.

I'd be happy with --follow not working with the wildcard pathspecs, but with the crash avoided.

-- 
dubiousjim@gmail.com
