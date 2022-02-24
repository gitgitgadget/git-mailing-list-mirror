Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D6C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiBXP1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiBXP1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:27:12 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129A33892
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:26:37 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id bu6so4085090qvb.10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZC7oub+ja+U3VRPjFih2f0ZOp+j/iX+GlHXcc7er5aU=;
        b=C6a9Wmm2PWEiXzt8L5pcIsq4lqJHW7gRxkrCAPb5yo+Th9lb5CvUYqmqoaQksDZq3e
         qQpL/I0X0BOjvzwJ1n4USpuvCgy+TF2aD4nJXIRagyJie9mKuUrm/gWXa4J5a4vfrdge
         Y4E0EazDJC8o2i4TbiKdVvG4xBgx8aaFcXn0BiZl3XuS5yeKozSBC7KGzehvmBx53yn8
         IYu9C8Oz1/4sV6wO/B9L4/QmNKp1buQvTytpSwLnPbE0DjPrZqFqTf5hSq6TtDKlzmaS
         cRNKc0dxMBdxucI/OPz/WMjGKV8weAE6fPEAN06r2mNgmOgZe4koW75y+7uL/VaxkZKL
         imPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZC7oub+ja+U3VRPjFih2f0ZOp+j/iX+GlHXcc7er5aU=;
        b=PwTIzRH4dJznJE4lrQLs/RXtju7e9FiAKoIZar0+auBoAnu7+/e0SxrtlDVNg0Joyz
         qs4S38cNPKASxZawTtmj5It0o3X+/WHc1UQIyiLRL+69Sv3fN7NRVxSLvmj1GyWXUUxr
         ilRzf+fi4Tt0roArQPJ3WefTXUyx0iGvk5tfL7ZZ/YWWldKFwNulef1fyuxXAYAElIUV
         qO+FMqxomXARRvbav3ud9KDvkdTYG+lvQe9hxJZdprspdihm9qdj09Tqdah7077dLZHW
         4DH0NbkLxfwbMFNQfqJMH3U2zdTxBePXtVvwEjuibQmYXDHDb0C0C2s9HnGlsKN5yxnI
         As0g==
X-Gm-Message-State: AOAM530IMqFzSeZuaHo+cgSGclJ4E6ZFhVZPdRERQQ+K60es/MC/PZDp
        JXqCEkkg/v857ilE4juobhRf
X-Google-Smtp-Source: ABdhPJwH859P0lsdxcUsdTjd4OM6sTcfohUwtVnRtHoCUnJKcMmXKXZUYwJPQGw6mfqcsRxlRYxngw==
X-Received: by 2002:a05:622a:110d:b0:2d4:e4c4:6b with SMTP id e13-20020a05622a110d00b002d4e4c4006bmr2821976qty.425.1645716396939;
        Thu, 24 Feb 2022 07:26:36 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t6sm1622966qtn.59.2022.02.24.07.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 07:26:36 -0800 (PST)
Message-ID: <c35cb692-4539-d43e-6df0-6ae5ee911f5a@github.com>
Date:   Thu, 24 Feb 2022 10:26:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 09/23] fsmonitor-settings: remote repos on macOS are
 incompatible with FSMonitor
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <412fbc45868e7f2a05a03e424584b53ded4842e9.1644940774.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <412fbc45868e7f2a05a03e424584b53ded4842e9.1644940774.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach Git to detect remote working directories on macOS and mark them as
> incompatible with FSMonitor.
> 
> With this, `git fsmonitor--daemon run` will error out with a message
> like it does for bare repos.
> 
> Client commands, like `git status`, will not attempt to start the daemon.

...

> + * A client machine (such as a laptop) may choose to suspend/resume
> + * and it is unclear (without lots of testing) whether the watcher can
> + * resync after a resume.  We might be able to treat this as a normal
> + * "events were dropped by the kernel" event and do our normal "flush
> + * and resync" --or-- we might need to close the existing (zombie?)
> + * notification fd and create a new one.
> + *
> + * In theory, the above issues need to be addressed whether we are
> + * using the Hook or IPC API.

The only thing I can think about is a case where the filesystem
monitor is actually running on the remote machine and Git
communicates with it over the network. This is currently possible
with the hook, but I am not aware of a hook implementation that
does this.

We can find a way to update the hook interface to communicate to
Git that a remote disk is an appropriate case, but only if there
is a real need for that.

> + * For the builtin FSMonitor, we create the Unix domain socket for the
> + * IPC in the .git directory.  If the working directory is remote,
> + * then the socket will be created on the remote file system.  This

The socket is on the remote file system, but the daemon process is still
local, so I still see this a problem.

> + * can fail if the remote file system does not support UDS file types
> + * (e.g. smbfs to a Windows server) or if the remote kernel does not
> + * allow a non-local process to bind() the socket.  (These problems
> + * could be fixed by moving the UDS out of the .git directory and to a
> + * well-known local directory on the client machine, but care should
> + * be taken to ensure that $HOME is actually local and not a managed
> + * file share.)
> + *
> + * So (for now at least), mark remote working directories as
> + * incompatible.
> + */
> +static enum fsmonitor_reason is_remote(struct repository *r)
> +{
> +	struct statfs fs;
> +
> +	if (statfs(r->worktree, &fs) == -1) {
> +		int saved_errno = errno;
> +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
> +				 r->worktree, strerror(saved_errno));
> +		errno = saved_errno;
> +		return FSMONITOR_REASON_ZERO;

So if we fail to inspect the filesystem, we report it as compatible?
I suppose other things are likely to fail if checks like this are
fialing, but I wonder if we should preempt that by marking this as
incompatible due to filesystem errors.

> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
> +			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
> +
> +	if (!(fs.f_flags & MNT_LOCAL))
> +		return FSMONITOR_REASON_REMOTE;

I do see that we need a successful response to give this specific
reason for incompatibility.

> +	return FSMONITOR_REASON_ZERO;
> +}
>  
>  enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
>  {
> +	enum fsmonitor_reason reason;
> +
> +	reason = is_remote(r);
> +	if (reason)
> +		return reason;

This organization is looking like you want to short-circuit the
checks if you find an incompatibility, with the intent of having
multiple checks in the future.

But this can be done with simple || operators:

	return is_remote() ||
	       reason_check_2() ||
	       reason_check_3();

Thanks,
-Stolee
