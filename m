Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13085C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGUSsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUSsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:48:39 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA88AEFF
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:48:38 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10d6e8990b9so3596279fac.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R+odcbyUo/1jC1G0qAzol+6WiFd6JCbpjAUQoXc7LyQ=;
        b=PmOBtwCsNThgmITC4/pngeQVo0MKOa2b0UZNh9BDMBMGU7uLrur4mv4n/iLeV9snpS
         AbAR6Z0DpU0RS2WJCkCRESkZ9Tj3vWHDunzSByHCyHWICF5Km6+mHHXCz2HGPRpm44XJ
         x1tmcp3zVLVCa01dkC1AR5Tj4l9A4tyip0ZwOKi6OZ2PNmyhB5G+zTDVXvi1X48ZgVxG
         zM3btBF4B0IifAR2IZw7dEGO0dtVMFCefbq/u4VsWP8SZjGFondlMcV2nWvDttlABdiA
         YjpAAXDmz1DpsVLKp/pwwegNu/TdX6QYWt1ATT5M/jLf+hS4YWuhdNM/t6oIKFe/QN87
         CM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R+odcbyUo/1jC1G0qAzol+6WiFd6JCbpjAUQoXc7LyQ=;
        b=SzVYgdOuoygoYLsxTFwbai9eLZpP7U9cP/kYm4nIo0oWdbdMI7xqSNr9PA/i+9mzZg
         7Su3azSj/OAe0IFwk6N6SlJFDY1oA65J8YUJFRY5yUyssdCunQD4ALw6jNP+oLNuGxZN
         lwKXPgDHAhl6YFvrfdm36f7GqAtrpGCTzKzAOm4QYIHEnmL5ErV90efRAlTpZF+Ljumj
         3dye4/ADy9v+NkQyPBUX8kGRf3M/KyByaKfzgv0jH0oxh6mxey01LFTixbb+ir3tWqRw
         6+EWaYEsly3nNGBzgp16hE0sFicOugowNZFrdh1JhgPl12Vc2vVSxU2l0DerIvJ6QVTM
         de1w==
X-Gm-Message-State: AJIora9qi+/xJ1yp3XigX3WFO2Dv0u8+MPkuCKbBI7RHTkEYgQOUSVA2
        SWlGaiXU3uqiPcWE5RVTBM2KljXjHqX6
X-Google-Smtp-Source: AGRyM1uLa6mQn+a1lHoIIGjCxUb9GRkh5ZoRKaoH477I3muSC/HZNhoEHuxwukLun557lmcNdEXr7g==
X-Received: by 2002:a05:6870:899d:b0:10c:b531:17b1 with SMTP id f29-20020a056870899d00b0010cb53117b1mr5851777oaq.271.1658429317595;
        Thu, 21 Jul 2022 11:48:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8099:5229:7961:505e? ([2600:1700:e72:80a0:8099:5229:7961:505e])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1321239oao.25.2022.07.21.11.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:48:37 -0700 (PDT)
Message-ID: <571ad4e2-e6de-35a2-0d58-2329cf8684ab@github.com>
Date:   Thu, 21 Jul 2022 14:48:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Question: How to find the commits in the ancestry path of seen
 down to _and_ including a given topic?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
 <xmqqy1wmlbnn.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqy1wmlbnn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 11:37 AM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> A simple question that I'm spinning out of [1]: How can I get `git
>> log` to show the commits in the ancestry path from seen, back to *and
>> including* a given topic (but not commits from unrelated topics)?
> 
> Drawing of a sample history, please.
> 
> I feel stupid asking this, but I do not think I even understand what
> the question is X-<.
> 
> Commits that are ancestors of 'seen' and are descendants of the tip
> of the topic?

Have you tried 

  git log --graph --oneline --boundary --ancestry-path <A>...<B>

The triple dots show the symmetric diff, and the --boundary shows
the possible merge-bases. The --ancestry-path option seems to trim
the output significantly in the example I tried.

Thanks,
-Stolee
