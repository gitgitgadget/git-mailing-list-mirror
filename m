Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A8F20248
	for <e@80x24.org>; Sat, 13 Apr 2019 12:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfDMMOi (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 08:14:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39384 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDMMOi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 08:14:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so15325616wrn.6
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=875zkk6eO9Pnjk0qq2/wkGE/7RUYiYE5LY24rthQDRE=;
        b=V/9ALDqJZaOFeq4DxFMrh254T046sX+xpWAGrRMntDa278UiRWDgjz06i42k+bt0Gg
         yhSMQ1f2cAA0eWcOkceE6Uw5k8WZuIRNtGMffGYkuo+UZw/GaTY8d3E3PikFK8OL+gYd
         JNhg6vwwpZvKTF8sNhCGk5TyH0wcbaxjB5Q1RLmxNMEtiIzHaIcaRtZTTIWyE60wY7l1
         CJCaZdTJw4mAfmiGivFVMmJzrpKrkMFUXL+R+HITzpn1k2Ddk2jCpAxNftEFMek7HZAI
         lvoyZtAE5g92PE0W8cSxlbyK4wQJcqnNkL3Im1KpvzjpfERei6z4xysxxgYOJS6rvweJ
         RIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=875zkk6eO9Pnjk0qq2/wkGE/7RUYiYE5LY24rthQDRE=;
        b=IhAXPeMZ2MkZSOm+X1nFQ9QeFmCyxLEzUvGKsR7UADglbaA5+O0L/D7hHdWcGMs0tt
         ZyaEeb1l+P9/nHkk54AG+v3qYp9/Mf5th3xC5QRkW46Ot+t9T7qT9BO3dvtgBQ7Bloqs
         ylBX2lSIQ+VNiG3s+vyuje/TgUWJCKkUFzgaMiKOZVe3zjWyBsdPG5ORYEGr4mslHPpX
         sq8YNn1UDdXxSLKhyPyTGpATVR9kwC5DEFoAKyYpWKb7m+WtaqHFkCSXW2/QAR/iA5RW
         34yOArancEsOmQIEFgcg19VY8gkTlipWuOcBfy9HcN5XJA8kX6NBxZyZbizezZEUZIYA
         O11g==
X-Gm-Message-State: APjAAAWTFutDBGdSgIc1BQ4b5EnGwPvL7WIzhsW0nK8P9R0QE62sI+m2
        TlUau/eQZ5hDYEuJvTk1Kkw=
X-Google-Smtp-Source: APXvYqyU4C9EUs8WZy1kwZ7FptPNC81AHjI9FylcUOc0C9YXkQ4NjDaMtenKxa9eriuwlR3jPqN7gw==
X-Received: by 2002:a5d:6101:: with SMTP id v1mr18683349wrt.222.1555157675770;
        Sat, 13 Apr 2019 05:14:35 -0700 (PDT)
Received: from szeder.dev (x4dbd3ef2.dyn.telefonica.de. [77.189.62.242])
        by smtp.gmail.com with ESMTPSA id l23sm9680096wmj.10.2019.04.13.05.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 05:14:34 -0700 (PDT)
Date:   Sat, 13 Apr 2019 14:14:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
Message-ID: <20190413121432.GB15936@szeder.dev>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
 <20190411205146.GK8796@szeder.dev>
 <20190411205857.GL8796@szeder.dev>
 <20190412001730.GM8796@szeder.dev>
 <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 04:25:08PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 12 Apr 2019, SZEDER Gábor wrote:
> 
> > On Thu, Apr 11, 2019 at 10:58:57PM +0200, SZEDER Gábor wrote:
> > > On Thu, Apr 11, 2019 at 10:51:46PM +0200, SZEDER Gábor wrote:
> > > > On Wed, Apr 10, 2019 at 10:56:52PM +0200, Johannes Schindelin wrote:
> > > > > >         ...>}
> > > > > >
> > > > > >       @@
> > > > > >     + expression c;
> > > > > >     ++expression r;
> > > > > >     + expression s;
> > > > > >     + @@
> > > > > >     +-- get_commit_tree(c) = s
> > > > > >     ++- repo_get_commit_tree(r, c) = s
> > > > > >     + + c->maybe_tree = s
> > > > >
> > > > > I think this is wrong, and admittedly I had the very same version
> > > > > originally.
> > > > >
> > > > > When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
> > > > > opposed to `the_repository`), the conversion to `c->maybe_tree` is most
> > > > > likely incorrect.
> > > > >
> > > > > Therefore, I don't think that we can do that.
> > > >
> > > > So, as far as I understand, the goal of these 'c->maybe_tree'-related
> > > > semantic patches is to prevent "generic" parts of Git from accessing
> > > > this field directly, as it might not be initialized in a
> > > > commit-graph-enabled repository.
> > > >
> > > > Only three functions are explicitly exempt, while this last semantic
> > > > patch in question implicitly allows a few more that assign a value to
> > > > 'c->maybe_tree'.  These functions are release_commit_memory() and
> > > > parse_commit_buffer() in 'commit.c' and fill_commit_in_graph() in
> > > > 'commit-graph.c',
> >
> > ... and make_virtual_commit() in 'merge-recursive.c'.
> >
> > > and after a quick look these functions seem to be
> > > > rather fundamenal in the life-cycle of a commit object.
> > >
> > > Erm, not "commit object"; I meant the life-cycle of a 'struct commit'
> > > instance.
> > >
> > > > I think they deserve to be explicitly exempted, too, and then we could
> > > > remove this last semantic patch altogether.
> >
> > And it would look like this.  Yeah, that's a very long line there, but
> > I don't think we can break it up.
> >
> >   -- >8 --
> >
> > diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
> > index 57c8f71479..fe814f313e 100644
> > --- a/contrib/coccinelle/commit.cocci
> > +++ b/contrib/coccinelle/commit.cocci
> > @@ -10,20 +10,15 @@ expression c;
> >  - c->maybe_tree->object.oid.hash
> >  + get_commit_tree_oid(c)->hash
> >
> > -// These excluded functions must access c->maybe_tree direcly.
> > +// These excluded functions must access/modify c->maybe_tree direcly.
> > +// Note that if c->maybe_tree is written somewhere outside of these
> > +// functions, then the recommended transformation will be bogus with
> > +// repo_get_commit_tree() on the LHS.
> >  @@
> > -identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
> > -expression c;
> > +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|fill_commit_in_graph|parse_commit_buffer|release_commit_memory|make_virtual_commit)$";
> 
> Hahahaha! That's *really* long.
> 
> And a good indicator that this should be hidden in a single helper
> function (`set_commit_tree()`, file-local of course) that is exempted in
> the cocci patch.

