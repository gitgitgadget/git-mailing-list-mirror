Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251F81F790
	for <e@80x24.org>; Tue,  2 May 2017 13:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdEBN5v (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 09:57:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:60652 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdEBN5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 09:57:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw1vh-1e8gao1qkH-017mpP; Tue, 02
 May 2017 15:57:35 +0200
Date:   Tue, 2 May 2017 15:57:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/25] mailinfo & mailsplit: check for EOF while
 parsing
In-Reply-To: <xmqqzievdhk5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705021553420.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de> <32a2d16902734c8794de61b5e86a0d2a6cf43fa3.1493387231.git.johannes.schindelin@gmx.de> <xmqqzievdhk5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iX9kgOX6QbZdPQhhmBtu8wxXwDPmOiTP1ItbHofRNPBYP9JPcAc
 2Y23EzDIzpBXP+Lhg+QQCxDOiVrCJtnetJmJbazcER3DhpijYUDIeLXqd9ZA5OXB8cpYT6N
 dBwQQysIezX8iFFgj7mIRGTgqsqtvKvu0RslTuOMzl1WeQJ/CLRO4HAugyaI0rmPZo/RlH4
 GGIelSz52Iee5APlp7LuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z2lzUm60SWc=:rHZEcyj6LqrQUY3m6ZuNxv
 d5TVWp7DV4Lv9zZX37aryfB+7pYBvvu4S7oe56mkEfOY47/EhnngGo2UFHYSywfmIDolvFTKk
 1aNOm2VOsHwQn9OYgwCTshJ+afrpVp4OqocRh0AfFcRE19RyT0HYrl9IJu9A3on8ZoSvE6yxu
 oemcirFsB3YkQBXy30WOD4PY49dDiwZeaG7Fx9x03xA07lhF3M4lB7/dmInXLkMpT6C4XiNjB
 FSqbJNK5xcyedmiUNOv6kFd6szh4juAdJgpjqdf6WHUKnr7tHp0JQ0MjOf2SbNg+gOYtPA0Z1
 9CfcUqHu6fQyDjE9IFlTFfRb1IbuY7QbqUJIr/D6dY8ymazhGT0HCZaTffmzbVNuNkVYaOHht
 gxct3j0dtMLxCcjx0u8VxetP+3e56NTK56fPhj1v6NSN92LdadORJIedReQ2iijSEMBItCuDp
 kwXZeqC+cmgcAWJAUo30lte4/8ejh7vD3U+Za6h+VXMPNYHyerSae8WsRSj6rWH1+G64UtnUs
 OpqmYvO1bMuKBnJQU0tkqbt3Glbp0x/x89/jvTz2LPjTjj5Rw6mNdHS3PiNzRHcriLkOYnrdP
 4Wo2/iyUDruRydOFR+cgznyBaREYgQR3RckRhdG89zc3oZPco1MW0ZhUvthabTq8voUGYBo/j
 GEjGzow+8yxqkE0I6LLzd2UgvLqUWypkInh6s7B/Rk2l7Lc2LOaevpGoUc3lFDlSH1pdmly61
 /b2XCwpvPJxfYtsd/ELfwfEQ9c7uFUQPht3UJ+erMlBRTia3tnfodmuzxaqTSNN6g3j8fkHx0
 EymyqOu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 1 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> > index 30681681c13..9b3efc8e987 100644
> > --- a/builtin/mailsplit.c
> > +++ b/builtin/mailsplit.c
> > @@ -233,7 +233,8 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
> >  	do {
> >  		peek = fgetc(f);
> >  	} while (isspace(peek));
> > -	ungetc(peek, f);
> > +	if (peek != EOF)
> > +		ungetc(peek, f);
> 
> I agree more with the first sentence in the proposed log message
> than what this code actually does.  I.e. breaking upon seeing an EOF
> explicitly would be nice, just like the change to mailinfo.c in this
> patch we see below.

I changed it to error out with a (translated) "empty mbox: '%s'" as the
other hunks.

> > @@ -1094,14 +1097,18 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
> >  		return -1;
> >  	}
> >  
> > -	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
> > -	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
> > -
> >  	do {
> >  		peek = fgetc(mi->input);
> > +		if (peek == EOF) {
> > +			fclose(cmitmsg);
> > +			return error("empty patch: '%s'", patch);
> > +		}
> >  	} while (isspace(peek));
> >  	ungetc(peek, mi->input);
> 
> The handling of EOF is improved, but is it correct to move the
> allocation of p/s_hdr_data down?

Sorry, I *assumed* that the function was passed a zero-initialized
mailinfo struct. And as you pointed out, that assumption was wrong.

My thinking was that I did not want to introduce another leakage by my
patch, but as your careful analysis determined: the only caller that does
not die() afterwards releases the data (and would not even be able to
handle p_hdr_data == NULL...).

I reverted that move.

Ciao,
Dscho
