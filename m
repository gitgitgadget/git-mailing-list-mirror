Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F7C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 20:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D464960F4A
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 20:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhJaUZw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 31 Oct 2021 16:25:52 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:8492 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJaUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 16:25:49 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:ca2c:7f9b:ab67:40b3])
        by smtp4-g21.free.fr (Postfix) with ESMTP id BE5E019F58C;
        Sun, 31 Oct 2021 21:23:11 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz@archlinux.org>
Cc:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in placeholders
Date:   Sun, 31 Oct 2021 21:23:11 +0100
Message-ID: <2803948.JoDkH9avOM@cayenne>
In-Reply-To: <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com> <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com> <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le dimanche 31 octobre 2021, 19:58:56 CET Eli Schwartz a écrit :
> On 10/28/21 12:21 PM, Jean-Noël Avila via GitGitGadget wrote:
> > From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> > 
> > According to CodingGuidelines, spaces and underscores are not
> > allowed in placeholders.
> 
> 
> I have a patch under review that touches the same files you are
> modifying here. As I've been pointed to these changes, I'd like to make
> a quick observation.
> 
> 
> > @@ -101,9 +101,9 @@ commits are displayed, but not the way the diff is 
shown e.g. with
> >  `git log --raw`. To get full object names in a raw diff format,
> >  use `--no-abbrev`.
> >  
> > -* 'format:<string>'
> > +* 'format:<format-string>'
> >  +
> > -The 'format:<string>' format allows you to specify which information
> > +The 'format:<format-string>' format allows you to specify which 
information
> >  you want to show. It works a little bit like printf format,
> >  with the notable exception that you get a newline with '%n'
> >  instead of '\n'.
> > @@ -273,12 +273,12 @@ endif::git-rev-list[]
> >  			  If any option is provided multiple times the
> >  			  last occurrence wins.
> >  +
> > -The boolean options accept an optional value `[=<BOOL>]`. The values
> > +The boolean options accept an optional value `[=<value>]`. The values
> 
> 
> Here you change "BOOL" to "value", below you change it to "bool-value".

Indeed. Should be fixed.

> 
> 
> >  `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> >  sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> >  option is given with no value, it's enabled.
> >  +
> > -** 'key=<K>': only show trailers with specified key. Matching is done
> > +** 'key=<key>': only show trailers with specified <key>. Matching is done
> >     case-insensitively and trailing colon is optional. If option is
> >     given multiple times trailer lines matching any of the keys are
> >     shown. This option automatically enables the `only` option so that
> > @@ -286,9 +286,9 @@ option is given with no value, it's enabled.
> >     desired it can be disabled with `only=false`.  E.g.,
> >     `%(trailers:key=Reviewed-by)` shows trailer lines with key
> >     `Reviewed-by`.
> > -** 'only[=<BOOL>]': select whether non-trailer lines from the trailer
> > +** 'only[=<bool-value>]': select whether non-trailer lines from the 
trailer
> >     block should be included.
> > -** 'separator=<SEP>': specify a separator inserted between trailer
> > +** 'separator=<sep>': specify a separator inserted between trailer
> >     lines. When this option is not given each trailer line is
> >     terminated with a line feed character. The string SEP may contain
> >     the literal formatting codes described above. To use comma as
> > @@ -296,15 +296,15 @@ option is given with no value, it's enabled.
> >     next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
> >     shows all trailer lines whose key is "Ticket" separated by a comma
> >     and a space.
> > -** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
> > +** 'unfold[=<bool-value>]': make it behave as if interpret-trailer's `--
unfold`
> >     option was given. E.g.,
> >     `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
> > -** 'keyonly[=<BOOL>]': only show the key part of the trailer.
> > -** 'valueonly[=<BOOL>]': only show the value part of the trailer.
> > -** 'key_value_separator=<SEP>': specify a separator inserted between
> > +** 'keyonly[=<bool-value>]': only show the key part of the trailer.
> > +** 'valueonly[=<bool-value>]': only show the value part of the trailer.
> > +** 'key_value_separator=<sep>': specify a separator inserted between
> >     trailer lines. When this option is not given each trailer key-value
> >     pair is separated by ": ". Otherwise it shares the same semantics
> > -   as 'separator=<SEP>' above.
> > +   as 'separator=<sep>' above.
> >  
> >  NOTE: Some placeholders may depend on other options given to the
> >  revision traversal engine. For example, the `%g*` reflog options will
> 
> 
> These changes over here are contrary to the statement in the commit
> message. In addition to switching to hyphens, they:
> 
> - switch casing (okay, makes sense, you point this out in the cover
>   letter but maybe it's worth mentioning it in the commit message too?
>   idk)
> 
> - change the terms used -- and this I don't understand. I'm not really
>   bothered by switching <n> to <number> or <k> to <key>, as these
>   changes seem reasonable (though again, they are not mentioned in the
>   commit message). However, "bool-value" seems odd. Why that and not
>   "number-value"? IMHO the "value" is redundant here, let it be "bool"
>   and "number".

My initial aim was to be more descriptive. The placeholders act as variables 
and you don't name variables with their types.	
Fair enough, "bool-value" isn't the best example, but there are some facts 
that drove these choices:
 * You can't expect manpage readers to be seasoned C programmers that 
understand what the word "bool" means. Using boolean-value, makes the 
reference to the description in the previous paragraph.
 * I'm facing a similar issue with translators. Some of them have some culture 
of computer science, but most of them are not programmers. Having more 
meaningful placeholders helps them find a correct translation: this is a bool 
value, not the bool type.

I did not push far to change all the placeholders that were not descriptive. 
Maybe another set of patches, if it is acceptable.

The choices here may be awkward; no problem to propose even more descriptive 
names.

> 
>   Similarly "the 'format:<format-string>' format" feels highly
>   redundant, I expect the reader knows that <string> contains a format
>   inside it as it's mentioned immediately before *and* after.
> 

The fact that it is a string doesn't tell you much about what you can do with 
it. For me, this isn't a problem that the explanation is redundant.




