Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEAC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiFMUZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351163AbiFMUZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 16:25:13 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F21C5DA6
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 12:07:52 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-f15a7ca913so5478335fac.8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gsnDJzjyyLInoxOzl0HESsldRYuBZXnzZyltgu2fd3U=;
        b=CVxSAXdpSrHau5MJQgTqIpa87Y2RFcgJ7wNYcC+jCP2HP+zs3RRF983pKwPvmoMS2X
         cjmmCJkmo+6hWZ10xBW9SgsZcqL3doHIvyG5Zfp5eBvjX8TbUAP3U3260RYI5tfvc61h
         /rwZAF+Dkj681IH3Q8pPEfl4ldPKVaQmNfJxRTULCMRA91vCJVvxSDWDyHKmfIAj2yFP
         1/rhEHJaM+5CrNalI2rRoZ4ZGUSdIAvIuFdk8Q10AE8YOBxa4KNdWLBDhuNME4Fy3Jzp
         kKMMxS4f/AR3TMNXcPgIIpqW2bthetXWoJBvWssuA4IQp09vhxlYqnmbhJFsmkOykUEz
         IcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gsnDJzjyyLInoxOzl0HESsldRYuBZXnzZyltgu2fd3U=;
        b=WeTqff9rP0rGwm7Mmq+Ei92v8jiGsKzbf/vDHph5ucGA2vDacM1QqtoePrWEMAJC2I
         zUtR3W5isCj28mXWvwsGp1sVExHaNZgacjcV10JD/BILu/tph+Dq0bt144lg/hea95/U
         CDu/2JbDNnpYz2F870j0ZlZHj9Z4io9cfvRkbz/N9oW71AQ/tRi0bGKZDOTIc3DLneU5
         tR7zH6nWggWz2RgJhmXWzJkJ2H58sn35Qy33xz0KIwdfJi8JbtxZZ3DZJp55ZR0M8Enu
         WEMhA1Br/wxNuNj3EKk6389mjGYInArTKwYu13t0Oa4UWzgWvy3vl39dZqg2j6n4g/Gj
         Zi5g==
X-Gm-Message-State: AJIora8yVtJvVf6WhwQGRCGGPb7H2YGlg64RVZM/b+y6/y82iOaV/RTJ
        lxhMUuDzbW52EWhOPb8/wRk3Eha2XbpLjA==
X-Google-Smtp-Source: AGRyM1tcPBkGOtwU2zQQEkAOsh4FlutPHUn9fiaa0vE1839McufOO/edQy9FhPG0TUsMlr3rnVLXkoYbobsPNg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6871:8a2:b0:fe:899:e540 with SMTP id
 r34-20020a05687108a200b000fe0899e540mr154522oaq.70.1655147271370; Mon, 13 Jun
 2022 12:07:51 -0700 (PDT)
Date:   Mon, 13 Jun 2022 12:07:39 -0700
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
Message-Id: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
Subject: Re: [RFC PATCH 00/20] submodule: remove git-submodule.sh, create bare builtin/submodule.c
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> As a result, git-submodule.sh::cmd_update() is now an (almost) one-liner=
:
>>
>> cmd_update() { git ${wt_prefix:+-C "$wt_prefix"} submodule--helper updat=
e
>> ${wt_prefix:+--prefix "$wt_prefix"}
>> "$@" }
>>
>> and best of all, "git submodule update" now shows a usage string for its=
 own
>> subcommand instead of a giant usage string for all of "git submodule" :)
>>
>> Given how many options "git submodule update" accepts, this series takes=
 a
>> gradual approach:
>>
>>  1. Create a variable opts, which holds the literal options we want to p=
ass
>>     to "git submodule--helper update". Then, for each option...
>>  2. If "git submodule--helper update" already understands the string opt=
ion,
>>     append it to opts and remove any special handling (1-3/8).
>>  3. Otherwise, if the option makes sense, teach "git submodule--helper
>>     update" to understand the option. Goto 2. (4-5/8).
>>  4. Otherwise, if the option makes no sense, drop it (6/8).
>>  5. When we've processed all options, delete all the option parsing code
>>     (7/8) and clean up (8/8).
>
> That's quite the timing coincidence. I hacked this up yesterday,
> thinking that the submodule topic had been too quiet for a while, and
> wondering how hard it was to convert the rest of git-submodule.sh.
>
> It's more than 2x the length of yours, but gets to the point where we
> can "git rm git-submodule.sh".

Very cool. I've skimmed through all of the patches, which mostly look
good except for ~1-2 things.

Your series shows that there isn't any prohibitively difficult work left
to finish the conversion, which is great! The real problem IMO is the
potential for mechanical errors given how many lines this touches.

Here's a way of breaking apart the work that makes sense to me:

- Reuse the patches that prepare git-submodule.sh for the conversion,
  particularly 1-7/20 (create a "case" dispatch statement and its
  preceding patches).
- Keep my series that prepares "update", since that's the most tedious
  one to convert. If I don't dispatch to the "case" statement, I don't
  think it will even conflict with the preparatory series.

  Some of your patches make more sense than mine, and I'll incorporate
  them as necessary :)
- Dispatch subcommands using the "case" dispatch, including "update". We
  might have to do this slowly if we want things to be easy to eyeball.
- "git rm git-submodule.sh"!

>> Glen Choo (8):
>>   submodule update: remove intermediate parsing
>>   submodule update: pass options containing "[no-]"
>>   submodule update: pass options with stuck forms
>
> Yeah, this is the alternate approach I considered and ended up
> discarding. I.e. to make forward progress with migrating things away
> from the cmd_*() functions you either have to prepare things in
> advance and then sweep the rug from under them in one go.
>
> Or, as you're doing here teaching them about the options they're
> not-really-parsing anymore, but must know about because they're in a
> loop that ends with a "if unknown option, usage".

