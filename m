Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA061F461
	for <e@80x24.org>; Wed, 15 May 2019 22:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfEOWHn (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:07:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38503 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOWHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 18:07:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so1968784edl.5
        for <git@vger.kernel.org>; Wed, 15 May 2019 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MGhZo0NINM1IdneaCTdO6Muy86Xkpf9zZa0YczMBtBE=;
        b=Sn45DNsvh1qPHDxcwDN0E0qZap/iCYruL0SdPl7jP/bXFLfd09Hmw/IcgaX1M978lV
         Oxz5atY0mH3gwife13wEyrzMoYfVYMrJs0hJdqNkJh5sAHaS2B1bUetjzXiql/A9k54F
         Zw+6Mk6WIS/1XfOsvl8+G/a5MpnHQuHx/jGTFW0zfVVcCHFOjHFgyK8dPzZDweIDx21W
         252EVXinlfpdIZbX6wZ/aTaREj+vYbWzru/itBTRqte3+7RYSg1LTkgfzgCAGRZv/6G7
         J9jHjhYWf2goXdWOkLgOwNSjL6tk/PaHFPignbT9+K2NztWGariHMqv39XhUEnSYn01s
         7/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MGhZo0NINM1IdneaCTdO6Muy86Xkpf9zZa0YczMBtBE=;
        b=rdt1OB0CdxheUcfgw7aHX6aLsxXXaC44UuCbWtcFv2xTcBpsd1KDSI4iZKSRYPwpx3
         7R5JuwpZth+0OA7SPD7HcaI3bc1nEji/I3/8X0fOK6dQd08se96KWGLVxWSzxC/41N/K
         xW4zLmPgSpskDYMMBw/vqS5sR5xSPTHzh3RdTpoIM11/NJ3c07buZNAeuFHW/n5MDnuP
         B9rYszzIL2BE1ozLqsZ5+ADdOrCXj0crBCraNj5UD7WxDQWnORIqglI+qeuSNscGbm7e
         7+6xQ4kDQjPxj82NoDgFEZDbUBVoKVBogMwxh8eNgs0lfVmZiV5i1y4/jD2We+0B3wFn
         B/OA==
X-Gm-Message-State: APjAAAVo/sHeItf9vXvHr+48Eg/e05KcMaeYtYp710blw/6k8s/JNuVq
        v7/5g/Mi+S8zE1/moMd/fu4ZjD1/
X-Google-Smtp-Source: APXvYqwfkj4Q/iQag79yuHa5bwZn1WBJKE5+8ghpV/SC/ltS54pwwqXEzK4jATHYNJQ0TNBzeEBhzg==
X-Received: by 2002:a17:906:4408:: with SMTP id x8mr13267997ejo.93.1557958061055;
        Wed, 15 May 2019 15:07:41 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s57sm1173017edd.54.2019.05.15.15.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 15:07:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        "'Eric S. Raymond'" <esr@thyrsus.com>
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com> <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com> <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us> <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
Date:   Thu, 16 May 2019 00:07:39 +0200
Message-ID: <87zhnnv0b8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 15 2019, Derrick Stolee wrote:

> On 5/15/2019 4:28 PM, Jason Pyeron wrote:
>> (please don=E2=80=99t cc me)
>
> Ok. I'll "To" you.

I'm a rebel!

>> and we follow the rule that:
>>
>> 1. any trailing zero after the decimal point MUST be omitted
>> 2. if there are no digits after the decimal point, it MUST be omitted
>>
>> This would allow:
>>
>> committer Name <user@domain> 1557948240 -0400
>> committer Name <user@domain> 1557948240.12 -0400
>
> This kind of change would probably break old clients trying to read
> commits from new clients. =C3=86var's suggestion [1] of additional headers
> should not create incompatibilities.

Yes, exactly. Obviously patching git to do this is rather easy, here's
an initial try:

    diff --git a/date.c b/date.c
    index 8126146c50..0a97e1d877 100644
    --- a/date.c
    +++ b/date.c
    @@ -762,3 +762,3 @@ static void date_string(timestamp_t date, int offse=
t, struct strbuf *buf)
            }
    -       strbuf_addf(buf, "%"PRItime" %c%02d%02d", date, sign, offset / =
60, offset % 60);
    +       strbuf_addf(buf, "%"PRItime".12345 %c%02d%02d", date, sign, off=
set / 60, offset % 60);
     }
    diff --git a/usage.c b/usage.c
    index 2fdb20086b..7760b78cb6 100644
    --- a/usage.c
    +++ b/usage.c
    @@ -267,2 +267,3 @@ NORETURN void BUG_fl(const char *file, int line, co=
nst char *fmt, ...)
            va_list ap;
    +       return;
            va_start(ap, fmt);

We don't need BUG() right? :)

Now let's commit with that git, that gives me a commit object with a
sub-second timestamp like:

    $ git cat-file -p HEAD
    tree 4d5fcadc293a348e88f777dc0920f11e7d71441c
    author =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 155795=
5656.12345 +0200
    committer =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> 155=
7955656.12345 +0200

Works so far, yay!

And now fsck fails:

    error in commit 31b3e9b88c36f75b3375471d9f5b449165c9ff93: badDate: inva=
lid author/committer line - bad date

And any sane git hosting site will refuse this, e.g. trying to push this
to github:

    remote: error: object 31b3e9b88c36f75b3375471d9f5b449165c9ff93: badDate=
: invalid author/committer line - bad date
    remote: fatal: fsck error in packed object

And that's *just* dealing with the git.git client, any such format
changes also need to consider what happens to jgit, libgit2 etc. etc.

Once you make such changes to the format you've created your own
version-control system. It's no longer git.

>> By following these rules, all previous commits' hash are unchanged. Futu=
re commits made on the top of the second will look like old commit formats.=
 Commits coming from "older" tools will produce valid and mergeable objects=
. The loss precision has frustrated us several times as well.
>
> What problem are you trying to solve where commit date is important?
> The only use I have for them is "how long has it been since someone
> made this change?" A question like "when was this change introduced?"
> is much less important than "in which version was this first released?"
> This "in which version" is a graph reachability question, not a date
> question.
>
> I think any attempt to understand Git commits using commit date without
> using the underling graph topology (commit->parent relationships) is
> fundamentally broken and won't scale to even moderately-sized teams.
> I don't even use "git log" without a "--topo-order" or "--graph" option
> because using a date order puts unrelated changes next to each other.
> --topo-order guarantees that a path of commits with only one parent
> and only one child appears in consecutive order.
>
> Thanks,
> -Stolee
>
> P.S. All of my (overly strong) opinions on using commit date are made
> more valid when you realize anyone can set GIT_COMMITTER_DATE to get
> an arbitrary commit date.
>
> [1] https://public-inbox.org/git/871s0zwjv0.fsf@evledraar.gmail.com/T/#t
