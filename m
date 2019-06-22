Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F731F461
	for <e@80x24.org>; Sat, 22 Jun 2019 00:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFVAhT (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 20:37:19 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:52406 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFVAhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 20:37:19 -0400
Received: by mail-vs1-f73.google.com with SMTP id b70so2872771vsd.19
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WC5AjSnGondhr1SnLEBb23071u6fJ7iny4XGBcoB1Po=;
        b=FJFr5IAg8xo4VE/STSI6PTjxmfh2/NMc2/DLumvjuZi7FSfrmvcKcgpSTuSq9cWhzX
         TtmrI2II4siHBIdPMK4Ms6gCLDXXRvcdWwFdQBXDqvyMeGjGIYqNSj1RR2DT1PUWMNbu
         y2lZ50Tj/D/mivw2AoAWyxBngsPd49YJMGEr/A5TNwLspSzDk2jIdLBVLSkNUWeZTFwf
         3/okT6/62h7m6sfkdCvogIrf1dCvbxCTXUi5ZCjPRwI5mRhHCBiJkLlr8z4tFRshf/b0
         d+eQsPvIJAc5uulkUs0PDJaZIFFfihVlQs/DnjNiVbBEDCBY0rdhgdE3Yzp+Z3KBjJ7l
         YGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WC5AjSnGondhr1SnLEBb23071u6fJ7iny4XGBcoB1Po=;
        b=Ai8pPhnhMxm/EutVRnmwNLFGHs7diQIipq592JKt9yt6Ztj0AfisZTQ0Wg1Z17cGWo
         5vCkjS15/MRp1vTcAs9fbUkzxknx08CRPwEqkZAh06+iLl2nhyGtGmkusV0BKJ61kTbb
         Zkfqk1R0+We7NDT4rO+T+g49Pl1n1UT39+UI1E8rhKOWqnD52OvcMDoESWSR5YNPWyg5
         15kfXPhyIfVN7ZnGPTa9QHGekERl4j1kCaWNGLa2EYSVcMf2Z4c9M/92fvdi2QG+jFA0
         uBScuO8MxtmO6N/1xLeedJDvQZ/dHsYVPxcEuP344tWkQg0qSt0KdVeM3fcRk56GlTGc
         cR7w==
X-Gm-Message-State: APjAAAXXrTaybo8nvNFefgUOnxHX32Cpo9atvla/MaWvXz7ombEc5/N/
        igFyl64aqhGYVcMggC0pGCDRjo7RovHe8W2zjTL2
X-Google-Smtp-Source: APXvYqxe7cefnPqCwbkCW+bz9lHK8U2zmKZR8vpAwTaYwtStd+bzn/RCzFU5q/84vlTP3LvvrmbPFScn4FqGpW4YAq++
X-Received: by 2002:a1f:3692:: with SMTP id d140mr10813469vka.88.1561163838237;
 Fri, 21 Jun 2019 17:37:18 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:37:13 -0700
In-Reply-To: <1a95dd91927973038c3d59bc3215556e448f0e63.1560558910.git.matvore@google.com>
Message-Id: <20190622003713.248581-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <1a95dd91927973038c3d59bc3215556e448f0e63.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH v4 06/10] list-objects-filter-options: make filter_spec a string_list
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 5 and this patch look good to me.

> @@ -1134,27 +1134,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>  
>  	if (option_upload_pack)
>  		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
>  				     option_upload_pack);
>  
>  	if (server_options.nr)
>  		transport->server_options = &server_options;
>  
>  	if (filter_options.choice) {
> -		struct strbuf expanded_filter_spec = STRBUF_INIT;
> -		expand_list_objects_filter_spec(&filter_options,
> -						&expanded_filter_spec);
> +		const char *spec =
> +			expand_list_objects_filter_spec(&filter_options);
>  		transport_set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
> -				     expanded_filter_spec.buf);
> +				     spec);
>  		transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
> -		strbuf_release(&expanded_filter_spec);

So expand_list_objects_filter_spec() now returns a filter_options-owned
string (instead of previously writing to a strbuf), which is why we no
longer need to do any freeing or releasing. That makes sense. (Same for
the other call sites.)

> @@ -177,72 +177,89 @@ static int parse_combine_filter(
>  	}
>  	return result;
>  }
>  
>  int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
>  			      const char *arg)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	if (filter_options->choice)
>  		die(_("multiple filter-specs cannot be combined"));
> -	filter_options->filter_spec = strdup(arg);
> +	string_list_append(&filter_options->filter_spec, xstrdup(arg));

This append needs to be called with xstrdup, because a zero-initialized
string list is NODUP. OK.
