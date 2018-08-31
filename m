Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BF11F404
	for <e@80x24.org>; Fri, 31 Aug 2018 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHaWfq (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 18:35:46 -0400
Received: from mout.web.de ([217.72.192.78]:44787 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbeHaWfp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:35:45 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPRu-1fwM0y30TK-000eXP; Fri, 31
 Aug 2018 20:21:42 +0200
Date:   Fri, 31 Aug 2018 20:21:41 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/11] t0027: make hash size independent
Message-ID: <20180831182141.GA9399@tor.lan>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-6-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829005642.980617-6-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:ldvfciJQYYmsApgVj0v2rCd0CFe/fH+WJt2pIOeNFQEpY45oS2U
 Tkwwyo3KnBmVTQ89e5vQQ79lgV6bbA5nwFfsD4oaXW3Nm4vYsVePB1lxuw0diypqcDjrzC6
 mb3uL6TZBzgedITRZ6d2AM8VXD4b8Ehw+R3Kab3h86bMmb2gHo5ZWkU4/clsWTgla6uxOhf
 WF/nyMO60ib2YXQh3+RgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sykE7OGNATU=:VFNEK6mYJ2jt5YuwWfp7J7
 iXj5NIlUHk3zNptKU24g3xrvk42jPDKw6RgzNaifTY/AK9pKIA6wq5sZDI9bhJegWtZrwvdRH
 e6dUIERoFClifG34L6+u4bim4gGqXchEj041k4OONZf06jc00/II8+TJOBCM0TmDDdcCF0Izd
 0hkPuMHhWqe3a5Xpb1dc7bmicEUrM4OOW045IzGsWTnCFpqgt1y/gKbVMV+OZfyeSTFhAEG2t
 SdxiRZ8tHPiTXGRIFvdNmVzHm8ZcIObAO2k2Yq+FOOEe4+JIDyoMTLY3juStQv8wvVMvJQ0L/
 DNO4EyLznYfJq4rAFkbvEry3w6aJCN9TCzUWtYT2eN0erJm4t2uNB+9AOBy8Jt0kHXvlGWes3
 OjRpvvFUBM7GkxVBNmpl7e+U1YNtFvzhrmsjdtnGytzxWYSy/YEEqom/PWFD6/VbHqZN+vDNS
 TzE0kCV7Nlv86lvHAmSIrjFDfMsqkCiW7TXwn1rLDTx+ZfRVxXTSANpXh/ocNHucmKGZBVZRX
 0H8eP6AcnzIef91r+PMLRRXr4DzPu8FI9N5/mYe2vjJ5HVCMXBvzxPftG4cjTsnVzL/NQ8L4n
 0tdqcZpTzVw9sa07Mg7mxsdRfLmZHxTTDuNBc74lo6XnUci7DYehhnyIHvAHIwcqsof/VGign
 Ryu0z0Q9DvBpauvmLTscXEj/YKRWC/aCjkqk/lByjk5MUHXfnoVM8pYE2Rhe7+u219pRrgq/E
 9t0EYmfbrv4T0GuTZi3RX9IZrFs9kbfK2EsjXzTxNH9PRimgl/oxuEs8vvo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 12:56:36AM +0000, brian m. carlson wrote:
> We transform various object IDs into all-zero object IDs for comparison.
> Adjust the length as well so that this works for all hash algorithms.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t0027-auto-crlf.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index beb5927f77..0f1235d9d1 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -14,11 +14,13 @@ compare_files () {
>  compare_ws_file () {
>  	pfx=$1
>  	exp=$2.expect
> +	tmp=$2.tmp
>  	act=$pfx.actual.$3
> -	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
> +	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$tmp" &&
>  	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
> +	sed -e "s/0000*/$ZERO_OID/" "$tmp" >"$exp" &&
>  	test_cmp "$exp" "$act" &&
> -	rm "$exp" "$act"
> +	rm "$exp" "$act" "$tmp"
>  }
>  
>  create_gitattributes () {

I only managed to review the changes in t0027.
Out of interest: why do we use a "tmp" file here?
Would it make more sense  to chain the 'tr' with 'sed' and skip the
tmp file ?

 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
	sed -e "s/0000*/$ZERO_OID/"  >"$exp" &&


Yes, we will loose the exit status of 'tr', I think.
How important is the exit status ?

I don't know, hopefully someone with more experience/knowledge
about shell scripting can help me out here.
