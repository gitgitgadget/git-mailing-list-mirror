Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C17C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 07:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiFBH06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 03:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiFBH04 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 03:26:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9DC28B5C1
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 00:26:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j7so4162996pjn.4
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kkYo7Mr+AlZm7eYxF5aHpNZUVxf95ZBUq5Od4TLvSMQ=;
        b=ppVqZ/9YkQkBvpaTluoc8ihvA9ZR8ZpOPQT8EODbDvdWBxTM3L7pHCa/UfvZ8tYjt2
         VyvqwWjB27qsEWg8x3UN3UFCLtqZPfoOIjR/SL0IkGWKU9OIKv197OBKw6bZd0q4+z//
         xwOfpTJ4UoCqxrlUATLEutZAks98hxTsK93HoldRTpIgKVMlUZcajAMLpLeg1XyTVhmv
         GkhMCYJeP4hGaQlxeP7QdhxGwLR1FSHgWTc5rIX35xbn+dYg82TvxgLG/AoKT8nEzJep
         te8QSNLWNsZtLS0A6SXluzgcjustbR4+n0Q2djJ6vp8vBmhpYt9jaSNzjUlwElKbQXDP
         Nkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kkYo7Mr+AlZm7eYxF5aHpNZUVxf95ZBUq5Od4TLvSMQ=;
        b=l26TkxlhG9w8DQ/cz25yKR7j9S1hKGIHmTQc7FQVeB35xgexZZn7i7HR0oIODbcnyq
         i1ZSaXCyvrWtU1EnEhVo4VYBJGVwNpHoKfQLsPbc1P+pmB63YUNLQ53O0ezqKHeMW9Oi
         Lh8+pzeKETS/py5yRZZPtANmzMlwAxFW8JaZ4qKsImyceZISdtbZ1FHIYAgsT2TWOAeG
         682wOVVfvsUDVGYRrR02JPZczWV+CUBDaYAxMFqejKINQVcBcaqfbcyUxyMJbJWOFxwP
         WMiPLmaoMH7RS4o2QLiHgYzxhF5ZnwwdsxjoFoU5PTTde1qKdbhGVeLr2TO28dR2renF
         nUsg==
X-Gm-Message-State: AOAM5310KvxkImZDSgKUqJUD18ViI0CdpQwjvRmLgkBNpKtk7F5saU70
        Miluxs+ulET/LzkZzK905y4=
X-Google-Smtp-Source: ABdhPJzgNmi8Vrd3Xa/92AwgNqmR3bJV7uOHLlb+Idt9LtIdFGGhekCeawpyFL7JOBFQNqYZxRX41Q==
X-Received: by 2002:a17:902:e94e:b0:158:91e6:501 with SMTP id b14-20020a170902e94e00b0015891e60501mr3544967pll.29.1654154810403;
        Thu, 02 Jun 2022 00:26:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id i20-20020a635414000000b003f60a8d7dadsm2548473pgb.15.2022.06.02.00.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:26:49 -0700 (PDT)
Message-ID: <530f7bb4-9f12-f681-0188-878054c4efbf@gmail.com>
Date:   Thu, 2 Jun 2022 14:26:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] gitweb: switch to a modern DOCTYPE
Content-Language: en-US
To:     Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220601012647.1439480-1-jason@jasonyundt.email>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220601012647.1439480-1-jason@jasonyundt.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/22 08:26, Jason Yundt wrote:
> According to the HTML Standard FAQ:
> 
> 	“What is the DOCTYPE for modern HTML documents?
> 
> 	In text/html documents:
> 
> 		<!DOCTYPE html>
> 
> 	In documents delivered with an XML media type: no DOCTYPE is required
> 	and its use is generally unnecessary. However, you may use one if you
> 	want (see the following question). Note that the above is well-formed
> 	XML.”
> 
> 	Source: [1]
> 
> Gitweb uses an XHTML 1.0 DOCTYPE:
> 
> 	<!DOCTYPE html PUBLIC
> 	"-//W3C//DTD XHTML 1.0 Strict//EN"
> 	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
> 
> While that DOCTYPE is still valid [2], it has several disadvantages:
> 
> 1. It’s misleading. The DTD that browsers are supposed to use with that
>    DOCTYPE has nothing to do with XHTML 1.0 and isn’t available at the URL
>    that is given [2].
> 2. It’s obsolete. XHTML 1.0 was last revised in 2002 and was superseded in
>    2018 [3].
> 3. It’s unreliable. Gitweb uses &nbsp; and &sdot; but lets an external file
>    define them. “[…U]using entity references for characters in XML documents
>    is unsafe if they are defined in an external file (except for &lt;, &gt;,
>    &amp;, &quot;, and &apos;).” [4]
> 
> [1]: <https://github.com/whatwg/html/blob/main/FAQ.md#what-is-the-doctype-for-modern-html-documents>
> [2]: <https://html.spec.whatwg.org/multipage/xhtml.html#parsing-xhtml-documents>
> [3]: <https://www.w3.org/TR/xhtml1/#xhtml>
> [4]: <https://html.spec.whatwg.org/multipage/xhtml.html#writing-xhtml-documents>
> 
> Signed-off-by: Jason Yundt <jason@jasonyundt.email>

So basically what this patch does is switch to HTML5, right? That is because
I can see DOCTYPE "upgrade" to use "<!DOCTYPE html>", which is the DOCTYPE
for HTML5. If it does, then mention HTML5 in v2.

-- 
An old man doll... just what I always wanted! - Clara
