Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3191FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbdALSSo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 13:18:44 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36126 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdALSRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 13:17:53 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so16807651pfu.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 10:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=B8GXyw8QY5klR7cUFv6d/rl5rrwdKA+2Yy3o2UWwO94=;
        b=qitovtpfVHL40kXbYbO4S46aaPWNmBd06Evxhu1dB1qUNlceBAYCA7X+5rETXyBBZo
         4QoIqmkT+Ee1N1Tcmdq/94AiRtNgmccjBXXcBNAULaPWv+L++Ppm9jgq16Mod9moWv8V
         AQdEiNDIC5OACG7qECOTQdskAbNMQ6SjW/YupyVae1vQUw5+KWHXLM24tvJ8Jwl1Awrm
         BYCHGEWo7N1sbB6wcdL9iVJ24GnXol1Hfjw+K8vs6I8m8InzZsjEpJm7Pu+h7iJ0uDg8
         X8GEf/j9hDIH1tH01ftfHwZUUSdDsA51ccWyPuegGqSCF+dbTjtcYs/OsnTL/mCad5QV
         J6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=B8GXyw8QY5klR7cUFv6d/rl5rrwdKA+2Yy3o2UWwO94=;
        b=ff44RP7OI1JHY6ypqJkKMe+g15NeJGvvirDivqj3rfcSCQhc4UXQr4GidcQrzZFe2/
         JpV0U4s72j8WEJZd6Md+xeUF1ym6I0M5gqwT7fjKVnn/jgBJjHBFTKQNGAOCMHHNHd7u
         8Ut1DHGQA0t6vUGJqSiO5UI+ZSzoddeI1Mqa1adymliISuYeb7moMEffyXqIY+OfLDqr
         I4MBsR/kPBP1iG7vco7BIcZKpX5tmhH3fHWeugcWXNJtgpwnR8NZG/Gz1cqjZ3CnCkPR
         TKnGLmlot59Y2FO4VQMLeRd+zPPLU0ooup2uxN4e7s1JOndnzV8FqvPol8ql/zEx5PYy
         YQ5w==
X-Gm-Message-State: AIkVDXIV2P54iPluProj1LgxKy8ppQib1vt0c+4LFOncuMselxCYnqPaJ4zvKA+qzZAnbEZd
X-Received: by 10.99.188.2 with SMTP id q2mr19091887pge.34.1484245072850;
        Thu, 12 Jan 2017 10:17:52 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:9d7c:d0a3:f441:afd8])
        by smtp.gmail.com with ESMTPSA id o18sm23450256pgn.36.2017.01.12.10.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 10:17:51 -0800 (PST)
Subject: Re: [PATCH 2/2] mailinfo: Understand forwarded patches
To:     Matthew Wilcox <mawilcox@linuxonhyperv.com>, git@vger.kernel.org
References: <1484212824-14108-1-git-send-email-mawilcox@linuxonhyperv.com>
 <1484212824-14108-2-git-send-email-mawilcox@linuxonhyperv.com>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <866bff14-ea25-c644-b8d2-1529f31e6461@google.com>
Date:   Thu, 12 Jan 2017 10:17:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1484212824-14108-2-git-send-email-mawilcox@linuxonhyperv.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12/2017 01:20 AM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> Extend the --scissors mechanism to strip off the preamble created by
> forwarding a patch.  There are a couple of extra headers ("Sent" and
> "To") added by forwarding, but other than that, the --scissors option
> will now remove patches forwarded from Microsoft Outlook to a Linux
> email account.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Also add a test showing the kind of message that the current code 
doesn't handle, and that this commit addresses.

> ---
>  mailinfo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index 2059704a8..fc1275532 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -332,7 +332,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
>
>  #define MAX_HDR_PARSED 10
>  static const char *header[MAX_HDR_PARSED] = {
> -	"From","Subject","Date",
> +	"From","Subject","Date","Sent","To",

Are these extra headers used in both the "real" e-mail headers and the 
in-body headers, or only one of them? (If the latter, they should 
probably be handled only in the relevant function - my previous patches 
to this file were in that direction too, if I remember correctly.) Also, 
I suspect that these will have to be handled differently to the other 3, 
but that will be clearer when you add the test with an example message.

>  };
>
>  static inline int cmp_header(const struct strbuf *line, const char *hdr)
> @@ -685,6 +685,13 @@ static int is_scissors_line(const char *line)
>  			c++;
>  			continue;
>  		}
> +		if (!memcmp(c, "Original Message", 16)) {

1) You can use starts_with or skip_prefix.
2) This seems vulnerable to false positives. If "Original Message" 
always follows a certain kind of line, it might be better to check for 
that. (Again, it will be clearer when we have an example message.)

> +			in_perforation = 1;
> +			perforation += 16;
> +			scissors += 16;
> +			c += 15;

Why 15? Also, can skip_prefix avoid these magic numbers?

> +			continue;
> +		}
>  		in_perforation = 0;
>  	}
>
>
