Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EA21F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKMMrX (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:47:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:43589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfKMMrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573649230;
        bh=UYvJfvO5LL6WfS6kRhHCY5ToGOcpjpsc8BVIqelrzc8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PVboFkdWlQiEEE077n8d4siLYvobk///vD0X8LNDZsRlkNx8J/or/4Kf3s31dvPeD
         i1Tyz97N+UBfrIAvFNStgzAnWo9uBRxBr4DiNsGK7aX4AodcWwisH7iwOaDynf6PTb
         GaTLQHLEEMMh1zC0E+63irusQURt1KFY+cpj1lCA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1ico972tt5-009klz; Wed, 13
 Nov 2019 13:47:10 +0100
Date:   Wed, 13 Nov 2019 13:46:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/9] git add -i: add a rudimentary version in C
 (supporting only status and help  so far)
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911131345310.46@tvgsbejvaqbjf.bet>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com> <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1458221144-1573649230=:46"
X-Provags-ID: V03:K1:X8J8UA7phq9z1t9zE+3zvg/ZhUG5ZpSvOJPm6oW0JPjDoJ4guqW
 vCwlEBY/XExoDgrDlrsk95AZxhKAAUty30MrWPyjC/TBJmgEK2zweTXY5QzU/ewlUeA9mvo
 Z2DZ63LNFBQYXCH5CWUx5I8c7/NDFpb7fYcvMaK2kJ2DEDPrgY49ofC82027LZTC4Y/VfuP
 JGFPL4BlNeuOM4/9ZaJ9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EqzmuMB+vGE=:Dig3kYi1pMW5vZOkaoM/7/
 9Jx0PiDDm0VN2Gwx6j9HSxDhQ+h5E2Pv+SW6+liMwGOrSpiqTjtpIe7I3Qr1t3nOUovN9SX7v
 /lfhmBXLOYXiEzR4xMcl+OpQiCVaB/u0VrG5UFNqUQRTNDXFMl2PI+/22KfM7h9pqcYKYJPlo
 dnod2VOvSeFesW2h3hSO9dAsT4s2nQZPBgwv91gMkhTYVcYYjELISqRMUSt8yLSV5nO3c4oe9
 6k/nTgg08YO0dPomcry+VZRlLbq+jm/qIMSYVa+s8M0kqwXRlDzCHx6tU3JkorIaU80aE6K4a
 1kvqQDU3GtvqFkQ8txy4gP3DbGEWgyTVRLxlx7cijn7Wndv8mtWHMUKMGjgH+1co7k3/8gEam
 KsOGvboz1+NElTdF7xpHxUz0AYH6KFtRfYH7RGCOgKCYVekpehGv3JRCJozFwyYWfd4DTmk1d
 /4ZGWflN0SbJ9wlCmCYpn57X9D+nv9jg6d/mhvLmxim+wBX7OaNNsgRPKOyV9mZOapPZoLY6Y
 hN6sAfg9PTQwYWAYjICx+NqiTNnOh/aC1RKwCDJu5pseJyreGzF93YfymemBtuzZRJ4OeAwat
 Tui7XEp7ujksYNnIsUC4nV20MdyQT8b8dXQTAUsUnpMVo+630QqOlyzChUcxCgxF9Wl0SIpT+
 93JeZuoOCAFHNJlf9wBTeUCOePkxqNpPZUBtyff+2sSBJ5gh72H0cjUp34DAGUMt1r2jjsKrB
 L+E3x3L7wvy/8/m84Xi7jt0cENCF+IS7WzSoBLHPITw/znMJJyePmMDAuE/28wCGiTgpSMhno
 XwQrh3WnT7NNVI++31EsdiY10nHmbsqJ/eqFYQhuC0qkhnmLGJ5D51aGb/gKi22BVJrMrKeUf
 jiUAeoWJwZgE3xN3qHo6n7lBViLGQGE5pMr6av9dr3nsN09zv5h3H+13DxQfZJyRmGqjnZiX2
 zEZeGJ/7BVoloSJ7sFAp9R4v6iizii02rQveCj84MaJ9KVSJC6VFYsFtA9FOs6N3PSybBb9QR
 VmzEYStUvurvhTeCBKFBnSIzyrnK9ttnaBeQ5kgdtwnQPHEiprYWRhGARpDc2cL45kwMx6iwp
 so+SKSOAFOQz5R83TLkU01UZSoXPse9y4jLq+pVPr3a3OuK1IBs0q3fR6UaRme6ao7hQrgg3Z
 fDbHN/MTNSRlbQBy0UEAthYsrDpMEzjhdd5RCLAZrBqIcjyrH/zixVf5Gmsk+L4Yd3YbdceLM
 oXzAWh79Foe9YlnGV4Y2Sa/ppqz4cfA21aSwO3nxB8qPXzGjHah25GOu2h8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1458221144-1573649230=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 13 Nov 2019, Johannes Schindelin via GitGitGadget wrote:

