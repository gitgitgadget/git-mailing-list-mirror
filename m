Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959552018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbcF0QOv (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:14:51 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32995 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcF0QOu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 12:14:50 -0400
Received: by mail-io0-f180.google.com with SMTP id t74so156593665ioi.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 09:14:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GgQVUElfHXDAPmWUzGJ4sS5BmSZBjd0Tj57gWoGpOek=;
        b=tqJ6CL8yPbBPx1qU1TGOsG/bHnJPXPHp4PkNTd/z0M+IFo+merCimuscozd8bqN2PR
         0JfajFPA2BRSS+l12JmHB6B0Re+tlbOIMOKUwAEiMt5r3nbZtBiSxJRADgdInjDE6fR0
         nliFLmvwNIJqglXDZ230wH6BrYDjTJJsMtTgk8vQxlDzF0nOl7ESP9uVBxLQZc4EzPjx
         ZL7+UZvtm8nVZ4qgU6Mzoh8LfYk55Km2Wf+K8shsA+gvlJ0/V7tx8FhJPhTbaBydJeqr
         fiLHCU1z4pvaizIrWk8rRfasU8y5UrFgBIJSoEgcEH4C4CDs0cI8p2uM06GIT9zMlhaw
         7OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GgQVUElfHXDAPmWUzGJ4sS5BmSZBjd0Tj57gWoGpOek=;
        b=S5/rpM4iAsMBIsU0Dde3y7gUSWkLwBp6yzE3TQ46SRYoCYbhWTVKIWwBBY+ioALzr4
         6zHfbro+QVxuEY2VFx4cwQSkATiQR2eCpT52ZGluCqosSJGRBbzNXx7Jwq6KOefvb9l4
         x4IhytyFO8i8qCZPLSV3ZDh6ZDQdps6Rc4YvHLZ4r4ohgjVM+LPtO2OaHSsxz5JY/Fyy
         fD/vvGbxEi88fF74Mr0Oq+UiU7i3b5qsgycPduOGYUBatVdkqXFNpgT8lqL8wosV9Gfd
         rH/3TlC3zNNIcBWwkooNxTTtNVdWYxC/4lHxB6C/EdDIglPOy392LTwif9ySMLU89www
         vOqw==
X-Gm-Message-State: ALyK8tLvQL7MD0BdQRUBoqneBzP3Hx2mOEAFhab9ZX9yxXgObMQY7IPmU/81diGcOcO0qXFW9OJ+85Gd4jCcdQ==
X-Received: by 10.107.22.6 with SMTP id 6mr1572726iow.128.1467044087003; Mon,
 27 Jun 2016 09:14:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 09:14:17 -0700 (PDT)
In-Reply-To: <20160626182715.GA12546@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com> <20160626182715.GA12546@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 18:14:17 +0200
Message-ID: <CACsJy8DAMe3YH-f_Qm8FEmanXepnwF2z1L6DDGoJf1eysmW2xQ@mail.gmail.com>
Subject: Re: [PATCH] config: add conditional include
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 8:27 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 26, 2016 at 09:06:17AM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> If the path argument in "include" starts with "gitdir:", it is
>> followed by a wildmatch pattern. The include is only effective if
>> $GIT_DIR matches the pattern. This is very useful to add configuration
>> to a group of repositories.
>
> I think this needs some more introduction to the concept. When you say
> "path argument" here, I assumed you meant the value of include.path. But
> you really mean: we are introducing a new concept for the "subsection"
> field of include.*, which is to provide restrictions for conditional
> includes.

Yep.

>
> It also may be worth discussing the motivation or examples.
>
>> For convenience
>>
>>  - "~" is expanded to $USER
>>
>>  - if the pattern ends with '/', "**" will be appended (e.g. foo/
>>    becomes foo/**). In other words, "foo/" automatically matches
>>    everything in starting with "foo/".
>>
>>  - if the pattern contains no slashes, it's wrapped around by "**/"
>>    and "/**" (e.g. "foo" becomes "**/foo/**"). In other words, "foo"
>>    matches any directory component in $GIT_DIR.
>>
>> The combination of the first two is used to group repositories by
>> path. While the last one could be used to match worktree's basename.
>
> This is a nice description, but it probably belongs in the
> documentation.

Yeah.. just too lazy for proper documentation at this stage.

>
> I don't have any real opinion on the rules themselves, though they seem
> reasonable to me (though in the first one I assume you mean $HOME).

Yep $HOME, what was I thinking...

(skipping all the technical suggestions, will do.. most likely)

>> +             } else if (!strchr(pattern.buf, '/')) {
>> +                     /* no slashes match one directory component */
>> +                     strbuf_insert(&pattern, 0, "**/", 3);
>> +                     strbuf_addstr(&pattern, "/**");
>> +             }
>
> I guess it's a little funny that "foo" and "foo/bar" are matched quite
> differently. I wonder if a simpler rule would just be: relative paths
> are unanchored.

I modeled it after .gitignore patterns, but that's probably not a good
fit here. Making all relative paths un-anchored means I can't say
"paths that end with this suffix". How useful that statement is, I
can't say though. Or if you mean only prepend "**/" to relative paths,
not "/**" then that door is still open.

(after a couple more minutes..) hmm.. I think that "paths that end
with ..." may have its use. The degenerated case is "match $(basename
<path>)", not very useful for gitdir when most of the time $(basename)
is ".git". It could be useful for "worktree:" matching and would
reduce false positives a bit (compared to un-anchoring both ends).
Conditionally including some config per worktree this way is also an
interesting way to deal with per-worktree config, but I need more time
to think about that...
-- 
Duy
