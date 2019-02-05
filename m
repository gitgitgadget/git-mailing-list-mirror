Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C96A1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 11:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBELGM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 06:06:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:54545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBELGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 06:06:11 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgtWa-1gUvSF3Ong-00M722; Tue, 05
 Feb 2019 12:06:04 +0100
Date:   Tue, 5 Feb 2019 12:06:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
In-Reply-To: <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org> <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a1T5R6XCsU4pm/Q7To1laYbAwTGP6hZ3hicj19oJI7hip6ooUF2
 60K3e96ihgq+bqHGLqzxdqWcJDZBVDNzcUbn1vAF5eslzxn+yaWD7LquocBgHGYOSSAEBPj
 2SbstNdZ9QFZXt2+PkMpsCoVCrwrXEBoKBMcA6nyS0pRGTkU+O4f83fRNvOmR1URBNwX0zg
 GQy6/NKqCMsCn40TPA+Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X1Jad/g6Muk=:IWHPs+pcHDzT4NccqfrkiW
 V9rHdfCkATHAFD4KA/5QfvIpx/HGDGgxoKFneiC9sZjacwx33KcUf0BB6uUM9rUDWDrs6E/Ag
 KpDqxyZXru2ROhFCQvmKOhJOj9DvC+jldXo1ujCqod10h80PDfIWkzV3NmqaiVkbUtNcl4vjy
 91AE8m22LbgDd+VHqNutIyjhT9vcdGoJ70L9f5OmlJZWMil8sWnuGjR3HDpmGWwmifA/QxfnN
 pRlEhTM2TRxPA53YN2pbHWqh6YTwKHWy0vFRW8HSYhPj+rn7sOhI/HsoiAKi29jmEz2/uCoxs
 whIFBhtxEbWBRhNJiScBs6u2F6XWGS9IGpL7bYheb3ufqaPXqNza+qWNeQTAydHU/NTTWRu2k
 Nh448CDH2Akf0CnCmYP5wuD0DZYARB0wskeBydgEZ/jirN1Eacn9zQ4LedHFNqFreV/Y+CMlk
 fC9oqBhGzFaiY8mqcfPZyJViqpijkmXwEgI2VrW5mXB/4ug37NYp2wn7FwtqagNGfcv0fmAWM
 CbeicoiJHPXgQaQHo+OIAEwvvVHLD/FgikRyv6/NBHLn7mfC3BsMSbq17q3Y+ffWQ08Mmue7V
 IO2H99CNGCtyd908Lmt4HZ3DhwAR6Aur2DXRXJybFiwZW7722WSzVRCs8POTfLVTcHAVVKPkv
 EKx6ZolIHrLZHmRWHhDVilwnrX/u2lVQs4xIGrIwDEBzFl5nYJUuD2IT5IyGh+w5CEpg8J/fS
 juixAnzj3f3J5nP2v6odLmWvYR0w6AkMA/tmruDWrlhP73T3FQ5zS/l3a1+ZLsm7AxRIm6t2e
 HwgtZi2STGjkVuhQbH0EZvvxNtKBlg3pcW2TeqWWGVaxnCLKrov2K+xoG6GkzmYUrk/7EZ+d/
 zbND8qjbBUH7noI/AvEgbvaf4KgOPHaaPc0HHyft4406rm8/TxAufA08YMu9heBIfo4nLzqdZ
 eKgYAtsZgKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 4 Feb 2019, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > strbuf_vinsertf inserts a formatted string in the middle of an existing
> > strbuf value. It makes room in the strbuf by moving existing string to
> > the back, then formats the string to insert directly into the hole.
> >
> > It uses vsnprintf to format the string. The buffer size provided in the
> > invocation is the number of characters available in the allocated space
> > behind the final string. This does not make any sense at all.
> >
> > Fix it to pass the length of the inserted string plus one for the NUL.
> > (The functions saves and restores the character that the NUL occupies.)
> >
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > ---
> >  I found this, because in my environment I have to compile with
> >  SNPRINTF_RETURNS_BOGUS. Our implementation of vsnprintf in
> >  compat/snprintf.c writes into the end of the buffer unconditionally,
> >  at a spot that is unrelated to the formatted string, and this leads to
> >  "BUG: a NUL byte in commit log message not allowed" in some "stash"
> >  tests.
> 
> An embarrassing indication that not every line is read during
> development or review with fine toothed comb.

Or that they are read with a fine toothed comb, but that the focus lies
more on style and maintainability than correctness. We talked about this
in the past.

> I guess it won't trigger without the returns-bogus thing, and the
> "testing" done on platforms did not help.

It won't trigger with implementations of vsnprintf() that write just the
necessary bytes. You will note that our compat/ version writes at the end
of the provided buffer, which is legal, but actually not necessary.

> Thanks for finding it.  This needs to be squashed into bfc3fe33
> ("strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`",
> 2018-12-20)?

Since you want to open that can of worms again, you will also want to
squash ed5d77f7d382 (stash: fix segmentation fault when files were added with
intent, 2019-01-18) into 1f5a011d90ec (stash: convert create to builtin,
2018-12-20). It will have trivial merge conflicts, and the addition of the
regression test will be surprising without modifying the commit message to
explain that there was a regression that was fixed very late in the
development, and that that regression test intends to guarantee that it
won't need to be fixed again.

> As you mention in the direct response of this message, it might make
> sense to get rid of the helper with YAGNI, but that's something we
> need to see what its potential users should be doing (note: I did
> not say "what its potential users are doing").

As I already mentioned, there are a couple of potential users that I even
included in my original proposal to Paul, but we decided that this is a
separate concern and should therefore be addressed in a separate patch
series.

> It could turn out that there may be many places that could use this
> helper, but it may merely be an indication that these many places
> are structured poorly to compute the "shell" string too early before
> the string to be inserted becomes computable, in which case the real
> fix may not be to use this helper but to change the order of
> building up the string.

We do not usually do that, as our reviewers would almost certainly point
out such a convoluted operation.

And you seem to make a case against having `strbuf_insert()` to begin
with. So I am wondering whether you want to take a step back before going
further down that road.

The real examples are much more mundane, and very different from what you
suspected, e.g. inserting the tag header before the tag message in
`create_tag()` in `builtin/tag.c`. Basically, it is building up a strbuf
for the sake of calling `strbuf_insert()` to insert that string elsewhere.

In any case, the mere existence, and use, of `strbuf_insert()` is a pretty
clear counter case to the idea that `strbuf_vinsertf()` would encourage
invalid code flows.

Ciao,
Dscho

> Perhaps we want a string that is concatenation of part #1, part #2 and
> part #3, but we somehow first compute concatenation of part #1 and part
> #3 in a buffer, which requires us to insert part #2 in between.  If we
> restructure the code to keep parts #1 and #3 separate, or delay
> computing part #3, until part #2 becomes available, that would fix the
> "potential users" in a better way without having to make calls into this
> helper, for example.
> 
> 
> >  strbuf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/strbuf.c b/strbuf.c
> > index bfbbdadbf3..87ecf7f975 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -270,7 +270,7 @@ void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
> >  	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
> >  	/* vsnprintf() will append a NUL, overwriting one of our characters */
> >  	save = sb->buf[pos + len];
> > -	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
> > +	len2 = vsnprintf(sb->buf + pos, len + 1, fmt, ap);
> >  	sb->buf[pos + len] = save;
> >  	if (len2 != len)
> >  		BUG("your vsnprintf is broken (returns inconsistent lengths)");
> 
