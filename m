Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A8F1FC43
	for <e@80x24.org>; Sat, 11 Mar 2017 00:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbdCKAli (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 19:41:38 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34589 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdCKAlh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 19:41:37 -0500
Received: by mail-vk0-f47.google.com with SMTP id r136so15020791vke.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 16:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fkdurgBy9H4fp85xwEJ95JCcSEdmC7bmb1FJ38mFmwk=;
        b=IIiymswcGUL4IuwzOlbuzlGzOnhVUnEYRarzlEEh0HXFdDqncKlbEuN5/kiKCZ5jxT
         t8s18DdHozsTwthIUdnFZ824ueIZVNiBTz5M+jIeldlTfUCpNc9KFE+cQbxOlSM4bqqJ
         9PRDltrQVCXCB3bouYlUD8LUDo07fqfmhim4XZXc1yigPKVjT46uBNW+SHUrKnhBSIsq
         ETgzZ5UpUZrLvxZSnIpZ8JuoE7x4OLr4OmPY7SGaVpOE22qb4J9zogBuw3EQ1GcnWTLn
         WmMwEIX6Sq+GzbXiA40V/7EpCpFYezEJEMK/TMnSAdr0s2aBmPW3I8UiTsSEF1JKNWVT
         pJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fkdurgBy9H4fp85xwEJ95JCcSEdmC7bmb1FJ38mFmwk=;
        b=QgV+7RJqYC9HzaoY/R5N++NwnpiO+6owMrnPFlWEh8m1c/ROdtQ2ceuU23jzZhyL/K
         EtXiqIqXKBdGLkP2E8hXtMP5LwYmEUh67PKK5G28vbTcurLxHaiQvBlzUu72+3uSo52i
         s+us76boBNa0nEmNLfkBRuWHmgvtXenGzQ8oXQZc/RE2dYFIm4AN/FA9iutYHI8S4cej
         RrJyHtIMBvDTI09fnwsgIOLjMTb93sCCOy2Pd29+cKXbAxqzkIdzxPUD6MlMVsyELs3N
         fRFonypdi+jGhoZIrwVZQHeQ7GeDqbrfzYfosFJIxjKB7xk4RN+/eDSljxZHPzZiyyju
         ydhw==
X-Gm-Message-State: AMke39kmVho40BV9qR9tBxNG5q02uSADGjl8tCSv1X5duOw+Il1jDepbgsToYKC1wtmjPzF/epiITugJcyijFQ==
X-Received: by 10.31.86.3 with SMTP id k3mr10404874vkb.154.1489192895347; Fri,
 10 Mar 2017 16:41:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.29 with HTTP; Fri, 10 Mar 2017 16:41:34 -0800 (PST)
In-Reply-To: <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net> <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 11 Mar 2017 01:41:34 +0100
Message-ID: <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial clone
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 10:12 PM, Jeff King <peff@peff.net> wrote:

> I didn't actually review it very carefully before, but I'll do so now
> (spoiler: a few nits, but it looks fine).
>
>>  static struct ref *wanted_peer_refs(const struct ref *refs,
>> -             struct refspec *refspec)
>> +             struct refspec *refspec, unsigned int refspec_count)
>
> Most of the changes here and elsewhere are just about passing along
> multiple refspecs instead of a single, which makes sense.

The new parameter should perhaps be renamed to 'refspec_nr', though,
as '_nr' suffix seems to be more common in the codebase than '_count'.

>> @@ -856,7 +861,9 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
>>       int submodule_progress;
>>
>>       struct refspec *refspec;
>> -     const char *fetch_pattern;
>> +     unsigned int refspec_count =3D 1;
>> +     const char **fetch_patterns;
>> +     const struct string_list *config_fetch_patterns;
>
> This "1" seems funny to up here by itself, as it must be kept in sync
> with the later logic that feeds exactly one non-configured refspec into
> our list. The current code isn't wrong, but it would be nice to have it
> all together. I.e., replacing:
>
>> +     if (config_fetch_patterns)
>> +             refspec_count =3D 1 + config_fetch_patterns->nr;
>> +     fetch_patterns =3D xcalloc(refspec_count, sizeof(*fetch_patterns))=
;
>> +     fetch_patterns[0] =3D value.buf;
>
> with:
>
>   refspec_count =3D 1;
>   if (config_fetch_patterns)
>         refspec_count +=3D config_fetch_patterns->nr;
>   ...