Note that this is not only about line length, and consider the slight
differences between the three approaches:

  - Currently only direct read accesses to 'c->maybe_tree' outside of
    the listed functions are forbidden and transformed, but still any
    function can set this field directly (thanks to the last semantic
    patch in 'commit.cocci').

  - Encapsulating writes in set_commit_tree() and adding this function
    to that list would prevent other functions from setting
    'c->maybe_tree' directly, but still any function could set it
    indirectly by calling set_commit_tree().

  - With that loooong line only those few listed special functions
    would be able read or write 'c->maybe_tree'.

Does the additional restriction of the long line variant bring us
benefits?  Well, not sure.

The root tree of a commit is needed in many places, and in the past we
got used to it being always initialized in any 'struct commit'
instance.  However, with the commit graph that's not the case anymore,
and any read accesses to the uninitialized root tree object would have
bad consequences.  That's why there is get_commit_tree() helper
performing lazy-initialization, and the protection from direct reads
in the form of the semantic patch.

OTOH, apart from five functions, most parts of Git simply don't want
to create new 'struct commit' instances themselves, or, more
generally, set anything in a 'struct commit', so arguably there is not
that much danger to protect ourselves from.

Anyway, I just wanted to make sure that we fully understand the
implications, and I think any solution is an improvement that
eliminates the current "let's transform this code pattern, but then
quickly transform it back in some cases" back-and-forth.


> > +struct commit *c;
> >  @@
> >    f(...) {<...
> >  - c->maybe_tree
> >  + repo_get_commit_tree(the_repository, c)
> >    ...>}
> > -
> > -@@
> > -expression c;
> > -expression r;
> > -expression s;
> > -@@
> > -- repo_get_commit_tree(r, c) = s
> > -+ c->maybe_tree = s
> >

