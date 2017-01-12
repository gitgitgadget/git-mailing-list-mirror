Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537341FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdALSEq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 13:04:46 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35350 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdALSEo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 13:04:44 -0500
Received: by mail-pf0-f179.google.com with SMTP id f144so16631616pfa.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JOT0yQCZkdCthYqrSm2Q11lwAbDzOXNL9afuBz1nzPM=;
        b=ndMb8+hBTM+98EfHycW1J7L47FyAodo0/Xo0IvUxwoE0qDJAbbHUUzK9CKCM2W5+tW
         Qb7bxLsc0LbZpFg/CL1Ws2JKyPH7AJSYY558+1tBmaIahNx+hnR+2GAvG5yifprQW/T2
         uo2BLLdqpmOSEIkmkqBSDa2T6Y+LKf2EfgT90ggh9ZUy/n2jN7OC2WvuGNAC33NV1LTv
         QjC8HA+CHSIceur++Yc9EXa1XjcnOBmDBDwNgQKzmqixlZhGyESSG5BCo9mtX3f1waOw
         Y4Srfc8497CJCnXovGOz70E1n7v3sI/2lBexA3QMj7ewuMKpx+xFRLaIJgl6x87DRzev
         oDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JOT0yQCZkdCthYqrSm2Q11lwAbDzOXNL9afuBz1nzPM=;
        b=IIp4B6L7QwI/RnPhyIDHY/PfknasWoanmNumxE/7jweeh6wsqfLjmZFnc7PuMCW6Vj
         FGKHE86gwkLuU8AvgyzJP1dnI6sBNwTYCTmpNsmXQ4BYj+vgosp/ca6qaFyYybPFGrck
         bqcAIszThTMfcyEigJyM/txrIHbINTEd7muPUXbEKnFgPvWCmIG9hJwI5RXeVR84uKpO
         9M/KHYE+5pUDjO/FKawA8BWykef/xOXk/sKIpsEe1anAXPb3Tsgkf5qBmcfyvRb/wYEC
         kcZu6dHWB2HIpIuqZ1Ep6t3I4mYX0b7iXZ1V86rB2H3xdcvCZP96LF0LSsCP740bPcJb
         OKLw==
X-Gm-Message-State: AIkVDXI1gE6BE5/BkV+ug6xtKyU1KAoTsfPqjZ6gZtOBRGQQfGij9DqnaNjKDf4JefOqbdkL
X-Received: by 10.99.110.74 with SMTP id j71mr18654649pgc.134.1484244278747;
        Thu, 12 Jan 2017 10:04:38 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:9d7c:d0a3:f441:afd8])
        by smtp.gmail.com with ESMTPSA id u82sm22437428pfd.7.2017.01.12.10.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 10:04:37 -0800 (PST)
Subject: Re: [PATCH 1/2] mailinfo: Add support for keep_cr
To:     Matthew Wilcox <mawilcox@linuxonhyperv.com>, git@vger.kernel.org
References: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <8f2be1e9-9199-44af-9d57-41763cb4d666@google.com>
Date:   Thu, 12 Jan 2017 10:04:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12/2017 01:20 AM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> If you have a base-64 encoded patch with CRLF endings (as produced
> by forwarding a patch from Outlook to a Linux machine, for example),
> the keep_cr setting is not honoured because keep_cr is only passed
> to mailsplit, which does not look through the encoding.  The keep_cr
> logic needs to be applied after the base64 decode.  I copied that
> logic to handle_filter(), and rather than add a new keep_cr parameter
> to handle_filter, I opted to add keep_cr to struct mailinfo; it seemed
> appropriate given use_scissors was already there.
>
> Then I needed to initialise keep_cr in the struct mailinfo passed from
> git-am, and rather than thread a 'keep_cr' parameter all the way through
> to parse_mail(), I decided to add keep_cr to struct am_state, which let
> it be removed as a parameter from five other functions.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

A test exercising the new functionality would be nice.

Also, maybe a more descriptive title like "mailinfo: also respect 
keep_cr after base64 decode" (50 characters) is better.

> @@ -143,6 +144,7 @@ static void am_state_init(struct am_state *state, const char *dir)
>
>  	memset(state, 0, sizeof(*state));
>
> +	state->keep_cr = -1;

Maybe query the git config here (instead of later) so that we never have 
to worry about state->keep_cr being neither 0 nor 1? This function 
already queries the git config anyway.

> diff --git a/mailinfo.h b/mailinfo.h
> index 04a25351d..9fddcf684 100644
> --- a/mailinfo.h
> +++ b/mailinfo.h
> @@ -12,6 +12,7 @@ struct mailinfo {
>  	struct strbuf email;
>  	int keep_subject;
>  	int keep_non_patch_brackets_in_subject;
> +	int keep_cr;
>  	int add_message_id;
>  	int use_scissors;
>  	int use_inbody_headers;

I personally would write "unsigned keep_cr : 1" to further emphasize 
that this can only be 0 or 1, but I don't know if it's better to keep 
with the style existing in the file (that is, using int).
