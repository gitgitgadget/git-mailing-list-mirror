Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF065C433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41E761038
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbhIYM0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbhIYM03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 08:26:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8879C061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 05:24:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso9617837pjb.0
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZVp5SLMfxoUJuNOoqozmkAhkBd0AVJIpd1KbY0bhHB4=;
        b=OPPOTGo3q9GWX8OBbI6RmZetL9fILdvXPMfiHKtlxFs6WkYYWT/vZp+itf4DD26kY7
         /s3w1Dinh/J6OsooAlcdsSzzv7jsW8gS438ZL31nL8GUfrZKuzSsTm+ofNEsVRrxbpK3
         qNm08Sp0roJQazwVBZgGnq+AsqXqnrX3Jh464fsvYY9VJIztfJ3fhDPXp/NxGeQG88R7
         eA4BTlXShWoee/VMhaR0d39Jr9n7ZGQ78zJwCfc61DGAzG2rv6IBTAZEBXd3pc9groCG
         rlPyCY5dteO7okToCb7KKNz6ZGKDehTEqV38fvzldGoyllXlmiKgKwas46Ip1Su0XbCl
         cdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVp5SLMfxoUJuNOoqozmkAhkBd0AVJIpd1KbY0bhHB4=;
        b=2IoFtCSD4GTOp4VNNio7BhhLpLhyfAtZbKTFnByQlFGudk3Su5PqH1r/+010eR4VzB
         FaxvmcAogBYHXZk3MgAZOfrYSaP2nPeQ4bVHFacuAhKuTc8DmVkO7dfC2MHBpOR/sLL4
         FqtJD6AeU5t/RbgGkQjSTOHAujk4rDVimb4AmI4g/yhBd5INngS6GHy79DbkN0aJOwxK
         r2BDFLjA8yu33GCw+YM3KvjSoG3aY6HHSLrrCq8Of2vXaNzCQPnqJ4D0G/BFepIENXzF
         ApECBSffw7Lf9SnXalpM2dIIkMfaJdUW69YOmUDYdsE011MbyH70JWE6aM02PX0SZu6b
         vT+Q==
X-Gm-Message-State: AOAM531kNQn+GrcmIUbCaBD7mGhlvxLI8Hm03OXn9ag12cfnw2oqZXme
        Jc89t13U1AkciBDdjh7ap5Y=
X-Google-Smtp-Source: ABdhPJyR3rdLP08bWShVTR6fg6Cv6Rm5wO7lDTyIiWiSx7kTnwWAFQEKH8QiFSsQvH9XhG3WUQWkKw==
X-Received: by 2002:a17:902:8b8b:b0:13d:e91c:a1b9 with SMTP id ay11-20020a1709028b8b00b0013de91ca1b9mr7020967plb.60.1632572694350;
        Sat, 25 Sep 2021 05:24:54 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-68.three.co.id. [223.255.225.68])
        by smtp.gmail.com with ESMTPSA id i19sm11712496pfo.101.2021.09.25.05.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 05:24:54 -0700 (PDT)
Subject: Re: [PATCH] blame: document --color-* options
To:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
 <20210925121817.1089897-1-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <355a8c33-2063-80be-ae88-515daefef8c4@gmail.com>
Date:   Sat, 25 Sep 2021 19:24:51 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210925121817.1089897-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/09/21 19.18, Bagas Sanjaya wrote:
> Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
> 2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
> lines, 2018-04-23) introduce --color-lines and --color-by-age options to
> git blame, respectively. While both options are mentioned in usage help,
> they aren't documented in git-blame(1). Document them.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Oops, I forgot Reported-by trailer.

Reported-by: Dr. Matthias St. Pierre <Matthias.St.Pierre@ncp-e.com>

-- 
An old man doll... just what I always wanted! - Clara
