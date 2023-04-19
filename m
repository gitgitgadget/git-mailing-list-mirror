Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E0C77B7A
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjDSUZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjDSUY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 16:24:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22276B8
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 13:24:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2efac435608so65181f8f.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681935865; x=1684527865;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMwPuLo2oydhWMGLmJfU+2TrTVnsjmLCorMi9VKihHU=;
        b=OvnRmiflz9fPoJLtQJVlzapRXPhNoiiMiSmrhuvteDqKAHg4NkZghvhOqv+Fr2U0/S
         3YVSkbICchaD1CUrDfn4kZoaq/jXKcmrkcaREeQn+AqMqVu2DU8leMhMnsV129j7S0Ht
         CmeXGJvdYTTaeWL/mBUtas4NvpA5Wxqo4tw/SLC+3uC0MdiNPwU/xlqSHeUWN5EQ5l5G
         qJyfTVrHIFdREF4908jqbPqzTMUNUMmiUtXsWRR79Zuw7TqCPM9DRVauQ6MHuLS2hjtZ
         SV60YQUe5Rhrs1hGaFoxCm2FFLXUEZNi0uiwrDPPIjCx2yojnJmrwblVsF+H9qW77rCb
         xF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681935865; x=1684527865;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMwPuLo2oydhWMGLmJfU+2TrTVnsjmLCorMi9VKihHU=;
        b=dE6b8UjxVHfE2H4F2XErfdsbi9EJ0jLSEF+iRHH25qaaw/kgiiUwjzPNKeFb+jpkpx
         KE+B+v/JJJYB7V2S1kaInpK02Vewa1AIhVQrTmKxuMjl0i2sI6lXXX+uU/3S9JG5Hi7u
         TALyWfBImGHcC5v29nfEfwznvOxcI/92F0vJCFcJRh5f+eQ6rD9w4I9dFXSdM5KUobKK
         8G/0BZYH5nTlgIZoZ48IHBIMPWw0Ioxx0P9dNTRNbll17unQa4bi58yajbiqS67vIO0U
         e+x9oKR+BQPNs0sfhQ+Jm5hFW18LeZFNHssW4ZLidijT3gL2OP2XgvwtfM+9UPzdupDI
         F2OA==
X-Gm-Message-State: AAQBX9cDBWZtnDbz0zSPV0jqSzYb63u93fscWVYsOSRZZyryjnVkxaYv
        dpHMyBMO0120pGxPJzsVg90aogVm0rA=
X-Google-Smtp-Source: AKy350bE5ZiCx4g63xbOHaZFeTTh2UQrgJYLkb356qN4lFxb1V8BsGJjAHejDHGynMiXXf8LEc8L/g==
X-Received: by 2002:adf:dfc3:0:b0:2db:11f3:f7ee with SMTP id q3-20020adfdfc3000000b002db11f3f7eemr5792982wrn.63.1681935865472;
        Wed, 19 Apr 2023 13:24:25 -0700 (PDT)
Received: from [192.168.2.52] (67.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.67])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b002e55cc69169sm38039wrm.38.2023.04.19.13.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:24:25 -0700 (PDT)
Subject: rj/branch-unborn-in-other-worktrees (was Re: What's cooking in
 git.git (Apr 2023, #05; Mon, 17))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfs8xfw25.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <3fa2ad13-9056-a14f-6d80-0f8f6c23597d@gmail.com>
Date:   Wed, 19 Apr 2023 22:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqfs8xfw25.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/4/23 10:12, Junio C Hamano wrote:

> * rj/branch-unborn-in-other-worktrees (2023-03-27) 5 commits
>  - branch: avoid unnecessary worktrees traversals
>  - branch: rename orphan branches in any worktree
>  - branch: description for orphan branch errors
>  - branch: use get_worktrees() in copy_or_rename_branch()
>  - branch: test for failures while renaming branches
> 
>  Error messages given when working on an unborn branch that is
>  checked out in another worktree have been improved.
> 
>  Will merge to 'next'?
>  source: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>

The current version of this series has not received any comments.  However,
the previous version was already merged to 'next', although it was kicked
out due to some unwanted behaviors that were detected.  Which have been
fixed in the current version.

I missed the "Will merge to 'next'?" for the previous version.  I just want
to say that I'm still happy with the current one.

Thank you.
