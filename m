Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624B71F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbcIIKlN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:41:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:49506 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbcIIKlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:41:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MPE7E-1bdtOB2fZ2-004VHT; Fri, 09 Sep 2016 12:41:03
 +0200
Date:   Fri, 9 Sep 2016 12:41:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Use the newly-introduced regexec_buf() function
In-Reply-To: <20160909095735.zen2ynpsn7azqfss@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609091238020.129229@virtualbox>
References: <cover.1473319844.git.johannes.schindelin@gmx.de> <cover.1473321437.git.johannes.schindelin@gmx.de> <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de> <xmqq1t0ujp2f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609091151510.129229@virtualbox> <20160909095735.zen2ynpsn7azqfss@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YpOQpBHeRfYBhIMKM5jlyjeixlcK0vqbIn3x5B3J9CO7ExWB3sm
 jY+Uo5JCFAexDvJQugskNK8vQa+R35xfM8khfYNTNy2ncLPmmDrPOPbST0ihh7DqycLaiRU
 WPBTwB6xwPyPVBlLTgzB2GFTufESQIVqj9bzSYTpjzHlbQ8916kLOiKdL6ew72o5qwaypM1
 joczdOOjgrqk8yZIQGtcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DSQKO3O7rx4=:dMTcqCiYyI4Uo9AOOvI3mS
 yHtsGzCtu0qp4k1SN35rFdF9ADcwpWCWvQW+SvqikrAArDIdUFCHdyMEmiI0+7DbwIiLFZg2w
 SiYqvwZmud5fuj5ru9YARX4ZIERQJMasZywagg08xD9h6weeoc2SM4G9A3wFKnkfgJluxqL6y
 GtAwQ5yq8baVo8A+cHQViPUkWZSA37NFZRISzrHuUrQuit2Pis7hRzWtUSEmm34wKXVtrCsOC
 7fJekSMYF2yQ/6FINRHzm35cWpafkxdXvhnYsB8HQM4lch0zoEcQ8CLnTAIFb9fDPkhEJZg8D
 vjjbfmEhXyfJZjjqZN3LwZAD7SBYiKiujv/h9pjmN5FkhU5FNUgL7JONOjzAhR3AkDGdUo0Ec
 ZE34dzGFEnJuI/wbMEQMylkamFR4V7FyBZ2RLpsH6rENqoDubopy9Z6cPpEHthmhG1oH+FfY9
 7Xfr3L0uaaInvie1HA0hBTHqQduD/mChUGmMVt3mUtkNDZAfmHeWlUEulQAjJjrvnAmDPKPf7
 C7yR2mPZ2eAJKYAcc+hq+QbPcsllhbSz9rD92uZDddFz+H3ujNG9nf5Lj9NWS+auvHAujeGFr
 UUtOdU73VO/yyYv6nUyo3DSIwduqr5e7ar6Z73WolLbvDR9vnC2RsUyuRQZtPmJ4LV0t4dEHF
 vs3U2qgZI6GPEstoIJ1QYBwzvgxl28A+nS8+v2pWmxbWsVXl7huTvV43O6nJ0etl6MJ8Py1WK
 +fI8kgCv+fhUVDMPoJfay6GC0xcGdSE9QIB9dh+4L8fr+eX+PQUPwxPu6Eu5eOXd1iPvmgArb
 Z9Ch17U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 9 Sep 2016, Jeff King wrote:

> On Fri, Sep 09, 2016 at 11:52:50AM +0200, Johannes Schindelin wrote:
> 
> > > Also I agree with Peff that a test with an embedded NUL would be a
> > > good thing.
> > 
> > This is something I will leave to somebody else, as it was not my
> > intention to fix this and I *really* have more pressing things to do right
> > now... Sorry!
> 
> I think it is literally just squashing this into your final patch:
> 
> diff --git a/t/t4061-diff-pickaxe.sh b/t/t4061-diff-pickaxe.sh
> index f0bf50b..37b8dde 100755
> --- a/t/t4061-diff-pickaxe.sh
> +++ b/t/t4061-diff-pickaxe.sh
> @@ -19,4 +19,13 @@ test_expect_success '-G matches' '
>  	test 4096-zeroes.txt = "$(cat out)"
>  '
>  
> +test_expect_success '-G matches after embedded NUL' '
> +	printf "one\0two" >file &&
> +	git add file &&
> +	git commit -m embedded &&
> +	echo embedded >expect &&
> +	git log -Gtwo --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Thank you for providing me with the patch.

However, the whole idea of supporting regular expressions on buffers with
embedded NULs *is* different from the purpose of this patch series.

And in my quick web search, I got the impression that the presence of
REG_STARTEND really does not guarantee that regexec() won't stop at the
first NUL when rm_eo points after it.

So yeah, the patch would be easy to squash in, but the entire "rat's tail"
of making sure that this works everywhere, *in addition* to making sure
that the crash on mmap()ed buffers no longer occurs, would just delay this
patch series.

And unfortunately I do not have time for that right now.

Ciao,
Dscho
