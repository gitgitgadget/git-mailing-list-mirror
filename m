Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39E4C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 12:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70BB20706
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 12:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b1Dct/wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHXMmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:42:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:59675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXMmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 08:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598272926;
        bh=i/aU0g20yss1oNGFeWaOnQLCttE8Hjz5jIagDdcuUYI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b1Dct/wcq7MTN9rFvg2vEKXbRpp6bk/Lu6QBRl/qzOM4Oi0MGwhN+eYcZfwye2Y3V
         91YuuAZ5tU5GDi8NaP1PtydGm3HPzl/LZtBoNO249B8Bo/Ur626xnvE3Zx1xxTX+4j
         5DyA2fqBQVYkCew41N7nFjFgd/uKa8HNbTvAoSeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.214.173]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1kDkQn0w0h-005GEA; Mon, 24
 Aug 2020 14:42:06 +0200
Date:   Mon, 24 Aug 2020 14:42:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Tilman Vogel <tilman.vogel@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] patch-id: ignore newline at end of file in
 diff_flush_patch_id()
In-Reply-To: <xmqqblj7worr.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008241441410.56@tvgsbejvaqbjf.bet>
References: <2639321.dTF8K4C05n@alien.lan> <b67eb51d-75e8-62c5-d1c4-fc3015e13fc6@web.de> <xmqqblj7worr.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-506925876-1598272926=:56"
X-Provags-ID: V03:K1:bBQk6TYsxrcTdA7ONX5ea9AXtcq2pKULcuIL1kMLGY0ppbmYnCo
 yp3p/WC9DXHdiyJoo4PSSRXIehBSKUbCVtyzp0eK+1U6vXfm9sg5/wA/sXikK+xA4JH3ckv
 cAtRwb6z/ASv4dehm6eIIJdZGy+8icR8bpwUydIMT35WRkyKRD8CeeU+f8rhQVieHRQz68c
 5uAOuH00tk3FWUC5eXqhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3mTj2T3jO1A=:ELvqjnIqBVJWqMI4h6X2ob
 mydxdfffm2c4otp0qPg/agQ3QHQztAh1E8s9DbPfU6Y+xpRF+HoRPU8zeB5zQK9yTs7D5EPMA
 ZjANTBmSmIQnnMvvE0DLYNS9XmvWT2Et32Cieb8RhOJoepXX5cX2MZBdP3hQig/G+lfnyZWqS
 8XVsrkiJTimtmDNIppSOV4kKRpXHiLvKGgy+STVlbY6eMb8tnFBIMC9auyAgBffJcEMrJr2xQ
 UPgc3p6hwAyiE6DSaaKrHY7eS1vV1OSQ2y6l+SRtitb+jYbCagv5aoUNicpX6v1/4yyu4dqHs
 dBoDjl4NwddaH2/u/gmfg5yGiiqCOuvQY9LSNCP/cCR1fVAO66eHJMMGfCUjjJMeoO/pUu6EV
 FYbOoTZ++ThwoS0n2Hv/lnfrAATlKJf5fZkDT1mRJHs0xdLMic+AEFuoLsbzcRs7EHHVwxk8x
 3TOEbQxzSut/uzhbAhlVpFofYVMLV/BiFUyRqbFfIQZmRLEgyrYOQqGwesSySLnfnGS7I5VgR
 j79ecHwVV45fRLWAiGIJ5qHSbM3nEt5HlOZpmwH4c0tJkckbNaavoMMkXDV8bcZwYJM3EVCSW
 Ue9CbJQJzfeDVszyA2HOjThMeQ+yoraf9YlKz5Kk2DSj2i3oABfVQ+uoW9pnBVjNqY3HxbHq5
 SvXvF7vkVHRRpgWILmSmQF9nWi/WcQJnwfer3gRcv5kF6aBAr5F7d6n/motDi1Ip0mi/BXtqR
 Eh4gHjCJouAGG7zbZTSoLLNHR2+v8dc569pmm7IHMDQpBS0SaCGbarXspXUZ4xKQete0nV/WI
 8PkrPvMCyIbX4KXN+k+WAYmun90vhtOIfdtxZn80xinaHBBQh4MLQ+A/y1NDvaMAo9ZsO+GCF
 4kK3lMKPtGzvZdmZJ7Bgq+75KONtYFJ8HuvszVDau/l2DFZm3UOR6HMa3JfrUzYDMHp6P0Jrp
 tXtxONJCgWpsSAkBcQi7iSrG51Ob5AAbn5dXiuUZCRzQno/yOGLCMUFg0C3ou7wbJR0sZgRno
 Y2hqCxSqTXN0FbtQH8jSKmquRjuL7zhnkVm+fmqryJHKAucTW6l9pxMm2zAu7o6M01ArbZcqW
 UYh9Ze4dvoYMdxR8n4YOw3fvh1sPnzpTs//dsuK1yCtLkMLAfJzS/wL/jjp5x1eZQ8OeFVTmp
 VdIuBkFDZFuYTyEh3Xo/iOjmHCwAppfeGqn1LRo4x5UnL+lnTuYmr7L/pC+aihjj+Uwpc7wIg
 E+G2x+N386N4l+SzOn6XP15SpAk3WCRL/QohVsxXXaYEE/NSLF8Lh+dMyULk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-506925876-1598272926=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 18 Aug 2020, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > Whitespace is ignored when calculating patch IDs.  This is done by
