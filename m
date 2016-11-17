Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9D01FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 23:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbcKQXe2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 18:34:28 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35730 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcKQXe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 18:34:27 -0500
Received: by mail-pf0-f175.google.com with SMTP id i88so51026584pfk.2
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 15:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=96vPYcFkUy7g8M3Iz2VNl5Rz9qgJQUtOQjBQNFk5d4c=;
        b=JNgKtTS6btbuomhIlcsYHNC6gMdyW75sNTo4lFIRz0aPJlauEoFNwZoniflLhyrUf6
         QOBWVxXxbFvms2iSLvFV9ekBA64XTrqTcnTR4aCuc+DDJ08nHLEUsZbYK/Jq1F9JusEX
         hh3UN8FFbDv5NyC9fFkpFUY77O6/51QdHKGj7jOJc1Qrmduy+wZ2fVXBa+r+E+ew0F6r
         pDGqUUrPClK5OcplEaWihy6R2FpusU8Svothyf0F+Y0GbLY35Ssat7IlTs+Bpa1IUxOE
         m68rD8Izxvoo5QhURV6PY3SNnGXbZn4X83Hf0UzuTcRTaf3jQMEOD/Sy3JOkNhVxhrmQ
         A6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96vPYcFkUy7g8M3Iz2VNl5Rz9qgJQUtOQjBQNFk5d4c=;
        b=W0qBPBnP1IoyFdrwPXgp5YLxrEdR1orJ4vI+Yn+jZh9K8vDtspV27/heDHpxW9EkOj
         g3uT6XLWcxx9pacs80x1fLexB9gU9EX+XSkdKjKWUdaUs9t5pmYdeWyqYBeI2IoaU4hF
         T1pd5GLTL0jvNAhTn8FVW+k/bhNakFFJHmOCs8stDN3aaQxyI+pjYargagHTXPxRWRDH
         flk9Sx1iRP4MedhzHF3Wm2LifF8I72IbDp4NjBR/MLLP1SGs8ILy9uSewNqySWfQbB/F
         +1YnfGjLLFQoLhuGP8SJEZxnahk8AvqeqTEHUkS+cCIkH2liMRzxqk2ernr14e0dsQ19
         BYlw==
X-Gm-Message-State: ABUngvd4Yzw9zYm53giOFHeORlHQPMO4AtsuuErlGM/BkFIFj3+PsvvoqVGXyfogg7Bjd9W+
X-Received: by 10.99.156.2 with SMTP id f2mr12643119pge.20.1479425666110;
        Thu, 17 Nov 2016 15:34:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:718b:9d6c:8235:ef51])
        by smtp.gmail.com with ESMTPSA id l7sm10928732pfg.35.2016.11.17.15.34.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 15:34:25 -0800 (PST)
Date:   Thu, 17 Nov 2016 15:34:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161117233423.GO66382@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1478908273-190166-6-git-send-email-bmwill@google.com>
 <CAGZ79kbqZs+wQYUBnvdw1YhC4dtHeodJWdved+it2Zg076vyOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbqZs+wQYUBnvdw1YhC4dtHeodJWdved+it2Zg076vyOA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> On Fri, Nov 11, 2016 at 3:51 PM, Brandon Williams <bmwill@google.com> wrote:
> > +       /*
> > +        * Add basename of parent project
> > +        * When performing grep on a <tree> object the filename is prefixed
> > +        * with the object's name: '<tree-name>:filename'.
> 
> This comment is hard to read as it's unclear what the <angle brackets> mean.
> (Are the supposed to indicate a variable? If so why is file name not marked up?)

Yeah you're right, the angle brackets don't really add anything to the
comment.  I'll drop them.

> >  In order to
> > +        * provide uniformity of output we want to pass the name of the
> > +        * parent project's object name to the submodule so the submodule can
> > +        * prefix its output with the parent's name and not its own SHA1.
> > +        */
> > +       if (end_of_base)
> > +               argv_array_pushf(&cp.args, "--parent-basename=%.*s",
> > +                                (int) (end_of_base - gs->name),
> > +                                gs->name);
> 
> Do we pass this only with the tree-ish?
> What if we are grepping the working tree and the file name contains a colon?

Actually you're right, this would only happen if we are passing a
tree-ish, which has a tree-name prefixed to the filename.  I'll add that
as an additional check to ensure that this handles file names with a
colon correctly....though why you have a colon in a filename is beyond
me :P

> > +test_expect_success 'grep tree HEAD^' '
> > +       cat >expect <<-\EOF &&
> > +       HEAD^:a:foobar
> > +       HEAD^:b/b:bar
> > +       HEAD^:submodule/a:foobar
> > +       EOF
> > +
> > +       git grep -e "bar" --recurse-submodules HEAD^ > actual &&
> > +       test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'grep tree HEAD^^' '
> > +       cat >expect <<-\EOF &&
> > +       HEAD^^:a:foobar
> > +       HEAD^^:b/b:bar
> > +       EOF
> > +
> > +       git grep -e "bar" --recurse-submodules HEAD^^ > actual &&
> > +       test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'grep tree and pathspecs' '
> > +       cat >expect <<-\EOF &&
> > +       HEAD:submodule/a:foobar
> > +       HEAD:submodule/sub/a:foobar
> > +       EOF
> > +
> > +       git grep -e "bar" --recurse-submodules HEAD -- submodule > actual &&
> > +       test_cmp expect actual
> > +'
> 
> Mind to add tests for
> * recursive submodules (say 2 levels), preferrably not having the
>   gitlink at the root each, i.e. root has a sub1 at path subs/sub1 and
> sub1 has a sub2
>   at path subs/sub2, such that recursing would produce a path like
>   HEAD:subs/sub1/subs/sub2/dir/file ?
> * file names with a colon in it
> * instead of just HEAD referencing trees, maybe a sha1 referenced test as well
>   (though it is not immediately clear what the benefit would be)
> * what if the submodule doesn't have the commit referenced in the given sha1

I'll add more tests too!

-- 
Brandon Williams
