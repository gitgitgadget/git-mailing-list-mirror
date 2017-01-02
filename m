Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50E01FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbdABJjL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 04:39:11 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34113 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbdABJjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 04:39:09 -0500
Received: by mail-lf0-f66.google.com with SMTP id d16so27396627lfb.1
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OtPqdndahpXh6T/Ygn8OpEx9+c7Qup7p2UaXXqy0a94=;
        b=gOnBQtd+b6ffdxJDVVPAXBcuEDQYEI1e+4TB+wvFZgZek2z1gx2f3lahjGFsPXHqNb
         95DZl47wyRmdWIl0LPuH92cq+LAVkxLwgRn+3k7d2sLRCVzB9IofV0hNMAli9S5Lh1/N
         PUULbI2LWzq4dy1RyLME3n4tU/7f5IMddbeGLYJP2sMFJjZTp74SPJUIHQX1ZWhW+hdt
         XbySpsKenpGW1H/I8FSVWe3bAbPpdkEEzCFkIQPpV7G2RTKo3jDbP2eo8cEqX5XxEvI/
         6nnB6uPiVTPIl1tpZYbZfJw9lqRnVaClHFo7W2NrgM+wWvpwhlC5ztNJovJulkEjg8+R
         ZvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OtPqdndahpXh6T/Ygn8OpEx9+c7Qup7p2UaXXqy0a94=;
        b=hrCNxTdqBFNhNMuJ6yx1VxHxj8pRdYVqHVB9i43PJ2e2BrrXSf730KR38l40Zh5jMN
         27+mNho/AMwtIqbOO8kusI2UHqM+HrkYjqJGH9SigPYE3Dzv4MZCksusHdu0GpoYQgL6
         WeSJWzZjzbMWPKs4rEmZX0DUw9m8VgfM/JKCwf4ypCFflTJosHE3ly10jdXjVQ6lXZI0
         uP/A0V2WUCl4mIc2N3WgCIuko4bXhgFrVvPVi9ph6b14sRW0R32ANpSibj3R72vZNHva
         rgKHAMUtC48bLi9Nli7fKYkb193JiU5opeN+FUtfJ5ei0DQ4smv9xf56KDQS3QGjczx/
         IzKg==
X-Gm-Message-State: AIkVDXIWxQioclU6qY7iO1TfsH4xVyJW1StKy3wAK3JFioZ6ldG1LwoUXgPplgo4R2G4XbpVbMWwrMATqCzfhw==
X-Received: by 10.25.72.74 with SMTP id v71mr21753894lfa.130.1483349947357;
 Mon, 02 Jan 2017 01:39:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 01:39:06 -0800 (PST)
In-Reply-To: <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-9-chriscool@tuxfamily.org> <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 10:39:06 +0100
Message-ID: <CAP8UFD06mxGiZmr4Lwv3M8CedBZaamswzz-Q+mOxuuUFet8KNQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] Documentation/git-update-index: talk about
 core.splitIndex config var
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/git-update-index.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index 7386c93162..e091b2a409 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -171,6 +171,12 @@ may not support it yet.
>>       given again, all changes in $GIT_DIR/index are pushed back to
>>       the shared index file. This mode is designed for very large
>>       indexes that take a significant amount of time to read or write.
>> ++
>> +These options take effect whatever the value of the `core.splitIndex`
>> +configuration variable (see linkgit:git-config[1]).
>
> Doesn't the "whatever..." clause in this sentence lack its verb
> (presumably, "is", right after "variable")?

I think that it is ok to have no verb here. My preferred online
dictionary (http://www.wordreference.com/enfr/whatever) gives "We'll
try to free the hostage whatever the cost." as an example with no
verb, though I am not a native speaker.

Also note that I mostly copied what I had already written for
--(no-)untracked-cache:

--untracked-cache::
--no-untracked-cache::
    Enable or disable untracked cache feature. Please use
    `--test-untracked-cache` before enabling it.
+
These options take effect whatever the value of the `core.untrackedCache`
configuration variable (see linkgit:git-config[1]). But a warning is
emitted when the change goes against the configured value, as the
configured value will take effect next time the index is read and this
will remove the intended effect of the option.

>> +emitted when the change goes against the configured value, as the
>> +configured value will take effect next time the index is read and this
>> +will remove the intended effect of the option.
>
> It feels somewhat strange to see a warning in this case.

We already discussed the warning issue for --(no-)untracked-cache, and
I am just following the conclusions of that previous discussion about
--(no-)untracked-cache. See the end of this message where you
suggested the warning:

https://public-inbox.org/git/xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com/

> If the user configures the system to usually do X, and issues a
> command that explicitly does Y (or "not-X"), we do not warn for the
> command invocation if it is a single-shot operation.  That's the
> usual "command line overrides configuration" an end-user expects.
>
> I think you made this deviate from the usual end-user expectation
> because it is unpredictable when the configuration kicks in the next
> time to undo the effect of this command line request.  And I agree
> that it is a very un-nice thing to do to the users if we did not
> warn here, if we are to keep that unpredictableness.

I also think it would be strange and user unfriendly for
--untracked-cache and --split-index to behave differently, and I am
reluctant at this point to rework the way it works for
--untracked-cache.

> But stepping back a bit, we know the user's intention is that with
> "--split-index" the user wants to use the split index, even though
> the user may have configuration not to use the split index.  Don't
> we want to honor that intention?  In order to honor that intention
> without getting confused by the configured variable to tell us not
> to split, another way is to destroy that unpredictableness.  For
> that, shouldn't we automatically remove the configuration that says
> "do not split" (by perhaps set it to "do split")?  Doing so still
> may need a warning that says "we disabled your previously configured
> setting while at it", but it would be much better than a warning
> message that essentially says "we do it once, but we will disobey
> you at an unpredictable time", I would think.

I wanted to do that for --untracked-cache around one year ago but in
the following message:

https://public-inbox.org/git/xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com/

you wrote the following:

"Why is it a good idea to allow an explicit operation from the
command line to muck with the configuration?  If the user wants to
change the configuration permanently, "git config" has been there
for the purpose for all the configuration variables to do so for
almost forever.  Why is it a good idea to make this variable so
special that the user does not have to use "git config" but disable
or enable it in some other way?"

It feels strange that when I do things one way, you suggest another
way, and the next time in a similar situation when I do things the way
you suggested previously, then you suggest the way I did it initially
the first time...
