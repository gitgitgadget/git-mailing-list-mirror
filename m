Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83022C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377744AbiDTNcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352554AbiDTNce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 09:32:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488EB39
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:29:47 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i3-20020a056830010300b00605468119c3so1077521otp.11
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neulinger.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=tu1cMI0U1PINTDIkCLiGxoR19vsRX2oII5Xg+CqGaYc=;
        b=HfWKm2ibisu2zxMPEZAmojGW8vj/Yn//lJ1urDWXVDd0LUhafH/sgzjy3H2dboWFRs
         TFIo7Qjr9xUFZzSL8z+uY44DKu8bIRNZe3MiAwL+7jzkJlTJhGYc+1ve8p9cTmBjzHPN
         RkZk7e5/mQOB+722LlCAHpKKxnrxETrjnQmOk+NYOqWyauFDNF+AMDBmxoxVQVhq25Ae
         QkQ8oZTCXiZng5Vn74OTpwUPX3X+W6pJHUfv0tioL4fdwSGWRy6Xqm/DtgoKADkX1Ztx
         XzPlMEo1GiEk1YKWYutDr7GMGhNmo7tEXQkFiQoDqP7TZ9gKuCLa7revHWAIrvGhLimU
         FTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tu1cMI0U1PINTDIkCLiGxoR19vsRX2oII5Xg+CqGaYc=;
        b=RAk4FqOTDIw5ff/7xLvSyDSrmTwS2M1Djz8m+wSnHFg9/+rwSPhjcr354zvoN0+She
         xJrSBo6Oi0ZoQ90+sTW8zS7pDWskS0qb7UIdgczdrHYPsEDAgz4IfUG64I/znYaDRRGh
         Yxmv5ZETQaAWttZmg+gLLgeCAF4XsIP9pSqFAjD4H7PywLoj4NJ96s6+Bp8xR72chM1d
         KM19sLnr1GnPh3rVHC9Fs5pu0dSOzfNO0FawmaQXnvruHSivvhephdrCwdOImfCOTxnn
         82OIRqeNT1wcwpjvY5yve80yGVkW7iKWq1pflRQEtTTiL9xjCP6yK3UI2HSSHh6kIzjs
         Bvbw==
X-Gm-Message-State: AOAM530NfdyblBHL3ahS5GBylyeVhokgN5P52ikA87uIdBm12xaEZlQB
        9niIu4SC7eiTd2f4yxpOZmHit2WBqwwk9g==
X-Google-Smtp-Source: ABdhPJxt1S+ZZZ38TXAOW8ZuAoXQnp9S+IpMfcRoipj3NP3itUFtErDF6jUJXq/ldxPpTfLWZEIPvQ==
X-Received: by 2002:a9d:57c9:0:b0:605:4ba7:d01f with SMTP id q9-20020a9d57c9000000b006054ba7d01fmr5549656oti.106.1650461386232;
        Wed, 20 Apr 2022 06:29:46 -0700 (PDT)
Received: from [131.151.93.93] (infinity.srv.mst.edu. [131.151.93.93])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0706000000b002f9d20b3134sm6323935oih.7.2022.04.20.06.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 06:29:45 -0700 (PDT)
Message-ID: <abf42057-7b40-0995-45a8-ac927800c485@neulinger.org>
Date:   Wed, 20 Apr 2022 08:29:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Recent changes for the unsafe directory handling - TINY
 improvement requested in error output
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <ec588ff7-b300-bc3a-b51c-67d190b27e9b@neulinger.org>
 <e689bb30-dc7f-6e3d-a8d5-864e00de59d4@gmail.com>
From:   Nathan Neulinger <nneul@neulinger.org>
Organization: Neulinger Consulting
In-Reply-To: <e689bb30-dc7f-6e3d-a8d5-864e00de59d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/22 01:16, Bagas Sanjaya wrote:
> On 4/19/22 18:26, Nathan Neulinger wrote:
>> However, if you do a 'git diff' - such as what you might naturally do right before attempting a 'git commit' - you do NOT get any useful response:
>>
>>    root@SERVER:/local/APPNAME/bin# git diff
>>    warning: Not a git repository. Use --no-index to compare two paths outside a working tree
>>    usage: git diff --no-index [<options>] <path> <path>
>>    ...snip-long-diff-help...
>>
>> Please consider a small improvement to have the git diff help output (if displayed due to the repo exclusion warning) - ALSO display the 'git config' suggestion at the end of the output, instead of me having to remember - oh, go issue status to get the command hint to go set the exclusion. Would also be useful to have the git diff output do the same 'unsafe repository' message about ownership.
>>
> 
> I assumed that you have /local/APPNAME/bin shared by users (maybe via
> NFS or something else), right?

Actually, each /local/APPUSER is the base of the clone - dev environment on master/main, test env on 'test' and prod env 
on 'production'.

Depending on the deployment we're either logging in directly as the application, or as common or admin accounts that 
have access over multiple application directory trees. The applications themselves each have their own userid for 
permissions isolation.

-- Nathan
------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
