Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA3F1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfIJSXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 14:23:12 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37405 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfIJSXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 14:23:12 -0400
Received: by mail-pg1-f180.google.com with SMTP id c17so2401740pgg.4
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AyvpEJhrIp2Szxo9K1DaNRoNBPlZl5HmS05yNj11KlA=;
        b=PoAHgXchnIU1wELnit3z8BlyahhAjncLk8E91crNhSNSkm/NDzXjcUsZ7WNVIttKra
         3Fuu50gQ3tsI8J2HYovFhehx67cV5w27ayl1hnn65zhJQB7DMyvxV7Cf6/TQ5w/DkOaz
         1auJMkFhRj8Hda4KsXCol3K6rS9T0tV6siWNXuytbUg7pKILA+0G6n5pe+u/42WOyDyr
         QqfwKkcnB0UsFZokG3uryS8Dy+AtSg8SxLdEgtyv0AIWqAIJTA+6EjGTBjzZ9t6qaqW+
         woyIvAyyYpD37IyDm78muvgy5aaVx1KQ5OniWa+TxSiMRjhrFex9mdQ6FxYzB8tvonK9
         hvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AyvpEJhrIp2Szxo9K1DaNRoNBPlZl5HmS05yNj11KlA=;
        b=caaZSteZ5+lZnY+wemUXuqG3VLKT4q6f5B+TGLvz/zcpWhHGeAT6PyeFQPoIcj5/NN
         JnKYVcjMSk0OFsM13D7IcrJ2AE9Gvh8PzCSWC+Gsuhw0KlOIZ/xq2h4dR3uoYGEQod8h
         2IAZ/fZdiPIu+mRPMEjUfrId5vSv3DvRJO5y4mQkNpH437GTKNn5knc9SmXmwnQ1wban
         1pXLvxeTHELIIgRVgimtgcxB+H2eYk1hxY53hVg2uPugWXCHA0bvdRCc441+Wyxf8yNc
         rI43k1buI4ANCk4yM38ObStTMuQRTt/+UZANnQuKHY+mtMai82b9GN1nnDGUUkqIIvfk
         GOWQ==
X-Gm-Message-State: APjAAAXmKhbKtjs3G9ZZCPM6xynBTu3FMznBYsH35xzNdD1BxbX7o7uj
        1KcJiatfMrWqXBDjZ4Hl+dBbLw==
X-Google-Smtp-Source: APXvYqxUxPq+BtWSg46lB7BmvAuc6KS+OOrzmwxWCgOk1xmcPEmhJyzVfiGwLsRQTzrJDrvvOHG5JA==
X-Received: by 2002:a17:90a:26e3:: with SMTP id m90mr905381pje.57.1568139791364;
        Tue, 10 Sep 2019 11:23:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id g18sm19399054pgm.9.2019.09.10.11.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 11:23:10 -0700 (PDT)
Date:   Tue, 10 Sep 2019 11:23:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
Message-ID: <20190910182305.GA11186@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.09.07 10:26, Junio C Hamano wrote:
> * js/trace2-json-schema (2019-07-25) 3 commits
>  . ci: run trace2 schema validation in the CI suite
>  . trace2: add a schema validator for trace2 events
>  . trace2: add a JSON schema for trace2 events
> 
>  The JSON output produced by "trace2" subsystem now has JSON schema
>  defined on it, to allow us validate the output and catch deviation.
> 
>  The CI integration may be a bit too heavy-handed.

You can drop this one, I am not planning on any further iterations of
this series.
