Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D76A1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbcK1SC1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 13:02:27 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33952 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbcK1SC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 13:02:26 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so59341958pgx.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/Yd2ywUAamXEzpFaaSemmSevNZ1GRem28etbW9FQns=;
        b=BDKPf6609BMgIGzD42Jnfg1Rp9OO1HLpkTtoWb3wmmb8w4VXH5uCgnghNRQ+r9rHUk
         +zPRavbIAHcjZhu2jvU8kvOqW1ACkQPbo7BwohL5Efguf0Rgx0+kFlmSWsz31YR2UfMI
         DFL0B/l1T4q15ioBO7VbGE75DcvYCcVINmsaRc8URgF05GSe5FcOk+Rm4S3tAkcZ0dbJ
         pcGb2T6bBHqk+KWJ3m2NzhrFnkzRB3IbbQv4ZZvV03txPf1Cca6r+0ERReqO7gK+3pcu
         33hW8a4RmgtGyfuEJJJODj7hBxQVyWSMaRn49mznCEggW4OPB1I8WHGDOgbj9/5X3hHE
         W1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/Yd2ywUAamXEzpFaaSemmSevNZ1GRem28etbW9FQns=;
        b=GozMRqFgUiSE8Y4mWh2kZqkkY8W8FDCE7cox77C1KBw8WQ6PgJsHcv5jC+QjCg3uTI
         7WyRdhT/M2bjQiGcoloY8u02bPAbyyWen1vZTpQHY2ZBRbWvIzSpoQGqaG7KrghrXQv3
         khoi6oTd8ddF/Q0QMtIR4NnOxqUYOEGoHEu9ymbplxtBbxf3DUvmf1uw3tg0QxBxeHGh
         4DyrfGzNdVXIlmVqWJezq2kJJJVGX5WfCq9wMExWOKUk+XYc5m86i+N7UYYkkKQ14NNw
         MqabADLURUXSd6Yua06A6TYAYl4vBQPK0bQVtu+RnFoIe/Uk3mCTNL1ACv5cRia/hTcm
         XKeg==
X-Gm-Message-State: AKaTC01hrFrI15i1RyVmxj6LhiFigxvar80QXMXy89fOLnm2p1DIF4U6QHNM7dvULZp4VuPN
X-Received: by 10.84.143.1 with SMTP id 1mr52215696ply.86.1480356145500;
        Mon, 28 Nov 2016 10:02:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:6409:b611:8934:17a0])
        by smtp.gmail.com with ESMTPSA id f14sm88918006pfk.5.2016.11.28.10.02.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Nov 2016 10:02:24 -0800 (PST)
Date:   Mon, 28 Nov 2016 10:02:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
Message-ID: <20161128180223.GA150448@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
 <20161110203428.30512-32-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161110203428.30512-32-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10, Stefan Beller wrote:
> @@ -500,6 +586,18 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
>  
>  void clear_pathspec(struct pathspec *pathspec)
>  {
> +	int i, j;
> +	for (i = 0; i < pathspec->nr; i++) {
> +		if (!pathspec->items[i].attr_match_nr)
> +			continue;
> +		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)

This looks like a bug.  Should it be:
  for (j = 0; j < pathspec->items[i].attr_match_nr; j++)

where items[j] -> items[i]

-- 
Brandon Williams
