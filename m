Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793521F461
	for <e@80x24.org>; Tue, 27 Aug 2019 09:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfH0JXJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:23:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:44501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbfH0JXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566897778;
        bh=EWb+FN6Gd0wVRnqiAEbka2t6LU2XVuCfsTZwJwtIAwI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z8E/UddKon9HXnu3ZDI8KrMwP3uQuh6RGNpSorn8GuJcxrJi5IMKKXlwq6+5xsxoo
         yfzFZlBs96TmibCO5IZ22FNPIclxJOS20WDn0/yEv5HQLcroUNCLijtxbtvCt/Wt+2
         +beMCHgvDhsS5J9w0C6lnJrzgT7I0l6s2CdH4JKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhyc-1hydf93MSg-00Ds3V; Tue, 27
 Aug 2019 11:22:57 +0200
Date:   Tue, 27 Aug 2019 11:22:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Daniel Ferreira via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v3 02/11] diff: export diffstat interface
In-Reply-To: <xmqqwofyozka.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908271121230.46@tvgsbejvaqbjf.bet>
References: <pull.170.v2.git.gitgitgadget@gmail.com>        <pull.170.v3.git.gitgitgadget@gmail.com>        <c7a377890d84849ea2f63099cfc081420a4de15d.1563289115.git.gitgitgadget@gmail.com> <xmqqwofyozka.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qSwsYRXlahNizJXI5FPj8h/DFKYB1gw1kMEgqcek9VJgWbpZ7nc
 v3rgIpEH3Vn7TCiG0TwVeUYNzP+/cSLo01PkvetPZRYPqzCQbSMF3SzkrNe4d9SAzkwMgE/
 d1wFnRQXh2aDDo9bWapJH8EhSWdDP2K4BWvRp9FPN2TE4VhTDo4x1SI0QMQUGZW6X47iNGp
 mUu2lqAgRUimdtUxDfSAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1mMkI3XmA1U=:1pdVbU98r202wJeSQK/HlZ
 guLOhSQgJT+D8kHPgUzZ6mA1/qiQh3Z100DfavZr28wIt3M3LNqP0xbJ4qhOUO25Q17Bfs68t
 FmTT/xSkyuB0IZLkS/elgvbzWIMyxYvOXGfNezyOXXDXcGBUj9r/5Q6Fo3Iep942KwiyqEdrT
 /ZpqztfdFG4t8Nr23jxz2EUqBe7+GKXH+nXGEFXTbf6tLCXLzszMZlf8V6Plbw2XVOJmsDytP
 V1+6wKqFULnin5TR/DHcEIXi//PlImMwqLrxAi504X98hTCM42JjIddi1Mzd93nWVe/Q6/OMB
 3YDgo14U9IfdoTgj4RvCfonaUkw5BBCuixyFabMPuNnJjiyVXCMoF38QOMw79PwAgNUTM9w/m
 4XpNOCH/79hyaSMHBUVADlucDWaYFx2rRve8Wz2gxQwPbMA90w5CFuOEhsSHplS3bSB34U+ZN
 baiPQJD6zfXvQad4D9AbFPb7jCyVME+frXGpuudVqS/29Y2Soy6GIWDQNJyH+fJomw1owlA2x
 QP0cAvzfLlRiCkguWsNG5Z6jRZY3yKLRxHzNygyMJfNaAsECkS+cB1ffWgt1N5i7/LtwLTQvU
 b5BRkn4mcy9vsHMdmKCtKiojuSaH4dBc0IaHaAX5b3zVfW8536b/9K8JVT5l2cNT/Q0tnx5EX
 OYivQqelWwhzopR4kzg6Ah/InSnwv3UD+XHh7FiIl4j2iRsBP/puN4JJfRIJEuHdoOZPCGYUU
 dGF+4MPynA5QzweNzNCZOIS6MPiglNCfg/rdQK3fBM8BZRlkgn6tTpIaBZVe95LBKM2ShU9n0
 czsMAa/N6rrOHjYhjo4yqGwgsoV9VbFGHxVXKaGxHzL7suNvQYZLXv1eL2LFPqga5IdOyCX+E
 R+gBhja2WBQsKHTl7kqmxUEHNmDExBrDiDadpTSe+SLkjFx/R6yOBk/w7CVNTOK7/8h+x/gd4
 KCbCeD/tr96YCkqCSIGPfptLp9+7eXbApob4KBBb+262y9HJyQhvRLjsKlJ9fGy/ZAwqzzxwN
 F4gD/zwPRLAShb3jO08EcitjQSYKJF9mrUkUl+Q87CF2Irphby1aEwcBWrV3VYDSAbXXWviKK
 slZp+Liu06goy4vq/jCJuwcwiP1QS3GLx7XwF8pxyWDagCsMJoNsKnQfncuEdxoZ/0vlkIkzo
 5oacY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Jul 2019, Junio C Hamano wrote:

