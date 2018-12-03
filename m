Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D5E211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeLCXen (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:34:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37071 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:34:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so7188825pfb.4
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myBrlGwsGGdS4hs2wJcEh6FN8WeCT040ednTztwD0Ag=;
        b=akNwUzP/23xjMlQqg1tHjiaPASxT4ejObeiNigyEugdZn5+Nm23vBkUAxcGf+p5IrS
         RF6C1mHY07u3dvqZNJNu4ci9hE2vt1EAwq11QS3COfZwJlI+XiT5Bpcp43tmRRQGeFd7
         QVhKERPFrohD77ZQZwVCnLIjz8JLaOozi4yrW+UdKr7+jw4MU9RY3ah39hTiTAIjrENC
         099md3+vJ+AdElgTsniR23A3y3BBWtjoS/CgynQvSdQ4I8a13k2K3AArlEWUVXgZlXQx
         tcYXhlvJiJUBmDjduu2TjRGPnmyx3y2qxY3uMS6AxmAZK+m/av7Mv9QpDtadrgHqA5X6
         qxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myBrlGwsGGdS4hs2wJcEh6FN8WeCT040ednTztwD0Ag=;
        b=nsYEDOJsEgjEkUlIXC31tV6sLj2esaqzN49kTc7ZGCe8hNqq4Hny7s/QBnsx5mw1BF
         doWdfbpQsBxNfYaUclR8iMmSzvI6tnRPLpHbCXbGLP267kEIUsCHxjNyW3LV3m7CEL8n
         zsp2S9VyGKFDjBypWRMCymhR9SNaM7qCLMF8v3IWt2QmijqOIQXUykK+3EbV3gU4sT+u
         XTJzOKJslIY0uJx04/McWsQNTu5dlPbw5ocLhQUKDMLATZme3dzOCLDA8D5WmrGMV4on
         MAXoBI+8YGawRS24gTzSAx5KFFBrFMY40iv669fZ8hVKuN5pTmJW8r9GdoFXkn9kcDYo
         8AJQ==
X-Gm-Message-State: AA+aEWYLhmusA+aOXsi8kfeWrkeb9iLXqU1Hac/CeFHu8GF0eElCnO7P
        dTzvMf+Pv0Bi86+ykz9LoFoTn5Jw
X-Google-Smtp-Source: AFSGD/W9W+NxzzZOYaLfhJEg/30HzX+Zc3AeZigh/C3Pe+C48xMWBI5vMN6ERdrcIKwVU8TGAE8zQg==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr18031615pfc.209.1543880081869;
        Mon, 03 Dec 2018 15:34:41 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r8sm16092989pgr.48.2018.12.03.15.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:34:41 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:34:39 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] sideband: color lines with keyword only
Message-ID: <20181203233439.GB157301@google.com>
References: <20181203223713.158394-1-sbeller@google.com>
 <20181203232353.GA157301@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203232353.GA157301@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Stefan Beller wrote:

>>  		/*
>>  		 * Match case insensitively, so we colorize output from existing
>> @@ -95,7 +95,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>>  		 * messages. We only highlight the word precisely, so
>>  		 * "successful" stays uncolored.
>>  		 */
>> -		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
>> +		if (!strncasecmp(p->keyword, src, len) &&
>> +		    (len == n || !isalnum(src[len]))) {
>
> Our custom isalnum treats '\0' as not alphanumeric (sane_ctype[0] ==
> GIT_CNTRL) so this part of the patch is unnecessary.  That said, it's
> good for clarity and defensive programming.

Correction: I am being silly here.  src[len] can be '\0', '\n', or
'\r' --- it's not always '\0'.  And the contract of this function is
that src[len] could be anything.  Thanks for having handled it
correctly. :)

Jonathan
