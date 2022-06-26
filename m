Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BFBC433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiFZNQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiFZNQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:16:12 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B89FDE9F
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1656249350;
        bh=Hp53y9eggjfjSZa3oAljiPx/svCkZikyHswThKi6y2I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fyC9onkJ+dXla0UIEqqpIrDZyuq5PKwuqUUPpCVXu0iX6W9fKDiIZhIwcqel2Wv0A
         xBN4fBAFV/rywQ2SCan5I1gTQgd98v8YslVVhkCZUH9MY6wG138noB7a+tGzY2tAWT
         +xM3q5emNM6aylsRvguKqPIRE2Vf9Aa2ZqOwtPUQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjIG-1nvZhC37k4-00CGrS; Sun, 26
 Jun 2022 15:15:50 +0200
Message-ID: <3bada133-3dec-8b59-96a6-567258660f6b@web.de>
Date:   Sun, 26 Jun 2022 15:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] fetch doc: note "pushurl" caveat about
 "credentialsInUrl", elaborate
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
 <patch-1.2-b6631cd839c-20220615T103852Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-1.2-b6631cd839c-20220615T103852Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X/BTi52zItWZ0NWSHljaNqC2FZRzeTJWVBH1dKO1QynyoHYz7tF
 7ECrMtYDZASz9RW4mvnj1AvJ8xwheXg2iatkY19PuqHp85PI6Q0iBfG/QETV+Sdwm04Ajw9
 uD5rTqiB9/9I2kI0x8/MYzzfTFDgM/6fGGR494cK1DYca/w77aYRzh9upqGArPfqlsChmfW
 TYMa3vIRQSHmksqPRvxHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3vnz/MTNFR0=:YhULuukAZu01OQZPCmAEi+
 iU1nhQggKigdLwC3X2IoUv7Qf7cvG5Nk/5oghxLv2Gsg7YWlu12YqnlR6vq9JJE4kfyD2ybDs
 NRTUCfTNGR3LkflgO4KMJanhkDMTCI0wJFCVi2EZiUQSNOMiqOhluyQ7MuPCEIwKze1pXk45g
 P2qKecWkjAcOt8YVyGOUGphwT0PqWmGD4DgVEHKVjO9X1OQd7g0cLH3V1lGLZawCArSFsjpR/
 MwY/FOE8/cQu4QEq1II66lX4wpSgrtYiv5t4cX9CVIyHY/zHE0WHTxGK1T90mOWz342GgdoF3
 vXls2iUrqOTt4e+smrlJpWiAtnxGe6g04JVuy62aoi+r7Mb6YdTLaf+HZutUL521CAhS5A7dA
 a6SaA6Q98Lu1WNVNOc9nkUcVEcSZHiuPq/+mrN4kscnAZxku+TkSyPJcI4TB5Fi77rtTu3n2L
 foB8cfxfTuUhE5pqy5MGChmpZTdWO824YJHAdpjqlnvsgX/ysRPi6ygAvUiDgVinNWeHkYmtN
 25cJES0juFzCzVQw4yiKSc7b0ioiffyFoIYC3c5Yxm3FYGSMZOLU2P4uTp8ItwGL8xBpeDBl+
 ppJi78fi9TeiKGxy8m2nh9IOs04X1u9WiWkxTEFSDC7n7AkjtYhLxvxg1Scf78vIaSWYJUiof
 FPL3U8VlQr3NxCALEgGGPqdcdvhNhul7UIvyAt3v0dIPZdz1l4WvFByqG+jzk9ksPaLY/nf4O
 4Uqzuortngl322JQueiTT5aE+nd+JmuTHYjlRfkmencXfVqXLRXiPZkis4aN1qaVTIMHhMQaB
 JO8I6zpoaoSwZsUV7WBRP0MMIf/i9ulAOSxRdcCO7kWO0Q64HNWOXkrzz0WRANycDOtvS0c3z
 k7oENPZIvlFFt58cwFEW56RyeRcvaXsYdwIiAwO3xOBL0bvJpCY2L3gb9HQAcSFds7cc9nLUp
 cTt+Dgz+/leA8IFo2VF1qc3OIpJvzBRQwLEGWKfv/kUS+xT/2zqwmOxP9odWDs3qM06wNtsbl
 HGW0XMyWJqvzAzQvzkeTmfdDF3Luf90+nzWpBQbjYuIJ9e/D6UcfumeB9cSkGagGTYXX+5vHt
 9UmJB5uCBLISG1odic1koqYdHz4GjPKJP4i
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.22 um 12:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Amend the documentation and release notes entry for the
> "fetch.credentialsInUrl" feature added in 6dcbdc0d661 (remote: create
> fetch.credentialsInUrl config, 2022-06-06), it currently doesn't
> detect passwords in `remote.<name>.pushurl` configuration. We
> shouldn't lull users into a false sense of security, so we need to
> mention that prominently.
>
> This also elaborates and clarifies the "exposes the password in
> multiple ways" part of the documentation. As noted in [1] a user
> unfamiliar with git's implementation won't know what to make of that
> scary claim, e.g. git hypothetically have novel git-specific ways of
> exposing configured credentials.
>
> The reality is that this configuration is intended as an aid for users
> who can't fully trust their OS's or system's security model, so lets
> say that's what this is intended for, and mention the most common ways
> passwords stored in configuration might inadvertently get exposed.
>
> 1. https://lore.kernel.org/git/220524.86ilpuvcqh.gmgdl@evledraar.gmail.c=
om/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/RelNotes/2.37.0.txt |  4 +++-
>  Documentation/config/fetch.txt    | 34 +++++++++++++++++++++++++------
>  2 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.37.0.txt b/Documentation/RelNotes/=
2.37.0.txt
> index 8f1ff3a5961..39ca3606dec 100644
> --- a/Documentation/RelNotes/2.37.0.txt
> +++ b/Documentation/RelNotes/2.37.0.txt
> @@ -55,7 +55,9 @@ UI, Workflows & Features
>   * Update the doctype written in gitweb output to xhtml5.
>
>   * The "fetch.credentialsInUrl" configuration variable controls what
> -   happens when a URL with embedded login credential is used.
> +   happens when a URL with embedded login credential is used on either
> +   "fetch" or "push". Credentials are currently only detected in
> +   `remote.<name>.url` config, not `remote.<name>.pushurl`.
>
>
>  Performance, Internal Implementation, Development Support etc.
> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch=
.txt
> index 0db7fe85bb8..827961059f8 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -98,12 +98,34 @@ fetch.writeCommitGraph::
>  	`git push -f`, and `git log --graph`. Defaults to false.
>
>  fetch.credentialsInUrl::
> -	A URL can contain plaintext credentials in the form
> -	`<protocol>://<user>:<password>@<domain>/<path>`. Using such URLs
> -	is not recommended as it exposes the password in multiple ways,
> -	including Git storing the URL as plaintext in the repository config.
> -	The `fetch.credentialsInUrl` option provides instruction for how Git
> -	should react to seeing such a URL, with these values:
> +	A configured URL can contain plaintext credentials in the form
> +	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
> +	to warn or forbid the use of such configuration (in favor of
> +	using linkgit:git-credential[1]).

