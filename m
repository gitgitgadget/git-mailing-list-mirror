Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60C920248
	for <e@80x24.org>; Wed, 20 Mar 2019 18:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCTSR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 14:17:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63405 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfCTSR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 14:17:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 275D91381B2;
        Wed, 20 Mar 2019 14:17:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=Q7i6VXpDAlptq
        /XKyCpTFGRuxZ4=; b=Nn6q+9sC7UxU/Yj02NxnFDZCk6TZhLsisNO7MZ4k7aJls
        ytaux9N9tb8dUA7O9z1sPEPCbTdQBlB/JqTqZKHCfXFkyHHrx0dSKlAyO3VQxqIp
        Te+yJ112yD4WNr/ctsC8OuqqKXe4HY4srXeFlr7Xioh5Ww7d6UJDRp/IKnFKBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=Ml8A4wu
        xkLPpW044Y2LwV7p1tCRxjzKI8J/YMDK5vvFbPUR5tykw0WDleVSR/lXtxm/K53R
        R8Q6/LtOgAdZmdIKl7vwOZxgCbjdLXcJNhAXz3iGu8gx9MT43KwaIZ5bgXFOr2uU
        tcAzhsx1dBI7sxjTVpNhzuD5muSJTdQrPdz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F24C1381B1;
        Wed, 20 Mar 2019 14:17:18 -0400 (EDT)
Received: from pobox.com (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 659191381B0;
        Wed, 20 Mar 2019 14:17:17 -0400 (EDT)
Date:   Wed, 20 Mar 2019 14:17:15 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190320181715.GJ31362@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 64EFA200-4B3C-11E9-AFA3-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin =C5gren wrote:
> On Sun, 17 Mar 2019 at 20:44, Todd Zullinger <tmz@pobox.com> wrote:
>> Martin =C5gren wrote:
>> +ASCIIDOC_EXTRA +=3D -a mansource=3D"Git $(GIT_VERSION)" -a manmanual=3D=
"Git Manual"
>=20
> So to be honest, I still don't understand how this works, but it does,
> great. I really need to improve my documentation-reading skills.

Let me know if you find any good methods for perfect
retention.  I've re-read enough documentation for a
lifetime. ;)

> I had some more time to look at this. Thanks for getting started on thi=
s
> switch. A few things I noticed:
>=20
> {litdd} now renders as &#x2d;&#x2d. We should find some other way to
> produce '--'. This should then be a simple change, as we're already
> providing this attribute inside an `ifdef USE_ASCIIDOCTOR`.

I noticed that one and didn't work out a good fix, but it
sounds like you have one in mind.  That's great.

> "+" becomes "&#43;". I didn't immediately find where we do that.

For this one, I was working on replacing "{plus}" with `+`
(along with " " and "-").  That's probably not ideal though.

This is what I had to test:

-- 8< --
Subject: [PATCH] WIP: wrap "[ +-]" in backticks (NOT FOR SUBMISSION)

asciidoctor's manpage output html-encodes "{plus}" which seems like a
bug.  At the least it needs some option I've yet to learn.
---
 Documentation/git-add.txt | 26 +++++++++++++-------------
 Documentation/gitweb.txt  |  6 +++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 37bcab94d5..dc1dd3a91b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -363,20 +363,20 @@ may see in a patch, and which editing operations ma=
ke sense on them.
 --
 added content::
=20
-Added content is represented by lines beginning with "{plus}". You can
+Added content is represented by lines beginning with `"+"`. You can
 prevent staging any addition lines by deleting them.
=20
 removed content::
=20
-Removed content is represented by lines beginning with "-". You can
-prevent staging their removal by converting the "-" to a " " (space).
+Removed content is represented by lines beginning with `"-"`. You can
+prevent staging their removal by converting the `"-"` to a `" "` (space)=
.
=20
 modified content::
