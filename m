Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97BF520248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCNP1K (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:27:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43591 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCNP1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:27:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id m35so4974281ede.10
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wF999szQda7yOzUGFLFHt4zDNzP+NvzdDTQkC1SB49A=;
        b=P5n9vOCgNbvsHjZ/v8AzvHeanYKkrFb/vg9Ybfvsq0qzezBBcFeowOsP9MmT2CaV2P
         4Lin1ugb8NR7Qo0Ec0v8u6EGCbqecGRlmHJn+d5gx1jMQS9ml3eguiOZo0BI4iiQejoX
         UP3a+hZvvegfLcvn65Kprf+QN5Y5cZZraJMr72zzM2KICD4FBAbU3RBEW8xKwSncJ27v
         fBkYTca2IJIpQXAf0jymgjMrCNbx3xe1IjVdeUfjlBYQ5RQXRKYcLy8hkIk6HPkcVHhK
         aNORow+0OYMonCp3f/+LySbmXz7+IZRgyYw9vyrpO76ZFB178VvgQrqt3dgWq07IPRKr
         DQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wF999szQda7yOzUGFLFHt4zDNzP+NvzdDTQkC1SB49A=;
        b=gRoG1jm30wKaAodI93M4QQ4U+7appMj0zpjl8dHP30JKuwWU4lFE0W2tDn/XnOzcVP
         1FjTbyy8NG/+qCMgq2F6htREZysYnAVI+I5EG90fHu5cDYmktlG1UytavUA5pOTggUl9
         rD1qIMtsNJ1sBgJT1spg1ifeX1C4yXLZTubXuAxisjvBWgz0BDZ7dhSlpIBjXMod4C00
         tg1E00nPg0NrS6JNXaUfQE+ozTymJpAGmUbZE+kL2Re1czJlO3N1qANdG35HyCzWiY4+
         bSroCrFn3+D/wOxmnm58/s3tKujwSDqr16SGajNX25xtKKW/m4hXvDxVd2T7/D5oiJMs
         zsSw==
X-Gm-Message-State: APjAAAWoBw12CRcL72XgQoG49T7kNsy3ZsyRQaI5srv07cIktEQs72ig
        a5HfXR8UqFp6g3oW1hIXCnY=
X-Google-Smtp-Source: APXvYqyFEt++o4pieN54Y7cq9JfsFy2v2kgPxR8QkG6QRIy4FGUHC5QJHU+C7BApy4qc7SRj/TzuRA==
X-Received: by 2002:a17:906:7210:: with SMTP id m16mr33981426ejk.171.1552577227973;
        Thu, 14 Mar 2019 08:27:07 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f5sm783936edt.36.2019.03.14.08.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 08:27:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase: remove the rebase.useBuiltin setting
References: <20190213142209.8226-1-avarab@gmail.com> <20190314132444.25881-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1903141544110.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1903141544110.41@tvgsbejvaqbjf.bet>
Date:   Thu, 14 Mar 2019 16:27:06 +0100
Message-ID: <87ef79bho5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 14 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 14 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Remove the rebase.useBuiltin setting, which was added as an escape
>> hatch to disable the builtin version of rebase first released with Git
>> 2.20.
>>
>> See [1] for the initial implementation of rebase.useBuiltin, and [2]
>> and [3] for the documentation and corresponding
>> GIT_TEST_REBASE_USE_BUILTIN option.
>>
>> Carrying the legacy version is a maintenance burden as seen in
>> 7e097e27d3 ("legacy-rebase: backport -C<n> and --whitespace=3D<option>
>> checks", 2018-11-20) and 9aea5e9286 ("rebase: fix regression in
>> rebase.useBuiltin=3Dfalse test mode", 2019-02-13). Since the built-in
>> version has been shown to be stable enough let's remove the legacy
>> version.
>
> I agree with that reasoning. Elsewhere, a wish cropped up for the `git
> stash` command to optionally ignore unmatched globs, and if we go about to
> implement this, we will have to implement it in the scripted and the
> built-in version. If we can at least avoid that for the `rebase` command,
> I think it would make things a bit easier over here.
>
>> diff --git a/Documentation/config/rebase.txt b/Documentation/config/reba=
se.txt
>> index 331d250e04..c747452983 100644
>> --- a/Documentation/config/rebase.txt
>> +++ b/Documentation/config/rebase.txt
>> @@ -1,16 +1,9 @@
>>  rebase.useBuiltin::
>> -	Set to `false` to use the legacy shellscript implementation of
>> -	linkgit:git-rebase[1]. Is `true` by default, which means use
>> -	the built-in rewrite of it in C.
>> -+
>> -The C rewrite is first included with Git version 2.20. This option
>> -serves an an escape hatch to re-enable the legacy version in case any
>> -bugs are found in the rewrite. This option and the shellscript version
>> -of linkgit:git-rebase[1] will be removed in some future release.
>> -+
>> -If you find some reason to set this option to `false` other than
>> -one-off testing you should report the behavior difference as a bug in
>> -git.
>> +	Unused configuration variable. Used between Git version 2.20
>> +	and 2.21 as an escape hatch to enable the legacy shellscript
>> +	implementation of rebase. Now the built-in rewrite of it in C
>> +	is always used. Setting this will emit a warning, to alert any
>> +	remaining users that setting this now does nothing.
>
> Do we really need to document this? Why not just remove the entire entry
> wholesale; the warning if `rebase.useBuiltin=3Dfalse` is set will be
> informative enough.

I don't have a super-strong preference in this case, but in general I
think it makes sense to have docs for this too.

Individual versions of git tend to be around for a while due to distro
packaging timelines, so e.g. if we're "lucky" a given version like 2.21
might be installed on say OSX for half a decade.

That'll mean some people probably setting this in config, and then when
they later wonder if it's needed they can Google search the config
option name or check it in git-config, less of a stretch than needing to
know to run git-rebase with the option...

>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 52114cbf0d..829897a8fe 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1143,21 +1143,8 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>>  	};
>>  	int i;
>>
>> -	/*
>> -	 * NEEDSWORK: Once the builtin rebase has been tested enough
>> -	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
>> -	 * can be removed.
>> -	 */
>> -
>> -	if (!use_builtin_rebase()) {
>> -		const char *path =3D mkpath("%s/git-legacy-rebase",
>> -					  git_exec_path());
>> -
>> -		if (sane_execvp(path, (char **)argv) < 0)
>> -			die_errno(_("could not exec %s"), path);
>> -		else
>> -			BUG("sane_execvp() returned???");
>> -	}
>> +	if (!use_builtin_rebase())
>> +		warning(_("The rebase.useBuiltin support has been removed!"));
>
> A couple of thoughts about this:
>
> - `use_builtin_rebase()` spawns a `git config`. This is a pretty expensive
>   operation on Windows (even if it might not matter in the big scheme of
>   things, as the couple of milliseconds are probably a mere drop on a hot
>   stone compared to the I/O incurred by the recursive merge), and it was
>   only done in that way to allow for spawning the legacy rebase without
>   having touched any global state (such as setting `GIT_*` environment
>   variables when a Git directory was discovered).
>
>   Couldn't we rather move this warning into `rebase_config()`?
>
> - The warning should start with a lower-case letter (why don't we have any
>   automated linter for this? This is a totally automatable thing that
>   could run as part of `make` when `DEVELOPER` is set, maybe just on the
>   `git diff HEAD --` part, and maybe even generating a patch that can be
>   applied; No human should *ever* need to spend time on such issues).

Both of these make sense. Will have that in a v3 pending further
feedback. Didn't notice that strange use_builtin_rebase()
implementation.

> - That warning should probably talk more specifically about the scripted
>   version having been removed, not only the option (which was actually not
>   removed, otherwise the user would not see that warning ;-)).

