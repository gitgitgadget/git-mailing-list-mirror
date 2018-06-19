Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A041F403
	for <e@80x24.org>; Tue, 19 Jun 2018 23:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbeFSXQs (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 19:16:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35746 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFSXQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 19:16:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id i7-v6so212225pgp.2
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eQZarPEYl+4t7mQp6xkhq81ulxvNZBMkcghqd5bVwSM=;
        b=SKuLKbFf4EjWMppRavXwzsOv+obcFvk3PrmtN8BCbpOnH27ymxCTJlnpIRu74ybf9T
         nDaR6wrg9JEmsNyD5/tuVgZMe22LmyOmQccQEER4JhhM5Dx6FYJW/BsJbXPCpw2RZWtu
         kLs21hB9VTAHK1RSJtwNT8gm6K6ADDUsfARKMwjnsPzEtVdTIEurGHRKeuQljtWuJlu9
         bl8+fx6I1TgUm8qa4V+aZ1/VFaF71kzrWmKrb4GoVJW7oDt7T6T9Tmg4ZlzMu/UhQb/o
         i6CP59ADz9TFwqginEb6YrJuRx99UYPiTfmNNr81fAPn1U4ucXaNnqMdULcVh6UgObWy
         Zwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eQZarPEYl+4t7mQp6xkhq81ulxvNZBMkcghqd5bVwSM=;
        b=HDBTNrJZ/mLdI/i/R0jLZDwEDKkZ6slZQ/4E7fqGLRZblPLmADxIsiAgZRonHhNeYY
         uMkqRsd8GNHRTvYEWdoVzX1ayjoYGXgOAZpY0hxkpSx04/hiTdZTBZi9RauVNUniSlSf
         CrSsPfdvP+mIFZy3NI+RbJN7CanWECwNyPpo+tqNm+4oTnzcLTCAAWqS9Q9VViOJtTGd
         rwStxcPIP/1YqwPUuWXFRPBLbPkmr3REDrjriOKUmlxe722QGmku8qbTdxLg4qLR/hK6
         u8N8n50XaUmncvFRsoDj2gdJAgt8xLrgEqX9s5dnKEWU9x7whstTCSjnIRp16vHZQMrk
         tZaw==
X-Gm-Message-State: APt69E2oP7qGEbDSltJB9ND8jpqdF+1bWyP4I2OF59M3Eu3Br3fctyW3
        3DwkXxXwMvmFJEVWvTFxn0b1PQ==
X-Google-Smtp-Source: ADUXVKIVMMePxSpnu8tWt1DtvPOSJ0mpGeBgRYWTRX+DQUw+fIg9DbPVI6LtFTpMDMAHap8wiMC6kQ==
X-Received: by 2002:a63:5fc4:: with SMTP id t187-v6mr16085144pgb.183.1529450206369;
        Tue, 19 Jun 2018 16:16:46 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a25-v6sm836720pff.8.2018.06.19.16.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 16:16:45 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:16:44 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] ref-in-want
Message-ID: <20180619231644.GB232723@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180615190458.147775-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615190458.147775-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Jonathan Tan wrote:
> 
> Supporting patterns would mean that we would possibly be able to
> eliminate the ls-refs step, thus saving at least a RTT. (Originally I
> thought that supporting patterns would also allow us to tolerate refs
> being removed during the fetch process, but I see that this is already
> handled by the server ignoring "want-ref <ref>" wherein <ref> doesn't
> exist on the server.)

What's your opinion on this?  Should we keep it how it is in v2 of the
series where the server ignores refs it doesn't know about or revert to
what v1 of the series did and have it be a hard error?

I've gone back and forth on what I think we should do so I'd like to
hear at least one more opinion :)

-- 
Brandon Williams
