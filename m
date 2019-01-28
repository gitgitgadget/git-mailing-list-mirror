Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7741211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 20:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfA1UEU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 15:04:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UEU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 15:04:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so14096151edd.11
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S7ALacDWjB+lR1nL1Yfq6A45MNownRgiSugwko38bbI=;
        b=K/iYBV/gdvO4uemDzsyxsTJx5DKGZwqhXLayT2Fse9LIMcwjPUJImJY78r2GAcfLTg
         DCMCxNe0/Hrv3+7jgc5rYyUUOzbvq2v6HTN4Ho2/vgMDKbN2L3BGz96WGsxd/uA59H0P
         Ag0BoQnwK2UOXcxcsSqitnVodVYH42CI79iKTbUBgnc8P9r5XxvaoSJmJuDPFzwlVxxo
         84eENAndCWJmdSiSew1XT4GJuqqX4mzCjrpYR5T7O1FVkn8L1QqWlv3g8Z9vhYmyXcSX
         0F7FX9wsL0HK9HD8sXFh2xoAPQGBQx4wr0kOAWzW3zA9eTc8ihb6O0F1snehD2jp7XQF
         Vmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=S7ALacDWjB+lR1nL1Yfq6A45MNownRgiSugwko38bbI=;
        b=heDMOxFOlEBw8JmXX5OZwjt8pjdGZhayE7QKSYk1zImnPvDlZCQxgsMlPA975ao7F8
         rZy2ay/WBdPcIuLOXaCnBS4A3gSzidW2LBTnA6JMoqf/ugSxf7Ras7CO2AFoQVAoLAYa
         8jZSxSRjkOsyvAAL/VCiRK48+9HdQnr9IC6l61/XwFiQMODNUPkj5yomAprtfUWR7DA/
         aSdEzhY98bH2DwkuUWSKKYoQeBPzpXlJWHR4vX0WpEVRLhOa2nF2PcEHY+luyOaWLYhZ
         7eVlzE2ZQRNNbYv0pdNCuopyGy1bg3x/42L5puvzRlH6h2T89yVOQxLqdYGtk9gahSPN
         7E3g==
X-Gm-Message-State: AJcUukeo4SXagUihDxe7u9tplh7EyiZeAH2h+I7Z7td6NfsmQCcs29k5
        VLVYkaIemivUuwbt/Q/a+w6OYpX2
X-Google-Smtp-Source: ALg8bN4Ho2X/0BfHsTRHqjzfhfIuqHLW+VzhpECPV8ICyX79NLXBZxlweWP2EdOtcA8UF0PWoyYF2g==
X-Received: by 2002:a50:c299:: with SMTP id o25mr23311369edf.281.1548705857456;
        Mon, 28 Jan 2019 12:04:17 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o23sm625820ejd.1.2019.01.28.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 12:04:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org> <20190125215955.30032-2-williamh@gentoo.org> <877ees4a65.fsf@evledraar.gmail.com> <20190128185817.GA28155@whubbs1.gaikai.biz>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190128185817.GA28155@whubbs1.gaikai.biz>
Date:   Mon, 28 Jan 2019 21:04:15 +0100
Message-ID: <871s4w4khs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 28 2019, William Hubbs wrote:

> On Fri, Jan 25, 2019 at 11:58:10PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, Jan 25 2019, William Hubbs wrote:
>>
>> > diff --git a/Documentation/config/user.txt b/Documentation/config/user=
.txt
>> > index b5b2ba1199..18e1ec3c1b 100644
>> > --- a/Documentation/config/user.txt
>> > +++ b/Documentation/config/user.txt
>> > @@ -1,12 +1,39 @@
>> > +author.email::
>> > +	The email address used for the author of newly
>> > +	created commits.  Defaults to the value of the
>> > +	`GIT_AUTHOR_EMAIL` environment variable, or if
>> > +	the environment variable is not set, the `user.email`
>> > +	configuration variable.
>> > +
>> > +author.name::
>> > +	The full name used for the author of newly created commits.
>> > +	Defaults to the value of the `GIT_AUTHOR_NAME` environment variable,=
 or
>> > +	if the environment variable is not set,
>> > +	the `user.email` configuration variable.
>> > +
>> > +committer.email::
>> > +	The email address used for the committer of newly created commits.
>> > +	Defaults to the value of the `GIT_COMMITTER_EMAIL` environment
>> > +	variable, or if the environment variable is not set, the `user.email`
>> > +	configuration variable.
>> > +
>> > +committer.name::
>> > +	The full name used for the committer of newly created commits.
>> > +	Defaults to the value of the `GIT_COMMITTER_NAME` environment
>> > +	variable, or if the environment variable is not set, the `user.name`
>> > +	configuration variable.
>> > +
>> >  user.email::
>> >  	Your email address to be recorded in any newly created commits.
>> >  	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, =
and
>> > -	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
>> > +	`EMAIL` environment variables or the `author.email` or
>> > +	`committer.email` settings discussed above. See linkgit:git-commit-t=
ree[1].
>> >
>> >  user.name::
>> >  	Your full name to be recorded in any newly created commits.
>> >  	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
>> > -	environment variables.  See linkgit:git-commit-tree[1].
>> > +	environment variables or the `author.name` or `committer.name`
>> > +	settings discussed above. See linkgit:git-commit-tree[1].
>>
>> Looks correct, although I wonder if we're at the point where it would be
>> better to present this info as a table.
>
> Maybe, but can we have someone do that in a separate patch? I ask
> because the documentation is not in a markup language and that would
> make setting up a table difficult for me at best with my screen reader.