Yes, if you took as many steps as I did, your series would be way too
long :P

To convert "update", I don't think this many steps is necessary; I
prepared it this way primarily to make it easier for everyone to spot
how the options changed so that they can give feedback. Some of these
can be squashed in my reroll

>>   submodule--helper update: use one param per type
>
> Same as my 13/20, but I ended up doing it in a more narrow/smaller
> way. I tried your way and ran into some bug, then figured I'd do it
> more narrowly instead of debugging it.

Yeah your approach is easier to eyeball, so I'll do this instead.

>>   submodule update: remove -v, pass --quiet
>
> Hrm, so we don't need it at all then. Well, that's a bit simpler than
> my 1[45]/20 and 17/20 :)
>
> So yeah, definitely RFC-quality, but I ran into that one test that
> used -v, and then saw the missing docs etc. But no cheating, so I've
> left it in :)
>
> I do wonder if we should leave it in anyway, we never documented -v,
> but we *did* understand it, and if you look at:
>
>     git log -p -Gsay -- git-submodule.sh
>
> We used to have a lot more code impacted by it, but looking at this
> again now it would have only been for users of command-lines like:
>
>     git submodule --quiet update -v [...]
>
> I.e. where we already set the flag to the non-default quiet, and then
> used -v to flip it.
>
> I think at this point I've talked myself into "let's just remove it",
> but maybe...

On hindsight, what I did is definitely cheating ;)

My series also breaks the way we'd handle --quiet in "git submodule",
i.e.

   git submodule --quiet update

should be quiet, but isn't.

Your approach actually handles --quiet as per the original shell script,
which is a good enough reason to do it your way. We can think about
removing it later.

> Brief commentary on my patches, details in commit messages:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (20):
>   git-submodule.sh: remove unused sanitize_submodule_env()
>   git-submodule.sh: remove unused $prefix variable
>   git-submodule.sh: remove unused --super-prefix logic
>
> I removed a bit more dead code here than yours.
>
>   git-submodule.sh: normalize parsing of "--branch"
>   git-submodule.sh: normalize parsing of --cached
>
> This & various other prep commits (hereafter "easy prep") make
> subsequent one-time conversions of whole cmd_*() easier.
>
>   submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>   git-submodule.sh: create a "case" dispatch statement
>
> easy prep

This would all make sense in a preparatory series, with the exception of=20
3/20 git-submodule.sh: remove unused --super-prefix logic.

We have several instances where we invoke submodule--helper directly
with --super-prefix, e.g. inside sync_submodule():
   =20
    if (flags & OPT_RECURSIVE) {
      struct child_process cpr =3D CHILD_PROCESS_INIT;

      cpr.git_cmd =3D 1;
      cpr.dir =3D path;
      prepare_submodule_repo_env(&cpr.env_array);

      strvec_push(&cpr.args, "--super-prefix"); /* Here */

I even have a (as of now private) patch that replaces "update"'s
--recursive-prefix with --super-prefix.

This probably wasn't caught in the tests because this only affects how
we calculate the submodule 'displayname'.

>   submodule--helper: pretend to be "git submodule" in "-h" output
>
> easy prep & bug fix for existing (on master) output bugs.
>
>   git-submodule.sh: dispatch "sync" to helper
>   git-submodule.sh: dispatch directly to helper
>   git-submodule.sh: dispatch "foreach" to helper
>
> These are easy conversions as the options 1=3D1 map after the above
> prep.

Yes, these are pretty easy. I'm worried about the number of lines
changed and the potential for mechanical errors, but we can roll these
more slowly if necessary.

>   submodule--helper: have --require-init imply --init
>   submodule--helper: understand --checkout, --merge and --rebase
>     synonyms
>   git-submodule doc: document the -v" option to "update"
>   submodule--helper: understand -v option for "update"
>
> not-so-easy prep for "cmd_update()"
>
>   git-submodule.sh: dispatch "update" to helper
>
> Full cmd_update() migration in one go.

Yeah, and since it's not-so-easy, it probably makes sense to continue to
keep my series around. I'll borrow some of these patches if that's ok :)

>   git-submodule.sh: use "$quiet", not "$GIT_QUIET"
>
> "easy prep", but this one is less overall churn if done at the end,
> but as noted above could/should maybe be dropped entirely.
>
>   git-submodule.sh: simplify parsing loop
>
> Not really needed, but I wanted to get the code as close to minimal
> for the next step, to eyeball the resulting sh v.s. C version.
>
>   submodule: make it a built-in, remove git-submodule.sh
>
> We now have a builtin/submodule.c *and* the current
> builtin/submodule--helper.c, and we even dispatch to "git
> submodule--helper" via run_command()!
>
> The idea is to be as close as possible to a bug-for-bug implementation
> of the shellscript, and that reviewers should be confident in being
> able to trace what commands we invoked before/after, we're invoking
> the same "git submodule--helper" commands.
>
> Of course we eventually want to get to some full union of
> builtin/submodule{,--helper}.c, but that can wait.
>
>   submodule: add a subprocess-less submodule.useBuiltin setting
>
> Wait, a useBuiltin setting to switch between two built-ins? Yeah,
> maybe it makes little sense, but here we get rid of the run_command()
> overhead, and could generally use the built-in to experiment with
> deeper integration between the two.
>
> ...

Interesting approach. It looks ok to me, but if we break up this series,
maybe this will be stale by the time we integrate the rest of the
changes?
