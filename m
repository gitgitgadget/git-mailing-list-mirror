Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B251F453
	for <e@80x24.org>; Wed, 19 Sep 2018 02:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbeISIc0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 04:32:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36279 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeISIcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 04:32:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so3744507oie.3
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dHcqiIGaX+Wo1vNV4YSjeJb8/+1LAOXw7wTvA6PZE8=;
        b=ZVQF2kvf8wlXK0i6IlRPmWbp1iJ63AsVYGnch6Ee8qAyVMmB+yT6Q7cqOiwPqbcNjK
         kl48eSAhRyZnDkqQX5rqHWqTtErdE2RGf3y63lxu/0xQwEb5W5ZZyFcx6jh5bXTcwpLI
         No+g4UfYmLByrBwjjuI9mG8WxSBQgPJ+1dp+1CEeKMHtYKJUAjB9D5jhqfHEt6u6cB0l
         srdgPlONMImDv9GpHovyq4lLCjBdzjEuZpP82oIc7t1mWqOGtwxW9quAMnhjYSQ/dDwO
         hsx8YlLPriiox6KPz0ilwGXkDCCU3/1ZscNdDD6YLWhs/WwgXugIa+6HdksYrYtngS1e
         SBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dHcqiIGaX+Wo1vNV4YSjeJb8/+1LAOXw7wTvA6PZE8=;
        b=pS6RdcRKw4vtcmzcXLB7qkKSELp25jlavAwOC7IUi+LekyqcuNue/I1QrnOm0FKSO7
         EML7nND8YByMSJuSgaMXgu7LeRryg4ahH/NypTGdo5fIrTCQoKDUXKjCvuoOo9nNEpnt
         pQXAxVVMBwHQerJaPjx7ph7LLdH9kT0nYtQVXomZb3NeHy1ai0qv9I4FY8azcXQpZEi1
         P0HFaHX8j+BCkRWrbeGK5X33ysflhypFgiRQzLa+o657B+N0xPJKnO8UbUFzUSJZFEvg
         sOyoC9qztm9aB/zAuOxLqdT90m3w5I2vQABmX4iyvYm6njdBfNhsw1pGTU79ohUBk8ep
         aHfQ==
X-Gm-Message-State: APzg51BuVfjcrY9ir8fU3CGBE1PzcWMebDC95Zvhj5MP1vRN1eb6szn+
        /Hvh9q7x7HMUd5G5pjQCKq6i1h0YMjyR16iV3Njx
X-Google-Smtp-Source: ANB0VdbKGaMuGzzUD3H8lv37LNy0+KDdwitLE16rT7CVuP4KODaefZ98rTE0xFSLMCMe2zPyC4KCgF/orXJlR5jZJ0U=
X-Received: by 2002:aca:d605:: with SMTP id n5-v6mr398254oig.287.1537325801296;
 Tue, 18 Sep 2018 19:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <e01b719de662f0b150f78b5a6ab6ccfce9c675fa.1537223021.git.matvore@google.com> <CAPig+cT5BLu2onbuTBbZ_mMzNMkEuPk5-g2d5YKw4V6Z42Y3aQ@mail.gmail.com>
In-Reply-To: <CAPig+cT5BLu2onbuTBbZ_mMzNMkEuPk5-g2d5YKw4V6Z42Y3aQ@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 18 Sep 2018 19:56:29 -0700
Message-ID: <CAMfpvhJ3ye_7LWaQ1abXKtMB=O1sfOz6xYN=7acrVdLOksq9eA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] t9109-git-svn-props.sh: split up several pipes
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:57 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> > t9109-git-svn-props.sh: split up several pipes
>
> Similar to my comment about 5/6, this title talks about the mechanical
> changes made by the patch but not the intent. Perhaps reword it like
> this:
>
>     t9109: avoid swallowing Git exit code upstream of a pipe
>
Here is my new commit description:

    t9109: don't swallow Git errors upstream of pipe

    'git ... | foo' will mask any errors or crashes in git, so split up such
    pipes.

    One testcase uses several separate pipe sequences in a row which are
    awkward to split up. Wrap the split-up pipe in a function so the
    awkwardness is not repeated.

    Signed-off-by: Matthew DeVore <matvore@google.com>

> > diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
> > @@ -190,16 +190,21 @@ EOF
> > +# Note we avoid using pipes in order to ensure that git exits with 0.
>
> This new comment doesn't really add value for someone reading the
> patch without knowing the history leading up to the point the comment
> was added. It should probably be dropped. (The actual text of the
> comment is rather confusing anyhow since avoiding pipes has nothing to
> do with ensuring that git exits with 0, thus another reason why this
> comment ought to be dropped.)
Yes, this comment was worded quite poorly. I've removed it since I
agree it doesn't add a lot of value.

>
> >  test_expect_success 'test propget' "
> > -       git svn propget svn:ignore . | cmp - prop.expect &&
> > +       test_propget () {
> > +               git svn propget $1 $2 >observed
>
> The &&-chain is broken here, which means you're losing the exit status
> from the Git command anyhow (despite the point of the patch being to
> avoid losing it).
Fixed.

>
> Also, for consistency, how about calling this "actual" rather than "observed"?
Done.

>
> > +               cmp - $3
>
> This is just wrong. The "-" argument to 'cmp' says to read from
> standard input, but there is nothing being passed to 'cmp' on standard
> input anymore now that you're removed the pipe. I'm guessing that you
> really meant to use "observed" here (and reverse the order of
> arguments to be consistent with the expect-then-actual idiom).
> Finally, since these (apparently) might be binary, you can use
> test_cmp_bin() instead.
Fixed, except for the test_cmp_bin part. My understanding is that git
svn propget is supposed to be printing human-readable strings. My
understanding is based soley on this page:
http://svnbook.red-bean.com/en/1.6/svn.ref.svn.c.propget.html

>
> > +       } &&
> > +       test_propget svn:ignore . prop.expect &&
> >         cd deeply &&
> > -       git svn propget svn:ignore . | cmp - ../prop.expect &&
> > -       git svn propget svn:entry:committed-rev nested/directory/.keep \
> > -         | cmp - ../prop2.expect &&
> > -       git svn propget svn:ignore .. | cmp - ../prop.expect &&
> > -       git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
> > -       git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
> > -       git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
> > +       test_propget svn:ignore . ../prop.expect &&
> > +       test_propget svn:entry:committed-rev nested/directory/.keep \
> > +               ../prop2.expect &&
> > +       test_propget svn:ignore .. ../prop.expect &&
> > +       test_propget svn:ignore nested/ ../prop.expect &&
> > +       test_propget svn:ignore ./nested ../prop.expect &&
> > +       test_propget svn:ignore .././deeply/nested ../prop.expect
> >         "
>
> After this patch, the test is even more broken than appears at first
> glance since the test body is inside double-quotes. This means that
> the $1, $2, $3 inside the test_propget() function are getting expanded
> _before_ the function itself is ever defined, to whatever bogus values
> $1, $2, $3 hold at that point. I can't see how this could ever have
> worked (except only appearing to work by pure accident).
Fixed, and here is the new test:

test_expect_success 'test propget' "
        test_propget () {
                git svn propget \$1 \$2 >actual &&
                cmp \$3 actual
        } &&
        test_propget svn:ignore . prop.expect &&
        cd deeply &&
        test_propget svn:ignore . ../prop.expect &&
        test_propget svn:entry:committed-rev nested/directory/.keep \
                ../prop2.expect &&
        test_propget svn:ignore .. ../prop.expect &&
        test_propget svn:ignore nested/ ../prop.expect &&
        test_propget svn:ignore ./nested ../prop.expect &&
        test_propget svn:ignore .././deeply/nested ../prop.expect
        "

I confirmed that git's exit code is being checked by putting "!" in
front of git and making sure the test failed. I made sure that
"actual" was actually being compared and the exit code of "cmp" was
checked by adding "echo foo >> actual &&" before cmp, and again making
sure the test failed. This test should be well-formed now.
