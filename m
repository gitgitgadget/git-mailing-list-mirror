Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AAF720966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbdDENlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:41:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35008 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754613AbdDENlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:41:00 -0400
Received: by mail-oi0-f68.google.com with SMTP id d2so2089588oig.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B9lOjHSjpIhecRVUZ5S8ZKHuR9cK/oPhCfgC9dEzxbI=;
        b=XLUN70LKfWvxkdPbhPgRQ3Gs3Dcu/4o7ZRqVoShhg6Qwibs3pFQF3b7oqzGasO0dGu
         pr5Jv1grRcNJgYzw5+ib0PiSlsEMYIM+SJ0GLh3FmpprZwigqD1RdDKSaaDBI1AapRqv
         WJsu8X7WeC7loApUQ6E0Z7TOnulzUuVueclFaaU/eq1inuFITTDn0RNUFvVReI39O8wF
         4Ld4lfmFnFa+5dddUpiR/7AISqk068/q+F55m5fq3EzsSY+XBdG5prCsUWJ97r5uOe91
         Jyl867Tu8q7SfZMLfDv8+C5+yDX3ZY1dtqRj9SmgZ4oq/U5IYLaizrgTi1bmLNZcE7tL
         bjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B9lOjHSjpIhecRVUZ5S8ZKHuR9cK/oPhCfgC9dEzxbI=;
        b=Btnjcji9IXCQ+nQKJLu2uuLBRSi6b3NpTPbp+aIKBf/SNOINmLwWCvMmt5vXnWOUN3
         iK8SsXvK6drNrbfmt7sY5YepLWFZ6EcuTam+QCsnrODNUoc+edxqOYV76rKGbolK2s5Q
         2H/OV5YwiywW5evJPP/RBk7PCajlUn3vAjk+6QJ6w6oRlYEa/aVIh/WtwohdQnC3ypSz
         BesHmxgtUyFv7EUMr1sNRczsdNNd9naZ09tvjkyQ76FtA15KDwzlzBc/OKKnpaVhKdSF
         rwD66LhXROnEGzq82k+fKmLqe+P8HG+FDK2RpTy10BZqsw/TB0zp3YQXTrzVXK9tlPPG
         SGvw==
X-Gm-Message-State: AFeK/H2Frcvlz23vkgrfdfyic1eWJRdVyTeBmrWfL8bRq8iKRBSPpTpAKmat2fQItZx+B5rheqlwSnYMiP9pmg==
X-Received: by 10.202.212.196 with SMTP id l187mr14308396oig.65.1491399659183;
 Wed, 05 Apr 2017 06:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 5 Apr 2017 06:40:28 -0700 (PDT)
In-Reply-To: <20170403162648.GA166794@google.com>
References: <1556910880cfce391bdca2d8f0cbcb8c71371691.1491206540.git.ps@pks.im>
 <20170403162648.GA166794@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Apr 2017 20:40:28 +0700
Message-ID: <CACsJy8CYzJv1RfC9-Z5gW_4a2cCX+0MbDtpgRD5kgoBDaQt67w@mail.gmail.com>
Subject: Re: [PATCH] pathspec: always honor `PATHSPEC_PREFIX_ORIGIN` flag
To:     Brandon Williams <bmwill@google.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2017 at 11:26 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/03, Patrick Steinhardt wrote:
>> Previous to commit 5d8f084a5 (pathspec: simpler logic to prefix original
>> pathspec elements, 2017-01-04), we were always using the computed
>> `match` variable to perform pathspec matching whenever
>> `PATHSPEC_PREFIX_ORIGIN` is set. This is for example useful when passing
>> the parsed pathspecs to other commands, as the computed `match` may
>> contain a pathspec relative to the repository root. The commit changed
>> this logic to only do so when we do have an actual prefix and when
>> literal pathspecs are deactivated.
>>
>> But this change may actually break some commands which expect passed
>> pathspecs to be relative to the repository root. One such case is `git
>> add --patch`, which now fails when using relative paths from a
>> subdirectory. For example if executing "git add -p ../foo.c" in a
>> subdirectory, the `git-add--interactive` command will directly pass
>> "../foo.c" to `git-ls-files`. As ls-files is executed at the
>> repository's root, the command will notice that "../foo.c" is outside
>> the repository and fail.

Oops. Sorry I missed this.

>> @@ -504,12 +504,12 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>>        * Prefix the pathspec (keep all magic) and assign to
>>        * original. Useful for passing to another command.
>>        */
>> -     if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
>> -         prefixlen && !get_literal_global()) {
>> +     if (flags & PATHSPEC_PREFIX_ORIGIN) {
>>               struct strbuf sb = STRBUF_INIT;
>>
>>               /* Preserve the actual prefix length of each pattern */
>> -             prefix_magic(&sb, prefixlen, element_magic);
>> +             if (prefixlen && !get_literal_global())
>> +                     prefix_magic(&sb, prefixlen, element_magic);
>>
>>               strbuf_addstr(&sb, match);
>>               item->original = strbuf_detach(&sb, NULL);
>
> Would it just make sense to drop the requirement that prefixlen be
> non-zero?  My problem with this change currently is the ability to get
> an original string with is empty (ie "\0") which would cause git to
> throw some warnings about not allowing empty strings as pathspecs if
> they were then passed on to other processes.

Good catch.

I did wonder if it's a right thing, because the result pathspec is
':(prefix:0)'. After leaving out the magic path, you get an empty
"path" of the pathspec, which probably should be warned because we
wouldn't be able to handle it. For example, "git add ." at root will
give you the path ".", not empty one. Maybe we can't handle the empty
"path" part.

But we have an exception for this already. In "git add :/", the "path"
of the pathspec is still empty ('/' is a magic, not "path" even if it
looks like so) and we handle it just fine. So everything should be
good here.

Patrick, please add a line or two about why you drop prefixlen when
you re-roll (or even better, make it a separate patch; this sounds
like an issue even before the code reorganization changes).
-- 
Duy
