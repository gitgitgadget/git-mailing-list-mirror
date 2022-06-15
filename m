Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D997C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbiFONMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348551AbiFONMg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:12:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8DB0B
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:12:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hh4so8073233qtb.10
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=inuUXyvZEKsLi6TaYIjKYNMmYEDDRy9VGL255TamEps=;
        b=cUFCgBkSAjujqr2NyMa3Hju7pbGc/+ZgTC6zfCc9ZuEAVSKEiBGzWoQGL6hP5SEVo1
         Z/4gQ6EQUEZTJXpyoWfoVPlBBFUQ5tPPRCDgQbvT1jMzPRcv8MoJ+FzQhguko8n/RUnM
         SEYwQHUOq/4cyEbVOgSw0CykLEpSPPmuGr236OzQM3UbY8shxtxdetYdiecdaJC8i4SM
         QmKxqIbotG31QQ9+MbKN7gC8/gkAieUtkLLnrxJ6HMNbON5SD9Ivje4rr+y6epVqUuqG
         Y7FfbfM1Q6G3ssPUUttYzXCs7hhxHXFcMMtsd1nmC5cIBFMnL33CidZ8tYy5L7Ch5Ge4
         G0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=inuUXyvZEKsLi6TaYIjKYNMmYEDDRy9VGL255TamEps=;
        b=v4He5i+nwmMynL3m1bMPG8DQGmGnXIYHilTTR6xf6SGFYgymsKZ9W73aP+rwnNgPZe
         zgz5Q3CISIxfkHG55Sul1zFPYVxs538HEsxZdTKIZi2TTV7+GnjknQmhQeeMeUn0f5VA
         AEuqbrs6c091pdJpTr0erFoXgn/2m/5jEl7wxnsv4rep+Jrux1ZaJCtRZ9D90JZLXVOX
         /0kkjKuILJWvLCs/LNourUSn/jM14ylqRJiwEBDEHfbfnAkaF+8WTZWmIpQDK4AiePTd
         mRbEVcOOy49J+e77a509oztb17WowcVMwFheU6ds77nVKIZuRYs42lB6XZ4QPN0iu/T7
         ep3A==
X-Gm-Message-State: AOAM530TUPi6tuqvmBke0zdx5MD1KWn9BjeHH93B2xstduI75hxKYCFY
        scgzi7LbFxMRohLs6sZGmXpu
X-Google-Smtp-Source: ABdhPJxmijUaAAoPuVqxTeWHPv6nMGZdsptaegzdgtaO9IrTU4MypXlVbwTeZhXr18kH8505YAIwfA==
X-Received: by 2002:ac8:5f50:0:b0:305:c06:362c with SMTP id y16-20020ac85f50000000b003050c06362cmr8633850qta.150.1655298746463;
        Wed, 15 Jun 2022 06:12:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id y11-20020ac87c8b000000b00304eb8e880dsm9021859qtv.23.2022.06.15.06.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:12:26 -0700 (PDT)
Message-ID: <e53a247d-1d12-e34c-6cc8-3813a2fa34dc@github.com>
Date:   Wed, 15 Jun 2022 09:12:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] For v2.37.0: rename fetch.credentialsInUrl to
 transfer.credentialsInUrl
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/22 6:44 AM, Ævar Arnfjörð Bjarmason wrote:
> The $subject is a case where nothing is broken except potential user
> expectations, but as argued in 2/2 I think we really should rename
> this before we kick it out the door.
> 
> Having a "fetch" configuration configure "git push" is really
> confusing, and once we need to support it backing out of it would be a
> hassle.
> 
> Then 1/2 clarifies how it really works, and what it's aimed to do, and
> notes the major caveat that the check doesn't cover "pushurl"
> configuration, which in some setups is the only place you'll put
> passwords in URLs. I think it likewise makes sense to have that in
> v2.37.0 so we won't lull users into a false sense of security.
> 
> This is a relatively large change for an "rc", but the only code
> changes are s/fetch\.credentialsInUrl/transfer.credentialsInUrl/g, the
> rest is all docs.

Sorry that I didn't see this before looking at your other RFC.
(That RFC still has some references to "fetch.credentialsInUrl"
in your commit messages, btw.)

This rename makes sense and is good to handle before the release.
Thank you for updating the release notes.

The expanded details in the docs are good.

Thanks,
-Stolee
