Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAB7CCA480
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 15:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiF3PeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiF3Pdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3294133E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:33:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so19225688edb.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YxCaA3QOFzzWgG/pb0GBXl6WQN7b/kIYYrRfwb3agJY=;
        b=GYrxYyQWP5rVUYrgH/zGUZErDlqkLl8VARbPC71A0o0A7KreSG0nUkSEuAPUH0RYmF
         A6PG30zAvz6j/ID1XJ4ONwOYsU0fiRnLEntG1ecMCNzDYssGzi7/PM4+eEfZqxn/YK2v
         UN3YFu2RFzOsCXmxUluyUenf+h9Qh1VUh9C4KnMxp3dBF1KOKLMATaT07ZD21JZmybsl
         6QVFhJ8tU/iKFoF59Gr0ebk4S3b8ieOi77mF+6Cp0fY2EEtmzt2dYl/i6BzUjpzIGVxJ
         LKG9kBTJY+3ENQ9Y8nUI3mqKCBWIqFWIFO+t5iLAT3h809Q1/jdXylqSj0Kflub7xZgX
         64wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YxCaA3QOFzzWgG/pb0GBXl6WQN7b/kIYYrRfwb3agJY=;
        b=zPtyJxwromPye769kVI1MHIm5/Mm+FcDomyy+QMwn8EeyUXRijFEF+HHclcvF48baV
         RKXjk9a5qmttHu9mAVEXtdpdUVPin8mpaj9l6PWfxVWfiEKPKyEAvNpgZmtjJrzIBUNG
         6IldvuOgc6Up3BryC7NBM/8Z4/KTYGX0YUk0s9Mv9ATm0mqgJqtOSV6gY/cKiAnNHkoM
         vlnoTGj23nLLABRp6i5DlUMvdkvgdev5skyL8/JV0TSqS8AVQmUn/CW/jnzoQyE3yl+N
         BfIm9kyj9SjUXEM+Sm+GCVCfRvWI+q6GwYfLuvhatsJQxpzSfBb90YNVSTwjjSxlHbNU
         pLEw==
X-Gm-Message-State: AJIora/AJ7EoHs5wI2RJ8qbhKSQgcEgH6dl3wY1yxMzSR4VfFBYONzv+
        EfeibH5bjRR6HE1BPXnwuflwyoIR5hs=
X-Google-Smtp-Source: AGRyM1uzlUuizd19D/m5DmF1k/4HpMOh2PJN9+8vbs3gJgqEbPRFKBqcrSrDePVdY7l7w0Xbe2mmSA==
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id eh13-20020a0564020f8d00b004356df2068amr12341288edb.209.1656603212645;
        Thu, 30 Jun 2022 08:33:32 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id j20-20020a056402239400b00439645915a4sm584673eda.49.2022.06.30.08.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 08:33:32 -0700 (PDT)
Message-ID: <ad7fff11-5ab2-d314-5e12-bdf61b854aa6@gmail.com>
Date:   Thu, 30 Jun 2022 16:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] ident: rename commit_rewrite_person() to
 rewrite_ident_line()
Content-Language: en-GB-large
To:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-3-siddharthasthana31@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220630142444.651948-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddharth

Welcome to the list!

On 30/06/2022 15:24, Siddharth Asthana wrote:
> We will be using commit_rewrite_person() in git-cat-file to rewrite
> ident line in commit/tag object buffers.
> 
> Following are the reason for renaming commit_rewrite_person():
> - the function can be used not only on a commit buffer, but also on a
>    tag object buffer, so having "commit" in its name is misleading.
> - the function works on the ident line in the commit/tag object buffers,
>    just like "split_ident_line()". Since these functions are related they
>    should have similar terms for uniformity.

I'm afraid I'm not sure about this change as the interface for 
split_ident_line() and commit_rewrite_person() are not uniform. 
split_ident_line() takes a pointer to the beginning of the name in an 
ident line and a length. commit_rewrite_person() takes the whole commit 
buffer and searches for the ident line based on the argument "what". I 
agree that having commit in the name of the function is confusing when 
it can be used for a tag, but having line in the name when it takes a 
whole buffer is also confusing. Maybe buffer_rewrite_person() or 
something like that would be clearer?

Best Wishes

Phillip


> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> ---
>   cache.h    | 2 +-
>   ident.c    | 2 +-
>   revision.c | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 442bfe5f6a..c8a98d8a80 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1694,7 +1694,7 @@ int split_ident_line(struct ident_split *, const char *, int);
>    * name and email using mailmap mechanism. Signals a success with
>    * 1 and failure with a 0.
>    */
> -int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap);
> +int rewrite_ident_line(struct strbuf *buf, const char *what, struct string_list *mailmap);
>   
>   /*
>    * Compare split idents for equality or strict ordering. Note that we
> diff --git a/ident.c b/ident.c
> index 8c890bd474..d15f579fd5 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -347,7 +347,7 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
>   	return 0;
>   }
>   
> -int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
> +int rewrite_ident_line(struct strbuf *buf, const char *what, struct string_list *mailmap)
>   {
>   	char *person, *endp;
>   	size_t len, namelen, maillen;
> diff --git a/revision.c b/revision.c
> index da49e73cd6..0c8243a8e0 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3790,8 +3790,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>   		if (!buf.len)
>   			strbuf_addstr(&buf, message);
>   
> -		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
> -		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
> +		rewrite_ident_line(&buf, "\nauthor ", opt->mailmap);
> +		rewrite_ident_line(&buf, "\ncommitter ", opt->mailmap);
>   	}
>   
>   	/* Append "fake" message parts as needed */
