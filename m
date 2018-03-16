Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0FF1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbeCPAyb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 20:54:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43110 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeCPAya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 20:54:30 -0400
Received: by mail-wr0-f194.google.com with SMTP id o1so10059746wro.10
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CcjJNAFn/HuUaS8VTl9NI/80KwagmQx5/VZWm4fEf9I=;
        b=TphANJpX00M8ziRn1wLiuxV4mYS2iS9+r/IZngefd8P9k7Og/xNVHlpxNkuReU2jE9
         vUMs5jth/zwTvG7/2iBoISeYZQ6mFHK16AXkqR18VagExK6ZSPCVkQjM3yAa2z+Fk54r
         xScMMhuCfDtV69MK+Aqu/kEBF21bQ2cRI8cT9LPhs7MAT45WRn97DxC5r+shBg3lA8GF
         qNsHr7/iRP+LrX7IQDSNPFU9ZAET3can9FhiAkdbs350nudf1/XT+MNNz90zvRgjQXt9
         bDjS1fk5GcDOnTwcX6axT1xFtwgROVxJJeo/QAuoAVDYbHs294P8J8mobhXA+wboF32M
         wKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CcjJNAFn/HuUaS8VTl9NI/80KwagmQx5/VZWm4fEf9I=;
        b=Mjc/LHCxRu8mZk296SsabawU5BJ9yHbM1vH+eIRIcv4ciwV6opDi6E8bm6jiURyjc/
         TkSMuHLF2JV1aomPm2wlxxsJP2whzUNxrRjWN7M1Rz2+dV99uklrjxlnZLa/qoWw3lfm
         hbssUl06NNNeXdz6Ha5+0c0LwJeGecJD7a06O9FYfM9znIEIAtb/o7QCg12SlpmvIJYD
         SioJonCF4amgXlumYpvIi4TAHkqVyBvoumEUF+9QhP/HIv/PGqYFgMbKVKMDHui0v91S
         7eTTblxSQjM/MAh07EXq4ZxvFbHVUzB+5MYweLFR74BKeUYjPyIhPmjrobz9YJP+8ce1
         iuIA==
X-Gm-Message-State: AElRT7FMxZxdoKhD7Pxjd39azPQP/tNoTQwbHtJ+WPbx/POWb2yBlADQ
        FVIGhBW8hKPMNySpp7+ZhjOJSa7X
X-Google-Smtp-Source: AG47ELvnIhkQdxMvBb4Re11LLLqWoEMhNDmOFziNQSog/ZR4SnNGu68oXuYAeVIppdtTISmoVVxpDA==
X-Received: by 10.223.154.181 with SMTP id a50mr8542333wrc.180.1521161668572;
        Thu, 15 Mar 2018 17:54:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o47sm7732613wrc.7.2018.03.15.17.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 17:54:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
        <7D05D553-D914-402F-8AE1-C49C1E1D64AB@gmail.com>
Date:   Thu, 15 Mar 2018 17:54:26 -0700
In-Reply-To: <7D05D553-D914-402F-8AE1-C49C1E1D64AB@gmail.com> (Lars
        Schneider's message of "Thu, 15 Mar 2018 20:18:02 +0100")
Message-ID: <xmqq1sgk4z7h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> If I hurry up (IOW: send a reroll tonight), would this topic
> have a chance for 2.17-rc1 or is it too late?

That depends on how well the reroll is made, but for an
average-sized and average-importance topic like this one that is not
yet in 'next' yet, even if it is very close, I'd have to say that it
is cutting a bit too close.


