Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85B91F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeD1WGw (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:06:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44229 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeD1WGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:06:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id o15-v6so4787822wro.11
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgKG92LfLGLrmkm6SpDj7PTON9tkG6AJqFqyv7GZWk4=;
        b=Bc0QEZi8qhJTl2//xQz9frMHlM+IDjuXcl7C6sEypFGp0wXlkDHcou/sbYyM4+/qmM
         GxxVRhJx4vdRvO2AzeI6cKzXvY9FaH70RQ50wlf/1jqXl+QGJVimsYYH9PkYAMLKJjGG
         2cAzXuYmjjLLtLaGOgEfKMfajIOTEiBaXG1ZPZRuANwk5de/EEPn6ffpiH2hnI5P5j09
         Epm2C9vFzopYB8W3SKC4y/tfQiLb+IPoR3NWzaDbOD0RJ2M95XVGPQCwwtcehN9HGfU7
         /QDjme8rbafjE0wkIyxG2Mq9qXSbPJwOYQ4nSVQ0CW+K6JlnFPBQ9c2gB+4jWLAsPWDQ
         bv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgKG92LfLGLrmkm6SpDj7PTON9tkG6AJqFqyv7GZWk4=;
        b=pGkG0wVOWtN/cvCxlB+alkZEPQDhjnxCnMIhz+gRyrSEHC6P0xCzhjuV1PYXQehpXX
         tl9JaHS07+W1agM7+5tk94GFmBuWIuu6MwJsvo//8T2kYPLc66i7OQsUko0TX8tunoFK
         Qdkm1d/ymNrp1LjrC1FXjSKJxhPqWJf7sHnUu/g7VzkeXdoeAl1qUbrN13fspH1WBrcg
         YyOE7AgOgtD5PBa52YBDcbXVj0nbwN4VUAVHVu1jJ977Op3Z9siceo7l9lwfLGHYRpsJ
         jfVRUYMDHDPfL0k879TPVlxDTe3D6OcGa0FdIgBxVmsKym+670jiiDpAOzLUSkE1dpIT
         kkNQ==
X-Gm-Message-State: ALQs6tDku2Z5AtSoFb7kkKby+5MhOHmf6aLZRjslPA+lg37lSYzURGfO
        r5DMxd+1q1Xfr5z8E6G2MXc=
X-Google-Smtp-Source: AB8JxZpXM4w1EykNN1NzA4+G9ASMKko1wT0XxsHJMeC2vz1561LP3lKyyqAcBHiHHI2p+1sWa6G8Lw==
X-Received: by 2002:adf:9306:: with SMTP id 6-v6mr234067wro.175.1524953209963;
        Sat, 28 Apr 2018 15:06:49 -0700 (PDT)
Received: from [192.168.0.137] (5-13-173-183.residential.rdsnet.ro. [5.13.173.183])
        by smtp.gmail.com with ESMTPSA id b10-v6sm9518144wrn.42.2018.04.28.15.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Apr 2018 15:06:49 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] Convert some stash functionality to a builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
References: <20180405022810.15796-1-joel@teichroeb.net>
 <nycvar.QRO.7.76.6.1804061813240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <80781666-fe94-f718-ff57-4faeddb9a183@gmail.com>
Date:   Sun, 29 Apr 2018 01:06:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804061813240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Joel,

>> Since there seems to be interest from GSOC students who want to
>> work on converting builtins, I figured I should finish what I
>> have that works now so they could build on top of it.

First of all, I must thank you for submitting this series of patches. It 
is a great starting point to convert 'git stash'.

I would like to continue your work on "git stash" if that is fine with 
you. I will continue to build on top of it, starting with applying some 
patches in order to implement what was already suggested in this thread. 
  During the summer, I am planning to finish this process and, 
hopefully, have a 100% C, built-in 'git stash'.

Best regards,
Paul
