Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EAA1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 17:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdHVRgR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 13:36:17 -0400
Received: from mout.web.de ([212.227.15.4]:51606 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751622AbdHVRgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 13:36:16 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPW7-1d9lLn3iOZ-00cU27; Tue, 22
 Aug 2017 19:36:00 +0200
Subject: Re: [PATCH] repository: fix a sparse 'using integer a NULL pointer'
 warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9e45674c-bdc2-003e-daa4-79a3903dde8f@web.de>
Date:   Tue, 22 Aug 2017 19:35:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <91150cfc-3271-16b0-33d3-9a4e149dc9fe@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:oeaRPn2ngci+7Mug9gpKtqij/A7rBRvtHUkSOFJCGBITLz8XZGq
 NbV4z80nYKROhQMt2HJm+fo2XyBE9lihO9vberVAuDxjO8o9bQWXvxWXZCT/ifFnYecL3z7
 jDf3ae0bWi7HV3Ew7QInj/ItppuHoF7nPeR1mqWRSyAtic680hxl0PiCs9igOzEuhfFEwSe
 iERVpkInC4xsmTzfkonhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MBrLfbcPqB4=:TVMKvySjrFzjj5g2UAHqqz
 rMUvoVTDtJ7cFszOodGeOuywt3LepU65MOE+1c2JMHEsdF582OWeiLGAqCM/bJtDCaRRAb+m1
 s6aiqLG0o0rq2GzQ7mvtlSCn0Ag96GWoPqAkwQ7+lUiAU0S6LDVBH5EXnMPmWL+fUqpSIekNy
 fHq0stv5ZLsmJHkFY/I+yR8S7tilNNgbNbCCXyk/bk5Nico9tz5zXqzKekku8xph99R92PbeV
 y44JB8hhyUIhKTKYNzs0KObj8qP0JRfLPS+T5i70Id40p/qHqeNYFkMkGcEmEk0tmlhPySZty
 qC94thWLjdF9eLztiVNQHKEq9QF9BA3Kb7/Jl+IbFS3s5ktciIa/18wNmx8U/R6SLuWNFZfz7
 H3efBXyu0EviWoxnyabAnzMPxypK6yTnOAHd61JRquyLqrWeL3ClMBtEQvsZbnjxUrgplzgSM
 BdMjjWPOlCkivOmUNDcjaw2kENnAK1a7SEMYhNWXynX+GPw0Vdk3wbCz3Ncf/mx/wgo0dlqsS
 +x5is+kQPV9KTlxKGDNOMqjqxrRXrG52dHChjUs1vAf1wfUcdxqrtTd7PjNLGGEdCXZw1f1YL
 iWzhSYpdkVCy2tibMkLVkhxUAq2FGE4+K4Oxhx+0/MUuLT51IeYZQZ1s1xVSEcGVGUqj5qT9N
 V0OHdYOxSMoLpImlLpHkKjNTEdlWPHA+pXrwgc5Xz1uwyC6tqGygeb0qAK+OonU5ZtXZO6U9P
 c1SV/HnZUPPGyzRr75zd5HybKOzSSDhDeM6OYyMeT8d5qJeL8dbfjCsrN7h8fDMqKIq4gJxLM
 gNq0AYjoC6FsxRm2+qwEOmaYYVzHkPwNnua/DJ0Uqd+U17MoP8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.08.2017 um 17:48 schrieb Ramsay Jones:
> 
> Commit 67a9dfcc00 ("hash-algo: integrate hash algorithm support with
> repo setup", 21-08-2017) added a 'const struct git_hash_algo *hash_algo'
> field to the repository structure, without modifying the initializer
> of the 'the_repo' variable. This does not actually introduce a bug,
> since the '0' initializer for the 'ignore_env:1' bit-field is
> interpreted as a NULL pointer (hence the warning), and the final field
> (now with no initializer) receives a default '0'.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Brian,
> 
> If you need to re-roll your 'bc/hash-algo' branch, could you please
> squash this into the relevant patch.
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>   repository.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/repository.c b/repository.c
> index 01af20dee..ceef73614 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -5,7 +5,7 @@
>   
>   /* The main repository */
>   static struct repository the_repo = {
> -	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0

This line yells out "designated initializer" to me:

+	.index = &the_index

>   };
>   struct repository *the_repository = &the_repo;
>   
> 
