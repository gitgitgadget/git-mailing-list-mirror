Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24BC1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeHXAmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:42:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42208 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeHXAmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:42:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so120665plq.9
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6SXH+JsmT/LmPoeswGNWOf7WF4vTmaZLAqyp2NzbeL8=;
        b=Kp1wWpG2+A1NN3V+R0SviPN4Xsh0Djp0+zZ0ikP3J69dmlquE/NL3yYpJJ2NOGcxK0
         LJQllJSah7Ekqc1AJwY8q6H3AQNY8d/JPVvQgYRoIUFxZc70ex8QDPmkvtxzfHGxRkpA
         YFJhJ+QqJacstR09eTUvSwTd/OXD3OGuKjgAJsgPR0o29vC7ji0PGltCEniAEecaQOfx
         K+u0yggarefNLEsT8utDVHx6SHUSaGGkmtJf+NQ+wtGfE966x+J8LZyo+POYAyhU9Oxs
         cR+vWDh6ghYLYzvIa3fWrvO6C819buRnT+PbIgJHPwXG1d6+sF+uuROIWsCJFvnfZ9p1
         nJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6SXH+JsmT/LmPoeswGNWOf7WF4vTmaZLAqyp2NzbeL8=;
        b=ZDbx9OPz4FXunm1fMRrBZTxPIasUkkwj01DfCe6a9JAkNJxBUt3cM4U77BCNfpE6Ic
         gbxDqZSmcKxPR5MFj6uUoYPSZUAzTDH5wmGAe0G9VcxGUsv6c7G+xfY+x5yfKXiab1e2
         vr+Tq2qyjEwvPr/DELMMEOgMdaYo4/EsNqyZUnYzgKCh5dQ0fNNupfue+l6tpqVcvyZR
         7iCdL3LovF5E0l4qQTuZ2Z5ycExSnD/Uj17zXZnOCVleiDQWKjgTopBklAsWTjXZSWSy
         u8f1Tc0RLYYED8g507Z0Q62hAqqKwKXCiR/xsa+szqAAjHZeVubiQqJ+N8nrKyH7LAk6
         7rEg==
X-Gm-Message-State: AOUpUlFsSjIHbNI4Lo+3QjsR343xfo2dFn1MVo9dL1+1VneDc3x05RUj
        U/KS9ITkh96HvE3DoIbXEsa9onl7
X-Google-Smtp-Source: AA+uWPzu6w3aFV/LhkRD/jO+4R1ntTc7l1ZEp6qNc2SHH+1ykmS1OtD4v72ZtD4m1Fk5p8XHAe4LNQ==
X-Received: by 2002:a17:902:6907:: with SMTP id j7-v6mr60116857plk.323.1535058630395;
        Thu, 23 Aug 2018 14:10:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l84-v6sm11306353pfg.3.2018.08.23.14.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 14:10:29 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:10:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823211028.GA99542@aiede.svl.corp.google.com>
References: <20180823082725.GB160081@aiede.svl.corp.google.com>
 <20180823120026.32127-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823120026.32127-1-kyle@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer wrote:

>  		OPT_BOOL(0, "no-dual-color", &simple_color,
> -			    N_("color both diff and diff-between-diffs")),
> +			    N_("color only based on the diff-between-diffs")),

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Dscho's suggestion "use simple diff colors" also sounds fine to me
(probably even better).

Thanks,
Jonathan
