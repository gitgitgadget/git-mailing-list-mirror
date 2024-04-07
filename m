Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269C184D
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468869; cv=none; b=NAzys0jPeadrGPZEjJnajl66p3xOutXtwkb7RHahYI8+5sB0hskLdb0nXrat0zfCXSPvNFpLVO36nwqB74vzdpRnqICg06PkmmiziuBeuve8iQK3BnZ1Dw5Is2KXgDKqr4nf+xleCDbH46BMrboM575sPJ1uws/snILtd2svjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468869; c=relaxed/simple;
	bh=pJc8sCCYFzWm4qJUDx+WmjqReD42utI7UMWZVia3JLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp+wwM6OAgnErSzs7YNZlTqhCH8mVQBYXhr719BUJ4h8tSUcggPkzQ5tVYfpR/Bw2Ri3nHwC+9WqOvzSIaNL25eKe4VZE5k+WClIunKdddhRvSaUP1hIDeggqheMmt7An1yian1czXp7GaXXA7wMeSZAOD7w9YtWhM3YEN87t2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69942241b79so9509856d6.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 22:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712468866; x=1713073666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwsCLVtliSidcnJ9txrf95DEgMMQXey4t67Su9kPUeg=;
        b=SunYaI9/cR5sFEetm3REWjstXB4KRSOBo2cMg+GM0r4vVdfOFj1d8xaQK3Tfhcb6XU
         kYncBbRnCMrCSQh+5n/IEpxWZG9evfXgD77ARtYiJ3kV++2M60ZxwFojEW1gF7T35WgY
         5kMu7heHQO7z8SAe3UHaqc9F/0aDDD2qft5EKEzxAMCS/Cp04FSzOBlHdoz8VOsfI+rL
         9yqsUhBtRfmWyAdL5twqQfkzpLpUj7LfRLKK6Uy+pObXBMSZ769FfzHG1DEd+aVLg7IX
         ixZ8S90Gwnyg7UaKSkoleMjaPyjKRuYVAAAb6GMFQtAiC5vTg/6/l28IQx7glVb9tfiA
         ePlA==
X-Gm-Message-State: AOJu0YxfWt0XfsspDHlYnR4ALg2KHxKpEnqf5GOyVZCNfqEYjHZ6nbT+
	kTBtFdyBkJPEKkyVCu/d3ENFHV8616k57bGACpJvnhQ7NQlqRaiN5VKvcaecGrfpIqpPKVgAr1H
	HOKhT/n44KhpJdDKo5eds4Q/KGL4=
X-Google-Smtp-Source: AGHT+IHEFmBTe29vDtsI4szZUI6WOuKhp/SfGG0XCoqs3OTYzJZuW3IYCeh5qdDTJ0C2NZWckvdl4xtD0s26LNb3yM0=
X-Received: by 2002:ad4:5cc1:0:b0:69b:155c:a793 with SMTP id
 iu1-20020ad45cc1000000b0069b155ca793mr632221qvb.39.1712468866358; Sat, 06 Apr
 2024 22:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com> <20240407051031.6018-2-leduyquang753@gmail.com>
In-Reply-To: <20240407051031.6018-2-leduyquang753@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Apr 2024 01:47:35 -0400
Message-ID: <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
To: =?UTF-8?Q?L=C3=AA_Duy_Quang?= <leduyquang753@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 1:10=E2=80=AFAM L=C3=AA Duy Quang <leduyquang753@gma=
il.com> wrote:
> This is to separate out connected regions of the resulting commit graph s=
o as
> to not have them confused as belonging to the same timeline.
> ---

I'm not particularly a user of --graph, so I don't necessarily have an
opinion about the utility of this change or its mechanics, but I can
make a few observations to help you improve the patch to improve the
chances of it being accepted.

First, move the information from the cover letter into the commit
message of the patch itself since that information will be helpful to
future readers of the patch if it becomes part of the permanent
history.

Second, following Documentation/SubmittingPatches guidelines, the
subject could instead be written something like this:

    log: visually separate `git log --graph` regions

Third, add a Signed-off-by: trailer after the commit message (see
SubmittingPatches).

