Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA41E892
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743157; cv=none; b=ovTBIcDtIZeMbi3F+YNtgkWHkAD24w1NJYIsoDaN0UhM648QnrOhME1ttLPhvpz/TAw2sifgPaddq4zaUVkZPRtdd8Ng2IT3jipvv51jxg8/BOr6WvkX2t7s5WtDd3aje+5uaaR6GltNCNhwd+PI2rjxtDQLBhxne6iCYrycHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743157; c=relaxed/simple;
	bh=6NZ3zgjdRr274YY8yGjzfod5oyec33J8gmZUimM4hWY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tE1T5ucFaByblueDdVFGa2GbA197vTjVTnLLkL9ovWT2OoTmqAn6bYHp2q48oM4EbbedXeePAdiZZ/k90bKskGb+Miq+r38Y1i9BRSE1kmJhZaG0lib7X1OE8BJgxOEkY2sMkYJjimEwTWXtALCpRKfHown7NWow+pHmh/WKFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=lLhH15pq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SpuAJXY+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="lLhH15pq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SpuAJXY+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A93A13802D9;
	Sat, 12 Oct 2024 10:25:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 12 Oct 2024 10:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728743154; x=1728829554; bh=/FsmvLP2Oyfh0oA7+VB97GVSy1s6Dt4U
	jcCzMFL1FT8=; b=lLhH15pqZbsMzoHa07mo7ypVdCbk3ysSU1eibEA8E8KcyWjx
	0NGKJdBu9km5IrV3TPbERpp95ZJgmxINyqlRywO8aGpFxh2g7dt6QmIOC8KKuMs1
	qrETqjkAFHIctgX5ASXaKkqshGe7JCb7d36+WDIOBTIhGvd98zDVQHcD0q+Z2Nk1
	uwDxh1io5ML1qv7eu0vuGjjG33Yeja6p6/45Rl+jRmNeWnc2MYc2L5L25jAZvq+M
	5P/RmZIYtARk40uPI/pip4/0hXpdDIRoeoNIQeJC57m/2jLpiXmp+lYb/rwXhgkl
	t81rZ2zVudXGstE+j4xB/OIRW3DtH2j08qllmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728743154; x=
	1728829554; bh=/FsmvLP2Oyfh0oA7+VB97GVSy1s6Dt4UjcCzMFL1FT8=; b=S
	puAJXY+YJnoH6x3xgT4izVVIdHWJrDftRyNKaK7XU/dUrEwcB++E7ExqgUXBbJjt
	H2/xX3GX/MrTg7VKUewvcKMsEbxo6OWmfW4XgUOHkFD0K3z8dhBI3mYSB40w3r5O
	9P0tNZJPJZSMyGJbOzPhVS0svQnFerDi7yHgZSgDhXzPvXP9Ts8j5jr22nxiKFyD
	AdS6kfZqd9nwS84Mw+2cpW82Em4ccyq3RhrUs0CfMivRyI50x2azMMQCgBX4yd61
	SxQ+vQHEtLIjbIihFJ9Duqs6suXPabdWduIm5uF99vFiBtkscohaibXGx2x6KZAd
	+M5qVOXoEb/QUhm/cBGvw==
X-ME-Sender: <xms:8YYKZ75_pPjwL94HPbbfCj3_MO9h6gIukmKpAgzMey70WIemdM4UAJ0>
    <xme:8YYKZw407XeC6P9Vyxw2an7-gbUjcdMtdE_QxgEW7y0oTqTnnLXMU1hLJflbAIFOI
    L-U5tlW1enb-Mdh9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeef
    veelgeduvdekteehieevffdujeelgfduffffjeelffffledukeejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrsghhihhjvggvthdtgedtgedtfeesghhmrghilhdrtghomhdprhgtphht
    thhopegrsghhihhjvggvthhsihhnghhhrdhgihhthhhusgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8YYKZycWDEUfNh8wa1B2jmVY5C0nMzBErSYGhu0NUBFcwbSx22tYuw>
    <xmx:8YYKZ8Lk48QrIJbJddCtTxNxCoesErNpRC6dN1FskfpurWC0pHAuvg>
    <xmx:8YYKZ_J2qu-4ZDyTPtkiRG_7SXpAIR-qNr71ymsDLXzevR79t1hvyw>
    <xmx:8YYKZ1ytcDaIMlb-57DPbd-MxIRUlIwT3bnGp3NtFAGBD7JuCbcs8w>
    <xmx:8oYKZ1jag00j-R3lYQdqGW_5HDIaUxzDrImp9sr80SSufMvkLEWU1rlV>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD5ED780068; Sat, 12 Oct 2024 10:25:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Oct 2024 16:25:23 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,
 "Abhijeetsingh Meena" <abhijeetsingh.github@gmail.com>,
 "Abhijeetsingh Meena" <abhijeet040403@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <09a4cec6-c655-44e9-9577-01e6a8cb1a3d@app.fastmail.com>
In-Reply-To: 
 <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 2/2] blame: introduce --override-ignore-revs to bypass ignore
 revisions list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024, at 06:37, Abhijeetsingh Meena via GitGitGadget wro=
te:
> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
>
> The git blame command can ignore a list of revisions specified either
> through the --ignore-revs-file option or the blame.ignoreRevsFile
> configuration. This feature is useful for excluding irrelevant
> commits, such as formatting changes or large refactors, from blame
> annotations.

In a later paragraph you mention `--ignore-rev` but not here.

> However, users may encounter cases where they need to
> temporarily override these configurations to inspect all commits,
> even those excluded by the ignore list. Currently, there is no
> simple way to bypass all ignore revisions settings in one go.

