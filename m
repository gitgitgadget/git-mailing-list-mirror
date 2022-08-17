Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F7C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 02:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiHQCD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 22:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbiHQCDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 22:03:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E5985A7
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:03:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so10829078pgs.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5mYg58RSqRZgURaEUc496M94NUwVWnnKDNwcmfWL5Sw=;
        b=UP/bemhJAXn2+dAHdmKpr21nJMgt/IbY2ypQ3M8rocznd8ToAklFhJxw+mMAjJf6RC
         KsvH2Kmhdzb8Q6rfla8e1in34MWCjXPPmki7nH0MNK1VVqcCd6CQ3A2eXJLn1ibXfspR
         LLSETZhtP/ZJs6pnKsuJujWmhXHno5hRo8Ua6Gx18GKsr4UULDPa9Qff7O2Rgm6b+kjD
         UxIoiyM9r3vavnQ+4i3OFKweF69ptK0h8jTbNfujE7W045gLShxebFeq0ayQG6WkwqSB
         RLqIkkbaSgJcOqcYeBfn8AsEzJIzfW99gBZhcswZA7gLVqWfhQhfGxydZjwXkWny5seE
         n0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5mYg58RSqRZgURaEUc496M94NUwVWnnKDNwcmfWL5Sw=;
        b=4dzt/r4lV2ZckS1IZlG/GA3JqvLanwlWAkbe1kWhalKyqVQsGT9eU9kRD+ebn0jBHK
         5fBFKgMnxG9MhZ4LdxroUoCiIxkcaTaRlOyMSAiQl472ZqNzhnzARlab6wfyivoY0rVa
         P3mQTvOhJW6Fml9WBGq+dciulQDkfNAXkOt3Hch58AHSIJv7cON1ju2MIR+fb+eySd+V
         Q3DX7AXMIxF8f9UKBMvTiphx8cemh8pOzayI0KAU36H3d84x4x1S16ToVVEqWK4W7Z4N
         GIuHCWFNk3Zb6sTspbAOI0P8Q272B8ad7KxfpYMqk1+Cm4fadsPbYXa22mchJBQKspOJ
         +PmA==
X-Gm-Message-State: ACgBeo1zFM2b5aVe0u+0hvCfBte6qT+fydSwapIrNCUVdKw0Sr6ezFM+
        lo/bRfJoNHZui2B307qusxc=
X-Google-Smtp-Source: AA6agR4JJv8SpuNtwrrGrRCaI3oeWuEFseNGgbV9Q6rFzapxpLb9mHyGQtxiV1Kb/hN0hBw+a7Rygg==
X-Received: by 2002:a65:68d0:0:b0:422:ebd2:302 with SMTP id k16-20020a6568d0000000b00422ebd20302mr16655235pgt.340.1660701817785;
        Tue, 16 Aug 2022 19:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([8.37.43.37])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b0016dbce87aecsm59262plh.182.2022.08.16.19.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 19:03:37 -0700 (PDT)
Message-ID: <1c8ffd85-2398-6910-b7ad-0555962e76e2@gmail.com>
Date:   Wed, 17 Aug 2022 10:03:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: sy/mv-out-of-cone (was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15))
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqq5yityzcu.fsf@gitster.g>
 <2b19b57b-b6b1-8214-d1fd-3ffe9eac2d9d@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <2b19b57b-b6b1-8214-d1fd-3ffe9eac2d9d@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 12:00 AM, Victoria Dye wrote:
> Junio C Hamano wrote:
>> * sy/mv-out-of-cone (2022-08-10) 9 commits
>>   - mv: check overwrite for in-to-out move
>>   - advice.h: add advise_on_moving_dirty_path()
>>   - mv: cleanup empty WORKING_DIRECTORY
>>   - mv: from in-cone to out-of-cone
>>   - mv: remove BOTH from enum update_mode
>>   - mv: check if <destination> is a SKIP_WORKTREE_DIR
>>   - mv: free the with_slash in check_dir_in_index()
>>   - mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
>>   - t7002: add tests for moving from in-cone to out-of-cone
>>
>>   "git mv A B" in a sparsely populated working tree can be asked to
>>   move a path from a directory that is "in cone" to another directory
>>   that is "out of cone".  Handling of such a case has been improved.
>>
>>   Will merge to 'next'?
>>   source: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
>>
> After reviewing the latest version [1], I think this is ready for 'next'.
>
> [1] https://lore.kernel.org/git/52b67242-5d91-5406-9c95-9d8ddc49c079@github.com/
Thanks!


