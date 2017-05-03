Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4621F829
	for <e@80x24.org>; Wed,  3 May 2017 14:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbdECOnC (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 10:43:02 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34636 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbdECOnA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 10:43:00 -0400
Received: by mail-ua0-f179.google.com with SMTP id g49so42731343uaa.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WmnTCeOqSl9uUXlay965ZPHz8LZimXIhBXM3ApkJp08=;
        b=QZAHWYwruMlU1aZtjHY+UvM84KxI+eOFNTaNbVgRVt4W7NJ+/aMzW1ic5nv9fSEyiW
         4aH0/J294PGq3nlm4q8g90Hr+lRAcG32YISkRea8ne1WOuHeIJcQS6YDWeq1H9/umuAc
         WY6kio7AJHI8zZ1K/wXtBYEkshWIgyME8Rnn+zl+yS4JyAw0ZWGNLKTkOYwdZvCXXT/R
         zme3cFZ1bFYtkv8hiL5EF7IpcB4ZBqPGbmGIfJISyRywN44Jq7LGdr8YDcf3+vv5Px4i
         kWw45D8ci3Wi4mlDIiZVX85ULFq66yTGY0ql6rPr8c3XVHYbHWpsSq34o0lKdSIXobFl
         ItJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WmnTCeOqSl9uUXlay965ZPHz8LZimXIhBXM3ApkJp08=;
        b=gqmqHFBE/L4GV5jB9nR8J31bN0+q9b58BhFRKzB+nKhr6o1B/6JM18XiRCwKs+i8n8
         NF4H6bcrYbl67RmQPg/mUe83ax6Wj6gj7aItUtqN10cB37IjAcOld4eWbYCWxkJPTiJF
         V4ThSpjPxh5nvecS9QkcvAFI+qhMm5XKm2YNpIO/TfW1QtVPoaZAW7ydpmjAdjXXmrME
         V2/xBsByjx9MShM7WxCqx7/8DuDHqX1jjnAEyD8dpabh6kP2UM/ZwE7/wcHrs1+Kd6C5
         z5nJ88h/n+MG8U/IqvnlDrH/DHY1oAr0mMGQSTnqe6JEqSYUK1mq86wP2mn7pAP7E+75
         VAGw==
X-Gm-Message-State: AN3rC/6ySbiZc9Spbt8Qjbh5y+IBPzu5iXvyTntajyS/3UGYcSDGN1Wj
        yKXNm+e1+dEXQ0+qj6/15iixEi++6Q==
X-Received: by 10.176.2.98 with SMTP id 89mr10658270uas.152.1493822579118;
 Wed, 03 May 2017 07:42:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Wed, 3 May 2017 07:42:58 -0700 (PDT)
In-Reply-To: <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net> <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net> <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 3 May 2017 16:42:58 +0200
Message-ID: <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial clone
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc'ing =C3=86var because of his work on 'clone --no-tags'.


On Wed, Mar 15, 2017 at 6:08 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 11, 2017 at 01:41:34AM +0100, SZEDER G=C3=A1bor wrote:
>> > Though if I'm bikeshedding, I'd probably have written the whole thing
>> > with an argv_array and avoided counting at all.
>>
>> Yeah, I did notice that you love argv_array :)  I had to raise an
>> eyebrow recently while looking at send-pack and how it uses argv_array
>> to read refspecs from stdin into an array.  I think argv_array feels a
>> bit out of place in both cases.  Yes, it does exactly what's needed.
>> However, it's called *argv*_array, indicating that its contents is
>> destined to become the options of some command.  But that's not the
>> case in these two cases, we are not dealing with arguments to a
>> command, these are just arrays of strings.
>
> In my mind, "argv" is synonymous with "NULL-terminated array of
> strings". If the name is the only thing keeping it from wider use, I'd
> much prefer us to give it a more generic name. All I really care about
> is simplifying memory management. :)

Whether its name is the _only_ thing keeping it from wider use, I
don't know :)

