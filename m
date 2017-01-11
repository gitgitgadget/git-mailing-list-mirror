Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C59C205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 17:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbdAKRZL (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 12:25:11 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36582 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759766AbdAKRY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 12:24:59 -0500
Received: by mail-qk0-f173.google.com with SMTP id 11so117270418qkl.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iYjxYrs+Eem4rjwdJrR0wGoO/xfRGhq1IF0URCTbN8s=;
        b=miQfAcTy5DpVLFsBBCRX3+JDhbYh1b/17HE076QxjBYeRljVl0gODZt+4fPbDlvEIV
         dsLI3Nx+SlyPT8+EpHVPXs5ZvE3jHayXCn/rvs/vezQmrYLmb/YayWY1Vxd8MjV4c6Ek
         AZGwHM6SAzsuXakmN4e2ZtVzBJ5+DM3mMrwA/jovwJ/Z3vqUwdOShNm+TnGSTiETz6P5
         EZ8a1QSI3LX5E2LrqWzktDp5DVfVpBvEBzsMCbMeUzw25gdfnacpo6nSuHxpuItsTh4Z
         A4xE3OH83CvgUxW866kVQPes4n5bYhUm88mV/Q1ViwQ+2++egH5XgoqfZRLLxKaN2cHJ
         ZDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iYjxYrs+Eem4rjwdJrR0wGoO/xfRGhq1IF0URCTbN8s=;
        b=HnRPYR21rpRypUkmzjbw7Co7gzKOeq7vJMvGVOeYMGzzz0RB3cW+iqy1yEcDM5DGsq
         4xCJKVznJXb2fXLSPd0UYuuxDYmAXWtSdf2GzhsJoOg351wvCugarevA4zxL30vDyfCm
         svT/tUvBonohjyx6OicbNBau7PsNq8+A0O4uAzY062BQJQEkO2ZUKaWE3zHOyCsmJjo6
         lTrEGInzpStXu1y1ZXciXojX/b+x9u4WbduJkDI+5FI1iMy74A4a1p0zh+640zM3GZqq
         imghzoRAwZK+1y9jOgck3k/7VteNusu3QhK60BU18g/rAs2nsLk5Z7LWvneEnlhDDgfj
         ro9A==
X-Gm-Message-State: AIkVDXLQe0c2mmQV7fRCi5bu86j1RD2qDTNiyHFs+diYKqLCQ5jFo8OVz2D9/XekJrC1yq85
X-Received: by 10.55.100.88 with SMTP id y85mr8698069qkb.194.1484155498550;
        Wed, 11 Jan 2017 09:24:58 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([2620:0:1004:2:8459:597d:aa56:dd3a])
        by smtp.gmail.com with ESMTPSA id o44sm4554842qtc.8.2017.01.11.09.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 09:24:58 -0800 (PST)
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
To:     Junio C Hamano <gitster@pobox.com>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170110004031.57985-3-hansenr@google.com>
 <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
 <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com>
 <xmqq60lmpb4j.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Richard Hansen <hansenr@google.com>
Message-ID: <21b416ae-8bf6-4f82-25d3-e51a574e7746@google.com>
Date:   Wed, 11 Jan 2017 12:24:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq60lmpb4j.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-10 21:46, Junio C Hamano wrote:
> Richard Hansen <hansenr@google.com> writes:
>
>> I was looking at the code to see how the two file formats differed and
>> noticed that match_order() doesn't set the WM_PATHNAME flag when it
>> calls wildmatch().  That's unintentional (a bug), right?
>
> It has been that way from day one IIRC even before we introduced
> wildmatch()---IOW it may be intentional that the current code that
> uses wildmatch() does not use WM_PATHNAME.

You are the original author (af5323e027 2005-05-30).  Do you remember 
what your intention was?

I would like to change it to pass WM_PATHNAME, but I'm not sure if that 
would break anyone.  I'm guessing probably not, because users probably 
expect WM_PATHNAME and would be surprised (like I was) to learn otherwise.

If we want to keep it as-is, I'll have to adjust [PATCH v2 2/2].

-Richard