...or just change it to briefly refer to the git-config docs where all
of this will be explained :)

>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 3e73f7584c..0a88eed1db 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -311,4 +311,10 @@ test_expect_success 'rebase--merge.sh and --show-cu=
rrent-patch' '
>>  	)
>>  '
>>
>> +test_expect_success 'rebase -c rebase.useBuiltin=3Dfalse warning' '
>> +	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=3D \
>
> Good attention to detail! I would have forgotten to unset that environment
> variable.
>
>> +		git -c rebase.useBuiltin=3Dfalse rebase 2>err &&
>> +	test_i18ngrep "rebase.useBuiltin support has been removed" err
>> +'
>> +
>>  test_done
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
>> index b60b11f9f2..1723e1a858 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -149,12 +149,10 @@ test_expect_success 'rebase -i with the exec comma=
nd checks tree cleanness' '
>>
>>  test_expect_success 'rebase -x with empty command fails' '
>>  	test_when_finished "git rebase --abort ||:" &&
>> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=3Dtrue \
>> -		git rebase -x "" @ 2>actual &&
>> +	test_must_fail env git rebase -x "" @ 2>actual &&
>>  	test_write_lines "error: empty exec command" >expected &&
>>  	test_i18ncmp expected actual &&
>> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=3Dtrue \
>> -		git rebase -x " " @ 2>actual &&
>> +	test_must_fail env git rebase -x " " @ 2>actual &&
>>  	test_i18ncmp expected actual
>>  '
>>
>> @@ -162,8 +160,7 @@ LF=3D'
>>  '
>>  test_expect_success 'rebase -x with newline in command fails' '
>>  	test_when_finished "git rebase --abort ||:" &&
>> -	test_must_fail env GIT_TEST_REBASE_USE_BUILTIN=3Dtrue \
>> -		git rebase -x "a${LF}b" @ 2>actual &&
>> +	test_must_fail env git rebase -x "a${LF}b" @ 2>actual &&
>
> Not a terribly big deal, but I would have structured the patch (series) by
> leaving this change to t3404 as a 2/2, as it is not technically necessary
> to include those changes in 1/2 (if your goal is, as mine usually is, to
> "go from working state to working state" between commits).

I run the test suite on various git versions, including for bisecting
purposes and with various GIT_TEST_* options on.

I'll probably never bump into *this* particular commit for this option,
but in general I think it makes more sense to not break the test suite
under existing GIT_TEST_* flags, unless it's a breakage where e.g. we
say "this isn't supported anymore".

By splitting this up as you suggest the 1/2 of those would be a head
scratching breakage under GIT_TEST_REBASE_USE_BUILTIN=3Dfalse, and only
under 2/2 would we show via the warning why it was failing.
