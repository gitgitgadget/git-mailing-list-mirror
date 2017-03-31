Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE881FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 12:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933231AbdCaMiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 08:38:12 -0400
Received: from mout.web.de ([212.227.17.11]:64415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932927AbdCaMiK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 08:38:10 -0400
Received: from birne12.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK24P-1ct6Kp2645-001Pe5; Fri, 31
 Mar 2017 14:38:06 +0200
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <264c72d0-9558-fa0d-e5ee-eaca894538be@web.de>
Date:   Fri, 31 Mar 2017 14:38:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:R/3I2pJxQ1cqQ7S/Hiz4hh2USBymPDJQJB/pOwC0kx9NEdLOLlV
 uZoBxHxhJfjhXi2/pm6UTlkKwXDXpXBAp36iixsglh1SWEJrkVfAa+JiNEbgnmNjd+8xQgs
 pG6Qksdil8DF0olmf43maLqmo0X0yfi4oXKSjf+OSIH5XvuTYRi1vTNy8upQ2TS2HcmAZX/
 r9yVoR3TjA1pzvpb9dtiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cqkZfET6hDc=:rOMI40QYcIuOyzAeoCCij2
 gPGRfnUBOelv33GiPvnJY/S/RXy+RuHx/OK7230/NVSG7m08U+Pd+WzQf57PCnMZk7/PaKG+o
 O/+B4hrVkA+HuQ5d79ryvI6+ua5ufSizGrgBr2kZxnmeBRUELMHqTIIbtOjrUcrYCV23PfdsH
 CHTZTtX2Tb2bgAzeP97VyDdeemYHhc6kdovzX3q4nCr4UP+OV2LTKLnDCO8m3crpvhktPRRfV
 DTPDbA+pdlBHucrTziLYJyCaaoCyl5KpkuqSIebGo2pxrpMehxLMm1ToOlWephI7L3LWHvrXn
 EL5SXmpUQUwo1PENGeprPzJnKYMQLfpEGV6sdjbqTUovJWLJyuXK8mXkmU0jLlKQkETI8KpLf
 pwPXkrs3p5ox2a3J/6/yXqERy5/LNIMOuQmMvG2tzxga7FpV3kb+PbiNFBStE9sZNPT/HDW6t
 Je/BJ5DxwPy8N8Sjr1RNPTNARiZPHmQp9ZI1hhai5RMM2vU9YNdtsnVUdE0+YntAE7Te/kQTJ
 z+r5PCqLMjqkUfhGlat88roInHZHRWxNLv1p8NKYdSNQSzwMX5HmcYnYjnHGIs2OXIbijiJJn
 v79ZEkjA7ZO5Z5z9yJp4mv0Dgy+TagadPRNrX5KNucz/NJnQfQnhtN1tP69DKa6HbuedMF1/C
 D2pUcwDiFogwlakZU0s0UDrQC/k0TSPFcH3ppghmc8HAJ7NH1p8nJwmvhCpHlXrO5TjKEiQod
 asuaYsYq8u5JZdNaNWbmM39O0Er+Rp+1jR0Umk6BrHZXbQKGFoLwcaeTGZ/iE6qdtVoalmeNX
 /6nermH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.03.17 21:35, Jakub Narębski wrote:
> Hello,
> 
> Recently I had to work on a project which uses legacy 8-bit encoding
> (namely cp1250 encoding) instead of utf-8 for text files (LaTeX
> documents).  My terminal, that is Git Bash from Git for Windows is set
> up for utf-8.
> 
> I wanted for "git diff" and friends to return something sane on said
> utf-8 terminal, instead of mojibake.  There is 'encoding'
> gitattribute... but it works only for GUI ('git gui', that is).
> 
> Therefore I have (ab)used textconv facility to convert from cp1250 of
> file encoding to utf-8 encoding of console.
> 
> I have set the following in .gitattributes file:
> 
>   ## LaTeX documents in cp1250 encoding
>   *.tex text diff=mylatex
> 
> The 'mylatex' driver is defined as:
> 
>   [diff "mylatex"]
>         xfuncname = "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"
>         wordRegex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
>         textconv  = \"C:/Program Files/Git/usr/bin/iconv.exe\" -f cp1250 -t utf-8
>         cachetextconv = true
> 
> And everything would be all right... if not the fact that Git appends
> spurious ^M to added lines in the `git diff` output.  Files use CRLF
> end-of-line convention (the native MS Windows one).
> 
>   $ git diff test.tex
>   diff --git a/test.tex b/test.tex
>   index 029646e..250ab16 100644
>   --- a/test.tex
>   +++ b/test.tex
>   @@ -1,4 +1,4 @@
>   -\documentclass{article}
>   +\documentclass{mwart}^M
>   
>    \usepackage[cp1250]{inputenc}
>    \usepackage{polski}
> 
> What gives?  Why there is this ^M tacked on the end of added lines,
> while it is not present in deleted lines, nor in content lines?
> 
> Puzzled.
> 
> P.S. Git has `i18n.commitEncoding` and `i18n.logOutputEncoding`; pity
> that it doesn't supports in core `encoding` attribute together with
> having `i18n.outputEncoding`.
> --
> Jakub Narębski
> 
> 
Is there a chance to give us a receipt how to reproduce it?
A complete test script or ?
(I don't want to speculate, if the invocation of iconv is the problem,
 where stdout is not in "binary mode", or however this is called under Windows)