Agreed.

> Though if I'm bikeshedding, I'd probably have written the whole thing
> with an argv_array and avoided counting at all.

Yeah, I did notice that you love argv_array :)  I had to raise an
eyebrow recently while looking at send-pack and how it uses argv_array
to read refspecs from stdin into an array.  I think argv_array feels a
bit out of place in both cases.  Yes, it does exactly what's needed.
However, it's called *argv*_array, indicating that its contents is
destined to become the options of some command.  But that's not the
case in these two cases, we are not dealing with arguments to a
command, these are just arrays of strings.

However, leveraging get_remote() makes it moot anyway.

>> +     refspec =3D parse_fetch_refspec(refspec_count, fetch_patterns);
>>
>> +     strbuf_reset(&key);
>>       strbuf_reset(&value);
>>
>>       remote =3D remote_get(option_origin);
>
> I do also notice that right _after_ this parsing, we use remote_get(),
> which is supposed to give us this config anyway. Which makes me wonder
> if we could just reorder this to put remote_get() first, and then read
> the resulting refspecs from remote->fetch.

Though get_remote() does give us this config, at this point the
default fetch refspec has not been configured yet, therefore it's not
included in the resulting remote->fetch array.  The default refspec is
set in write_refspec_config(), but that's called only about two
screenfulls later.  So there is a bit of extra work to do in order to
leverage get_remote()'s parsing.

I think the simplest way is to keep parsing the default fetch refspec
manually, and then append it to the remote->fetch array.  Definitely
shorter and simpler than that parsing in the current patch.
Alternatively, we could set the default fetch refspec in the
configuration temporarily, only for the duration of the get_remote()
call, but it feels a bit too hackish...

>> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
>> index e4850b778c..3bed17783b 100755
>> --- a/t/t5611-clone-config.sh
>> +++ b/t/t5611-clone-config.sh
>> @@ -37,6 +37,30 @@ test_expect_success 'clone -c config is available dur=
ing clone' '
>>       test_cmp expect child/file
>>  '
>>
>> +test_expect_success 'clone -c remote.origin.fetch=3D<refspec> works' '
>> +     rm -rf child &&
>> +     git update-ref refs/grab/it refs/heads/master &&
>> +     git update-ref refs/keep/out refs/heads/master &&
>> +     git clone -c "remote.origin.fetch=3D+refs/grab/*:refs/grab/*" . ch=
ild &&
>> +     (
>> +             cd child &&
>> +             git for-each-ref --format=3D"%(refname)" refs/grab/ >../ac=
tual
>> +     ) &&
>> +     echo refs/grab/it >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'git -c remote.origin.fetch=3D<refspec> clone works=
' '
>> +     rm -rf child &&
>> +     git -c "remote.origin.fetch=3D+refs/grab/*:refs/grab/*" clone . ch=
ild &&
>> +     (
>> +             cd child &&
>> +             git for-each-ref --format=3D"%(refname)" refs/grab/ >../ac=
tual
>> +     ) &&
>> +     echo refs/grab/it >expect &&
>> +     test_cmp expect actual
>> +'
>
> These look reasonable. Using "git -C for-each-ref" would save a
> subshell, but that's minor.

Loosing a subshell is good, but I subjectively like how the
indentation highlights that that command operates on a different
repository.

However, the tests should also check that refs matching the default
fetch refspec are transferred, too, i.e. that the clone has something
under refs/remotes/origin/ as well.  Case in point is using the result
of get_remote(): at first I naively set out to use remote->fetch
as-is, which didn't include the default fetch refspec, hence didn't
fetch refs/heads/master, but the test succeeded nonetheless.

> If we wanted to be thorough, we could also check that the feature works
> correctly with "--origin" (I think it does).

I think it works, but I'm not quite sure what you mean with "works
correctly with --origin".

So just to be clear: the behaviour depends on whether the remote name
given in '-c remote.<name>.fetch=3D<refspec>' matches the name given to
the '--origin=3D<name>'.  If they match, then refs matching the
additional refspec are transferred, too.  That's good.  However, if
the two remote names don't match, then refs matching the additional
refspec are NOT transferred.  I think this is good, too, because only
the origin remote should be cloned, whatever it is called, and in this
case that additional refspec belongs to a different remote.

G=C3=A1bor
