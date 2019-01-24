Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FAE1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAXOH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 09:07:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44470 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfAXOH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 09:07:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id o8so3244622qkk.11
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=AzMjvpMi6NGVeQEpfkeP1XAJxc7fbn0Bhxv2gfFY6fw=;
        b=cdpLU9hcEoq0vdPlMfLuZ6iVlo+wqhPpOaqcS8FNqLRZlW490Kwf+LI09s+M4/wC7Y
         CaDviQJrwAU7oIAPUWa8zJLLT7S8td72rQOc3V6d8owHxDcBkyTTMqFZeWRBpotPtlX4
         PsaiBXXqABTwdVGR/Mf/+3EdkG19OnRYCXtBzJEKT+bmUjCYJq7x3Pm8vcUBgRLRk33W
         AtYK0TkrAvweu8MYBhBHMoW+4SoGxcodgnSF9haCdKxVidswpSxwmAuxNeNBE+vuBWWd
         QlweNfzEc8TqWB1Y1iV5apbZQ2yiOnx9TDre1br1eyLs7N9ZpTkOXudxvoakrVF/yaiM
         Qbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AzMjvpMi6NGVeQEpfkeP1XAJxc7fbn0Bhxv2gfFY6fw=;
        b=rFac0lzs/+FJnUpWairsEVdAxPtR2Ngc1vzXZe6+16MaPpL5eJUfoiW/43hj52JsJw
         ITTLZ0Awlel+ZCO5m+CDPTnIScpJkt/dlxh9o26+lsRgT8PWg3T2ifwvDNU/HhrrWuLd
         9FrDyuq5W2AX8pzoML5YcBH1D8iHESXotaOnJbIJvkomuN9gQw1eyw/nfzeahhR/78EN
         ssp1cp/MmiVicFXimI3f4saSVefkcV2Jc2HfGqGbpYD6pNricyT6WAb94nNfFdKDopZj
         u31Xb9EmlFcLhZBZlnkCpz8yRy+whWZz168auYLAm7LyaCr2AdHcjdIUZp1QyDZUVuLZ
         H6Ig==
X-Gm-Message-State: AJcUukdpWGSI3sGmKKaou2+P4SFB323btKGQYE1ghuRUvUJBnM4nuFyP
        616GVVpyCtMccKSNE7QnDg4ICbLl
X-Google-Smtp-Source: ALg8bN4SwcAQntpTKN2+fb8TPWKvb7b+waT3iQPMwvcFvVTdB6LTIIVO+NehWq9Ddn/SKyBL1GDekg==
X-Received: by 2002:a37:e20b:: with SMTP id g11mr5645302qki.21.1548338874540;
        Thu, 24 Jan 2019 06:07:54 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:2:8944:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id l33sm80915587qta.57.2019.01.24.06.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:07:53 -0800 (PST)
Subject: Re: [PATCH 5/8] show_date_relative(): drop unused "tz" parameter
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190124131104.GA24017@sigill.intra.peff.net>
 <20190124131221.GE22398@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fcbafa52-2f6d-1497-f34f-d16ea76ee7f3@gmail.com>
Date:   Thu, 24 Jan 2019 09:07:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190124131221.GE22398@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 8:12 AM, Jeff King wrote:
> The timestamp we receive is in epoch time, so there's no need for a
> timezone parameter to interpret it. The matching show_date() uses "tz"
> to show dates in author local time, but relative dates show only the
> absolute time difference. The author's location is irrelevant, barring
> relativistic effects from using Git close to the speed of light.
I fully support more humor in our commit messages.

-Stolee
