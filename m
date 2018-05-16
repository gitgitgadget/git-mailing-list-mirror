Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95AD1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeEPBRN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:17:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46611 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEPBRN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 21:17:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so1949232wrn.13
        for <git@vger.kernel.org>; Tue, 15 May 2018 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bC0RbZjp3UdIoeKaLr9OsG5xi5MEUblNz1Yiub8/G/4=;
        b=ozMrDozeYISKzIywJKEdWJSqsmS3wjfL4s1d0fAcZ5T0Hc7NE4RhCQ5sIcgbmIE1Bp
         sX7i5AhNGDafdG3s/2rE2OspIvJ+u25QEdfftbsf7w8VNmK6jiEU5Bx4VKzYSfk8+/rQ
         iabyf7LxGBMDxj7l8dKSO04Cz4yPcrmtZPxTpCLOSp1CM4PJ4qNJl6M4zC4j61BKkl0k
         W12/VjzwCQ8a1WOq8UrCCz0jCbv1zXQYqsObIPcIwv4VxlOsi1nzo82iGZuBnyF5AeQ+
         RQXgNRrreBIHKD4hvYLCZh/RkvPBdBcT69jwPPDGrVBBrBfSAVZm6hjhze9kCI6/hjSq
         qZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bC0RbZjp3UdIoeKaLr9OsG5xi5MEUblNz1Yiub8/G/4=;
        b=JkU7LGeURLb9eoXqKybHL2SQ5z82OkI22eZAFjLOyjzwdws4bEy81SZeCL3gblyAn8
         +Whgx3XFKaTyyc6vUE/3WvpIOt8KgFXXdGJ4Jo40dZBx+oUYRhhjBe/+OiVVwvsaQ1yZ
         KNpR13sUReqYPZbKZdGpNCP8aooHG3ugWzVgWgFhCZQhL4VyeqlOpWEYHShwxfx9K2dP
         AcG+xLoFd1qm57nFDahhfR5WLes38MqxQcct++UAOGtwVVGiul5Y38m6BrzF1wtNAerc
         1YuMOBKeHJyXDbr8GxTWsPagTLsmDHlxvGqCb4Me0PwvgisF9HP9YpeXEb+NQyxphIFc
         h69Q==
X-Gm-Message-State: ALKqPwcXQlQtWMofl7GM5mo9pVLob03mTFAez426MvTaSNcyHxqJypGz
        G15MibDD0CfOGP0lWQFDv/A=
X-Google-Smtp-Source: AB8JxZo5XsoUg3WRbex5Vm8auoSSsARSWIVcNgNZVMBo8eTqEsfyf5+rExx/whB7CIcZim5Qb57+FA==
X-Received: by 2002:adf:a0ea:: with SMTP id n39-v6mr12232958wrn.87.1526433431616;
        Tue, 15 May 2018 18:17:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14-v6sm2211122wra.84.2018.05.15.18.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 18:17:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, leif.middelschulte@gmail.com, newren@gmail.com
Subject: Re: [PATCH 2/3] merge-recursive: i18n submodule merge output and respect verbosity
References: <20180515200030.88731-1-sbeller@google.com>
        <20180515200030.88731-5-sbeller@google.com>
Date:   Wed, 16 May 2018 10:17:09 +0900
In-Reply-To: <20180515200030.88731-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 15 May 2018 13:00:29 -0700")
Message-ID: <xmqqtvr87622.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static int merge_submodule(struct merge_options *o,
> +			   struct object_id *result, const char *path,
>  			   const struct object_id *base, const struct object_id *a,
> -			   const struct object_id *b, int search)
> +			   const struct object_id *b)
>  {
>  	struct commit *commit_base, *commit_a, *commit_b;
>  	int parent_count;
>  	struct object_array merges;
>  
>  	int i;
> +	int search = !o->call_depth;

I kind of like this "while at it" change in this patch ;-)
