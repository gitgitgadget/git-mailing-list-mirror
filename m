Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38B11F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeGSTth (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:49:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeGSTth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:49:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so9090084wrt.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uzClSJgqQObSfutdjFdxWMaOqtqV1dAa5GDfnZl9vVs=;
        b=dEOCBmsd4BJZMydnltIfsnUFMjw/2Z6nuXNbVdONCMhWyL92HZyIe4WteAPzJxSrl1
         4SyxLzACu2jMwoUERvkgGhKGP/5crn5npgirKLbkvmL9Aea/WFBogP/ZOwaqGBJGzOk4
         GRhQ4mlQo75Rgpd2OUr+m+R5XDB4z5ob+S4HQMKdKWxPN5Ieb/BzNsrAQ8R4QT7F1dHJ
         o3ur0UtWCmRQY9fr2TSygaQV21VhKDlf2aJdi2ps42LRP2U2BJ/vBt+Mj4+y9TEBrR8X
         AGrJAdaFhJ/Rq+sccYi9Ik4jbNZiMuV0PJgeRFegVqlM0BZ/8Wsz5zf7FKtqCfK3I31P
         CxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uzClSJgqQObSfutdjFdxWMaOqtqV1dAa5GDfnZl9vVs=;
        b=HKnIYtK16Fpr86oYFdxk/7h+a2gbR/PT6W0ziKEhQoLwlgqtTFUpqm/r27zMuk8o1z
         cOlsE7B3Jddz+z55r2k+R3bIUMSxcKIjpTZjJsPtAgAF1MQsvm8Oaua69ul3TKaM5DfS
         qpnW6A/4J5YbhW48igl7EBNTQmu6DXgGjB4A6ZHlsUzENu78NjwywYeYWCE3UrgtLEPf
         CUrnYsUXAdeKhEgba7UfdwKSJR+DDoFsQK4mOu+sStstZZuekHUShPt3PYGzTK9a77I8
         WI84X6q3GLT3ClW9lFIY7YeuNElR/jUlEdr02GfpiEdYjP1Sj9oY/IdQBvi1Ulod2k2v
         cXgw==
X-Gm-Message-State: AOUpUlF9SrDylDntt6/30UmXV9Fvih7URIJUY2eNyYIu/fLGnF1iClRQ
        2pqWKyU8AKillrBslZAoaBo=
X-Google-Smtp-Source: AAOMgpcx2VabEd4TL9WkzacA5GmPUoqEKe0ctl1KwVfCFSzz9GoO6auRO0F+bTmjrcSukh9HYFBpJg==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr8298322wru.64.1532027106479;
        Thu, 19 Jul 2018 12:05:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p184-v6sm173482wmp.43.2018.07.19.12.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:05:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com
Subject: Re: [PATCHv6 00/10] Reroll of sb/diff-color-move-more
References: <20180718193156.47365-1-sbeller@google.com>
Date:   Thu, 19 Jul 2018 12:05:05 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 18 Jul 2018 12:31:46 -0700")
Message-ID: <xmqqwotrdp26.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> v6:
> * fixed issues hinted at by Andrei, thanks! (range-diff below)
> * incorporates the new config option, sent separately previously.

Let's declare victory and move to incremental by merging to 'next',
if nobody spots anything more serious than just a missing SP around
comparison operator.
