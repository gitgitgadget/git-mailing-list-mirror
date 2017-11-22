Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A40A20954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbdKVXCo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:02:44 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38576 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdKVXCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:02:42 -0500
Received: by mail-it0-f65.google.com with SMTP id n134so8233456itg.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=684aUbNwCZkis2TbCtFrk2tDR4k9vYA2m3W2JA5Ql3M=;
        b=b1yjjvYYljZqmLTJy6FWSUeByUjJSa1u1cvg1qrmvU0V6X2sQqb9FGN1HLs/zN49gF
         URLMVv8tHE0w7ixqEp7MRL3UAd/9bwo5ZDyVIDJEU142csRpIldvyapcu7CVhdWP1OdK
         nhCgy6WYmoisD4xBfgeeMUFYqRks/E/Shleg0cN4y0ek9X7mlg/AU286WiSKAnFe8yfo
         vJ88jxEb6Z6uhzluGhqUtf8BraU8hCABDjWblMPVFrNU/31cxW60IhThF0HaDlKAZbym
         Q0YDfPtXXDV3W2DMS4JC9oziXDIBxsoz8EsNtum3FQYTKbO21eB6RPPptX7GfXPvRzPU
         TV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=684aUbNwCZkis2TbCtFrk2tDR4k9vYA2m3W2JA5Ql3M=;
        b=tP+yx8k0F6sNWidRKGcBw/O0AD6vvqEwWFS6U1dd6N03uUJnYJKwEBXhA8B2YVR9yC
         yo4six4rXgGC5eLmLr+CKxTxzq6yeZZCid4S1dM22zNsbsnXSrRJyrXKSPZ5Ccvl5FJS
         FPlXmY0VoSOF7M7YL6OsA3LY7a7r5K8kM71ComRE4y9mC1NZnb+t8rya/Hxnoytzzmu6
         fax/X08/rsQ9WHltDPDGfncG1EQMV/yAvopcFOqec6xBSLzt5YRLvjCIuDRBydsdA4A+
         wouPO099T8ssARDBnq8+vR7zxZgwckaXF/YYWhss2mWfARPcSUVyZ+f017LOjWyIaoIo
         pdYg==
X-Gm-Message-State: AJaThX7EdcoMAai07BAl8BM1+nI8Nae2hJYkxRXE/PDorzMknRjPPCY5
        fPL25QY9WnZ05rri3OAV9SM=
X-Google-Smtp-Source: AGs4zMaFNBiJJ5thYCEf5reeuZjoJw71TdTYgl28TK63uL8TsSgA0ITl0gAyPgKJmq5L96xzlreVcA==
X-Received: by 10.36.108.81 with SMTP id w78mr9451174itb.140.1511391762048;
        Wed, 22 Nov 2017 15:02:42 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l195sm2541855itl.0.2017.11.22.15.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 15:02:41 -0800 (PST)
Date:   Wed, 22 Nov 2017 15:02:39 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/3] git-compat: introduce BUG_ON(condition, fmt, ...)
 macro
Message-ID: <20171122230239.GG11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122223827.26773-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122223827.26773-3-sbeller@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1092,9 +1092,13 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  __attribute__((format (printf, 3, 4))) NORETURN
>  void BUG_fl(const char *file, int line, const char *fmt, ...);
>  #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
> +#define BUG_ON(condition, ...) do { if (condition) BUG(__VA_ARGS__); } while (0)
>  #else
>  __attribute__((format (printf, 1, 2))) NORETURN
>  void BUG(const char *fmt, ...);
> +
> +__attribute__((format (printf, 2, 3)))
> +void BUG_ON(int condition, const char *fmt, ...);
>  #endif

I worry that these definitions are mildly incompatible: the macro
accepts anything that can go in an 'if', including pointers, and the
function only accepts an int.

Is there a way for the macro to typecheck that its argument is an
integer to avoid that?

Thanks,
Jonathan
