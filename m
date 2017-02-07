Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F8F1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 11:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbdBGLV4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 06:21:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:55297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753843AbdBGLVz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 06:21:55 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2zr-1cWxFH47TH-005HBx; Tue, 07
 Feb 2017 12:21:49 +0100
Date:   Tue, 7 Feb 2017 12:21:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     David Aguilar <davvid@gmail.com>, Git ML <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] difftool: fix bug when printing usage
In-Reply-To: <xmqqinon2nnt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702071220290.3496@virtualbox>
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com> <20170205212338.17667-1-davvid@gmail.com> <alpine.DEB.2.20.1702061716120.3496@virtualbox> <xmqqinon2nnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TCZYBBC5rwWoob0wQaTYVha4xyiG4iTb0ggCYAKPBA7B2aikw8G
 ZL/Chj5xeC7QEuKfIaWyisQ2IjT1fVBpAyWPluZojsUcycQVttHQpca8al4iNz81AfLTlRy
 NOVOz5kirZFwGpXtbJA+njvyRt/7tX/aIYhkCdlEPRv+6BtYhdrdn3MzAtCXPOOZM30xu5D
 DSWQJotdOL1Hs1J7wQFuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ULtZJY+Yt5k=:/VykepbVbl2LHQs2efSeFf
 HWpkaiAGMpvDi67hRcxF3aqtST8GNzBAoW4D72B7nXhaheqPcKp5GfMif6wbO4aP2h+pf5Y9d
 ZHz+cJ/ClYdvt9CYi+APvxQtJAeyV0qmVKPeDUUJHl7Q0SLc4nuTlxkKLppeBwEoc77RqiaXs
 OzlRas66Xph96TkI9BRZKcNGQs8cGWDUAIoiOnbYA9pIl3dtnjJ+By52UPrrX39tPG8Ch9nEY
 rIrs0yUzrs4Pamlfw70j0fqMPxm6eAZITyv1+IveXfZuL9LMfXsZiQ5xmUDqwHZUvDoXmggcJ
 XSoX3ZEgv6VJLDcUwWaZYUVVbUSdFk9r503kW82TUaN/qaxCkZ/+ng5uYkDyAiSAkH2TqrqdX
 NRE0adDGmRLtlkBrmjHvZD54wTrAZIr9Ve4f1OR/7P7y0smQfZ9iRfYb0O+mtaelIGu/rX5Jj
 Guaf1Z8aSAhs/Nt19BI6EEGB2AZt0NVAiWrpXVfgBrRx975rrJxDdqQ/g5w6hlmsuTkx0HoGy
 FZVdP83Dtza5TsAdUv53ibqxE4fVu+c9ayIweeuIbsw+ErheUAvKWTA0eDfmM3sQVijva0zO8
 OS7MVRZZ/MbuzzjAPtqINA1AXX4LXp1ah7lKrMMqfsNZ/fUV/DE6KobWC6LGYd8nUbzRv2uC2
 4+u4OuOCKvTKQJBpSZrO0hyAMdFav4WcqNmPlK2+t6Z6aCM/6Yy7VcYOUzpea5S0b5KwpSqmY
 h/R5+BSqcV3Tb3/eWi8UYcy7aZZFzSlh3nPcqKPeY8mfll0d8IqldIffBcqayS1IXAMm398bM
 wJMVUSo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > [... and he quoted someone ...]
> >
> >> +	# create a ceiling directory to prevent Git from finding a repo
> >> +	mkdir -p not/repo &&
> >> +	ceiling="$PWD/not" &&
> >> +	lines=$(cd not/repo &&
> >> +		GIT_CEILING_DIRECTORIES="$ceiling" git difftool -h |
> >> +		grep ^usage: | wc -l) &&
> >> +	test "$lines" -eq 1 &&
> >
> > Likewise, this would become
> >
> > 	GIT_CEILING_DIRECTORIES="$PWD/not" \
> > 	test_expect_code 129 git -C not/repo difftool -h >output &&
> > 	grep ^usage: output
> 
> I agree with the intent, but the execution here is "Not quite".
> test_expect_code being a shell function, it does not take the
> "one-shot environment assignment for this single invocation," like
> external commands do.

So now that we know what is wrong, can you please enlighten me about what
is right?

Thanks,
Johannes
