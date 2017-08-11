Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0513420899
	for <e@80x24.org>; Fri, 11 Aug 2017 13:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbdHKNIk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 09:08:40 -0400
Received: from mout.web.de ([212.227.15.3]:58541 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbdHKNIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 09:08:38 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNL6f-1di5cd2uPx-00706S; Fri, 11
 Aug 2017 15:08:22 +0200
Subject: Re: [PATCH] cache-tree: remove use of strbuf_addf in update_one
To:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
References: <20170810184723.12424-1-kewillf@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bc8f198c-3fe2-035a-4408-6369f34023e9@web.de>
Date:   Fri, 11 Aug 2017 15:08:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810184723.12424-1-kewillf@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PIyYAlJNFeheb/DAyo92OWtuMcbybu0KBvEY5LTVjcerWDPOct1
 F/tcZyv+4H4S/xnbwJCJljZ+qMhFRcPEzw11ml1sqDsHftuwH+wdozDHPLx6iGNeUXMWxK2
 VaPu4/3CvxiwYZGNOmu1Ekm2PLs0OsdnZCFNpYrLjvt5R8HqMBvM+ysuFi5NiFUPeLRd/vm
 Lg/aXsx8nVaBNo6EblvvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gp2+Jwvwm4g=:Kb0Rzu1SXtCbs58Zi4e+uo
 THv8R9aiLtlGfLcPyt4Omcx0K4/HGSSv4VRriTSmizkUevPCq5dVZjH1g8x/Gc9GbC5XZoQ7V
 sS1kEgwC29mIgkBdAOY8qoJ+2l7kOkWrQFwavvsdnhl5xSM43qhENoAtmwiC1n1aYBSEKOiFk
 /KWZiv1KI03eZ95y0mjKy2AOmgPF/CVBh+q+NOYEgJS9gfB9dEMwi2Slkm/0/2/U6YuyCWOdv
 E/lO5iwf8mmRKMn5QEYvY1MAxPAMFATPgCWx7hkG9fvNPxQeSrna494S6J/NBwrCuyHVSvs/D
 CZSM+7e8vFbItdzKHK6nocO7ik4L3ZFbgvN3Tyy+ALQ/nYtgsqyvl4uIcqOy7pcyowz2oSE/x
 iqtOeIp1OreCiyvbA5YpTLFRGa5Capv90Apx79HbQMBjP0vNLzPqTaYUkK1388fZj9HtCsd9/
 BECWZg8NNw77ggLd8rQTNsr7SFrkzhnoCKubGiRbvIs791E70hmdbvgGsOh1rKSFNwuO7hAV0
 4/EldCtt35jEqXYz0jh1uOwIR06fHhgoBmTagI815tOdRMSR1Zm5B+Zmt4kI/gZdm+nCr8nBJ
 KtCxbEr7wIlZHfnKlp0Jrv5rlC6LIlecrPBVaXfUOc15RISOH+aj9ZTGHaFdyc2WhBo1rIiWP
 u9O2f2jDlNlhmjVZWXm1wlRNUUncz2NOTO1tZWAR2/a1KEBzS8bjrUnqctrkXVMqe7O7PUV6v
 yz9r1aUCtCG8IWPA8yNHD+upgw9LMLgvKMcRPEK0i2po2nGV1oNV7IorHOmJwm+LZdgtMYpso
 dJcsLi32BcYWorcJZ9gmICT9K5ufncrn9qYUyYt99EzRK+86ec=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.2017 um 20:47 schrieb Kevin Willford:
> String formatting can be a performance issue when there are
> hundreds of thousands of trees.
> 
> Change to stop using the strbuf_addf and just add the strings
> or characters individually.
> 
> There are a limited number of modes so added a switch for the
> known ones and a default case if something comes through that
> are not a known one for git.
> 
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>   cache-tree.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index 2440d1dc89..41744b3db7 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -390,7 +390,29 @@ static int update_one(struct cache_tree *it,
>   			continue;
>   
>   		strbuf_grow(&buffer, entlen + 100);
> -		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
> +
> +		switch (mode) {
> +		case 0100644:
> +			strbuf_add(&buffer, "100644 ", 7);
> +			break;
> +		case 0100664:
> +			strbuf_add(&buffer, "100664 ", 7);
> +			break;
> +		case 0100755:
> +			strbuf_add(&buffer, "100755 ", 7);
> +			break;
> +		case 0120000:
> +			strbuf_add(&buffer, "120000 ", 7);
> +			break;
> +		case 0160000:
> +			strbuf_add(&buffer, "160000 ", 7);
> +			break;

You can avoid specifying the string length by using strbuf_addstr.  The
compiler can determine that value; the resulting object code should be
the same with -O2.

> +		default:
> +			strbuf_addf(&buffer, "%o ", mode);
> +			break;
> +		}
> +		strbuf_add(&buffer, path + baselen, entlen);
> +		strbuf_addch(&buffer, '\0');

How much of the performance improvement is due to these two (especially
%.*s)?  Looking forward to the perf script to find out myself. :)

>   		strbuf_add(&buffer, sha1, 20);
>   
>   #if DEBUG
> 