I'm happy to help if you'd like. I had a thinko with "table", and I
think our asciidoc dialect doesn't support it (maybe I'm wrong), but
thinking about it again we could just describe these variables all in
the same documentation. As in this hunk (which you could squash in):

BEGIN QUOTE
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 18e1ec3c1b..ad3c43cf47 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -1,39 +1,20 @@
-author.email::
-	The email address used for the author of newly
-	created commits.  Defaults to the value of the
-	`GIT_AUTHOR_EMAIL` environment variable, or if
-	the environment variable is not set, the `user.email`
-	configuration variable.
-
+user.name::
+user.email::
 author.name::
-	The full name used for the author of newly created commits.
-	Defaults to the value of the `GIT_AUTHOR_NAME` environment variable, or
-	if the environment variable is not set,
-	the `user.email` configuration variable.
-
-committer.email::
-	The email address used for the committer of newly created commits.
-	Defaults to the value of the `GIT_COMMITTER_EMAIL` environment
-	variable, or if the environment variable is not set, the `user.email`
-	configuration variable.
-
+author.email::
 committer.name::
-	The full name used for the committer of newly created commits.
-	Defaults to the value of the `GIT_COMMITTER_NAME` environment
-	variable, or if the environment variable is not set, the `user.name`
-	configuration variable.
-
-user.email::
-	Your email address to be recorded in any newly created commits.
-	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
-	`EMAIL` environment variables or the `author.email` or
-	`committer.email` settings discussed above. See linkgit:git-commit-tree[1=
].
-
-user.name::
-	Your full name to be recorded in any newly created commits.
-	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
-	environment variables or the `author.name` or `committer.name`
-	settings discussed above. See linkgit:git-commit-tree[1].
+committer.email::
+	The `user.name` and `user.email` variables determine what ends
+	up in the `author` and `committer` field of commit
+	objects. These config variables will be overridden by
+	`GIT_COMMITTER_NAME` and `GIT_COMMITTER_EMAIL`,
++
+Most users should have no reason to set the `author.*` and
+`committer.*` variables, but can do so to e.g. set different a
+different E-Mail for the `committer` field. Like the `user.name` and
+`user.email` variables, these can be overridden in the environment
+with `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME` and
+`GIT_COMMITTER_EMAIL`.

 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
END QUOTE

Another thing I spotted while hacking that up is that the
git-commit-tree docs we're pointing to as the full explanation haven't
been updated. They still just talk about user.{name,email}.

And poking at this a bit more I see that something about this is
introducing new edge cases into our "you haven't set user.name or
user.email" logic. I.e. if I do:

    GIT_AUTHOR_NAME=3Dhi GIT_AUTHOR_EMAIL=3Dblah GIT_COMMITTER_NAME=3D"hell=
o" ./git-commit -a -m"hi"

I end up with an object like:

    author hi <blah> 1548705397 +0100
    committer hello <avar@nix.is> 1548705397 +0100

I.e. here I haven't supplied the committer E-Mail but it was inferred
(and a warning was printed to that effect). But if I do the same thing
with setting author.name etc. for all fields except committer.email I'll
get an empty ("<>") field for the committer E-Mail, even though it
printed "Your name and email address were configured automatically based
on your username and hostname".


>> > diff --git a/builtin/am.c b/builtin/am.c
>> > index 95370313b6..53fdd22c45 100644
>> > --- a/builtin/am.c
>> > +++ b/builtin/am.c
>> > @@ -1594,7 +1594,7 @@ static void do_commit(const struct am_state *sta=
te)
>> >  	}
>> >
>> >  	author =3D fmt_ident(state->author_name, state->author_email,
>> > -			state->ignore_date ? NULL : state->author_date,
>> > +			WANT_AUTHOR_IDENT, state->ignore_date ? NULL : state->author_date,
>>
>> This & a few other things in this series take the code beyond 79
>> characters.
>
> This doesn't look like it is beyond 79 characters to me, but that may be
> because I use a tab stop width of 4.
>
> Can you reply again and flag the lines that are longer than 79
> characters?

I see Junio replied to this already.

Adjusting for limited time, I'm happy to help out with this series,
particularly if you have visual (screen reader) issues that make some of
this prohibitive for you. Just say what you need.
