Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E14E201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933148AbdKOQ7q (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 11:59:46 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:47046 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbdKOQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 11:59:45 -0500
Received: by mail-pf0-f174.google.com with SMTP id i15so7112601pfa.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMIDOguf41GUU3v8WF0gae3sAnP6dk3DwlphUfv1Z3M=;
        b=oaJu53CXriw5M0Jggt6PGLTKfXBNprWsAgWEbqcrgjSTf8wo3GpxRj8EeSYscOfeGW
         GlslhiRUgfsweJZeRLOokOZT2bh8F9wBDk1jXxHmRki9QaSr78PXEOnDNDgc8FSUEeUG
         CTRCkEKE5d5ZTI3B+yEbIKPvypXd/HES9Nintney34XeDURjYuo1qNnVjmH52iIWs347
         4xA1J1ieD6CrAIK2E9tcoZOwtASlFlfHq30yZYLY2hugX3RxvRuaXfk9GEsNp2aK7RDu
         3d+UbSl2d6fQNTxpFItXQbeIm/7L7CJQhGIVdvUuy8at+0rONiZ8gKEgrpDypcLAdPis
         06Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMIDOguf41GUU3v8WF0gae3sAnP6dk3DwlphUfv1Z3M=;
        b=ffNgZDlv60+0rOeM+VzUGARqf8g4SyTLEixX5NuBblK9PrcSNS9YSxrlC1FYpeeVhQ
         nuuXEDheR8MRcnmjF1k6mj5zfHqYZF2fnVYgmbXXOTqZgTT0W5uoA27WdCiizxlKA1yk
         wfa2ekRPg1y20vuAUtOSODmUE7C3mtE+zqcYTynvF2fEVVLMHdymhWJjlLBFneV2M5Lp
         6V8j6TvQMkZ58vqjkr6ME/uNZqP3hetMjyfOPkgRDFLz1wbdGxF9OkUZB3KDYEVOJVbS
         0nbA6r/GMfHWTryZq+rrjY6b7ejbQO5srm6knN8HcEfRGPtRZsl6Hz/E2FlCfGDkBZu3
         ApKg==
X-Gm-Message-State: AJaThX6zjOA+rTQCri8kzGsdmNdlQyRLiFLLWJ1qwoT+Sl47kscaulul
        WzmwavNR8SbMIiVJiQGkOFZX+wHz
X-Google-Smtp-Source: AGs4zMbEg4TmJHEqKmbpcXPoryp2WOoeMW9YRSOibg1Feo+Iq57vT9MoglGkxDBBnYJzjs+jJjZnCw==
X-Received: by 10.98.32.21 with SMTP id g21mr11895355pfg.52.1510765184409;
        Wed, 15 Nov 2017 08:59:44 -0800 (PST)
Received: from ?IPv6:2405:204:72c0:fc36:9c82:85fe:4ccc:5d56? ([2405:204:72c0:fc36:9c82:85fe:4ccc:5d56])
        by smtp.gmail.com with ESMTPSA id t4sm18536732pfd.110.2017.11.15.08.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Nov 2017 08:59:43 -0800 (PST)
Subject: Re: [PATCH v2 1/2] branch: forbid refs/heads/HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
 <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
 <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <bb3485d0-71bc-452e-e4b9-8a7d767753a5@gmail.com>
Date:   Wed, 15 Nov 2017 22:29:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 14 November 2017 08:38 PM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> I should have been a little more clear with the numbering, sorry. The
>> correct prefix should have been as follows,
>>
>>     * [PATCH v2 1/2] --> [PATCH v2 3/3]
>>
>>     * [PATCH v2 1/2] --> [PATCH v2 4/3]
>>
>> Sorry for the inconvenience.
> 
> I assume that the second one above actually talks about what was
> sent as "v2 2/2" (not "v2 1/2") being "4/3"?
>

Yeah. Copy paste error, sorry.


> Are these two patches follow-up fixes (replacement of 3/3 plus an
> extra patch) to jc/branch-name-sanity topic?
> 

Yes, that's right.


> Thanks for working on these.
> 

You're welcome. Please do be sure I haven't broken anything in v2. These 
patches should cleanly apply on 'next', if they don't let me know.


Thanks,
Kaartic

