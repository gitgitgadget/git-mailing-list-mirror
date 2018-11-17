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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EDD01F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 21:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeKRHcY (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 02:32:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46688 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeKRHcY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 02:32:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id b34-v6so22352271ede.13
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 13:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OgCPJ1LtKPIDmqXgJIOVzhSIglMoqWrfLgHbiqZ/rCk=;
        b=LEGTQb+plRGuyMyvUHoDX2527K20zK+eVXNoSdw9G2VrkW/b6yH9x6BsTZdhTVps1W
         j9JU3eCx3myFlFHTnuheY+kJ4/jkdQBr2sNVLI4AZYZmR1mx2VQ1q6h8MJxby4ov04t1
         0OO/mrytHUInhDytk4kUkG6eGREjoZ7f5VAEg6EkF5uSNjn7nKjgcMvuQlfTNr6/sdPw
         YHdLQfXiRkTIKy3DD2Q8AzxwzTWnKip/Xrq1jqbmT5cBkzNg2kRNMw9d7sr06CZxU9Jc
         QE6qloN0hXyytRwgE2BNLkJpwXuOoFg852fbYRarXEsrH9uVuzQjHqZWcBZzU+ex5SXy
         hXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OgCPJ1LtKPIDmqXgJIOVzhSIglMoqWrfLgHbiqZ/rCk=;
        b=jgE2v/KwDm84iHDsfL20GFCHLc0qjlJmUnjtTKhcJi4Pqkn9rGzSfAFCEzflJDHwdI
         imCVMk4o+0L9cnAXgBENGKODYtmW0qWBv59bV9tz3S64IGqElYwgwv6D3HhMiffkay7e
         kB6Wpggx2QLltVfdCldEZnCcVYTHBQZZVx3h22E+iWsjI/645YgjLFgAtv3VFfL37jDa
         Bw19XxppGL3paTI64OsHiHzSSs27a+pbEM6g6C0Gne4b2wWw7n/xT0zhH1AV/cNpIQLG
         elnl3XYhi6GiyypJ7E7zYgSpSs3OXXXHLeITY3lbhXQLsN31wFByxOOxIo2qUFKvYU0u
         MduQ==
X-Gm-Message-State: AGRZ1gLSBOBDfUJI0DS/Dq0n1MbcDKjTVgQ5GCSor/pJkKh0vJW/Zcs1
        yNacVb7qBkNRp8dD9bjj59Y=
X-Google-Smtp-Source: AJdET5ciB8OJUDl/PdvUti8pm4qn8DWgmFLZ0ofD+ezmaOeEdjSRI0g7uyjRECMkqNslPrkjktiGjQ==
X-Received: by 2002:a50:ca47:: with SMTP id e7-v6mr14374770edi.56.1542489263810;
        Sat, 17 Nov 2018 13:14:23 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id q4sm5439357eda.50.2018.11.17.13.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 13:14:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org> <xmqqpnv4gigi.fsf@gitster-ct.c.googlers.com> <CAP8UFD0f_oD2cm61exc9mCczD59ze0Qj1cHGn-MvtSMWNXA+gg@mail.gmail.com> <xmqqftvzhn22.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqftvzhn22.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 17 Nov 2018 22:14:21 +0100
Message-ID: <87ftvz1k5u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 17 2018, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> "However, as noted in those commits we'd still create the file as
>> 0600, and would just re-chmod it only if core.sharedRepository is set
>> to "true" or "all". If core.sharedRepository is unset or set to
>> "false", then the file mode will not be changed, so without
>> core.splitIndex a system with e.g. the umask set to group writeability
>> would work for a group member, but not with core.splitIndex set, as
>> group members would not be able to access the shared index file.
>
> That is irrelevant.  The repository needs to be configured properly
> if it wanted to be used by the members of the group, period.
>
>> It is unfortunately not short lived when core.sharedrepository is
>> unset for example as adjust_shared_perm() starts with:
>>
>> int adjust_shared_perm(const char *path)
>> {
>>         int old_mode, new_mode;
>>
>>         if (!get_shared_repository())
>>                 return 0;
>>
>> but get_shared_repository() will return PERM_UMASK which is 0 when
>> git_config_get_value("core.sharedrepository", ...) returns a non zero
>> value which happens when "core.sharedrepository" is unset.
>
> Which is to say, you get an unwanted result when your repository is
> not configured properly.  It is not a news, and I have no sympathy.
>
> Just configure your repository properly and you'll be fine.
>
>>> > Ideally we'd split up the adjust_shared_perm() function to one that
>>> > can give us the mode we want so we could just call open() instead of
>>> > open() followed by chmod(), but that's an unrelated cleanup.
>>>
>>> I would drop this paragraph, as I think this is totally incorrect.
>>> Imagine your umask is tighter than the target permission.  You ask
>>> such a helper function and get "you want 0660".  Doing open(0660)
>>> would not help you an iota---you'd need chmod() or fchmod() to
>>> adjust the result anyway, which already is done by
>>> adjust-shared-perm.
>>
>> It seems to me that it is not done when "core.sharedrepository" is unset.
>
> So?  You are assuming that the repository is misconfigured and it is
> not set to widen the perm bit in the first place, no?
>
>>> > We already have that minor issue with the "index" file
>>> > #leftoverbits.
>>>
>>> The above "Ideally", which I suspect is totally bogus, would show up
>>> whey people look for that keyword in the list archive.  This is one
>>> of the reasons why I try to write it after at least one person
>>> sanity checks that an idea floated is worth remembering.
>>
>> It was in Ævar's commit message and I thought it might be better to
>> keep it so that people looking for that keyword could find the above
>> as well as the previous RFC patch.
>
> So do you agree that open(0660) does not guarantee the result will
> be group writable, the above "Ideally" is misguided nonsense, and
> giving the #leftoverbits label to it will clutter the search result
> and harm readers?  That's good.

Aside from issues with the clarity of the commit message, which I'll fix
& thanks for pointing them out. I think we may have stumbled on
something more important here.

Do you mean that you don't agree that following should always create
both "foo" and e.g. ".git/refs/heads/master" with the same 644
(-rw-rw-r--) mode:

    (
        rm -rf /tmp/repo &&
        umask 022 &&
        git init /tmp/repo &&
        cd /tmp/repo &&
        echo hi >foo &&
        git add foo &&
        git commit -m"first"
    )

To me what we should do with the standard umask and what
core.sharedRepository are for are completely different things.

We should in git be creating files such that if I set my umask to
e.g. 022 all users on the system can read what I'm creating.

E.g. I tend to use this on something like a production server where
others (if I'm asleep) might want to look at my .bash_history as a last
resort, and also some one-off repo I've created without setting
core.sharedRepository.

I've yet to run into a case where this doesn't just work, aside from
core.splitIndex where before the patch here we're using a tempfile API
for something that isn't a tempfile.

This is distinct from the core.sharedRepository use-case, where you'd
like to on a per-repo basis override what you'd otherwise get with the
umask. E.g. if you have a shared server hosting a shared git repo, where
users with umask 077 will still be forced to create e.g. group rw files.
