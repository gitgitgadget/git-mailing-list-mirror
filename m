Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AF61F597
	for <e@80x24.org>; Fri,  3 Aug 2018 03:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeHCFYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 01:24:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42172 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeHCFYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 01:24:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so1932868plo.9
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 20:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+x5wIL/XHaDjnY78cZzmc0GPohUCOsOcklDyOGH69YM=;
        b=Qgvt/lggKN3ctmUu3QumXI9q7ITQbrHYxUHeC3DxhfeduP+Nph4RNB1zTyexFiYNXf
         +9owTsnNYYoQS+RoDuDJrOXPeImcx37HbWDgeV8xcuDhdf4St3Wl3Tc3UM8pJZnv6WxX
         wxVHiFICHPeqDSqXMrnXh1jcapDjjkFMT9M1w0knn3uPNDEWk2Of/eSwChOx12cPZUxg
         /vGfLuBs9w2FqjDTjtQwXLrlosRP5tti5pDxYySCGS83XV3s5FO8FEusjTx6IUmyzAlz
         +TfuRd6d7QIJk5ORJd/h5tb6t6ZNqnn7pAg37nzHUlSqOs4w1OveijIEHMpMaWAUfks1
         HmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+x5wIL/XHaDjnY78cZzmc0GPohUCOsOcklDyOGH69YM=;
        b=gqfK9uM99tD85QLxGzp989ff6n86uqMzQbniGM3aACH25XfUtwbVgSGvpNWvW2O1K/
         Llh2qbJEXovsxJSHAv3xrkjuBPS2WLkjzHEVUhEFyags/kf8FAyaPHFnhztnUCchJP3+
         SpxjiSx+lEsn2PycOdVe2B8QU4fRCtBX4+flFyEQNxdqNBT5CFZ0+9hDf4nWKAuqtlGU
         I4ywBkKIiPlPt+PUB1hKBrIggFbQUdLUyE19tzarGriQJUESm21ZdalbKlao6xLtmhG0
         w9HdPvht5qj3ioWJemaiEls5h8jj0kNUKfg4czlkawVtEOIqgjpi5rqQekz9VYjEs/S/
         iuhg==
X-Gm-Message-State: AOUpUlFvfri77C1ToaK2rJ7k/9Fb7EHmexiwBdpwXDXg96n0nAEgb4uz
        9hZ0j8gMcGRdo/Pw1Da7Rpi/JlcN
X-Google-Smtp-Source: AAOMgpeeRqzCcXwUdvhpug7g3yYf1mh0dC1Zc0OpIP+AG27IbCIwHGE+9CuZHPA0hXsvvetqG8JuJw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1-v6mr1898067plo.81.1533266990567;
        Thu, 02 Aug 2018 20:29:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i26-v6sm4597512pfo.107.2018.08.02.20.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 20:29:49 -0700 (PDT)
Date:   Thu, 2 Aug 2018 20:29:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     gitster@pobox.com, sunshine@sunshineco.com, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config: document git config getter return value.
Message-ID: <20180803032948.GG197924@aiede.svl.corp.google.com>
References: <20180802121308.17371-1-hanwen@google.com>
 <20180802121308.17371-2-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802121308.17371-2-hanwen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing peff, config whiz)
Hi,

Han-Wen Nienhuys wrote:

> Subject: config: document git config getter return value.

micronit: no period at the end of subject line

> ---
>  config.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

May we forge your sign-off?  See Documentation/SubmittingPatches section
[[sign-off]] for what this means.

> 
> diff --git a/config.h b/config.h
> index b95bb7649..41700f40b 100644
> --- a/config.h
> +++ b/config.h
> @@ -178,10 +178,16 @@ struct config_set {
>  };
>  
>  extern void git_configset_init(struct config_set *cs);
> -extern int git_configset_add_file(struct config_set *cs, const char *filename);
> -extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
> +

nit: this blank line feels out of place (though I don't particularly
mind it and wouldn't reroll just for that)

>  extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
>  extern void git_configset_clear(struct config_set *cs);
> +
> +/*
> + * These functions return 1 if not found, and 0 if found, leaving the found
> + * value in the 'dest' pointer.
> + */
> +extern int git_configset_add_file(struct config_set *cs, const char *filename);

This function doesn't take a 'dest' argument.  Is the comment meant to
apply to it?  If not, can the comment go below it?

> +extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
>  extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
>  extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);

With a sign-off and whatever subset of the above suggestions makes sense
to you,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
