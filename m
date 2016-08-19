Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F9D2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 14:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbcHSOtp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 10:49:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:49622 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbcHSOto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 10:49:44 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LcSAg-1arHUa1ZsE-00jucG; Fri, 19 Aug 2016 16:49:38
 +0200
Date:   Fri, 19 Aug 2016 16:49:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] cat-file --textconv/--filters: allow specifying the
 path separately
In-Reply-To: <xmqqfuq26mu3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608191521410.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <787224ce9a382ddd1180a408e784ca26993e5603.1471524357.git.johannes.schindelin@gmx.de> <xmqqfuq26mu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GcS0WALxOYupW0vnj+T0julnpKV7YQvxnfodZl6Xl/kX35SrAD0
 smU5L/PVS9f2SEZRQKpmgrw9U07OzGCBtzccLf7R2y3VwOIOmnmBvKtat3CV9M3vCeHI4Jl
 t+wSJnrRarUq8Hh2//Y1wSajkukOtvBY5koyp1DRV7RgR2wlFivKzaXOx8kvJH6tx0/LU/h
 x6YUmDjMiY10lWNduMVTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HV5Vuc2d5Ns=:BFcncqAzWbgVcFhuGMEu4I
 iSySN/iL625kePx33C9C0deuZmot0dp7tMBgr8CgzAo6e0m7CfGeyRJNyPJZR8VJ3cNLsNnyf
 UMAc368HZmJ8XK+klaPFQYPTwAAPYiuQO2OGSU88LwRu6jSj+hy0gnH/GZw3Yx9Oq8zSWL4Rh
 mlYQNNEg7/9Kw1vHZbluQAq32AG0VFmiIPgOb3AnYyv/dU5HdO66K36jS1Amrcg6fm45DIgfO
 UmupiJyHbM2Z5LnnWH93HheU6aKcZJQoDYH1O+iNv9kBusAbPdOKxiaBupxmDyIZ98Z5ypqiN
 EOnQrBRVZc2OYo55qaFGXTO/2UJIBFQ6PfL0K/0lOitXeHds79JVlZSVjShCUS+R44dfSBFSM
 DqarHeq02rFdxgZlLlzrikBvw+vIJj5r9OeqbgfQfxV/YrgXE8icR+EgySau38RgJX6/OQYft
 LEV2cIU38otdAhCjYX14F/aOX6MAP14h/uYRBNCDv2+mbft8sMh47oUDrNuTQQremYFKPJnkw
 Emfd0OZihc57qI8ue2BhEmRE7mnDKgO+0hLZ8w0WELUpetRaM8sK1KLUEHdBMf3TD6RBENFeK
 XTQNDNTWAz2ZWkFvqtyqmhX5TaRwGaIirWWp1F10g8KfyV8QBj4LZNFEinVkQPAlALKtD+Nj8
 CXxWwguxoXg9G085Tmh1lMiyIZWWq5ZZqQqwdORrmfG6lW9tAqr2dKdD/9ErsEYfYdV/g1PmN
 lyqlAvuj6CCp0F+urHVe1S1Fab2U2HRpXjJacoDYg9Nu7/fL1j058NydB7RJENaWIAmwFbEUB
 HDQR+sW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > There are circumstances when it is relatively easy to figure out the
> > object name for a given path, but not the revision. For example, when
> 
> revision of the containing tree, I presume?

name of containing tree, actually.

> > Let's simplify this dramatically, because we do not really need that
> > revision at all: all we care about is that we know the path. In the
> > scenario described above, we do know the path, and we just want to
> > specify it separately from the object name.
> 
> I wouldn't call it "simplifying dramatically".  It is just to
> support two use cases that is different from the use case where you
> want to use "<tree>:<path>".

"this" was not the code in question. "this" is the use case. Just put my
shoes on for a moment. As described: you have a list of object names and
their path. Now you need to use the --textconv or --filters option, but
you do not have the commit name. What do you do? Concoct a script that
goes through `git rev-list --all -- <path>` in the hopes of finding a
revision soon? I hope after this little exercise you agree that
introducing the --path=<path> option simplifies this use case
dramatically.

> We already have a precedent in "hash-object --path=<path>" for these
> two different uses cases from the primary one.  That form can be
> used when we know the contents but we do not know where the contents
> came from.  It can also be used when we want to pretend that
> contents came from a specific path, that may be different from the
> file we are hashing.

Agreed. I was unaware of hash-object's existing option.

> Let's be consistent and (1) call it "--path", and (2) explain it as
> a feature to allow you to tell the path separately or allow you to
> pretend that the content is at a path different from reality.
> 
> After all, you would want to ignore <path2> part in this construct:
> 
> 	git cat-file --filter --path=<path1> HEAD:<path2>
> 
> for the purpose of filtering, right?

True, and I even make use of that in the test for the batch mode.

> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 0b74afa..5ff58b3 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -20,6 +20,8 @@ struct batch_options {
> >  	const char *format;
> >  };
> >  
> > +static const char *force_path;
> > +
> >  static int filter_object(const char *path, unsigned mode,
> >  			 const unsigned char *sha1,
> >  			 char **buf, unsigned long *size)
> > @@ -89,21 +91,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> >  		return !has_sha1_file(sha1);
> >  
> >  	case 'w':
> > -		if (!obj_context.path[0])
> > +		if (!force_path && !obj_context.path[0])
> >  			die("git cat-file --filters %s: <object> must be "
> >  			    "<sha1:path>", obj_name);
> >  
> > -		if (filter_object(obj_context.path, obj_context.mode,
> > +		if (filter_object(force_path ? force_path : obj_context.path,
> > +				  force_path ? 0100644 : obj_context.mode,
> >  				  sha1, &buf, &size))
> 
> The mode override is somewhat questionable.  Wouldn't you want to
> reject
> 
> 	git cat-file --filter --path=Makefile HEAD:RelNotes
> 
> when HEAD:RelNotes blob is known to be a symbolic link?  After all,
> you would reject this
> 
> 	git cat-file --filter --path=Makefile HEAD:t/
> 
> and it is quite similar, no?  I think this can be argued both ways,
> but I have a feeling that obj_context.mode, if available, should be
> honored with or without force_path.

I see your point. All I wanted to do was to enable

	git cat-file --filters --path=Makefile cafebabe

in which case obj_context.mode == S_IFINVALID. I fixed it (see interdiff
of the next iteration).

> > diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
> > index e466634..fd17159 100755
> > --- a/t/t8010-cat-file-filters.sh
> > +++ b/t/t8010-cat-file-filters.sh
> > @@ -31,4 +31,17 @@ test_expect_success 'cat-file --filters converts to worktree version' '
> >  	has_cr actual
> >  '
> >  
> > +test_expect_success 'cat-file --filters --use-path=<path> works' '
> > +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
> > +	git cat-file --filters --use-path=world.txt $sha1 >actual &&
> > +	has_cr actual
> > +'
> > +
> > +test_expect_success 'cat-file --textconv --use-path=<path> works' '
> > +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
> > +	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
> > +	git cat-file --textconv --use-path=hello.txt $sha1 >rot13 &&
> > +	test uryyb = "$(cat rot13 | remove_cr)"
> > +'
> 
> I think I saw some code to ensure "when giving this option you need
> that option in effect, too"; they should be tested here, too, no?

No, I would rather not test for that. These conditionals are purely for
any user's convenience, in case they specify an option that has no effect.
They are absolutely not essential for the function introduced in this
patch series.

Ciao,
Dscho

