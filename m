Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC631F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJZD1w (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:27:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZD1v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:27:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh10-v6so4284761plb.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LV1nVQU4TzoG7UeJHuH954+6Vl9lfX4XMRz+CxdXrtk=;
        b=sA20zk36EJ3vj4nN2rh5XDQIws3cs+KoLn+fvxvYvrTb7Dl/zJHDBp8ms/8cC22IzP
         PeasHtynKUCAngRFuUny0Alz23WblMp8e77Q8owZ3+oi68hOc69Ia4oDUFgKYGgMfaiH
         MDfeM3OJWH99auEBL7P9KXNOrexaSB0r/QrPxYulqURO4jD9ZFpfUAiVR4dcnejk6HV2
         VLd2UkYa3SmL67YhJPhxUjSBUGPBBJJTHfBE8jzuo3Q4jQkLPD7v5nApTzRksjJAoqlQ
         xCuhi+Km88uB6bA9Q1A+3/vh8PzqESNjWX4Y3NqdBbhg56vbcugvuvyM1DoT9iOJQSBD
         6FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LV1nVQU4TzoG7UeJHuH954+6Vl9lfX4XMRz+CxdXrtk=;
        b=CdneAC6wrgLJ40DuXAPFNFjR+6s05bBv3uY8FsKEnPr+0GuTmAN3xhgqfc+PuTLUB1
         WY60UvndKJLwcEVfGpveLuETPHfcHxKzNV49/cl1ab04IUcNjpymDne/iVOP+NRHkVqK
         7kR2g68YX4CN4copq25EID5dnm+yXworVdSnPIpXk6a+8fDM53eU6c3OvTLlfPVI92ma
         djGroPRt0KOt+SnyzottdXYh4g6qDUSaz7AfZjVsKmAW8QYXvoqD+PRSuNnU9Z+hjqQI
         ePFy5FwWeEmAfRCgY9B9u+gnUd3xx6Wx23ilCduYCqUlzceTvzw0c6/dckvcehKWNY0i
         eKEg==
X-Gm-Message-State: AGRZ1gL8VJ19+erHYlVAwGqd/hWZdHUN7D6pG5BpMdV7p8hVj/wcDBzO
        tukrAcO3xZjqGevGhMdOWxA4vorv
X-Google-Smtp-Source: AJdET5f0Fq6OcgGgVYmwYZJWpMkobm8jhHa8DlhUK4XN4LakLzsgZrnISFXsRl1EcAcWp9oBBTvH2g==
X-Received: by 2002:a17:902:404:: with SMTP id 4-v6mr330645ple.331.1540493633021;
        Thu, 25 Oct 2018 11:53:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id e81-v6sm15982501pfb.153.2018.10.25.11.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:53:52 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:53:52 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Oct 2018 18:53:47 GMT
Message-Id: <pull.46.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.46.git.gitgitgadget@gmail.com>
References: <pull.46.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Allow choosing the SSL backend cURL uses (plus related patches)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic branch brings support for choosing cURL's SSL backend (a feature
developed in Git for Windows' context) at runtime via http.sslBackend, and
two more patches that are related (and only of interest for Windows users).

Changes since v1:

 * Reworded the commit message of v1's patch 2/3, to talk about the original
   design instead of "an earlier iteration" that was never contributed to
   the Git mailing list.
 * Changed the confusing >= 7.44.0 to < 7.44.0.

Note: I had prepared 
https://github.com/dscho/git/commit/81e8c9a4006c919747a0b6a287f28f25799fcaf4
, intended to be included in v2, but Junio came up with 
https://public-inbox.org/git/xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com/ 
in the meantime, which I like better.

Brendan Forster (1):
  http: add support for disabling SSL revocation checks in cURL

Johannes Schindelin (2):
  http: add support for selecting SSL backends at runtime
  http: when using Secure Channel, ignore sslCAInfo by default

 Documentation/config.txt | 21 ++++++++++++
 http.c                   | 71 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)


base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-46%2Fdscho%2Fhttp-ssl-backend-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-46/dscho/http-ssl-backend-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/46

Range-diff vs v1:

 1:  8c5ecdb6c = 1:  85bd0fb27 http: add support for selecting SSL backends at runtime
 2:  764791d13 ! 2:  951383695 http: add support for disabling SSL revocation checks in cURL
     @@ -14,10 +14,10 @@
      
          This is only supported in cURL 7.44 or later.
      
     -    Note: an earlier iteration tried to use the config setting
     -    http.schannel.checkRevoke, but the http.* config settings can be limited
     -    to specific URLs via http.<url>.* (which would mistake `schannel` for a
     -    URL).
     +    Note: originally, we wanted to call the config setting
     +    `http.schannel.checkRevoke`. This, however, does not work: the `http.*`
     +    config settings can be limited to specific URLs via `http.<url>.*`
     +    (and this feature would mistake `schannel` for a URL).
      
          Helped by Agustín Martín Barbero.
      
     @@ -77,7 +77,7 @@
      +		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
      +#else
      +		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
     -+			"your curl version is too old (>= 7.44.0)");
     ++			"your curl version is too old (< 7.44.0)");
      +#endif
      +	}
      +
 3:  9927e4ce6 = 3:  a5f937a36 http: when using Secure Channel, ignore sslCAInfo by default

-- 
gitgitgadget
