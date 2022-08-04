Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78934C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiHDNiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiHDNiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:38:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582783FA0F
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:38:13 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s16so6315289ilp.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=d0fjeNZatIoCCpL3MOs80eHz5w9CPucy8HxuIFBlhY0=;
        b=caFr9B1PRjTxRzis96P/QPWygVGHIj22bDLJbGRKIp5hFQnbCDDzrTWV+MlLPHe1BA
         fPAoR66g0K9miUzX1pGYAhaih4rVnMkjV1g3tIXo0HlRf4SfuxWHwNB7RdN29oisPqhT
         nYgiwREYTFRtSMNXC1fndqRnCzAULHAcp6s9AaSYeb/gTuzFC31pFOCM3FKiCKIuO5SW
         4RRmLrppOHpPnlS9YQlm5GRyEcEUM+4a9F6rzUzzfPln4SC2jAjjbIVABxSXpqvvlPCV
         jXafGsNorngrwfGK+4Rg6qP5IMzmx99uniuiPJFJ3bJRNP5T8s1eDvYGl3wUrZMZHIY7
         z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d0fjeNZatIoCCpL3MOs80eHz5w9CPucy8HxuIFBlhY0=;
        b=YKmwtTdTnDW7l1VnVCmb9KBCxDEaRvOgYAm9lXJlD7jyGnnShC6aWzfn6TxYV4bKAj
         nX+kdSMjBe7MvGZ5KWumzfFMSz40OrQfopn2vZF07k3wKZoTpVAx4YeF8BLNN8M1InNl
         LRRZ60bBwMo+jx+TJo092/Ar1V8wl2r2GXJM0JTvsx5PkuO3Vw2jCYlfA3d3STx+cCPk
         FiHFrNR8AIHrugYV4L6Irg2AfZ8m+XXmc9+tA/vkj9mTdRJZC5mKe6ZzLv0a638CgmsQ
         FDJBi69kgzX5LOSGGYhJU7r4R29QKWKmOAyYPS2vJjScafPftfLS2fseStpm9GPr+zu+
         /9mA==
X-Gm-Message-State: ACgBeo0maWBPBhCVYBAg9CSRDBOqZl/S03LSfkP7sdHSFbf6NTBswHmW
        rM1AEXDs4yYVAxl9NuaYPZiO
X-Google-Smtp-Source: AA6agR7mqz8884y2Q5qrR9xe4NmpvYUMQHMyIAnChVTHZEbWtgeZLJVcS76oJqZ9Ido0XISQEzOExA==
X-Received: by 2002:a05:6e02:17c6:b0:2dd:d9dc:6387 with SMTP id z6-20020a056e0217c600b002ddd9dc6387mr872371ilu.321.1659620292771;
        Thu, 04 Aug 2022 06:38:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id d17-20020a056602185100b0067c553c7f61sm474421ioi.16.2022.08.04.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:38:12 -0700 (PDT)
Message-ID: <bf77e4cb-6205-36d3-d7e9-e2ea989ea637@github.com>
Date:   Thu, 4 Aug 2022 09:38:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/10] log: create log.decorateFilter=all
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <8142b32f023685c78936a618d7b93aaf86ba77fb.1659122979.git.gitgitgadget@gmail.com>
 <Yur5wXXiBtKRO/Y5@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yur5wXXiBtKRO/Y5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 6:42 PM, Josh Steadmon wrote:
> On 2022.07.29 19:29, Derrick Stolee via GitGitGadget wrote:

>> +log.decorateFilter::
>> +	By default, `git log` only shows decorations for certain known ref
>> +	namespaces. If 'all' is specified, then show all possible ref
>> +	decorations. Default value is 'default'.
>> +
> 
> Could we make it more clear here that "all" is the only supported value?
> IIUC any other value will just get the default behavior. Just reading
> the doc as-is, I worry that users might expect that they can add
> specific refs / ref-patterns that would be added to the filter.

Perhaps that's a sign that the config key is poorly named. I had
considered other options:

* log.decorateFilterMode (seemed too long)
* log.decorateMode (hard to distinguish from log.decorate)

Perhaps we could leave this as a boolean config with the name
'log.decorateHiddenRefs' with default being 'false'? I'd love to
explore other options.

Thanks,
-Stolee
