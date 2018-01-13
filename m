Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7815C1F404
	for <e@80x24.org>; Sat, 13 Jan 2018 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbeAMS4n (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 13:56:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:56392 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754158AbeAMS4m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 13:56:42 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUHoI-1eR32g1Zr8-00Qz0e; Sat, 13
 Jan 2018 19:56:24 +0100
Date:   Sat, 13 Jan 2018 19:56:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kim Gybels <kgybels@infogroep.be>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] packed_ref_cache: don't use mmap() for small files
In-Reply-To: <20180113161149.9564-1-kgybels@infogroep.be>
Message-ID: <nycvar.QRO.7.76.6.1801131954380.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180113161149.9564-1-kgybels@infogroep.be>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mUj7C5s+8rU02zcvJ2CSDEqYtac/jV8IM06O/GBpIL969+bmWA8
 uTym2dWJyvVLv0geoNi07pAJWKy9N3GDvF5APO07/3Ci/P6URGNwPeejZPnUxh2ig5a5vgn
 iqCXZ+hWhxpC/iYrSLgeDDg0ZCkpDAohEd3efbnBrXOhYtlE7N10QhJmTPyhClo1XLsPnqo
 +jkvnkHh/PLItk6gSVMIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E6458msBrmo=:oVBjzC6GSHRxNd7k01PG97
 o/CI8sRGga7MSh+wzFO/vwtoSdS5KTxOv3gI9NbTULT3SXt4/+YyBU+uQnM4z1Vh+Puhvkmec
 fhKI6tedjIjiolCUMZIzMbwSJrAXEItAAuoYIcgQ6V1g0IWQHjitsnSYvDG9+GCwdGbVnGRqg
 m/uCrl3ZvfCC8JEvSReQz8eq+6ofeVgJqBn7X/31dzn9hCCINwdKaLdow11bMksrpzzlHxcW1
 sxlfiCRH9+Lq9o9IPoNcEZHE49ESg74/lsEY3+/WXpmTzTUEkgLBhhfK7Gl7yVgcQjn5wb2oM
 +YO6FXEa22pFtsm2FeKqlg0IOsUYcRXnwk/wEX82MFszrGI+NLOXLooHM4YFBRt6w5vZ/sZ3G
 rE9I7WR6SI2rjjhLQypbK2FTrmCQF4PuuD0loWXdc5r/ex7ZcEX3AF2wnVCi4OX02B9WOLG1L
 NItZ0+taMbRnoHj07KWIf4cvH7YA1zAucbnm1fmSc14okX19mc6dsJO81LNIr2gd+DfP/xSYR
 UMD6TMfysBLiKVnH/UMtbYOfS6rbS6oKVmw38JBq2I/PFeq6KHnmOUldWHkFc1ybINtlcREUs
 paE0qZEWzLrUPIaKZsk8VAWDtiVrC9hJOTweL9OWLmpd2Ps7WRDbyKlGnBeREDEGdgOVxu0SK
 1mgiwqpaWuqXL57E26y6htSg/JXr8TJ+blj107IhxL0oUmENOn5dSUuhuLgj7/9uprVd1dPKH
 wwMo/yQT6uayS1uorMtgt8533n03FwhPZZl+olJbcilapjwcHoP/6HdyXt65yUyhGUUPF2xKz
 QzOXf5AWX2x43rb2ME9BYuYXPbIqPMOHAF+rOow/EfVaGVU90E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Jan 2018, Kim Gybels wrote:

> Take a hint from commit ea68b0ce9f8ce8da3e360aed3cbd6720159ffbee and use

Maybe use

	ea68b0ce9f8 (hash-object: don't use mmap() for small files,
	2010-02-21)

instead of the full commit name?

> read() instead of mmap() for small packed-refs files.
> 
> This also fixes the problem[1] where xmmap() returns NULL for zero
> length[2], for which munmap() later fails.
> 
> Alternatively, we could simply check for NULL before munmap(), or
> introduce an xmunmap() that could be used together with xmmap().
> 
> [1] https://github.com/git-for-windows/git/issues/1410
> [2] Logic introduced in commit 9130ac1e1966adb9922e64f645730d0d45383495
> 
> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> ---
>  refs/packed-backend.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index dab8a85d9a..7177e5bc2f 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -455,6 +455,8 @@ static void verify_buffer_safe(struct snapshot *snapshot)
>  				 last_line, eof - last_line);
>  }
>  
> +#define SMALL_FILE_SIZE (32*1024)
> +
>  /*
>   * Depending on `mmap_strategy`, either mmap or read the contents of
>   * the `packed-refs` file into the snapshot. Return 1 if the file
> @@ -489,21 +491,21 @@ static int load_contents(struct snapshot *snapshot)
>  		die_errno("couldn't stat %s", snapshot->refs->path);
>  	size = xsize_t(st.st_size);
>  
> -	switch (mmap_strategy) {
> -	case MMAP_NONE:
> +	if (!size) {
> +		snapshot->buf = NULL;
> +		snapshot->eof = NULL;
> +		snapshot->mmapped = 0;
> +	} else if (size <= SMALL_FILE_SIZE || mmap_strategy == MMAP_NONE) {
>  		snapshot->buf = xmalloc(size);
>  		bytes_read = read_in_full(fd, snapshot->buf, size);
>  		if (bytes_read < 0 || bytes_read != size)
>  			die_errno("couldn't read %s", snapshot->refs->path);
>  		snapshot->eof = snapshot->buf + size;
>  		snapshot->mmapped = 0;
> -		break;
> -	case MMAP_TEMPORARY:
> -	case MMAP_OK:
> +	} else {
>  		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
>  		snapshot->eof = snapshot->buf + size;
>  		snapshot->mmapped = 1;
> -		break;
>  	}
>  	close(fd);

Nicely explained, and nicely solved, for a potential extra performance
benefit ;-)

Thank you!
Dscho