All I can say is that I was aware of argv_array, but because of
its name it didn't even occur to me.  And even if I had considered it,
I still wouldn't have used it here.  Had it been called string_array,
I think I would have used it.

On a related note, we have string_list, which is not a list but an
ALLOC_GROW()-able array, and not that of strings (i.e. plan char*),
but of structs with a string and an additional data field.
Oh, well :)


>> > I do also notice that right _after_ this parsing, we use remote_get(),
>> > which is supposed to give us this config anyway. Which makes me wonder
>> > if we could just reorder this to put remote_get() first, and then read
>> > the resulting refspecs from remote->fetch.
>>
>> Though get_remote() does give us this config, at this point the
>> default fetch refspec has not been configured yet, therefore it's not
>> included in the resulting remote->fetch array.  The default refspec is
>> set in write_refspec_config(), but that's called only about two
>> screenfulls later.  So there is a bit of extra work to do in order to
>> leverage get_remote()'s parsing.
>>
>> I think the simplest way is to keep parsing the default fetch refspec
>> manually, and then append it to the remote->fetch array.  Definitely
>> shorter and simpler than that parsing in the current patch.
>> Alternatively, we could set the default fetch refspec in the
>> configuration temporarily, only for the duration of the get_remote()
>> call, but it feels a bit too hackish...
>
> Yeah, I think manually combining the two here is fine. Though I won't
> complain if you want to look into setting the config earlier. If the
> refactoring isn't too bad, it would probably provide the nicest outcome.

I did actually look into that, but don't think it's a good idea.

write_refspec_config() nicely encapsulates writing the proper fetch
refspec configuration according to the given command line options.  Of
course these options are already known right at the start, so solely
in this regard we could call this function earlier.  However, in some
cases, e.g. '--single-branch', the refspec to be written to the config
depends not only on the given options but on the refs in the remote
repository, too, so it can only be written after we got the remote's
refs.


Unfortunately, there is more to this issue.  Earlier I though that the
fetch refspec is the only config that is ignored during a clone.
However, =C3=86var's 'clone --no-tags' patches[1] drew my attention to the
'remote.<name>.tagOpt' config variable, that I overlooked earlier...
and apparently 'git clone' overlooks it as well, grabbing all tags
even when it's set to '--no-tags'.

The root issue is that 'git clone' calls directly into the fetch
machinery instead of running 'git fetch' (either via run_command() or
cmd_fetch()), and some of these "higher-level" config variables are
only handled in 'builtin/fetch.c' but not in 'git clone'.  By
"handle" I mean "parse and act accordingly": as it happens, these
config values are parsed alright when 'git clone' calls remote_get(),
but it never looks at the relevant fields in the resulting 'struct
remote'.

Luckily, many "lower-level" config variables are working properly even
during 'git clone', because they are handled in the transport layer,
e.g. 'git clone -c url.https://github.com/.insteadof=3Dgh: gh:git/git'
does the right thing.


I'm not sure what the right way forward would be.

My patch deals with 'remote.<name>.refspec', i.e. 'remote->fetch'.
Apparently some extra care is necessary for 'remote.<name>.tagOpt' and
'remote->fetch_tags', too.  Perhaps there are more, I haven't checked
again, and maybe we'll add similar config variables in the future.  So
I don't think that dealing with such config variables one by one in
'git clone', too, is the right long-term solution...  but perhaps it's
sufficient for the time being?

Running a fully-fledged 'git fetch' seems to be simpler and safer
conceptually, as it would naturally handle all fetch-related config
variables, present and future.  However, it's not without drawbacks:
'git clone' must set the proper config before running 'git fetch' (or
at least set equivalent cmdline options), which in some cases requires
the refs in the remote repository, making an additional "list remote
refs" step necessary (i.e. both 'clone' and 'fetch' would have to
retrieve the refs from the remote, resulting in more network I/O).

Or we should libify more of 'builtin/fetch.c', but with all those
static variables and functions in there...  Ugh :)


G=C3=A1bor
