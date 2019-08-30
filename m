Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9001F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfH3TqS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:46:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:48299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfH3TqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567194366;
        bh=QQP/dmqlfNOuPn35dJGBjCTxfevdMt6jklhuONGz09U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=glvoLHIZFlgU/wI8kRdB+3t6QY5IDCA5XyU8V55ehThW89kRT+FFcT+eIhq9KHjtM
         3gCApadqaAxVLd3h0nPMSCdRIzS/n47qnn3iHpucipU6Qqhvtz92S36rcKAQx9dPTp
         jI1IYneDOQw+MbgH3rTAIZnaD1j3w21dK1mLnltI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1iKtQB3sru-00uuHQ; Fri, 30
 Aug 2019 21:46:06 +0200
Date:   Fri, 30 Aug 2019 21:46:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v5 2/2] am: reload .gitattributes after patching it
In-Reply-To: <20190829230928.GF11334@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1908302145270.46@tvgsbejvaqbjf.bet>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net> <20190825233340.10894-3-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.1908281327180.46@tvgsbejvaqbjf.bet> <20190829230928.GF11334@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MX+e8SkXWxYJ7eAw/afGhXV2x8YkxZv+cY1EAUTTMAsWolVWaA+
 FGq802PDejfc5et5+pqRONdnGBWUELkhsHV9rZMsEqaPanSMxhdT4jqOrSn9dPztvW/TCWf
 8WDQuVnZavStHrOip9HD/wxqsV3POY51G69yGTRFzsKTd8tQJzoORUh0CNOni7J/zzHGJ2C
 eSJZG8oQL8gdykNrwd7JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q1F/uaAkHsk=:jOwivkOQdDpXwe4584QMla
 /AX/1s68riB+WLQpwpSQnwKdSVBcEwmXWvuJhCcq3eKammVAFEJzinlxKyd+l7fujEFrkfTpy
 wPngkKaEZcBD1YhdV97VSkXIzXJ3ME24ywoYS2RNW/JL6WJlYVxrqIJT6Mfej65aQ58k7CUNs
 nLqvXG0MSeSHsmPlgVihoZ6wK/JuGPRO5bWpKQj9EcsNGxNCZkEt+KV0FaD/uSQP+AxjnPNuJ
 og2xOxin3s/xrNFsklkamV7yasQsXBVvwqvSqynwJ/j0PKa5bjsNDaU/NGtuc+E1KuY14gSC1
 40oI+xhQW/GMt2/GNqSOSJkz0MxoweznV6dgNClyNKnG5qLnEf9MYYbhQPcXofG9ObINxvxzj
 haur4J27vWdY2mLET2GnlqcYZyKdo9d3f17fy1yNew7jcnB/woPQ9Pjl490V4tmdNilziqMlS
 A5iY5vmUF1q1jlDGYnLiRtKNbGkFPRfQ+xXlfIH7VyPoijcnI1nPtIXaM3hpJwJ8xSxFdMwbI
 xwl2BSkn3/7gAuiPNE5fyXiZ7My4WetK6C6YjwmOC1Kf2yrhCY+V97T8VtBkMHKJidQbuRusi
 4cKni2LJXbwJ9o/wXJOlQJybSepA/3SUbtKvSTbXvvE3Nezap7mmkPrDKWgXk2Trpw3Jvc3W6
 dJSerhH+rXDRypv2DTFqbR6cgIvlVgNuHGTWSPH+3g+TrQrIls4CrjcrpFlMyoRMUS4xRLEsY
 Q7AIISOwykGbTK6Cpg5e8wxANH1U4y9G6PLua86xNdDaw+oSjmMq9tDgIPZEdM7IkYaUfct/p
 NNQjEk00RRPfMx9KMLz4Q69xtwt4+vleP3tdS3x7xq2/jA5XhW+Wx2B6Ib3bjZHOIFm27bcQC
 AEzwEr4o+WnqKgPvHtFzKV5k64gLxR9iJuCGP+83x0yoejWBVWx/0xRB2rnAWoxkqqkg5daXm
 lArSSQwIKJi1jkaE+7ot2SjcKORayBma/QMbwjV+z4tDSD6t+UIyK82bDAspacUo7lp12/hwg
 mSiYXHkieKXn19knpoeFGipoSSkm+YtIj/6e76ZXB4x8fu7Yb3cwy/iYW51+q83XJ43Gn/BRY
 MzsDlgDTjvshrbFFYHDi3v1Ux+wYyOGX9ZExBMYSRFZpjtf45KJjQQZNsnwMRCLFkZWzHu+qN
 yVBA++JRzhlI2VTnEe4cIIMZghIRhNmqXSYroZXkfWpuCbPc7SwEkHryeeLlK579KJKk4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Thu, 29 Aug 2019, brian m. carlson wrote:

> On 2019-08-28 at 11:30:53, Johannes Schindelin wrote:
> > > diff --git a/convert.c b/convert.c
> > > index 94ff837649..0e6e9d2d75 100644
> > > --- a/convert.c
> > > +++ b/convert.c
> > > @@ -8,6 +8,7 @@
> > >  #include "pkt-line.h"
> > >  #include "sub-process.h"
> > >  #include "utf8.h"
> > > +#include "ll-merge.h"
> > >
> > >  /*
> > >   * convert.c - convert a file when checking it out and checking it =
in.
> > > @@ -1293,10 +1294,11 @@ struct conv_attrs {
> > >  	const char *working_tree_encoding; /* Supported encoding or defaul=
t encoding if NULL */
> > >  };
> > >
> > > +static struct attr_check *check;
> > > +
> > >  static void convert_attrs(const struct index_state *istate,
> > >  			  struct conv_attrs *ca, const char *path)
> > >  {
> > > -	static struct attr_check *check;
> > >  	struct attr_check_item *ccheck =3D NULL;
> > >
> > >  	if (!check) {
> >
> > After this line:
> >
> >                 check =3D attr_check_initl("crlf", "ident", "filter",
> > 				"eol", "text", "working-tree-encoding",
> > 				NULL);
> > 		user_convert_tail =3D &user_convert;
> > 		git_config(read_convert_config, NULL);
> > 	}
> >
> > I am a bit worried about `user_convert`: it seems never to be re-set.
>
> Yeah, it looks like I'll need to reset that as well.  The only
> consequence is that we leak a small amount of memory if there are filter
> attributes, but it's better to avoid that leak if we can.

Okay, good, so my suggestion was not so completely off the mark.
>
> > Also, how thread-safe do we need `reset_parsed_attributes()` to be?
>
> Since patch application isn't thread safe, it doesn't need to be
> thread safe at all.  The original wasn't thread safe, either, since it
> used a static variable without a mutex.

Thank you for clarifying! Much appreciated.

Ciao,
Dscho