=E2=80=9CNo simple way=E2=80=9D gives me pause.  But there are those opt=
ions/methods
that we discussed before:

=E2=80=A2 `--no-ignore-rev`
=E2=80=A2 `--no-ignore-revs-file`

These are not documented but I can provide these options and get a
different output from git-blame(1).

`builtin/blame.c` uses `parse-options.h` which provides automatic
negated options.  I just looked at the code today (so it=E2=80=99s new t=
o me)
but it seems like it will empty the lists that are associated with these
options.  See `parse-options-cb.c:parse_opt_string_list`.

So I think this should be sufficient to reset all =E2=80=9Cignore=E2=80=9D=
 options:

```
git blame --no-ignore-rev --no-ignore-revs-file
```

However I tested with this:

```
git blame --ignore-revs-file=3D.git-blame-ignore-revs --no-ignore-revs
```

And the output suggests to me that `--no-ignore-revs` affect the result
of the before-mentioned list of files.  Even though these are two
different lists.  I can=E2=80=99t make sense of that from the code.  But=
 I=E2=80=99m not
a C programmer so this might just be a me-problem.

>
> This patch introduces the --override-ignore-revs option (or -O),

Phrases like =E2=80=9Cthis patch=E2=80=9D is discouraged compared to the=
 imperative mood
style of commanding the code base to change (so to speak).  See
`imperative-mood` in Documentation/SubmittingPatches.

> which allows users to easily bypass the --ignore-revs-file
> option, --ignore-rev option and the blame.ignoreRevsFile

I can see no precedence for the name =E2=80=9Coverride=E2=80=9D for an o=
ption in this
project.  The convention is `--[no-]option`.

Like Eric Sunshine discussed: a common convention is to let the user
activate and negate options according to the last-wins rule.  This is
pretty useful in my opinion.  Because I can then make an alias which
displays some Git Note:

```
timber =3D log [options] --notes=3Dresults
```

But then what if I don=E2=80=99t want any notes for a specific invocatio=
n?  I
don=E2=80=99t have to copy the whole alias and modify it.  I can just:

```
git timber --no-notes
```

And the same goes for an alias which disables notes:

```
timber =3D log [options] --no-notes
```

Because then I can use `git timber --notes=3Dresults`.

> configuration. When this option is used, git blame will completely
> disregard all configured ignore revisions lists.
>
> The motivation behind this feature is to provide users with more
> flexibility when dealing with large codebases that rely on
> .git-blame-ignore-revs files for shared configurations, while
> still allowing them to disable the ignore list when necessary
> for troubleshooting or deeper inspections.

You might be able to achieve the same thing with the existing negated
options.

If you *cannot* disable all =E2=80=9Cignore=E2=80=9D config and options =
in one negated
one then you might want an option like `--no-ignores` which acts like:

```
git blame --no-ignore-rev --no-ignore-revs-file
```

>
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
>  builtin/blame.c                       |  8 +++++++-
>  t/t8016-blame-override-ignore-revs.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100755 t/t8016-blame-override-ignore-revs.sh
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 1eddabaf60f..956520edcd9 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -69,6 +69,7 @@ static int coloring_mode;
>  static struct string_list ignore_revs_file_list =3D STRING_LIST_INIT_=
DUP;
>  static int mark_unblamable_lines;
>  static int mark_ignored_lines;
> +static int override_ignore_revs =3D 0;
>
>  static struct date_mode blame_date_mode =3D { DATE_ISO8601 };
>  static size_t blame_date_width;
> @@ -901,6 +902,7 @@ int cmd_blame(int argc,
>  		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"),
> XDF_IGNORE_WHITESPACE),
>  		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"),
> N_("ignore <rev> when blaming")),
>  		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list,
> N_("file"), N_("ignore revisions from <file>")),
> +		OPT_BOOL('O', "override-ignore-revs", &override_ignore_revs,
> N_("override all configurations that exclude revisions")),
>  		OPT_BIT(0, "color-lines", &output_option, N_("color redundant
> metadata from previous line differently"), OUTPUT_COLOR_LINE),
>  		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"),
> OUTPUT_SHOW_AGE_WITH_COLOR),
>  		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find
> better match"), XDF_NEED_MINIMAL),
> @@ -1119,7 +1121,11 @@ parse_done:
>  	sb.reverse =3D reverse;
>  	sb.repo =3D the_repository;
>  	sb.path =3D path;
> -	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
> +
> +	if (!override_ignore_revs) {
> +		build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
> +	}
> +

This demonstrates the more limited behavior: you either override
(discard) the ignores or you don=E2=80=99t.  With the negated options yo=
u build
up and reset/empty those lists before you get to this point.  That ends
up being more flexible for the user.

>  	string_list_clear(&ignore_revs_file_list, 0);
>  	string_list_clear(&ignore_rev_list, 0);
>  	setup_scoreboard(&sb, &o);
> diff --git a/t/t8016-blame-override-ignore-revs.sh
> b/t/t8016-blame-override-ignore-revs.sh
> new file mode 100755
> index 00000000000..b5899729f8e
> --- /dev/null
> +++ b/t/t8016-blame-override-ignore-revs.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +test_description=3D'default revisions to ignore when blaming'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success 'blame: override-ignore-revs' '
> +    test_commit first-commit hello.txt hello &&
> +
> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&
> +
> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
> +    mv hello.txt.tmp hello.txt &&
> +    test_commit third-commit hello.txt &&
> +
> +    git blame hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame -O hello.txt >actual &&
> +
> +    test_cmp expect actual
> +'
> +
> +test_done
> --
> gitgitgadget