What I want is one thing, but the more interesting point here is that
this option actually allows me to achieve these goals, no?  E.g. "This
configuration variable can let git warn about or reject such URLs.".
Otherwise this reads more as a general kind of advise along the lines
of "Passwords are insecure; you may want to use multi-factor
authentication.".

> ++
> +Note that this is currently limited to detecting credentials in
> +`remote.<name>.url` configuration, it won't detect credentials in
> +`remote.<name>.pushurl` configuration.

That's a puzzling restriction.

> ++
> +You might want to enable this to prevent inadvertent credentials
> +exposure, e.g. because:

At this point in the text "this" is undefined; the values and their
meaning are explained two paragraphs down.  Perhaps reverse the order?

> ++
> +* The OS or system where you're running git may not provide way way or
> +  otherwise allow you to configure the permissions of the
> +  configuration file where the username and/or password are stored.

Perhaps s/way way/a way/?  In that case: What's the difference between
"provide a way" and "allow you" in this context?  The point here is that
"you are unable to restrict access to the configuration file storing the
credentials", right?

> +* Even if it does, having such data stored "at rest" might expose you
> +  in other ways, e.g. a backup process might copy the data to another
> +  system.

No need for scare quotes here; this is a legit term.

> +* The git programs will pass the full URL to one another as arguments
> +  on the command-line, meaning the credentials will be exposed to oher
> +  users on OS's or systems that allow other users to see the full
> +  process list of other users. On linux the "hidepid" setting
> +  documented in procfs(5) allows for configuring this behavior.

"oher" has been fixed already.  Linux should get a capital L.

> ++
> +If such concerns don't apply to you then you probably don't need to be
> +concerned about credentials exposure due to storing that sensitive
> +data in git's configuration files. If you do want to use this, set
> +`fetch.credentialsInUrl` to one of these values:

So I'm safe as long as I don't make backups, right? ;-)

Cleartext passwords are a security risk and advising not to be concerned
about storing them in a config file is a bit scary.  A better default
would probably be to reject URLs with credentials and make credential
helpers at least as convenient to use as a plaintext file (if they
aren't already) -- but that's just a tangent from a slightly paranoid
admin type.  My point is that the tone seems a bit off.

>  +
>  * `allow` (default): Git will proceed with its activity without warning=
.
>  * `warn`: Git will write a warning message to `stderr` when parsing a U=
RL