> diff --git a/graph.c b/graph.c
> @@ -729,9 +742,9 @@ static int graph_num_expansion_rows(struct git_graph =
*graph)
>  static int graph_needs_pre_commit_line(struct git_graph *graph)
>  {
> -       return graph->num_parents >=3D 3 &&
> +       return graph->connected_region_state =3D=3D CONNECTED_REGION_NEW_=
REGION || (graph->num_parents >=3D 3 &&

Style: This line is overly long and should be wrapped; we aim (as much
as possible) to fit within an 80-column limit.

>                graph->commit_index < (graph->num_columns - 1) &&
> -              graph->expansion_row < graph_num_expansion_rows(graph);
> +              graph->expansion_row < graph_num_expansion_rows(graph));
>  void graph_update(struct git_graph *graph, struct commit *commit)
> @@ -760,6 +773,12 @@ void graph_update(struct git_graph *graph, struct co=
mmit *commit)
> +
> +       /*
> +        * Determine whether this commit belongs to a new connected regio=
n.
> +        */
> +       graph->connected_region_state =3D (graph->connected_region_state =
!=3D CONNECTED_REGION_FIRST_COMMIT &&
> +               graph->num_new_columns =3D=3D 0) ? CONNECTED_REGION_NEW_R=
EGION : CONNECTED_REGION_USE_CURRENT;

Style: overly long lines

> +static void graph_output_separator_line(struct git_graph *graph, struct =
graph_line *line)
> +{
> +       /*
> +        * This function adds a row that separates two disconnected graph=
s,
> +        * as the appearance of multiple separate commits on top of each =
other
> +        * may cause a misunderstanding that they belong to a timeline.
> +        */

This comment seems to explain the purpose of the function itself. As
such, it should precede the function definition rather than being
embedded within it.

> +       assert(graph->connected_region_state =3D=3D CONNECTED_REGION_NEW_=
REGION);

We tend to use BUG() rather than assert():

    if (graph->connected_region_state !=3D CONNECTED_REGION_NEW_REGION)
        BUG("explain the failure here");

> +       /*
> +        * Output the row.
> +        */
> +       graph_line_addstr(line, "---");

The code itself is obvious enough without the comment, so the comment
is mere noise, thus should be dropped.

> +       /*
> +        * Immediately move to GRAPH_COMMIT state as there for sure aren'=
t going to be
> +        * any more pre-commit lines.
> +        */
> +       graph_update_state(graph, GRAPH_COMMIT);
> +}
> diff --git a/t/t4218-log-graph-connected-regions.sh b/t/t4218-log-graph-c=
onnected-regions.sh
> new file mode 100755

We typically try to avoid creating new test scripts if an existing
script would be a logical place to house the new tests. I haven't
personally checked if such a script already exists, but if so, it
would be good to add new tests to it. If not, then creating a new
script, as you do here, may be fine.

> @@ -0,0 +1,119 @@
> +#!/bin/sh
> +
> +test_description=3D"git log --graph connected regions"
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-terminal.sh"
> +. "$TEST_DIRECTORY/lib-log-graph.sh"

"lib-terminal.sh" doesn't seem to be needed by these tests.

> +test_cmp_graph () {
> +       lib_test_cmp_graph --format=3D%s "$@"
> +}
> +
> +add_commit () {
> +       touch $1 &&

If the timestamp of the empty file being created is not significant,
we avoid `touch` and instead use `>` to create the file:

    >"$1" &&

> +       git add $1 &&
> +       git commit -m $1
> +       git tag "$1-commit"
> +}

Is this add_commit() function more or less duplicating the
functionality of test_commit() from t/test-lib-functions.sh?

> +cat > expect <<\EOF

Style: drop whitespace following redirect operators:

    cat >expect <<\EOF

> +* a3
> +* a2
> +* a1
> +| *   b4
> +| |\
> +| | * c3
> +| * | b3
> +| |/
> +| * b2
> +| * b1
> +|/
> +| * d4
> +| * d3
> +| | * e3
> +| |/
> +| * d2
> +| * d1
> +|/
> +* root
> +EOF
> +
> +test_expect_success 'all commits' '
> +       test_cmp_graph a b c d e
> +'

Modern test style is to perform all actions inside the
test_expect_success body itself, so:

    test_expect_success 'all commits' '
        cat >expect <<-\EOF
        ...
        EOF
        test_cmp_graph a b c d e
    '

Note the use of <<- to allow you to indent the here-doc body.
