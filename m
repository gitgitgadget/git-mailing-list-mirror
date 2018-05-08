Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB8D200B9
	for <e@80x24.org>; Tue,  8 May 2018 04:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEHEEI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 00:04:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36790 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeEHEEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 00:04:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id p4-v6so463201wrh.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qJEKVENJiu7x5WdeH0utHzyYqcwXunk5IILYXTCTaww=;
        b=RrwcR6xKXwbVjt1558KDYU0oVgPZcrUaF/a9RiR0GcnIVwYGkmUTVN1APH+Af9Kbwz
         komGN/6QVC2/njCWMF4GmBGb9Env/w2AYi6kydZoo+wntioUUhkcE9Wfh8bI5cab5zFS
         QPhAHABzY6Y8oE00NDxYnZL7AvodJ9b5X1PnBiXpi6vn0JBUUz09IiOI/fw1zq1ZPJIi
         zebRXqSAFrEdx5Mq/yFw94zeXVAL3TgtwqUymGuedjtGm0W8d1XGp5Beoq4shWFRdy1T
         8YP3gMXZFpkUXJiGCARa4EyJxwSYtqHBr0u7hDmqN4oeof5jg1oSmu0qsp1AD3gMBASX
         qkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qJEKVENJiu7x5WdeH0utHzyYqcwXunk5IILYXTCTaww=;
        b=mzyr+5VbvgxSIEoXxKZoThWQ/gVRP+snchfBJdxo/zWKvkF365aMiml1O9MEkyEExI
         Y0Jv9CDcvbt5l4vLZsG3ETV3A0RKhlhkMSrmw7gqMMhuNwaaFyqJvWKzg7sniyTbQ4sp
         y+Yt9XGLVGRcqlFYKXSjmQbFDo2rjzN4lZHWbYqa2Fho5alpJ1boV58FSEKxluIs2LeS
         Zs669jJN6xqs7lEtjzZ9fmBeLGQzcp/gYAWPdOf2ChCwL/SnJuLBqtuR93VjdXqbrSIU
         TBrbp6XoEnOngKurwHc8FbObAQjkvtqPAcl1aY+SzNAyPR4M+wZ3of6Qd3F9NadjvkPk
         W0AA==
X-Gm-Message-State: ALQs6tAyCT3xgno5V+blI+6+QdALIEoxJ+IR7Oa4Fpvc+9K1wkUF0VTD
        7BgCPewtOcXVe4A2Clk7ECo=
X-Google-Smtp-Source: AB8JxZoPkqQ3ea6tjYn+SuMEKUJYTLulKADGwBZi3OvU12riF+wfshXUsRkhDmrZICBX6QDmwt8Hrw==
X-Received: by 2002:adf:a075:: with SMTP id l50-v6mr34302704wrl.227.1525752246514;
        Mon, 07 May 2018 21:04:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b57-v6sm38164157wra.9.2018.05.07.21.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 21:04:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v6 10/13] help: use command-list.txt for the source of guides
References: <20180429181844.21325-1-pclouds@gmail.com>
        <20180507175222.12114-1-pclouds@gmail.com>
        <20180507175222.12114-11-pclouds@gmail.com>
Date:   Tue, 08 May 2018 13:04:05 +0900
In-Reply-To: <20180507175222.12114-11-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 7 May 2018 19:52:19 +0200")
Message-ID: <xmqqa7tan68a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The help command currently hard codes the list of guides and their
> summary in C. Let's move this list to command-list.txt. This lets us
> extract summary lines from Documentation/git*.txt. This also
> potentially lets us list guides in git.txt, but I'll leave that for
> now.
> ---

Nice.

Missing sign-off.

