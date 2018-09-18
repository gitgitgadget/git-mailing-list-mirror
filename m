Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C18A1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbeIRWai (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 18:30:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35835 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbeIRWah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:37 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so3951743itf.0
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d9My+NMrzylGKnezko3XoG+WaPO5Yvf+sh0janzqBFE=;
        b=n/SG59tWZ1At+8vx3ftASDon9m6sW1BfcI6na+s2QlfTOFYxO+aGNNyqkOmt6fnRcx
         vkmDj0hYd6z8Fx/Z4gAMkUHZozY6vYaMYrwygAAHwT18xFzXHJTTdwHS62WJbyzAEw0y
         TzNcNb+aMdi/2/jZstS1FNiUn9DBOzwrsEinOQ6yY8XSTZPuEJBJGzorhnytxi+K9+5h
         RaJ/6ZHyvHfPPTko8RRG8mJz5l7R82SUxJRE1vSQYrK9xDuJuiW0EIvL6P9tMIMVhD7b
         LiFhRCmK/Pbzn1LLBCMylb3FBXpEjwD3TdAcoe6/f0xvr0VAkwrV8MVerVuvfaw48k5V
         CxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d9My+NMrzylGKnezko3XoG+WaPO5Yvf+sh0janzqBFE=;
        b=IlTtIyqUH+anBIugOiFRSSSHSx42tvVjkTA0i3qWNOLMKYUN/3fIffodaJnN5k/0XW
         PSUgp5/c9U+vkz6jIrGfGgW2AkR2TPxV+184zAcwxTN25syQZqnrvnbGA0cSZM0mE6mO
         QkLm8taU0isN61DUL7uQT4MhPD/oYJ95Fc+vGCuZz7wwoLZ3obzW5yZY5afij9F675cG
         wKKEutgxgfUpaiL7IojggbOTMAPvby4Aj82hE394rtk1hW+mGW5wXJWxU5WjkQ6jdNpC
         E4V+MD8LDNkmXTqcx6A3aC6keYnjiSdG+dCxzbmkLTVDz3qQOVof/u3eeW1Ii4d+2t4L
         qrMw==
X-Gm-Message-State: APzg51BRof2EvTIkwgltt34m80uBSuOJ1u3ReSIWI+A3/le94EUmAflr
        lLGektDQbpv1n7B4ccpBGL9i1g==
X-Google-Smtp-Source: ANB0VdYsFoXH+Eo8kIf+KNhL9bIW2Nq2CE/gyCMiZW9had+ig5u+wez+cwlilns9RK2N/87EC44HDA==
X-Received: by 2002:a02:5fcc:: with SMTP id x73-v6mr28689775jad.96.1537289829811;
        Tue, 18 Sep 2018 09:57:09 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id z26-v6sm6101286ioc.41.2018.09.18.09.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:57:08 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 18 Sep 2018 12:57:07 -0400
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config doc: add missing list separator for
 checkout.optimizeNewBranch
Message-ID: <20180918165707.GC72102@syl>
References: <20180816182653.15580-1-benpeart@microsoft.com>
 <20180918053449.14047-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180918053449.14047-1-avarab@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Sep 18, 2018 at 05:34:49AM +0000, Ævar Arnfjörð Bjarmason wrote:
> The documentation added in fa655d8411 ("checkout: optimize "git
> checkout -b <new_branch>"", 2018-08-16) didn't add the double-colon
> needed for the labeled list separator, as a result the added
> documentation all got squashed into one paragraph. Fix that by adding
> the list separator.

Looks good. Here's my:

  Signed-off-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
