Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91DE1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 13:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeJaWcZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 18:32:25 -0400
Received: from mout.web.de ([212.227.15.4]:45391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbeJaWcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 18:32:25 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1WtV-1fOUzH3vKb-00tQtc; Wed, 31
 Oct 2018 14:33:43 +0100
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1WtV-1fOUzH3vKb-00tQtc; Wed, 31
 Oct 2018 14:33:43 +0100
Date:   Wed, 31 Oct 2018 14:33:41 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 3/3] cat-file: handle streaming failures consistently
Message-ID: <20181031133341.GA5070@tor.lan>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232337.GC32038@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030232337.GC32038@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:d8+G5gOSX/SPh4bvQuAoyJQNrjPdZ30BJPw/0+D/x/itUr0PvYv
 KqDtiATFrPQfZOvlrB5tEK+u6bXEDVIMGMDjgyOgAiaWzAB5P+l/7KNINInaufteiSDUOEf
 obrP5OlBcsvcrsi2nU/WSpZyN+Nid/DKyg+lN5YyRYCoQuRr1NCbzKes2tslE71H43VlLun
 1bf12vYWcv5A6RVx008sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yeTdXDPtit0=:egcgepWZcHfMmjDKsVKefM
 WSdcMozEIpPNMss+tDEfcK4tEwuz2OJkS0KfaaXYFS7ohV7CCJknsr0SL7eob0k0FxNT+GCgo
 Xmusi6iq8i3i2PZT4ub+P/aylDhj0HN/K/KxM2pmU/58MnFurA7hANN+xIEM4aZfuzxHgS05V
 OrIJ7RRIJbSXiLTMoSjadsw4HTB2vILKxiTSUY7PF6O2Mx56WO7mwWzJJzCyC4vQEJfzAXCY+
 8dw+NNz7WZ78yLDNkVxyhGEq87htPagLL2zgyF0JJabHAYlcDsL5a1A1zbGLjB5ZUw7RKayTw
 63HGpanChov6Z6YMZFkaOE3mzXK58nhCpbDT+4F1E7tipvVP3AJObFOOH4x4i+VkbboGrzI1P
 R0Iy2f8oMzRkcesHD3z1glK5APin1MZqneHdXU6CO1pXBEevm350dQiPagUUn+KFETFvThWo6
 QcKxdK+7oBlc9GJ2P5Jdcpo39GUfS6pSd+k3/ShH+kHSuVIm4mRyV/XusammYyEQTiyjlGgoA
 3AgCz57dXInEl/8h3YUmWQrBK+nPCGMwVhWSPfeZIXzBO8gXQYVypz657pRtm9MDR69v6x0x7
 OBzneHgFXma/SyAXD1+2rXHHX0k55UYHirkiE2ZiLEzYCMmxuB27mszvTyT4Ga1pGixz56d2o
 FlXcMHWDAxdKElTq7bDPW1nuZsALJP+p4Tay0UcU9sCxZZKWKlwYIVzE3A+ALkAQ0+z/S18P/
 IA5DNFSZO3xnZWrRMO9ZQt0PqWHI6vmFsvAJ655eQCzazYMQTWAditudw5fRhw+NserSIRUds
 0bK1WlAECaZHlp6FYeoYyHPJq8pcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 07:23:38PM -0400, Jeff King wrote:
> There are three ways to convince cat-file to stream a blob:
> 
>   - cat-file -p $blob
> 
>   - cat-file blob $blob
> 
>   - echo $batch | cat-file --batch
> 
> In the first two, we simply exit with the error code of
> streaw_blob_to_fd(). That means that an error will cause us
> to exit with "-1" (which we try to avoid) without printing
> any kind of error message (which is confusing to the user).
> 
> Instead, let's match the third case, which calls die() on an
> error. Unfortunately we cannot be more specific, as
> stream_blob_to_fd() does not tell us whether the problem was
> on reading (e.g., a corrupt object) or on writing (e.g.,
> ENOSPC). That might be an opportunity for future work, but
> for now we will at least exit with a sane message and exit
> code.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 8d97c84725..0d403eb77d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -50,6 +50,13 @@ static int filter_object(const char *path, unsigned mode,
>  	return 0;
>  }
>  
> +static int stream_blob(const struct object_id *oid)

Sorry for nit-picking:
could this be renamed into stream_blob_to_stdout() ?

> +{
> +	if (stream_blob_to_fd(1, oid, NULL, 0))

And I wonder if we could make things clearer:
 s/1/STDOUT_FILENO/
 
 (Stolen from fast-import.c)

> +		die("unable to stream %s to stdout", oid_to_hex(oid));
> +	return 0;
> +}
> +
[]
