Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39EF203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 20:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbcLLUfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:35:32 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35026 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbcLLUfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:35:32 -0500
Received: by mail-pg0-f45.google.com with SMTP id p66so38877728pga.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Na40uQZLclWRYXeqTwrwzudk26DYH20clZNYRQOh2s=;
        b=F4PlcO1/W3Fro5v6j7OIC35CBDmW2pgdRWq0Eqt/9YOtFcHDlSoQoWwvLzcBKP+FtB
         scpR9ahJzBQGCyTXw/d6dLQAPs/1BSi5GXvFtSZIga6yW6NoPZ7EwfwsYiLFG3UbJ7VL
         oA4wCybH6pcDhm68ZWhzJpX91UT/HVyRsFNzchuiwVi7HGd9OZdxRFC20/yqgSBd8jsS
         9Nb0K5qq2or+ugsz3p7HdGS0Jh8aZDRh25712JfD5buMjy22hJOSBaogNzPEZewNDw/2
         qA14fSBi2H06T+vKkVJR3gDLXgyKWwm0PiYcakE7rTi8lX8fHaMsc19uz5xx7JohMIJk
         ccng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Na40uQZLclWRYXeqTwrwzudk26DYH20clZNYRQOh2s=;
        b=kbDsee1XtLMhIxjhfWis0TEBLIixalQrV5+c6wPZ6tOyJzsN1CLZrAWejzFRymuamN
         m8ne0rryM8BHQX5Qvqy56Mbu2s4pSo81ddMiyYix2BvlcKj4QVipulNIxE1cNDNBrn0z
         YB7lu3iRy3NHO1RbFUwuN5Wbv36hmJkY2kzrKKKpksbRHlH6GenH4cMryD3fOtJlTzS6
         FET1IPz5ZGMveXpYvQJgx1fEiNcGDwdwKJlvS0OJ8zPZIHGqcMgyMKrvusWEOY2BAkUB
         PVeWdgM+EXf0k+M6tZrJu1BG80EY5EpJp7v8JkTgWBASH4z6TXZzRxIdgYUfzm5kcpHv
         OEiQ==
X-Gm-Message-State: AKaTC00ZTYeESMQY2swRhGRNzrKZhFiQvjrHmI9H/rTn6lPIFkQ4xVcz5seFS5ZdxaHeyICJ
X-Received: by 10.84.204.133 with SMTP id b5mr36050328ple.49.1481574931066;
        Mon, 12 Dec 2016 12:35:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b51d:6a5e:36ae:c0a])
        by smtp.gmail.com with ESMTPSA id y66sm77963563pgb.21.2016.12.12.12.35.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 12:35:30 -0800 (PST)
Date:   Mon, 12 Dec 2016 12:35:28 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCHv7 0/6] submodule absorbgitdirs
Message-ID: <20161212203528.GA193413@google.com>
References: <20161212190435.10358-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212190435.10358-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12, Stefan Beller wrote:
> v8:
> * Change the worktree implementation: do not have an internal
>   submodule_get_worktrees, and count the number of worktrees, instead
>   directly look if there is a worktrees dir and check if there are any files
>   in there.
> * reworded one test title slightly.
> * interdiff to v7 (that is queued as origin/sb/submodule-embed-gitdir) below.
> 

not important but your cover letter's subject is v7 instead of v8 :)

-- 
Brandon Williams
