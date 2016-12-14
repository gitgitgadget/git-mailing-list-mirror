Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D8C1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbcLNRky (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:40:54 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:58303 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753167AbcLNRkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:40:53 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 769A1C3442;
        Wed, 14 Dec 2016 18:40:49 +0100 (CET)
Received: from mcmini.bolli (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 41B03C343E;
        Wed, 14 Dec 2016 18:40:49 +0100 (CET)
Subject: Re: [PATCH v2 4/6] update-unicode.sh: automatically download newer
 definition files
To:     Junio C Hamano <gitster@pobox.com>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
 <1481671904-1143-5-git-send-email-dev+git@drbeat.li>
From:   Beat Bolli <dev+git@drbeat.li>
Cc:     Git List <git@vger.kernel.org>
Message-ID: <b137249e-728a-5d3c-4993-5ed5a1593737@drbeat.li>
Date:   Wed, 14 Dec 2016 18:40:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1481671904-1143-5-git-send-email-dev+git@drbeat.li>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.12.16 00:31, Beat Bolli wrote:

> [PATCH v2 4/6] update-unicode.sh: automatically download newer definition files

Dang! And again I'm not capable of putting an underline instead of the
dash...

Junio, would you please reword the subject to

Re: [PATCH v2 4/6] update_unicode.sh: automatically download newer
definition files

Thanks,
Beat


> we should also download them if a newer version exists on the Unicode
> consortium's servers. Option -N of wget does this nicely for us.
> 
> Reviewed-by: Torsten Bögershausen <tboegi@web.de>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  contrib/update-unicode/update_unicode.sh | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
> index 9f1bf31..56871a1 100755
> --- a/contrib/update-unicode/update_unicode.sh
> +++ b/contrib/update-unicode/update_unicode.sh
> @@ -8,12 +8,8 @@
>  cd "$(dirname "$0")"
>  UNICODEWIDTH_H=$(git rev-parse --show-toplevel)/unicode_width.h
>  
> -if ! test -f UnicodeData.txt; then
> -	wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
> -fi &&
> -if ! test -f EastAsianWidth.txt; then
> -	wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
> -fi &&
> +wget -N http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
> +	http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
>  if ! test -d uniset; then
>  	git clone https://github.com/depp/uniset.git &&
>  	( cd uniset && git checkout 4b186196dd )
> 
