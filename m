Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E371F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 18:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfJGS0Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 14:26:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42577 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 14:26:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so20591111qto.9
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pABxVQOpSyfAOIFahUnytCY5zoSXIQdvAZiTKNhGcyw=;
        b=XN/6yrWHLgeIcD0TyU1r8R/XqO5j5+U9raCwQaoa4IBK66M6F52RrjrWVo3fMSlBAX
         i1K6Km7xd8TJmK8gGttYoQsXkgGp4gOaftD7F/RBvG0ktfvqJ7v9hLDTMUSXfZUModLE
         RO+O5HRv0P/MmI7QHFuNoft7GF2w94Wke6AAPpct/6FTbw3ngbQqqV3G8P3rp47MzWKR
         GHyghTd8BtIGA0aEsKcbs8LEjHwFTRzd7nYF/DhrV+6wOGLY0/XsE1pANJpTdaNOrZZR
         FQORBkc5S6BZ115GoVWZ9Sc2wejXXSoVoL/XrJR7/MbH/lf3xtCCUDTHxXtcqn9HuhT3
         qwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pABxVQOpSyfAOIFahUnytCY5zoSXIQdvAZiTKNhGcyw=;
        b=Yh9AW42EeYaPQjoojeEJrcoxKx2g1G0GA0dyke1UkzO0RoFh/xeZunOdeFHN6yeQ2K
         RUvXtC7eDFKQPktGHqm/8LDynzQpM2NgTwnPuGF3QvtLytX9diiOIs6A2P/PJOuN8kTE
         +4xcvPh4Drb8tZ51OX+D8gGVepwTb6HSJ4fx0IucDA/CaqhhwB0GtzwCi3kOjOeXIkIE
         o7L39d1ZNK/Ypm9Bk3y87GLgWgZj++5NNfyXIUW6cATJI9J+FVdmOlA2FEM//CprFose
         53ZLPJR4qu3iBS5Y7OoMHJdd04sIBZA0rsmu5sL4LZDOGqWlDicyEFz1dy8FqXh4HFCR
         OlUA==
X-Gm-Message-State: APjAAAXkoM7wXKR/8qtPTjNPVv6zEAzoFQA+ahkfz+J614khAsRBlk43
        rUGL17rJx4FcAkusE5oeT2Q=
X-Google-Smtp-Source: APXvYqxgp6RRr+ipsj3+MVuwALqdw/Ec0ngwMWoB5RC0GHIPWxMZv3edW+pbrxYuTQ4njg8Aw2GEmw==
X-Received: by 2002:a05:6214:1401:: with SMTP id n1mr28987721qvx.196.1570472774487;
        Mon, 07 Oct 2019 11:26:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1010:7abe:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id t32sm10169303qtb.64.2019.10.07.11.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:26:13 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] sparse-checkout: 'set' subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <9a78f9ea0fe8d1988654f52a86a01031607621fe.1568904188.git.gitgitgadget@gmail.com>
 <CABPp-BHB0UM1G2tHQ7igRX7Sn1O9ujW6mq_e-UGanGMONHxiag@mail.gmail.com>
 <CABPp-BGcZT2-m=D_X4d7zE9pzuWTKCnmURruahdQndpp=+-_WA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c3e34ab-1eee-fe29-f584-d21047fd1457@gmail.com>
Date:   Mon, 7 Oct 2019 14:26:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGcZT2-m=D_X4d7zE9pzuWTKCnmURruahdQndpp=+-_WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2019 8:30 PM, Elijah Newren wrote:
> On Sat, Oct 5, 2019 at 3:44 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Thu, Sep 19, 2019 at 3:07 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> +static int write_patterns_and_update(struct pattern_list *pl)
>>> +{
>>> +       char *sparse_filename;
>>> +       FILE *fp;
>>> +
>>> +       sparse_filename = get_sparse_checkout_filename();
>>> +       fp = fopen(sparse_filename, "w");
>>> +       write_patterns_to_file(fp, pl);
>>> +       fclose(fp);
>>> +       free(sparse_filename);
>>> +
>>> +       clear_pattern_list(pl);
>>
>> It seems slightly odd that pl is passed in but cleared in this
>> function rather than in the caller that created pl.  Should this be
>> moved to the caller, or, alternatively, a comment added to explain
>> this side-effect for future callers of the function?
>>
>> The rest of the patch looked good to me.
> 
> Actually, thought of something else.  What if the user calls 'git
> sparse-checkout set ...' without first calling 'git sparse-checkout
> init'?  Should that report an error to the user, a suggestion to
> follow it up with 'sparse-checkout init', or should it just call
> sc_set_config() behind the scenes and allow bypassing the init
> subcommand?

Maybe a warning would suffice. I still think the workflow of the
following is most correct, and not difficult to recommend:

* "git sparse-checkout init [--cone]" -OR- "git clone --sparse"
* git sparse-checkout set [stuff]
* git sparse-checkout disable

Thanks,
-Stolee
