Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D3C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 04:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiC1Et4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 00:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiC1Ety (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 00:49:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8062BDA
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 21:48:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v4so12912954pjh.2
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=75j3c0mn6nTZGyHLbNAu23DZHzY1lkhpcEE3f2H9t8M=;
        b=PkeOurYdizUwfJHMaX7AJSH6Sm87bIqYNnny1TpS0pqGoTKC5uuJP0B34ZjiHxwc7B
         G8xi55Zz0A7kmYRxceteY85C3A4EA5kdESUdtfqBlPQXo6tdvSusrv3W8JFaB2StRFxo
         a6YlGAMCSFaW6jzV3WXTjeC/cY5ii/BCztWoQAhHTIiWP+ACbSVNKkitjnavbX3yyXfh
         2Bw7AFAREANYeYpHfpvHiJpHfNa0fJOxBI9rCGNujhZVGeLOz2Q5yVcgFKI8ih/8Wvdy
         rY4GbehOh7xryOrlrnStB7DYrHSNdxiA7VIvfYZxa5W1OwfgI4Wu+1RiP/oEaKejIDQy
         DyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=75j3c0mn6nTZGyHLbNAu23DZHzY1lkhpcEE3f2H9t8M=;
        b=Jf6VFrx7nA2Dj1/zO238ZkQhAun/ACVNYyi/3Dbm57UO142+ZWUK8BEDscuotRXGYQ
         g1oiFlf4fnh5Xq4PaojvfCltE5iz++tFch8j///NAKj8bRZf2GkT3ZxO+lAG41vnMhRg
         n2JpDMkuKtrJjRFau5716okEOPtJZ60ftdgdkIAFAwifPVBbh748oV70df5jJqeuaUpM
         7YTZNg09n5GsEFIpcCuFgSAhnTmTVdo478MxFZh9a7USDQiHBkR9FkYPnz1zo/qKk59/
         N7/CFXjqrGgu+WgEDFgWjemSl7TwcLJBWUSKLnNiI8lbz8cDZVZ5XmrK2njTBetQ8Jlf
         gHgw==
X-Gm-Message-State: AOAM532y0M9ORa+MjJY7d29cLh4/HXsD/M2oEdjI4PN0oCuWGbSeHkJt
        Yuk8o/t2rXDdST+OvFT9+doUIzWb+N6hPw==
X-Google-Smtp-Source: ABdhPJzNQU4lrlO9aXo4iDyQeJiUIzQSyXMbzbLaU6jSC0z08IMsGC/L6jx8jH4DaTy7aqZj6znMTQ==
X-Received: by 2002:a17:903:244b:b0:154:2cb2:86d with SMTP id l11-20020a170903244b00b001542cb2086dmr23935216pls.123.1648442893503;
        Sun, 27 Mar 2022 21:48:13 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id 96-20020a17090a09e900b001c6dc775159sm19124466pjo.46.2022.03.27.21.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 21:48:12 -0700 (PDT)
Message-ID: <2d1b3c6d-4345-8b7d-b8b8-4baf1edd91f0@gmail.com>
Date:   Mon, 28 Mar 2022 11:48:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
Content-Language: en-US
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-4-greenfoo@u92.eu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220327112307.151044-4-greenfoo@u92.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/22 18.23, Fernando Ramos wrote:
> +When using these variants, in order to specify a custom layout you will have to
> +set configuration variables `mergetool.gvimdiff.layout` and
> +`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
> +

What about this wording?

"These variants also have corresponding layout configuration named
  `mergetool.gvimdiff.layout` and `mergetool.nvimdiff.layout`, respectively."

-- 
An old man doll... just what I always wanted! - Clara
