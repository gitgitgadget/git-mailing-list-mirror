Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D043F1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeABPdy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 10:33:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59391 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751300AbeABPdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 10:33:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C1A7CE75F;
        Tue,  2 Jan 2018 10:33:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=WbKOOaaU52loIWgKqgDsJt8c2tg
        =; b=xEyLzbvlZcCDX2exd0kfiIc7uXEe69l1QGgVE7DKruqbVvDvY/wqxlxGo6T
        mchJ9gcvozh36k1Ha6m7tNQVWvKKmK9ZQsdAleqS4RIJSotbOW9nuK7DFFP7aG0S
        DG1GMPMaxEFXCZY8g9oLzVKO8P1vDkRVaTDCs4MEKPKFqta4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=pix5D6S1HJ25077EAqAqu
        n5bgg/9QzNlRXpwq6PrUmQsqs3ArPQylr1VhrMcfz8KgMMSvuEHYDAVuAi3oEPNd
        pXA/2/Hnudy+IC4ZwpckpkmUqigUIfbChGjS4Ce0USbtCTy8k5gcLEz2B/LoGfrr
        VvgU+WrX/rOImjUaZ2Bk+8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51EFACE75E;
        Tue,  2 Jan 2018 10:33:52 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.86.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B6E5CE75D;
        Tue,  2 Jan 2018 10:33:51 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc/SubmittingPatches: improve text formatting
Date:   Tue,  2 Jan 2018 10:33:50 -0500
Message-Id: <20180102153350.11723-1-tmz@pobox.com>
X-Mailer: git-send-email 2.16.0.rc0
X-Pobox-Relay-ID: 55AFFF90-EFD2-11E7-820E-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

049e64aa50 ("Documentation: convert SubmittingPatches to AsciiDoc",
2017-11-12) changed the `git blame` and `git shortlog` examples given in
the section on sending your patches.

In order to italicize the `$path` argument the commands are enclosed in
plus characters as opposed to backticks.  The difference between the
quoting methods is that backtick enclosed text is not subject to further
expansion.  This formatting makes reading SubmittingPatches in a git
clone a little more difficult.  In addition to the underscores around
`$path` the `--` chars in `git shortlog --no-merges` must be replaced
with `{litdd}`.

Use backticks to quote these commands.  The italicized `$path` is lost
from the html version but the commands can be read (and copied) more
easily by users reading the text version.  These readers are more likely
to use the commands while submitting patches.  Make it easier for them.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

I missed this in the initial discussion.  It was mentioned by
Junio and brian explained the reasoning for using it in
<20171031012710.jfemqb6ybiog4sbz@genre.crustytoothpaste.net>:

> > The +fixed width with _italics_ mixed in+ mark-up is something not
> > exactly new, but it is rarely used in our documentation set, so I
> > had to double check by actually seeing how it got rendered, and it
> > looked alright.
>
> I thought it provided some hint to the reader that this wasn't meant to
> be typed literally.  It's a preference of mine and I think it aids in
> readability, but it can be changed if we want.

That's what I had guessed before I looked back at the list
archives.  I understand the desire to make it clear that $path
isn't a literal value.  I think that it's worth losing that subtle
hint in order to make the plain text SubmittingPatches file a
little easier to read.

Whether the people most likely to be considering sending a patch
for git.git are will read the document from a git clone or the
rendered html output is the main question.  Though even readers of
the installed text file in their packaged git will suffer a bit.

It's great having the document in HTML to aid in sharing it's
guidance with others, no doubt.  I've wanted to symlink to
portions of the document numerous times.  I hope a small change to
make it more legible to those who also like plain text will be
welcome.

I considered using backticks for the commands and then +_$path_+
for the argument.  Maybe that's a reasonable compromise?  I.e.:

-+git blame _$path_+ and +git shortlog {litdd}no-merges _$path_+ would help to
+`git blame` +_$path_+ and `git shortlog --no-merges` +_$path_+ would help to

The text version is still a bit strange with that method, but it
certainly separates "$path" from the rest of the command in both
the text and html output. :)

 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 3ef30922ec..a1d0feca36 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -261,7 +261,7 @@ not a text/plain, it's something else.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the output from
-+git blame _$path_+ and +git shortlog {litdd}no-merges _$path_+ would help to
+`git blame $path` and `git shortlog --no-merges $path` would help to
 identify them), to solicit comments and reviews.
 
 :1: footnote:[The current maintainer: gitster@pobox.com]
-- 
2.16.0.rc0