=20
-Modified content is represented by "-" lines (removing the old content)
-followed by "{plus}" lines (adding the replacement content). You can
-prevent staging the modification by converting "-" lines to " ", and
-removing "{plus}" lines. Beware that modifying only half of the pair is
+Modified content is represented by `"-"` lines (removing the old content=
)
+followed by `"+"` lines (adding the replacement content). You can
+prevent staging the modification by converting `"-"` lines to `" "`, and
+removing `"+"` lines. Beware that modifying only half of the pair is
 likely to introduce confusing changes to the index.
 --
=20
@@ -393,29 +393,29 @@ Avoid using these constructs, or do so with extreme=
 caution.
 removing untouched content::
=20
 Content which does not differ between the index and working tree may be
-shown on context lines, beginning with a " " (space).  You can stage
-context lines for removal by converting the space to a "-". The
+shown on context lines, beginning with a `" "` (space).  You can stage
+context lines for removal by converting the space to a `"-"`. The
 resulting working tree file will appear to re-add the content.
=20
 modifying existing content::
=20
 One can also modify context lines by staging them for removal (by
-converting " " to "-") and adding a "{plus}" line with the new content.
-Similarly, one can modify "{plus}" lines for existing additions or
+converting `" "` to `"-"`) and adding a `"+"` line with the new content.
+Similarly, one can modify `"+"` lines for existing additions or
 modifications. In all cases, the new modification will appear reverted
 in the working tree.
=20
 new content::
=20
 You may also add new content that does not exist in the patch; simply
-add new lines, each starting with "{plus}". The addition will appear
+add new lines, each starting with `"+"`. The addition will appear
 reverted in the working tree.
 --
=20
 There are also several operations which should be avoided entirely, as
 they will make the patch impossible to apply:
=20
-* adding context (" ") or removal ("-") lines
+* adding context (`" "`) or removal (`"-"`) lines
 * deleting context or removal lines
 * modifying the contents of context or removal lines
=20
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 88450589af..d27f239242 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -80,15 +80,15 @@ continuation (newline escaping).
 * Leading and trailing whitespace are ignored.
=20
 * Whitespace separated fields; any run of whitespace can be used as fiel=
d
-separator (rules for Perl's "`split(" ", $line)`").
+separator (rules for Perl's "`split(`" "`, $line)`").
=20
 * Fields use modified URI encoding, defined in RFC 3986, section 2.1
 (Percent-Encoding), or rather "Query string encoding" (see
 https://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the differen=
ce
-being that SP (" ") can be encoded as "{plus}" (and therefore "{plus}" h=
as to be
+being that SP (`" "`) can be encoded as `"+"` (and therefore `"+"` has t=
o be
 also percent-encoded).
 +
-Reserved characters are: "%" (used for encoding), "{plus}" (can be used =
to
+Reserved characters are: "%" (used for encoding), `"+"` (can be used to
 encode SPACE), all whitespace characters as defined in Perl, including S=
P,
 TAB and LF, (used to separate fields in a record).

-- 8< --

> `./doc-diff HEAD^ HEAD` shows how several "git-\nfoo" become
> "\ngit-foo", i.e., linkgit expansions are now treated as non-breaking.
> That's arguably good, but it brings some noise to the diff. Maybe one
> should try and see if it's possible to break that to have a nicer
> diff, then remove that breakage in a follow-up commit. Or, if it's
> possible to make "git-foo" non-breaking before the switch. Hmm, was thi=
s
> why you increased MANWIDTH?

Yeah, I noticed a number of places where asciidoc and
asciidoctor wrapped lines at slightly different places.  I
didn't see if they were all due to wrapping at a dashed git
command, but that could certainly have been the main cause.

I set the large MANWIDTH and then I think I added
--color-words to the diff call in doc-diff.

> A double-space between sentences turns into a single space -- at least
> in constructions such as "... to foobar. `git-foo` does ...". Not a
> problem perhaps, but noise in the diff.
>=20
> And I'm sure there's more lurking in that huge diff. Whether any of tha=
t
> is significant or not is another matter. ;-)

Oh my yes, I'm sure. :)

--=20
Todd
