Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714B61F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964880AbeFYSYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:24:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44325 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeFYSYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:24:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so2446885pls.11
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OnNRsiMopEa07EGpfefqQAM7HwY7KOQoj/bwRw4rB7I=;
        b=IPwncZyYXckQRfO43Q8Yne90sBd2OgB7BCbHCsaiXt35DFMN/SKYl+AfYtBAuZ7j43
         91tno087a0K6jmpmuUsYOvm75KdzBilxRmBc2BngO8FTD2OK64nMKB5ry1r+VDxfATkf
         twJdw9gO82bNwJO+PLVpLKZ4S2YLoJPYFTzxbnWy9A5WFN/KZgETZH1Kn8m8hGG0gO+I
         isv9vTlFbzvdXUB+nCnSpaXj/UrffiaF/C1b1KdR9CZ9CJffbrGmsBQRm/o6A4zNnqni
         1Vl8904VzhRwsCXPDZEsq/h+Hd3D/bIr3Xx4ZXa8ASXEM4Q3iauGC4UFgZETNT8bJhn4
         UCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnNRsiMopEa07EGpfefqQAM7HwY7KOQoj/bwRw4rB7I=;
        b=UFHEeeFQE245yaYr1PvOSEoBoU3ZDfZJVA7jFF9r94aht9xcXEG7ko6cRPXvaGk+6f
         6DcuDKlgl4FgVgRIC3F7JCvR82kw+/j2jMqXopMutKmcRIPNgV7YQBxMR3wVbmt1WmoO
         zq8JCUoTAyaFVQwLZetsFhXSeKx784tmyzQPfDIx0E/Mi7LgiWcIyiAkJvKyP8ldu8p1
         e6ZgD2AKAR2yAATaJ9hNhvj9IDrt/OldKtoupkStxLyBFrmMNsJ55SqTyOew6H/U/GP8
         hTOOW7530e6opqBNbKUNZnSo7Uk8WnOy8uWdM08FQPUcNqaWcOVX4Tk1qr5iUcsU9USt
         qjJw==
X-Gm-Message-State: APt69E3Xti7GEAYQyCGJcQ/pb+X+KeMSEQzCO7ggENC9d/gZ85ua7av8
        gKwADrVvE3gSOMcL2d4Qlt6hTQ==
X-Google-Smtp-Source: ADUXVKI1OzdLWH9GpluJtqS2S4Jp1xwpKa4mmF34BPJPt2H2L1jbaL5u6RdWTA6EwFPGUNIkEMqVUQ==
X-Received: by 2002:a17:902:a24:: with SMTP id 33-v6mr13513989plo.88.1529951077039;
        Mon, 25 Jun 2018 11:24:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 90-v6sm3776082pfr.75.2018.06.25.11.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:24:35 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:24:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/7] Refactor fetch negotiation into its own API
Message-ID: <20180625182434.GE19910@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <cover.1529016350.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Jonathan Tan wrote:
> Thanks, Brandon and Junio, for your comments.
> 
> Updates since v2:
>  - nothing new in patches 1 and 2
>  - patch 3: now clear priority queue unconditionally once we are done
>    with it (as requested by Brandon in a comment for a later patch)
>  - patch 4: updated commit message to not mention everything_local() (as
>    pointed out by Brandon), updated test to not rely on the fact that
>    fetch-pack uses prefix matching (thanks, Junio, for the observation)
>  - patch 5: used a more descriptive name ("struct negotiation_state")
>    for the struct, instead of "struct data"
>  - squashed patch 8 into patch 7; this means that the comments are not
>    moved verbatim, but for the reviewer, verbatim-ness of comments is
>    probably not that important anyway

Thanks this series looks good now.

Reviewed-by: Brandon Williams <bmwill@google.com>

-- 
Brandon Williams
