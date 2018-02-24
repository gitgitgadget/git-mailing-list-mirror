Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041261F404
	for <e@80x24.org>; Sat, 24 Feb 2018 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeBXMuw (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 07:50:52 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:40439 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeBXMuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 07:50:51 -0500
Received: by mail-lf0-f47.google.com with SMTP id 37so16083339lfs.7
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hsIXHFpPKTJ6oSEsk93nMNDHa45pSwtPsmqkWzDxlYk=;
        b=ASYM9v7GWA7V/IlX74uqVdRk1QuLxWW4+8IHvQoqTo9PzhtCKanu3+OYFPkHrOhFhS
         mUIiprLYHD8zROCiYNOsMaG4jM7BGrJ+lEbPhzoswPVW8oGbHeTZS9ZsrDIo/bPnt5VC
         SdmWuG5Jm9IGTdtBz00OK36vCVYdbjjDxD4PGZ4v5z1uQWCuPChrLPIhv4LCLTE99dYK
         4N1HSrA86hBZS74fIGjXvjxcrQ5PL49STS0QIae1rjI1L89ofUII2/cGesvKPKXOpbJF
         5dlqzwrkazPi9He0dL7KRKqFSLdNkud2lqTFYJh0xP3LUEY66DBsEt1wAl/bi8QQTcJU
         ieFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hsIXHFpPKTJ6oSEsk93nMNDHa45pSwtPsmqkWzDxlYk=;
        b=RlzRaOiPinyqag7DKogbbObw89+qX4io4h6gxjgPflCjTuHgs71vRYygpHbKo8uQh+
         B1XZU0xCRo5hx7bIKYXi+rL2ZD3ruC0PyGE4uGpiYdUvQ5tN/N5U2aQ4QatMwN1E6E+D
         28tUmXLNfAMlL5CFEXrj4KBYaIb0/WNltBmQRyaqGwQZM0eOsI6/KH0v6NR5LTqajZFv
         v93QD9khgnijtna2NW9+ABy354LNKcWKXQXrhjJz/BRkosgoSXbwewST8OxuYW1DBsDh
         NtPe1HaJuCHzGRoIJHglEJjyufHQneU/R6gg/vGT8OKQuUzI7CwcDD+UfHzOsTWjszFp
         KzNw==
X-Gm-Message-State: APf1xPDf87nkNAfMYaUF6I//Y5qyXL4oZPv+Vv0EeM1qaAwuNWzL8B7A
        PLV3KlIYOIIbRC6gOWi6TDClkLPmW7YTFKD2kgQ=
X-Google-Smtp-Source: AG47ELvBvM/VteemPS/jJSXm3g6Amw4k6/NqEwb3UjqrwJLwQLXqMTog0PJn2Q7RQhjiwvXJLQ4SLCKzCZbGtIGXAUc=
X-Received: by 10.25.169.67 with SMTP id s64mr1231254lfe.80.1519476649475;
 Sat, 24 Feb 2018 04:50:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.22.2 with HTTP; Sat, 24 Feb 2018 04:50:48 -0800 (PST)
In-Reply-To: <CAE5ih7_=0Vn2J+TRnUfzT8TsyfmUa5PYpzviOf_DD+NTZtUZPA@mail.gmail.com>
References: <20180222095022.6227-1-luke@diamand.org> <20180222095022.6227-2-luke@diamand.org>
 <CAKYtbVYe5hHDXf=nQzt6r9N20CrTgbEMbBS0JBBXQLpz+BVu1A@mail.gmail.com>
 <CAE5ih79E1Z8h+hAgr8zCw7=Dtec6sxT7Xf4cWn8zOLNs=mY1jg@mail.gmail.com> <CAE5ih7_=0Vn2J+TRnUfzT8TsyfmUa5PYpzviOf_DD+NTZtUZPA@mail.gmail.com>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Sat, 24 Feb 2018 13:50:48 +0100
X-Google-Sender-Auth: OcEO5xWoZ5eTu2rLRnJ5oS6cAcY
Message-ID: <CAKYtbVYc3nF1C8cRrXwqfEb2OUamTrvq7dH_jE5TfuXvkMMfKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add unshelve command
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        gvanburgh@bloomberg.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 6:22 PM, Luke Diamand <luke@diamand.org> wrote:
> On 22 February 2018 at 22:28, Luke Diamand <luke@diamand.org> wrote:
>> On 22 February 2018 at 21:39, Miguel Torroja <miguel.torroja@gmail.com> wrote:
>>> Hi Luke,
>>>
>>> I really like the idea of creating a branch based on a shelved CL (We
>>> particularly use shelves all the time), I tested your change and I
>>> have some comments.
>>>
>>>  - I have some concerns about having the same "[git-p4...change =
>>> .....]" as if it were a real submitted CL.
>>>     One use case I foresee of the new implementation could be to
>>> cherry-pick that change on another branch (or current branch) prior to
>>> a git p4 submit.
>>
>> OK, I think we could just not add that in the case of an unshelved commit.
>>
>>>
>>>  - I see that the new p4/unshelve... branch is based on the tip of
>>> p4/master by default. what if we set the default to the current HEAD?
>>
>> There's a "--origin" option you can use to set it to whatever you want.
>>
>> I started out with HEAD as the default, but then found that to get a
>> sensible diff you have to both sync and rebase, which can be quite
>> annoying.
>>
>> In my case, in my early testing, I ended up with a git commit which
>> included both the creation of a file, and a subsequent change, even
>> though I had only unshelved the subsequent change. That was because
>> HEAD didn't include the file creation change (but p4/master _did_).
>
> Discussing this with some of my colleagues, and playing around with
> it, it seems that what it really needs to do is to figure out the
> parent commit of the shelved changelist, and use that as the basis for
> the diff.
>
> Unfortunately, Perforce doesn't have any concept of a "parent commit".
> One option that would be possible to implement though is to look at
> the shelved changelist, and foreach file, find the original revision
> number ("//depot/foo.c#97"). Then "p4 changes //depot/foo.c" would
> give you the changelist number for that file. Find the most recent P4
> changelist, find the git commit corresponding to that, and do the diff
> against that.
>
> It's pretty clunky, and I'm quite glad I didn't try to do that in the
> initial revision, as I would surely have given up!
>
> To do it properly of course you need to handle the case where the
> shelved changelist author had some files at one changelist, and others
> at another. But I think that's just far too complicated to deal with.
>
> Luke

The behavior of "p4 unshelve" and your "git p4 unshelve" approach I
think are equivalent
as p4 just copies the whole contents of the shelved file locally,
regardless of the previous revision synced.
In other words, you get the same result with "git p4 unshelve" than
with "p4 unshelve" now.

What about creating a new command in a future update to apply just the
change to your local tree?
One approach we took in the past was to create a diff patch and then
apply it to the working tree.
The command "p4 describe -S -du 12345" will output a patch but it has
two problems:
 * the header for each file is not standard, it has to be parsed and
converted, (it starts with "==== //depot/..." and it needs to be
converted to "--- a/...")
 * The new files are not output as a patch
let's say we call the command "git p4 cherry-pick"

Miguel