> "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -6273,12 +6257,7 @@ void diff_flush(struct diff_options *options)
> >  	    dirstat_by_line) {
> >  		struct diffstat_t diffstat;
> >
> > -		memset(&diffstat, 0, sizeof(struct diffstat_t));
> > -		for (i =3D 0; i < q->nr; i++) {
> > -			struct diff_filepair *p =3D q->queue[i];
> > -			if (check_pair_status(p))
> > -				diff_flush_stat(p, options, &diffstat);
> > -		}
> > +		compute_diffstat(options, &diffstat, q);
> >  		if (output_format & DIFF_FORMAT_NUMSTAT)
> >  			show_numstat(&diffstat, options);
> >  		if (output_format & DIFF_FORMAT_DIFFSTAT)
> > @@ -6611,6 +6590,20 @@ static int is_submodule_ignored(const char *pat=
h, struct diff_options *options)
> >  	return ignored;
> >  }
> >
> > +void compute_diffstat(struct diff_options *options,
> > +		      struct diffstat_t *diffstat,
> > +		      struct diff_queue_struct *q)
> > +{
> > +	int i;
> > +
> > +	memset(diffstat, 0, sizeof(struct diffstat_t));
> > +	for (i =3D 0; i < q->nr; i++) {
> > +		struct diff_filepair *p =3D q->queue[i];
> > +		if (check_pair_status(p))
> > +			diff_flush_stat(p, options, diffstat);
> > +	}
> > +}
>
> Hmm, (1) clearing diffstat struct to initialize, (2) looping over
> diff_queue to compute stat for each path, (3) using diffstat
> information and then (4) finally freeing the diffstat info is the
> bog-standard sequence of the user of this API.  Merging step (1) and
> (2) may probably be OK (iow, I do not think of a use pattern for
> future users where being able to do some custom things between steps
> (1) and (2) would be useful), which is this function is about.  (3)
> is what the user of this API would do, but shouldn't (4) be exported
> at the same time, if we are making (1+2) as an external API?

Good point.

It _also_ hints at the fact that we're not releasing the memory properly
after running the diffstat in the built-in `add -i`.

Will fix,
Dscho

>
> >  void diff_addremove(struct diff_options *options,
> >  		    int addremove, unsigned mode,
> >  		    const struct object_id *oid,
> > diff --git a/diff.h b/diff.h
> > index b680b377b2..34fc658946 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -244,6 +244,22 @@ void diff_emit_submodule_error(struct diff_option=
s *o, const char *err);
> >  void diff_emit_submodule_pipethrough(struct diff_options *o,
> >  				     const char *line, int len);
> >
> > +struct diffstat_t {
> > +	int nr;
> > +	int alloc;
> > +	struct diffstat_file {
> > +		char *from_name;
> > +		char *name;
> > +		char *print_name;
> > +		const char *comments;
> > +		unsigned is_unmerged:1;
> > +		unsigned is_binary:1;
> > +		unsigned is_renamed:1;
> > +		unsigned is_interesting:1;
> > +		uintmax_t added, deleted;
> > +	} **files;
> > +};
> > +
> >  enum color_diff {
> >  	DIFF_RESET =3D 0,
> >  	DIFF_CONTEXT =3D 1,
> > @@ -333,6 +349,9 @@ void diff_change(struct diff_options *,
> >
> >  struct diff_filepair *diff_unmerge(struct diff_options *, const char =
*path);
> >
> > +void compute_diffstat(struct diff_options *options, struct diffstat_t=
 *diffstat,
> > +		      struct diff_queue_struct *q);
> > +
> >  #define DIFF_SETUP_REVERSE      	1
> >  #define DIFF_SETUP_USE_SIZE_CACHE	4
>
