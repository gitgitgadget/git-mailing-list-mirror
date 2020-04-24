Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F4C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9EB215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="a39M25x9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDXVEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:04:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:48331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgDXVEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587762280;
        bh=gk+LA/9Qugssi2aaVWAqVT59+q0YCnTzCDDgxLyl0rQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a39M25x9qMacrU1ZkwjnesJMDjgaQtu23o4v283rtt9Tjp3JDIVfI3VSBPxQxjZQ5
         Zea3iXQeMBYRYBT7jXi/okh9W5F2Faownd9fITwNVurcbOj0OFYhFE69kGQkKJNmGn
         qyj6IB/J4XTrQNFxDyPj9K9HjbTJbabaIsiT2qfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.1]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MMXQF-1jjtKa3TvT-00Jcc7; Fri, 24 Apr 2020 23:04:39 +0200
Date:   Fri, 24 Apr 2020 23:04:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] push: anonymize URLs in error messages and warnings
In-Reply-To: <xmqqtv18bov7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004242259520.18039@tvgsbejvaqbjf.bet>
References: <pull.618.git.1587738008248.gitgitgadget@gmail.com> <xmqqtv18bov7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vr4TjiHBLEyHOopInlR2BsT/ky4usdEMWBX6yWWiKyeVFCbqWyQ
 ticJhJ1N5+4BX4psqEOEZiTSDul6ZxTRTBeMoy3Kv9XhGoPJPSQKBt8RjVI2reGfUAzhnn8
 n5YP2kVWcZORuCdNoVAVRAUWNza3djmgtYmg5PJsGxd+35PP6l3I8I2yl9n3q5CPtpeAriu
 iyBNc4qAWkFYAbtjP6xTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qgAUzyL+WnM=:U7/TaOnrCbENAaEebDRBE6
 pQQYuYTgIJ90vFR4ydB7mlDbqhsDHJG8stbskLUqevIYYyNEw4RW+UesEhq4SsAi8t2ihv6GH
 3QasodATa0caPoxZ2Flep1rK+G909yCJS+GiscwaX3TYyliaPz8pGx03RTPg5w9+Zs3NNIeuE
 Cbrq3zNmyQSF5HP1liXGfmaznIHWo+dux3q3jpxJ2yu7S7E4WlVfjM34nXgV7EYxdHG5xtYsM
 0VmHM0A83z9VmFm+Hn+aaYmDglHODmlz7PtPiRGBfa5EBxvGwrCBarYu7MN7dt6z7QoBbK+Au
 H0lsPqic46cZGmpGE4AEeJ6WAAqaM+kW4SJPhCyu2oMEW4OxXUdYdIU4VkgyeeFx9llfPwN2L
 8MM4pZNd9SLk09HHl/rrfASySs92JlTq1LLGhR6XZYqeWWRs5MAd0HYkv2IIiZsQ+Gqzk4oJY
 OO96ZtdNSx+COjFm6juenAF+YQ3CfJXrlILBSwgH+kILZYV/7yTzSjoJttguO57UlCcwVkzr4
 Jhk/srYsZ08dbCAeGmtJ1zyHIF9B78VmCiS8n/tHn6js6kQx2qhqt8WZeHDW6cEXOjyLLvwNU
 Mkq+MJVaNyJFIX6WoLre/PRSrIH324QuUsSL6NE3C+9HyoMOvQ/Xy1VVeiPfgULDVjVOtaVXp
 GDr2RCkd2F0iKr82VRqUgYItkX+ZkHA4NIQShZL3PHRoLZa4m8ldWKDEw0yRTEphunaca/aEo
 7FAYCoL+553gCg2/72JCp8Cm5TgIjBXG3W1Wf9SHYL/G+qFpYwfwLE2HaaRKIa0H+Wiory8kN
 pH+EM4Xh0pk5inLBABvhdO47HNx+ey5nnT+fQKDWnYrlri6DdHgcEcRh5XcrNlsg9XiOG8aAf
 mFXEtPldm6qcJFStDYLzqrCKDK0Y7YYERq/Ph6rpkApO9oVnv62zfJu3WJ8k4WUcHpLz6ECIF
 kSIddFRon0YCicB0P3L3qdOE/o5LGNIFNGSDzKLv+KcLqJHg1xbYTTHLpdYFaWAHWp6hPn+RS
 htQeHsFVZGL+vJ0XoCIxzKO+nhGbTzzwRJjp1I/ZmSrnvii467U026ImQCkVVd5ywsXk0s6bs
 Tv5txmA0xs4DL2p3NsuH1f/aHMM/XB6v21cou7ps+yArfGLMMPno9720aL6nSgAX8j/uRlMrK
 GOYO2ML1bQbDVSIxuJa3R/dS6Ew7balHhOMU23IFGnRgdmmB5XSz8sTgSHxZ0Y32K7zYcInCH
 yq1HHPQ8V6ZFdv90H
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 24 Apr 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  builtin/push.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Is this something we can protect with a test?  perhaps like 882d49ca
> (push: anonymize URL in status output, 2016-07-13) did?
>
> > diff --git a/builtin/push.c b/builtin/push.c
> > index 6dbf0f0bb71..bd2a2cbfbd7 100644
> > --- a/builtin/push.c
> > +++ b/builtin/push.c
> > @@ -340,6 +340,7 @@ static int push_with_options(struct transport *tra=
nsport, struct refspec *rs,
> >  {
> >  	int err;
> >  	unsigned int reject_reasons;
> > +	char *anon_url =3D transport_anonymize_url(transport->url);
>
> Do we need to anonymize this early, way before we know we'd fail the
> push?  It wouldn't be that transport->url is going to be munged
> before we realize that we have to issue an error message---otherwise
> you'd not be writing a patch to replace transport->url in the error
> message.  So this placement of anonymize call sounds like taking the
> error path as the main flow of control.
>
> In other words, would it break to squash the following change in?

It would break it _if I hadn't forgotten to include this_:

diff --git a/builtin/push.c b/builtin/push.c
index bd2a2cbfbd73..59c8acb55680 100644
=2D-- a/builtin/push.c
+++ b/builtin/push.c
@@ -358,7 +358,7 @@ static int push_with_options(struct transport *transpo=
rt, struct refspec *rs,
 	}

 	if (verbosity > 0)
-		fprintf(stderr, _("Pushing to %s\n"), transport->url);
+		fprintf(stderr, _("Pushing to %s\n"), anon_url);
 	trace2_region_enter("push", "transport_push", the_repository);
 	err =3D transport_push(the_repository, transport,
 			     rs, flags, &reject_reasons);

And it's not like we change the URL in `push_with_options()`: it is
expected to remain unmodified throughout this function.

Do you want me to send a v2 with above diff squashed in, or can you apply
locally (unless more reviews trickle in that require changes)?

Ciao,
Dscho

>
>  builtin/push.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index bd2a2cbfbd..b88948b07e 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -340,7 +340,6 @@ static int push_with_options(struct transport *trans=
port, struct refspec *rs,
>  {
>  	int err;
>  	unsigned int reject_reasons;
> -	char *anon_url =3D transport_anonymize_url(transport->url);
>
>  	transport_set_verbosity(transport, verbosity, progress);
>  	transport->family =3D family;
> @@ -364,13 +363,14 @@ static int push_with_options(struct transport *tra=
nsport, struct refspec *rs,
>  			     rs, flags, &reject_reasons);
>  	trace2_region_leave("push", "transport_push", the_repository);
>  	if (err !=3D 0) {
> +		char *anon_url =3D transport_anonymize_url(transport->url);
>  		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
>  		error(_("failed to push some refs to '%s'"), anon_url);
>  		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
> +		free(anon_url);
>  	}
>
>  	err |=3D transport_disconnect(transport);
> -	free(anon_url);
>  	if (!err)
>  		return 0;
>
>
>
