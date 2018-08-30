Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38721F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeH3X5R (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:57:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41667 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeH3X5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:57:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so7418767edd.8
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YT0JSjw/dfjNmOmJ+ssBY2gQ8VdGo2w5GA7GRYr+y+k=;
        b=M0MAbdqGnu1+IDYZX/HqJZ2L1CNph3+sgdFA/WcrW76sfxx1rF4s1XQoHFFep70sMB
         Kqe7aqenu5UAkUmYHsETsqLryeQke8L+oVi7AN5FmGqo4a7RexrE9yHScmrqgj62ATqt
         eszPFqjuLt3dPxkMP/4sjfK8KMObtCV35pXAzDGTCx6MjKJQGk6hpGtI09FdPtB4WT9o
         K6buWrGFvcSC2gtkXoTUgEsj2FxSO7IeODIhweyxvn2S1Ei+kSwfrxp1Nqa6s98G6lGg
         WLIU1fkSNgz97ou/tyRT5db4jZJ4DYNp3a6iJIzYlDv0egcf9p44f6/OkpGtyb9t6e3p
         UH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YT0JSjw/dfjNmOmJ+ssBY2gQ8VdGo2w5GA7GRYr+y+k=;
        b=XXb1OCwp6OtuIPjzbHQ+5EVSJpAXzEwn8boHDQcuX8ysNoi1jeRVC5jjf4zTTScXaG
         aYXuqMfGg+uV6X2Gs46MGSA6laUMPqS+U9z0MkHroyXGejhXENE9n6tbDdPuMXS3H1xa
         noLL7eeVPRVhJqIffM5Ym5tat3lL0PGqm9+xlRgP/DIdemBmzbrQlrT5p+giQAILYVyc
         j8tPAjQp4Reefyelr7YKnvrt14Ttw5PF9RRopeFNaYyE0vDOI4EiseMyKIFWZUx9Yzfg
         5hog8DLXCiwMqsaiztQK4cjcEguKdZjUiKhzhOuKXtHSjYMo/QmoXbQHnikriqhEXJpq
         ZGfQ==
X-Gm-Message-State: APzg51BehzYYmfXYGNOP9lfgtyYLEmsd33BM4iS/90VsSTTu5RZLmD3s
        7NLwtjFaiJPZu4aItLzarvs=
X-Google-Smtp-Source: ANB0VdYcOlXIVYqnjPm+RGim6xzxUF3PgonXUY476S0PLJZUYHQ9iscWjBQ+6sTo8095fTdbvOe9ZA==
X-Received: by 2002:a50:fd84:: with SMTP id o4-v6mr14507942edt.116.1535658807429;
        Thu, 30 Aug 2018 12:53:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id d35-v6sm3270656eda.25.2018.08.30.12.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 12:53:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
References: <20180622092327.GA8361@sigill.intra.peff.net> <20180622092459.GD13573@sigill.intra.peff.net> <87wos8cjt8.fsf@evledraar.gmail.com> <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 30 Aug 2018 21:53:25 +0200
Message-ID: <87in3rd422.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> +-l::
>>>  --list::
>>>  	List branches.  With optional `<pattern>...`, e.g. `git
>>>  	branch --list 'maint-*'`, list only the branches that match
>>
>> I think it's better to have something like this on top:
>>
>>     diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>>     index 5552dfcec3..a03cb1ebc9 100644
>>     --- a/Documentation/git-branch.txt
>>     +++ b/Documentation/git-branch.txt
>>     @@ -163,6 +163,11 @@ This option is only applicable in non-verbose mode.
>>      This should not be confused with `git branch -l <branchname>`,
>>      which creates a branch named `<branchname>` with a reflog.
>>      See `--create-reflog` above for details.
>>     ++
>>     +
>>     +Until Git version 2.20 `-l` was the short form of
>>     +`--create-reflog`. As of version 2.19 using it would warn about a
>>     +future deprecation.
>
> Doesn't your patch show a more grave issue with the current state of
> 'next'?
>
> The sentence in the pre-context in your suggested patch says that
> "--list" should not be confused with "git branch -l <branchname>",
> but --list and -l are now synonyms in the new world order.
>
> Worse yet, '-l' is no longer a way to create the branch with a
> reflog; in the new world, you would say "--create-reflog" if you
> want to do so.  "git branch -l foo" would list branches that match
> that pattern 'foo'.
>
> In the SYNOPSIS section we still see "[-l]" listed; that also must
> be replaced with "--create-reflog", or just dropped, as that is the
> default.

Oh yes, it seems all of the doc indeed wasn't updated!

> I do not know if the documentation that is shipped in 2.20 should
> talk about how the old world looked like, though.  `-l` was a short
> for `--create-reflog` is worth saying, but I do not see much value
> in talking about the warning given in 2.19.

I'm anticipating that there will be users in the wild with similar -l
invocations, noting this helps them, because they'll be wondering what
some script that does "git branch -l <name>" is trying to do while
reading our docs.

Both our command-line options (plumbing or otherwise) and file various
formats (e.g. I had a similar mention of version differences in my
recent skipList patches) can be expected to be used across multiple git
versions, by users who most likely are only browsing the latest version
of the docs, not comparing how the manpage looked like in multiple git
versions to see if an option meant something different, or if a format
was documented as behaving differently.
