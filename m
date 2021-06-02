Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F311C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BCA613DA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFBUkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:40:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBUkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:40:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 619DEC19DB;
        Wed,  2 Jun 2021 16:38:51 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=XHnYCsfpkV+6O
        Igy3hB9qDY3O7I/wtbbxwivxRdTf+I=; b=VFg63v2l1ToTQf3aXO/SON5ClGIea
        qeQJPHGCpVVwWImpi2qo4QLXhu4ToqsA28Y1/Pn4oQMIZHvDkGHY3IpY4ZcAOo6E
        V6YzUP1cdZ9j+cmjjq39u1fKT/EaTyEdQF5tr0gWMlQj8ZKvxhfrMFyLIhV+4O9C
        rhPRweOpsog038=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58523C19DA;
        Wed,  2 Jun 2021 16:38:51 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.178.134])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C91E4C19D8;
        Wed,  2 Jun 2021 16:38:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 2 Jun 2021 16:38:49 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Message-ID: <20210602203849.GD15354@pobox.com>
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
 <057126a2-81c4-41cf-e41a-52a24a0c9a52@gmail.com>
 <YLe4+2JKH1LYRTvv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLe4+2JKH1LYRTvv@nand.local>
X-Pobox-Relay-ID: 89E9C6DC-C3E2-11EB-9DE7-FD8818BA3BAF-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Tue, Jun 01, 2021 at 09:17:54PM -0400, Derrick Stolee wrote:
>> On 6/1/2021 8:11 PM, Andrei Rybak wrote:
>>> Config variables feature.experimental and feature.manyFiles are group=
ed
>>> together under "feature.*".  However, this is not easily visible when
>>> scanning the help page of git-config.
>>>
>>> Indent the descriptions of individual feature.* config variables to h=
elp
>>> the reader distinguish this group of variables.
>>
>> I'm not sure how these extra tabs help in the rendered text, or in
>> the formatted HTML output for the git-scm.com web page. I do believe
>> that we would want to re-wrap the paragraphs to ensure we are not usin=
g
>> too many characters per line.
>>
>> Is there precedence for a simple tabbing like this? I was able to find
>> a similar grouping for advice.* in Documentation/config/advice.txt, bu=
t
>> it uses a different kind of grouping. Perhaps reorganize the file to u=
se
>> that strategy instead?
>=20
> AsciiDoc has a couple of ways to indent a subsection, one example (whic=
h
> uses the same style '--' header as in these patches) can be found in
> 9218c6a40c (midx: allow marking a pack as preferred, 2021-03-30).
>=20
>> Or, perhaps just point me to an existing use of this pattern.
>=20
> git-scm.com doesn't have 9218c6a40c yet, since it won't be released
> until 2.32, but grepping around for '^--' in Documentation shows some
> other results.

One thing worth noting if this is picked up, I think the `+`
continuations inside the `--` open block should be removed.
They render fine in asciidoc, but in asciidoctor the `+`
characters remain in the rendered output.

Here's a doc-diff with and without the additional `+`
continuations in asciidoctor:

    --- a/git-config.1	2021-06-01 21:39:56.769640893 -0400
    +++ b/git-config.1	2021-06-01 21:40:03.318893602 -0400
    @@ -2474,7 +2474,7 @@
                    version updates. These settings may have unintended
                    interactions since they are so new. Please enable thi=
s setting
                    if you are interested in providing feedback on experi=
mental
    -               features. The new default values are: +
    +               features. The new default values are:
    =20
                    =E2=80=A2   fetch.negotiationAlgorithm=3Dskipping may=
 improve fetch
                        negotiation times by skipping more commits at a t=
ime,
    @@ -2484,10 +2484,10 @@
                    Enable config options that optimize for repos with ma=
ny files
                    in the working directory. With many files, commands s=
uch as git
                    status and git checkout may be slow and these new def=
aults
    -               improve performance: +
    +               improve performance:
    =20
                    =E2=80=A2   index.version=3D4 enables path-prefix com=
pression in the
    -                   index. +
    +                   index.
    =20
                    =E2=80=A2   core.untrackedCache=3Dtrue enables the un=
tracked cache. This
                        setting assumes that mtime is working on your mac=
hine.

Here's what I suggest be squashed into this patch:

diff --git a/Documentation/config/feature.txt b/Documentation/config/feat=
ure.txt
index 2c4dee170b..7975ec35fd 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -12,7 +12,7 @@ feature.*::
 		have unintended interactions since they are so new. Please enable this
 		setting if you are interested in providing feedback on experimental
 		features. The new default values are:
-	+
+
 	* `fetch.negotiationAlgorithm=3Dskipping` may improve fetch negotiation=
 times by
 	skipping more commits at a time, reducing the number of round trips.
=20
@@ -20,9 +20,9 @@ feature.*::
 		Enable config options that optimize for repos with many files in the
 		working directory. With many files, commands such as `git status` and
 		`git checkout` may be slow and these new defaults improve performance:
-	+
+
 	* `index.version=3D4` enables path-prefix compression in the index.
-	+
+
 	* `core.untrackedCache=3Dtrue` enables the untracked cache. This settin=
g assumes
 	that mtime is working on your machine.
 --

With the above, the man page output renders identically with
asciidoc (9.1.0) and asciidoctor (I tested both 2.0.10 and
2.0.15).

The asciidoc documentation[1] says:

    If you=E2=80=99re attaching more than one block to a list item,
    you=E2=80=99re strongly encouraged to wrap the content inside an
    open block. That way, you only need a single list
    continuation line to attach the open block to the list
    item. Within the open block, you write like you normally
    would, no longer having to worry about adding list
    continuations between the blocks to keep them attached
    to the list item.

[1] https://docs.asciidoctor.org/asciidoc/latest/lists/continuation/#list=
-continuation

Only mildly related, but while I was looking at the output,
I noticed that the man page renders the phrase "The config
settings that start with `feature.` modify the defaults"
oddly.  It places two spaces after the full stop.  It might
be worth writing that sentence slightly differently to avoid
that.  Maybe something like:

-       The config settings that start with `feature.` modify the default=
s of
+       The `feature.*` variables modify the defaults of

--=20
Todd
