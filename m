Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979BC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiCAK2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCAK2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:28:35 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6B4E395
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:27:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g1so13805385pfv.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=IaIci53G0xezjSlXWUKK5Nt2Cdp/CPsnK2BCrX6436Y=;
        b=g1J0xTR7mwG+AHoZsK72TdhQSCW059MN6ZSThCmScNDyZESvsv+hCNrpfraUO8se9/
         nqOHikxIcHwnfL71oxaBX1lMihdPORVvQ2x8m3zseYKp4xS1k83FsgvRB7jGanN6i0mF
         yRGsnxuhsHDz6/jDahYdKM8p+CG1MSXIj/0daxu+Oi01LWJfS94maRFSD3Z39BA4n3J5
         LVdFKF/fm3iBapDwVun330TKjKpvvvPMU4XwqpmBpgb5YL+zQMw75TkJJ/LtGcIqug2j
         3iAmVOAgro9hhi+l/Aadb+PcTe166G9YAGYVwPbXI5KtZJ2CkKFpYSGx5uF/JWGbVVEZ
         HbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=IaIci53G0xezjSlXWUKK5Nt2Cdp/CPsnK2BCrX6436Y=;
        b=5HBxHGG4lk8ldb+0jEy/lvWu6rZFIwK5gTKDk0M8dLlEa+h/Z6e7f2x5xLfCjhbUVL
         G+jfeKRZzcxf1wU1eoEf3zGzgG+15pz7/DrQ4HNpucNeI02Fc9TQ6dHvmiUhYENixLVr
         cSzh6joS3fV4v0asWTmcrJ/kjSyH7tFczfPyxFK5e1kwtTS+ZJTzTNKGBpQaGQLfYzTn
         JZ3lUFCxiLKCY5bOFUb6k9mm3FF35s/KlxKdHJ/s7IUolNBvD0KWkVXonjOu7hB8kvZF
         BTARcF/xm+PQg2pkaCIYdbyNUWb15lHu1yspl9fs9n4ViUqiPmxBMIUGvajNlKTk2Kg7
         VT6g==
X-Gm-Message-State: AOAM533p4NfMrx8wfomNBRE1++WyFzfvpko0HmnhRUo7AQUgZwEB989V
        SLUKFw3MA/raTCNjWWL3MKU=
X-Google-Smtp-Source: ABdhPJzmnVP1mW4v8TbS4jRuaBkELGB6TbQuGDkNmO9y9CMBavKKTGdMGdXnnq7YmIWdqqcCHOlq7g==
X-Received: by 2002:a63:fb44:0:b0:372:9ec8:745a with SMTP id w4-20020a63fb44000000b003729ec8745amr21320209pgj.551.1646130474647;
        Tue, 01 Mar 2022 02:27:54 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm15418066pfg.165.2022.03.01.02.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:27:54 -0800 (PST)
Message-ID: <806840db-e353-860a-e7ec-a83e303b648c@gmail.com>
Date:   Tue, 1 Mar 2022 15:57:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] userdiff: Add diff driver for Kotlin lang and tests
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220301070226.2477769-2-jaydeepjd.8914@gmail.com>
 <220301.867d9e107u.gmgdl@evledraar.gmail.com>
In-Reply-To: <220301.867d9e107u.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review. I will be submitting another patch with
the requested changes shortly.

Thanks,
Jaydeep.
