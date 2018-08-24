Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41921F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHXTsr (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:48:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:50785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeHXTsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:48:47 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lk81O-1fMulj0bve-00c9cb; Fri, 24
 Aug 2018 18:13:25 +0200
Date:   Fri, 24 Aug 2018 18:13:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Pratik Karki <predatoramigo@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] builtin rebase: start a new rebase only if none
 is in progress
In-Reply-To: <CAGZ79kafP=dVrwWopXW0WCWf199sU6uFSphjxtMTXDSix4Y81Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808241811240.73@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-10-predatoramigo@gmail.com> <CAGZ79kafP=dVrwWopXW0WCWf199sU6uFSphjxtMTXDSix4Y81Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2ZcPCrCXRcE1oha9UgrW39bwc6fnkNG+tCNL4N9/r4BB9Ivrcw9
 hIGwFqxcIjyG6Uq9jMiwjfMgIJP1CdlP5IFQhbn784iPx3o45HvQKbs9XlJr/028N6MEr5h
 z6IQwbVW+KJx1H2lbX8fbLSwgJArsjrxJgD6ropQ0yDpBbLj34Iovr/m33MSsTaOLGNTjID
 s4ifzVU+lvmnPp54DqC8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eGcMUZlMOzw=:LU9F2cVk3Pt7ij6tcNT7ep
 aFUmcGSsaj6E3S9QwR5/xc7RYE6/OtJcKuWylCfa6imicL7SNA7k4Utf4P4PEs4gjVe6LIYgS
 VA8rbNYUZSk7Qy7BFBW6MSZPUtO58MHhoH1GqHMS050DB1mmx2Nj9uQMXphFZPN+qHbLINZxT
 fAQlll7SblFXvOWfODOs0ZiUjrJa2sLLKincyws1SpFDKeAdadOdgQ08hAKdH1obHc1N4y7LJ
 o1wmWNr8MQbxTe80yXYR0h1GesDs9MLV4RiXWQRi5Jbyoe7MPiUTFxMyiShdK3Y1IQz+A40H2
 avRWxdrijgWoD8/t82EYFX+ncbqNCqTjkLvlJGb5zCvnDBJDiYacJwXO/pm5Elrk5j+Mmsobk
 tcA3/K473atrQGFyf7osMc4UBSmoNVwG/HrdZKGui/QRrS25gCRayv6obJsA/g+p0IJrvNaW7
 dOppf3fJQScSFOb3ZpPgvns+Z/gLNwQw0gSZkjWSVQWzf+MuX2svVZY5M9qPUT3aaZCQaScst
 m7ewyO5NLjJwhzxXsX0VSDQ2hcKw5dn6aH4dEU5gWV114KwEdRhEFoV6RtBeuU7oYK50CllYN
 FZ/8WAlfJlqyAMtjgD1BhLndDLM5Nt8a5rHmVd9yF9qXPb0lz37iGoIkd44fNs/rxNO8Kk6SP
 YeCje+VXuc0/SceCJHBAkqhsZM3QgWTa26ORu/ITcYanL3McOn1Fd9lg8Vk9cZ2dpou4O4unY
 PFIlFsEIzWVW0wsj+R+y1fqp0T7KymxEffPYa2jA9aioqmGejnQw3QlKEnu6AB84EMwYjv3J3
 7BFdB1Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 8 Aug 2018, Stefan Beller wrote:

> On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 8a7bf3d468..a261f552f1 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -455,6 +481,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                 usage_with_options(builtin_rebase_usage,
> >                                    builtin_rebase_options);
> >
> > +       /* Make sure no rebase is in progress */
> 
> The faithful conversion doesn't even stop at the comments. ;-)

Yes, I insisted on it.

TBH it is a bit of a shame that we cannot fix all those error messages
going to stdout, but... you know... One step after the other.

> I shortly wondered if this is the best place for this comment,
> but let's just keep it here to have the 1:1 rewrite.

It should probably be inside the conditional block, but as you say: the
original had it in a funny spot, and so does the converted code.

> > +       if (in_progress) {
> [...]
> > +                   state_dir_base, cmd_live_rebase,buf.buf);
> 
> In case a resend is needed, add a whitespace after the
> comma and buf.buf, please.

I will fix this before sending the next iteration.

Thanks for the review!
Dscho