> > removing all whitespace from diff lines before hashing them, including
> > a newline at the end of a file.  If that newline is missing, however,
> > diff reports that fact in a separate line containing "\ No newline at
> > end of file\n", and this marker is hashed like a context line.
>
> Ah, ouch.
>
> > This goes against our goal of making patch IDs independent of
> > whitespace.  Use the same heuristic that 2485eab55cc (git-patch-id: do
> > not trip over "no newline" markers, 2011-02-17) added to git patch-id
> > instead and skip diff lines that start with a backslash and a space
> > and are longer than twelve characters.
>
> Good find of previous example.  Excellent.

Yup. Looks good to me, too. Thank you!
Dscho

>
> > Reported-by: Tilman Vogel <tilman.vogel@web.de>
> > Initial-test-by: Tilman Vogel <tilman.vogel@web.de>
> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> > ---
> >  diff.c            |  2 ++
> >  t/t3500-cherry.sh | 23 +++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
>
> Thanks.
>
> > diff --git a/diff.c b/diff.c
> > index f9709de7b45..f175019eb7a 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -6044,6 +6044,8 @@ static void patch_id_consume(void *priv, char *l=
ine, unsigned long len)
> >  	struct patch_id_t *data =3D priv;
> >  	int new_len;
> >
> > +	if (len > 12 && starts_with(line, "\\ "))
> > +		return;
> >  	new_len =3D remove_space(line, len);
> >
> >  	the_hash_algo->update_fn(data->ctx, line, new_len);
> > diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> > index f038f34b7c0..2b8d9cb38ed 100755
> > --- a/t/t3500-cherry.sh
> > +++ b/t/t3500-cherry.sh
> > @@ -55,4 +55,27 @@ test_expect_success \
> >       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* =
- .*"
> >  '
> >
> > +test_expect_success 'cherry ignores whitespace' '
> > +	git switch --orphan=3Dupstream-with-space &&
> > +	test_commit initial file &&
> > +	>expect &&
> > +	git switch --create=3Dfeature-without-space &&
> > +
> > +	# A spaceless file on the feature branch.  Expect a match upstream.
> > +	printf space >file &&
> > +	git add file &&
> > +	git commit -m"file without space" &&
> > +	git log --format=3D"- %H" -1 >>expect &&
> > +
> > +	# A further change.  Should not match upstream.
> > +	test_commit change file &&
> > +	git log --format=3D"+ %H" -1 >>expect &&
> > +
> > +	git switch upstream-with-space &&
> > +	# Same as the spaceless file, just with spaces and on upstream.
> > +	test_commit "file with space" file "s p a c e" file-with-space &&
> > +	git cherry upstream-with-space feature-without-space >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done
> > --
> > 2.28.0
>

--8323328-506925876-1598272926=:56--
