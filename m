Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A332D20956
	for <e@80x24.org>; Fri,  9 Dec 2016 12:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbcLIMAN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:00:13 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36713 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbcLIMAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:00:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so2168978pgx.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQAcd+U+UjP8jeH9FesxqOlqnGczcFnjK8IMasho9XQ=;
        b=OTfcyG3z2nbGtmlEaavUzngijp/g8CpjhBn7W6cqOJuz+kSaE/tbBafS3VUbGSDuKq
         qTf/XAB5wOx6gTMpp4TQ61GPdIkkK4uJx4+kMb7OebCpQz5gE1ViGxW3CsbWGuKqTuD6
         fsZKXxYyre0nk958TBDowxGPq9aPEvtCpXMMLPHEd0eeBVs8zguYOlffmmAVmRCzkr5V
         rznnt2Er/vrMnkBPynCmqE/uygNogZR3Azsw6RchBwd/K/SW6d7+6GfUGoL8TGQm18Q9
         WzDhZBAvjEEh1BHL9VVdeRfWvFLR5T7OsUwtlVDwVemcWNk6gP5DHqSZw44WDyxQByZm
         V0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQAcd+U+UjP8jeH9FesxqOlqnGczcFnjK8IMasho9XQ=;
        b=Or1RdqeCQp6TSHnxz8oTtM5AtLMuwj2ldWE4s8Ylj/LXC8XZsW743KRCIU5KJHrnt6
         Qp2TWE8cHyrGsTglOHnkDQJ39dhKvGEFPWDL78QuI/YEujX282KiKO2giDqS2FzETqsE
         kWivMYAh2v12ALogtcrU2AekrNj16D6WNMsrNsgdF0W/fw1sRnFmInnH0Musq5oowEIs
         mRPHmiKQHhjtSN5PWmnjyw/3+jh7wK8QdRvm4sXwO2tDgqBzXr/IqCVHloBu7YEM8XBL
         9xQ551zrG+RkSrddNkGkhlwKf4GSsy2UWrKhB9THsfWcIeJ8hmWv2F/Z9mseRaxbti5z
         osbA==
X-Gm-Message-State: AKaTC02bH0pFvPyA7gouuJ5kCdz8PMmOGo4XTpjIYZvLoykCgYR195OdXi4iOqjJy79YjQ==
X-Received: by 10.98.155.9 with SMTP id r9mr83828801pfd.71.1481284811490;
        Fri, 09 Dec 2016 04:00:11 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id 65sm57305224pfn.12.2016.12.09.04.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 04:00:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Dec 2016 19:00:06 +0700
Date:   Fri, 9 Dec 2016 19:00:06 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv7 4/6] worktree: have a function to check if worktrees
 are in use
Message-ID: <20161209120006.GA6609@ash>
References: <20161208210329.12919-1-sbeller@google.com>
 <20161208210329.12919-5-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208210329.12919-5-sbeller@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2016 at 01:03:27PM -0800, Stefan Beller wrote:
> +/*
> + * NEEDSWORK: The values in the returned worktrees are broken, e.g.
> + * the refs or path resolution is influenced by the current repository.
> + */
> +static struct worktree **get_submodule_worktrees(const char *path, unsigned flags)

I'm ok with this (at least we know the function is half-broken). But I
wonder if we could go simpler, with something like this. It's more
efficient as well. And we can replace its implementation with
get_worktrees() or something when we are able to.

As long as this function stays in worktree.c I think it's ok for it to
peek into "worktrees" directory directly. That's what all other
functions in this file do after all.

int submodule_uses_worktrees(const char *path)
{
	struct strbuf path = STRBUF_INIT;
	DIR *dir;
	struct dirent *d;
	int ret = 0;

	strbuf_addf(&path, "%s/worktrees", path);
	dir = opendir(path.buf);
	strbuf_release(&path);

	if (!dir)
		return 0;

	while ((d = readdir(dir)) != NULL) {
		if (is_dot_or_dotdot(d->d_name))
			continue;

		ret = 1;
		break;
	}
	closedir(dir);
	return ret;
}
--
Duy
