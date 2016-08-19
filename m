Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E611FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 08:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbcHSI5V (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 04:57:21 -0400
Received: from mout.web.de ([212.227.17.11]:50677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753547AbcHSI5U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 04:57:20 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MQvsg-1bjyzp0t2M-00UKTY; Fri, 19 Aug 2016 10:57:03
 +0200
Date:   Fri, 19 Aug 2016 08:57:00 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
Message-ID: <20160819085700.GA23254@tb-raspi>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:zPKH2lYbrw10QPhLqnp0wKrFg9YK6utqFj+GemhXLaxaXzp6+vI
 6zBZ1Q+emHPup0vFL0rh9vqpwwiyR9e6rTKSpFIKY2sQnZ3ismUSka07N8w4f9n2iD1DkW6
 i0eYW2PaRIpDOnWKum+VyQMAydFMD0dKGJUCWHY+/26qyzDBKlcVmLoC3fvDeiOAwqBsN5s
 5kDNIvhPZMPmh0CQIlMsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lgb5LPQeetw=:Rqc82e0nkZxIKxMI2uwm1G
 sU/plTR0viqhm2DYOfQ//abfR8xTKYw6RmSR3IH/DTe9lN5WYtWTCVl4ZXPzeEtbSw2jK6CV8
 XKpGjVeoEFLmOF+/eFHDkgM7KdOA/NRbn8rVSp6j8hAAwOuk83T3ne0QKO/gVQ+Mnty32Eb2A
 HdoWT3CziyGGQkk5a0VAaviHwUGbiBUtAulAFqliV1Aa2QtUcljbccxaPJ9/sglBZxeK7NCyb
 sVcmPlHjlBvU3joUgKDqOmfbS7IIzIYgSWf/7iHzXIWPWBxAbzSXoyzzS1Mbp2r1Dhf2KKUFA
 ccoKHlzFTxjtH0+dZ6wLPby5u/hZKaQpTJozN9+oh0FiFkEQUrhx6rFqqoJ7fcCdqB9JlWo2+
 Cf9k2vwmhrL752p8LA2P8+sGcIeDQ/Yo58M9pOihBv5D+yhzINcZwMKrIdVGZuqp8Kdjar7NM
 gdVxE5SrQpcuzMlWGOaPQuLnRugn3CUFtHL/GsGuhxsWO33M6YWAOcDx54pFBGAI3KIrB3y2k
 bWZkm8SuKHcjM0prYv0JoH+a+JMCfRR1K8erYuTFFpo2EzjFmNKKqReM/2xD+ctM3PLzLIpxb
 Qru5uOxo+uNmDzW2AAu/rTDxOSVUCbJvNOfkwptWlTJcXhdATkBstJDbLXVuRLTR25w0olYqZ
 lQFPruoxYK5ixrnF0Klj690wxUmVk0rliV1qcH3lsOvd9AbqCCpeE9Ofa0esZAYIT73l8ZI+J
 MXF9Tx5pbZRvYPJf5NdKH8n5Bz/fRpctAXL5D4uHyra40Ah1WCDOD9O7Q+U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
On Thu, Aug 18, 2016 at 02:46:17PM +0200, Johannes Schindelin wrote:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 071029b..7d48735 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -9,15 +9,15 @@ git-cat-file - Provide content or type and size information for repository objec
>  SYNOPSIS
>  --------
>  [verse]
> -'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv ) <object>
> +'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) <object>
>  'git cat-file' (--batch | --batch-check) [--follow-symlinks]
>  
>  DESCRIPTION
>  -----------
>  In its first form, the command provides the content or the type of an object in
>  the repository. The type is required unless `-t` or `-p` is used to find the
> -object type, or `-s` is used to find the object size, or `--textconv` is used
> -(which implies type "blob").
> +object type, or `-s` is used to find the object size, or `--textconv` or
> +`--filters` is used (which imply type "blob").
>  
>  In the second form, a list of objects (separated by linefeeds) is provided on
>  stdin, and the SHA-1, type, and size of each object is printed on stdout.
> @@ -58,6 +58,12 @@ OPTIONS
>  	order to apply the filter to the content recorded in the index at
>  	<path>.
>  
> +--filters::
> +	Show the content as transformed by the filters configured in
Minor comment:
s/transformed/converted/ ?

Does it make sense to be more specific here:
The order of conversion is
- ident
- CRLF
- smudge