> This is the first leg on the long journey to a fully built-in git add -i
> (next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
> [https://github.com/gitgitgadget/git/pull/172], 4
> [https://github.com/gitgitgadget/git/pull/173], 5
> [https://github.com/gitgitgadget/git/pull/174], and 6
> [https://github.com/gitgitgadget/git/pull/175]). Note: the latter PRs ar=
e
> not necessarily up to date, and will be re-targeted to the appropriate
> branches in https://github.com/gitster/git as soon as Junio picks them u=
p.
>
> This here patch series reflects the part that was submitted a couple of
> times (see https://github.com/gitgitgadget/git/pull/103) during the
> Outreachy project by Slavica =C3=90ukic that continued the journey based=
 on an
> initial patch series by Daniel Ferreira.
>
> It only implements the status and the help part, in the interest of maki=
ng
> the review remotely more reviewable.
>
> As I am a heavy user of git add -p myself and use a patched version for
> several months already (it is so nice to not suffer over one second star=
tup
> until the MSYS2 Perl finally shows me anything, instead it feels
> instantaneous), I integrated these patch series into Git for Windows
> already, as an opt-in feature guarded by the config variable
> add.interactive.useBuiltin (and Git for Windows' installer knows to dete=
ct
> this version and offer the option in the graphical user interface).

And of course I forgot to summarize the changes since v5:

- Reworded two commit messages.
- Clarified code that does not affect `patch_mode`.
- Restricted scope of the very local variable `endp`.

Ciao,
Johannes

> Changes since v4:
>
>  * Rebased onto current master to make use of Thomas Gummerer's
>    repo_refresh_and_write_index() as well as to avoid merge conflicts wi=
th
>    Eric Wong's work on struct hashmap.
>  * Instead of rolling a dedicated data struct to simulate a Trie, we now=
 use
>    string-list extensively (an unsorted copy and a sorted one, the latte=
r to
>    determine unique prefixes). This had massive ramifications on the res=
t of
>    the patches... For example, the struct command_item structure no long=
er
>    contains the name field, but is intended to be a util in a string_lis=
t.
>  * Changed the commit messages and author lines to reflect Slavica's nam=
e
>    correctly.
>  * Touched up a couple commit messages.
>
> Changes since v3:
>
>  * Rebased to v2.23.0 to reduce friction.
>  * free_diffstat_info() is now made public as well, and used, to avoid a
>    memory leak.
>  * Prepared the patches for ew/hashmap (which is strict about the hashma=
p
>    entries' type in hashmap_entry_init() and friends).
>  * The private data types have been moved from prefix-map.h to prefix-ma=
p.c.
>  * A lot of int types were converted to more appropriate size_t in
>    prefix-map.c.
>  * A misleading parameter name list was renamed to the correct array.
>  * The code comment above find_unique_prefixes() was (hopefully) improve=
d.
>  * The run_help() function's signature now reflects that most of the
>    parameters are actually unused.
>
> Changes since v2:
>
>  * Rebased to master to avoid merge conflicts.
>  * Renumbered the prefix-map test to avoid conflicts with two patch seri=
es
>    that are currently in-flight in pu.
>
> Changes since v1:
>
>  * The config machinery was reworked completely, to not use a callback t=
o
>    git_config(), but instead to query the config via the repo_config_get=
_*()
>    functions. This also prevents a future "Huh???" moment: the internal =
add
>    --interactive API accepts a parameter of type struct repository *r, b=
ut
>    the previous configuration did not use that to query the config (and
>    could in the future be a repository other than the_repository).
>
>
>  * As a consequence, the color sequences are no longer stored in file-lo=
cal
>    variables, but passed around via a struct.
>
>
>  * Instead of using the magical constant -2 to quit the main loop, it is=
 now
>    defined as LIST_AND_CHOOSE_QUIT (and likewise, LIST_AND_CHOOSE_ERROR =
is
>    defined as -1 and used where appropriate).
>
>
>  * Improved the add_prefix_item() function by avoiding buffer overruns, =
not
>    reusing the struct that is used for lookup also for adding the new it=
em,
>    and by strengthening the bug check.
>
> Daniel Ferreira (2):
>   diff: export diffstat interface
>   built-in add -i: implement the `status` command
>
> Johannes Schindelin (4):
>   Start to implement a built-in version of `git add --interactive`
>   built-in add -i: implement the main loop
>   built-in add -i: show unique prefixes of the commands
>   built-in add -i: support `?` (prompt help)
>
> Slavica =C4=90uki=C4=87 (3):
>   built-in add -i: color the header in the `status` command
>   built-in add -i: use color in the main loop
>   built-in add -i: implement the `help` command
>
>  Documentation/config/add.txt |   5 +
>  Makefile                     |   1 +
>  add-interactive.c            | 651 +++++++++++++++++++++++++++++++++++
>  add-interactive.h            |   8 +
>  builtin/add.c                |  12 +
>  diff.c                       |  39 +--
>  diff.h                       |  20 ++
>  t/README                     |   4 +
>  t/t3701-add-interactive.sh   |  25 ++
>  9 files changed, 742 insertions(+), 23 deletions(-)
>  create mode 100644 add-interactive.c
>  create mode 100644 add-interactive.h
>
>
> base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2F=
dscho%2Fadd-i-in-c-status-and-help-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho=
/add-i-in-c-status-and-help-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/170
>
> Range-diff vs v5:
>
>   1:  ff59d2d0b3 !  1:  5d9962d434 Start to implement a built-in version=
 of `git add --interactive`
>      @@ -2,31 +2,31 @@
>
>           Start to implement a built-in version of `git add --interactiv=
e`
>
>      -    This is hardly the first conversion of a Git command that is i=
mplemented
>      -    as a script to a built-in. So far, the most successful strateg=
y for such
>      -    conversions has been to add a built-in helper and call that fo=
r more and
>      -    more functionality from the script, as more and more parts are
>      -    converted.
>      +    Unlike previous conversions to C, where we started with a buil=
t-in
>      +    helper, we start this conversion by adding an interception in =
the
>      +    `run_add_interactive()` function when the new opt-in
>      +    `add.interactive.useBuiltin` config knob is turned on (or the
>      +    corresponding environment variable `GIT_TEST_ADD_I_USE_BUILTIN=
`), and
>      +    calling the new internal API function `run_add_i()` that is im=
plemented
>      +    directly in libgit.a.
>
>      -    With the interactive add, we choose a different strategy. The =
sole
>      -    reason for this is that on Windows (where such a conversion ha=
s the most
>      -    benefits in terms of speed and robustness) we face the very sp=
ecific
>      -    problem that a `system()` call in Perl seems to close `stdin` =
in the
>      -    parent process when the spawned process consumes even one char=
acter from
>      -    `stdin`. And that just does not work for us here, as it would =
stop the
>      -    main loop as soon as any interactive command was performed by =
the
>      -    helper. Which is almost all of the commands in `git add -i`.
>      -
>      -    It is almost as if Perl told us once again that it does not wa=
nt us to
>      -    use it on Windows.
>      +    At this point, the built-in version of `git add -i` only state=
s that it
>      +    cannot do anything yet. In subsequent patches/patch series, th=
e
>      +    `run_add_i()` function will gain more and more functionality, =
until it
>      +    is feature complete. The whole arc of the conversion can be fo=
und in the
>      +    PRs #170-175 at https://github.com/gitgitgadget/git.
>
>      -    Instead, we follow the opposite route where we start with a ba=
re-bones
>      -    version of the built-in interactive add, guarded by the new
>      -    `add.interactive.useBuiltin` config variable, and then add mor=
e and more
>      -    functionality to it, until it is feature complete.
>      +    The "--helper approach" can unfortunately not be used here: on=
 Windows
>      +    we face the very specific problem that a `system()` call in
>      +    Perl seems to close `stdin` in the parent process when the spa=
wned
>      +    process consumes even one character from `stdin`. Which preven=
ts us from
>      +    implementing the main loop in C and still trying to hand off t=
o the Perl
>      +    script.
>
>      -    At this point, the built-in version of `git add -i` only state=
s that it
>      -    cannot do anything yet ;-)
>      +    The very real downside of the approach we have to take here is=
 that the
>      +    test suite won't pass with `GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue`=
 until the
>      +    conversion is complete (the `--helper` approach would have let=
 it pass,
>      +    even at each of the incremental conversion steps).
>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de=
>
>
>      @@ -99,12 +99,14 @@
>        	struct argv_array argv =3D ARGV_ARRAY_INIT;
>       +	int use_builtin_add_i =3D
>       +		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>      -+	if (use_builtin_add_i < 0)
>      -+		git_config_get_bool("add.interactive.usebuiltin",
>      -+				    &use_builtin_add_i);
>       +
>      -+	if (use_builtin_add_i =3D=3D 1 && !patch_mode)
>      -+		return !!run_add_i(the_repository, pathspec);
>      ++	if (!patch_mode) {
>      ++		if (use_builtin_add_i < 0)
>      ++			git_config_get_bool("add.interactive.usebuiltin",
>      ++					    &use_builtin_add_i);
>      ++		if (use_builtin_add_i =3D=3D 1)
>      ++			return !!run_add_i(the_repository, pathspec);
>      ++	}
>
>        	argv_array_push(&argv, "add--interactive");
>        	if (patch_mode)
>   2:  2fc8cc3546 =3D  2:  f42d7b1310 diff: export diffstat interface
>   3:  6aaa0de4f4 =3D  3:  4836191271 built-in add -i: implement the `sta=
tus` command
>   4:  e405f07110 =3D  4:  d61cf9daeb built-in add -i: color the header i=
n the `status` command
>   5:  25590fbbbe !  5:  b0c04e6ec6 built-in add -i: implement the main l=
oop
>      @@ -7,33 +7,34 @@
>           function that we conveniently introduced for use by the `statu=
s`
>           command.
>
>      -    Apart from the "and choose" part, there are more differences b=
etween the
>      -    way the `status` command calls the `list_and_choose()` functio=
n in the
>      -    Perl version of `git add -i` compared to the other callers of =
said
>      -    function. The most important ones:
>      +    In contrast to the Perl version, in the built-in interactive `=
add`, we
>      +    will keep the `list()` function (which only displays items) an=
d the
>      +    `list_and_choose()` function (which uses `list()` to display t=
he items,
>      +    and only takes care of the "and choose" part) separate.
>
>      -    - The list is not only shown, but the user is also asked to ma=
ke a
>      -      choice, possibly selecting multiple entries.
>      +    The `list_and_choose()` function, as implemented in
>      +    `git-add--interactive.perl` knows a few more tricks than the f=
unction we
>      +    introduce in this patch:
>
>      -    - The list of items is prefixed with a marker indicating what =
items have
>      -      been selected, if multi-selection is allowed.
>      +    - There is a flag to let the user select multiple items.
>
>      -    - Initially, for each item a unique prefix (if there exists an=
y within
>      -      the given parameters) is determined, and shown in the list, =
and
>      +    - In multi-select mode, the list of items is prefixed with a m=
arker
>      +      indicating what items have been selected.
>      +
>      +    - Initially, for each item a unique prefix is determined (if t=
here
>      +      exists any within the given parameters), and shown in the li=
st, and
>             accepted as a shortcut for the selection.
>
>      -    These features will be implemented later, except the part wher=
e the user
>      -    can choose a command. At this stage, though, the built-in `git=
 add -i`
>      -    still only supports the `status` command, with the remaining c=
ommands to
>      -    follow over the course of the next commits.
>      +    These features will be implemented in the C version later.
>
>      -    In addition, we also modify `list()` to support displaying the=
 commands
>      -    in columns, even if there is currently only one.
>      +    This patch does not add any new main loop command, of course, =
the
>      +    built-in `git add -i` still only supports the `status` command=
. The
>      +    remaining commands to follow over the course of the next commi=
ts.
>
>      -    The Perl script `git-add--interactive.perl` mixed the purposes=
 of the
>      -    "list" and the "and choose" part into the same function. In th=
e C
>      -    version, we will keep them separate instead, calling the `list=
()`
>      -    function from the `list_and_choose()` function.
>      +    To accommodate for listing the commands in columns, preparing =
for the
>      +    commands that will be implemented over the course of the next
>      +    patches/patch series, we teach the `list()` function to do pre=
cisely
>      +    that.
>
>           Note that we only have a prompt ending in a single ">" at this=
 stage;
>           later commits will add commands that display a double ">>" to =
indicate
>      @@ -101,7 +102,7 @@
>       +	ssize_t res =3D LIST_AND_CHOOSE_ERROR;
>       +
>       +	for (;;) {
>      -+		char *p, *endp;
>      ++		char *p;
>       +
>       +		strbuf_reset(&input);
>       +
>      @@ -133,6 +134,7 @@
>       +			}
>       +
>       +			if (isdigit(*p)) {
>      ++				char *endp;
>       +				index =3D strtoul(p, &endp, 10) - 1;
>       +				if (endp !=3D p + sep)
>       +					index =3D -1;
>   6:  57fdc01463 !  6:  b6459be5eb built-in add -i: show unique prefixes=
 of the commands
>      @@ -177,7 +177,7 @@
>       +	find_unique_prefixes(items);
>       +
>        	for (;;) {
>      - 		char *p, *endp;
>      + 		char *p;
>
>        		strbuf_reset(&input);
>
>   7:  77ad5f333a =3D  7:  bdf9058d9e built-in add -i: support `?` (promp=
t help)
>   8:  3d0b172a7f =3D  8:  eafeedc49b built-in add -i: use color in the m=
ain loop
>   9:  85e508ef11 =3D  9:  7fda76255a built-in add -i: implement the `hel=
p` command
>
> --
> gitgitgadget
>

--8323328-1458221144-1573649230=:46--
