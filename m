Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D10B2018E
	for <e@80x24.org>; Sun,  7 Aug 2016 09:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcHGJYx (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 05:24:53 -0400
Received: from mout.web.de ([212.227.15.4]:62331 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcHGJYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 05:24:52 -0400
Received: from [192.168.178.36] ([79.213.122.23]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M25Bz-1bGRAF2Kpn-00u4qu; Sun, 07 Aug 2016 11:24:44
 +0200
Subject: Re: Rename detection within in files WAS: [PATCH 2/6] t7408: merge
 short tests, factor out testing method
To:	Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <20160804195159.7788-1-sbeller@google.com>
 <20160805232643.23837-1-sbeller@google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57A6FE5A.9050803@web.de>
Date:	Sun, 7 Aug 2016 11:24:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160805232643.23837-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gYR/fRpvynci/kVjzvNXA2WWu6hxIk1mzs88+/O8vO/oz2bUlEM
 7wHK98TU05Lr7GamWkSo2Ov7O92wg/5pJPkt4Hl+n7GJng/RmfM+RCKscbi0924/IcUYQuW
 a8bVyp2tdnIGJEteViM1MJI7zya+P8AtGhM3gDcE5Z58elm5AQtTS/r5bLIixfWa39MeuAR
 Tt6njQeYKS2V3COBqgTgA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:69RyaTgMcpE=:v70DbQAQ4AXK7TO/z3gjYc
 xxcLyyUVLCn1KFFl7vvmLf/U+LS+nqHPryCpRi/35CyFQ0W8mALzvC+SCw/DycqqOmEG3S5ur
 YHV0x+rFwAbgl9ymRdKm+gzYyJN9haykiGLcHkZjOyjK0d553teIU4ZekrmmReKN86kxr08ln
 QQvOVtroADTI561mcdRoDFMVvEwVEr6GnWeHTJKXACflS5rwQ6o6Xcll4+C/298GpBydpv4XN
 GU1DyOkN+ert+tHHx4SI0WJ/6dt9jisxwkvV3oM9HFSQ6ki1wcKkiuDHAIl+jXkE/s7Fh5FRM
 afX/OUQb5JaLiXTskhEN3esrZAy/vqXol6ZlJxZ2hrgqaj/CavERE7q8uYxEodcso6i4Uv5mi
 4cHDxqnfqlgFUHe99WAjWB0MqzqNm/h5pFQbDwBuHndsvSl4gVk8fbBJhCsYJtVp2KFs9UFiZ
 78QKZhZ05O/9vn6y3U5xPOqi1IxPorN4HWJMcjasYCHtWhFfuB8Z1oNbjrx7kiFy6seUlV8Qh
 HFQNNtEoYQEHycloIqrtPtpxOzy8F+TycVP82E3c4CHemGjDYwCs8+t8jZTadml3bzXPPh1g1
 TDVxQ37ReVoC2ynLgV2x/pHdguUX61KCwk8+2KZB53Hm4MzoycGf9ktxpnhNMgabzvOZGaO4b
 lV6mHtNtzbpK92Q17bjEtyPte5KB20Yl+k6EhNHdqqWzZqJPwGhXotMVzNhfcikNtekMiV7im
 VhrmOkCnMlLxOPM3wRjysF6AmWsAc2+g+giYLe5zf04Vgyv9U/1CuLur2kaZ7nlDcA1022Bcc
 rOFogc6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 06.08.2016 um 01:26 schrieb Stefan Beller:
> When moving code around, we usually get large chunks of text. If the contributor
> is not 100% trustworthy, we need to review all the code without much intelectual
> joy. Essentially the reviewer is just making sure the parts of the text are the
> same.
>
> I'd like to propose a new addition to the diff format that makes this use case
> easier. The idea is to mark up lines that were just moved around in the file
> instead of adding and removing them.
>
> Currently we have 3 characters that
> are allowed to start a line within a hunk:
> ' ' to indicate context
> '+' to add a line
> '-' to remove a line
>
> I'd propose to add the following characters:
> '*' which is the same as '+', but it indicates that the line was moved
>      from somewhere else without change.
> 'X' The same as '-', with the addition that this line was moved to a different
>      place without change.
>
> The patch below uses these new '*' and 'X'. Each hunk that makes use of these
> additions, is followed other sections, [moved-from, moved-to] that indicate
> where the corresponding line is.

Interesting idea. It should be easy to convert the result into a regular 
unified diff for consumption with patch(1) or git am/apply by replacing 
the new flags with + and - and removing the moved-* hunks.

Your example ignores whitespace changes at the start of the line and 
within it, the added "-C $working_dir", s/expected/expect/; is this all 
intended?  Only a single blank line was moved verbatim.

The moved-from and moved-to hunks make this diff quite verbose.

If multiple lines from different sources are moved to the same hunk then 
you'd get multiple moved-from hunks following that single destination, 
right?  (Same with lines moved from a single hunk to multiple 
destinations and moved-to.)

But does it even warrent a new format? It's a display problem; the 
necessary information is already in the diffs we have today.  A 
graphical diff viewer could connect moved blocks with lines, like 
http://www.araxis.com/merge/ does in its side-by-side view.  A 
Thunderbird extension (or a bookmarklet or browser extendiion for 
webmail users) could do that for an email-based workflow.

Still, what about adding information about moved lines as an extended 
header (like that index line)?  Line numbers are included in hunk 
headers and can serve as orientation.  A reader would have to do some 
mental arithmetic (ugh), but incompatible format changes would be 
avoided.  For your example it should look something like this:

	move from t/t7408-submodule-reference.sh:52,1
	move to t/t7408-submodule-reference.sh:22,1

>
> There are multiple things to tackle when going for such an addition:
> * How to present this to the user (it's covered in this email)
> * how to find the renamed lines algorithmically.
>    (there are already approaches to that, e.g. https://github.com/stefanbeller/duplo
>    which is http://duplo.sourceforge.net/ with no substantial additions)
>
> Any comments welcome,
>
> Thanks,
> Stefan
>
> ---
>   t/t7408-submodule-reference.sh | 50 +++++++++++++++---------------------------
>   1 file changed, 15 insertions(+), 29 deletions(-), 6 moved lines
>
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index afcc629..1416cbd 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -10,6 +10,16 @@ base_dir=$(pwd)
>
>   U=$base_dir/UPLOAD_LOG
>
> +test_alternate_usage()
> +{
> +	alternates_file=$1
> +	working_dir=$2
> +	test_line_count = 1 $alternates_file &&
> *	echo "0 objects, 0 kilobytes" >expect &&
> *	git -C $working_dir count-objects >current &&
> *	diff expect current
> +}
> +

Post-image line 22.

>   test_expect_success 'preparing first repository' '
>   	test_create_repo A &&
>   	(
> @@ move-source 42,6 @@ test_expect_success 'that reference gets used with add' '
>   test_expect_success 'that reference gets used with add' '
>   	(
>   		cd super/sub &&
> X		echo "0 objects, 0 kilobytes" > expected &&
> X		git count-objects > current &&
> X		diff expected current
>   	)
>   '
> @@ -42,44 +52,20 @@ test_expect_success 'preparing superproject' '
>   	)
>   '
>
> -test_expect_success 'submodule add --reference' '
> +test_expect_success 'submodule add --reference uses alternates' '
>   	(
>   		cd super &&
>   		git submodule add --reference ../B "file://$base_dir/A" sub &&
>   		git commit -m B-super-added
> -	)
> -'
> -

Pre-image line 52.

> -test_expect_success 'after add: existence of info/alternates' '
> -	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
> -'
> -
> -test_expect_success 'that reference gets used with add' '
> -	(
> -		cd super/sub &&
> X		echo "0 objects, 0 kilobytes" > expected &&
> X		git count-objects > current &&
> X		diff expected current
> -	)
> -'
> -
> -test_expect_success 'cloning superproject' '
> -	git clone super super-clone
> -'
> -
> @@ move-to 10,6 @@ test_alternate_usage
> +	alternates_file=$1
> +	working_dir=$2
> +	test_line_count = 1 $alternates_file &&
> *	echo "0 objects, 0 kilobytes" >expect &&
> *	git -C $working_dir count-objects >current &&
> *	diff expect current
> +}
> +
> --
> 2.9.2.572.g9d9644e.dirty
>

