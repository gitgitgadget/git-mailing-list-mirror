Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EEC38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 10:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjAXKgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 05:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjAXKgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 05:36:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183842DEC
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 02:35:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v30so17767617edb.9
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 02:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZcilJalNaSfiwZOP9jLMhWHluwDbG/xamEzWocyjgo=;
        b=k3rh53yy0oiGiz3Cuw3xps1rBsdLIFxN0VRn8C965ZrbZZXieBlb+/tNEOmlvaW3dv
         qGdZKCKcisfZmCSQf9kgirTR7TJmci2aYiJs+0a3e9UjClK1spL+oi87786JzUY94S0O
         UOhxYsxZZu1c0nGUUm4CqQsacH8hVD+7yB3Hed9dByJsTEME8lUaeePNOSTu0vlry7B4
         nVqsl6lFSvCT0SYz5PhAD6QK9cb/yXCze+pSS57hQFkWIgK1/sMycWE3yvIdyCZzIhnD
         DSWNdozqIrW0esWEpnEsfxtozbs6+wVtEzSbhK+hX5+R2rtDRb/fwfNpa4FwaSnZbH6J
         /nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZcilJalNaSfiwZOP9jLMhWHluwDbG/xamEzWocyjgo=;
        b=U70EmZY69fy4a1aj/3hDeHuApBGL0kT/qnZ9m1pju+JSSSXh9j8bR+kv22ygYEGe6V
         XTlNLxF4cT2BWwbVcQgQVFs/BSPuhd2PRsedTnJ64ngYaPZ8xsBaGtpDIoDTPyn07/Zb
         1ieL1c7dNoGg2nmgxW5kLvaBJRAOntq3NTzrPBYXFnqTOzRCy7JU5/0XWyeMVadDL8uI
         wEkK5ym6YVs2PZDkojMOaQ5G3IODedZDFtLIm6+Qf1R9A6jL+tl9LdbFKb50YmmZlp5h
         yK7KqJl0IP9P+/CDnBZgGVLQmB/LeMxyBpWPBCQN0qTjsu4go616OOLbfqLrePZiUjqW
         8Vpw==
X-Gm-Message-State: AFqh2kr5KPCHFa4oFPTsfJ8zCGDoCYhq+N/6zMQS5TIrCUIIF29BKx47
        rHtF+3orSY5WMixiy/ztXf8=
X-Google-Smtp-Source: AMrXdXu6U1XOFBLAf/n1t/1hVBh3YZmk+pevCa7paLN77BUBFNDMOI7v5na8Rq+/1mAOzW4yb9Y9nA==
X-Received: by 2002:aa7:c917:0:b0:483:5e56:7bc5 with SMTP id b23-20020aa7c917000000b004835e567bc5mr27291180edt.40.1674556530659;
        Tue, 24 Jan 2023 02:35:30 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id fs36-20020a170907602400b00770812e2394sm685110ejc.160.2023.01.24.02.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:35:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1a7fa327-3833-8da3-46d7-60bfe8dae82c@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 10:35:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com> <xmqqbkmruykg.fsf@gitster.g>
 <766b25e1-2d7a-7b5c-10a9-43e545a57dba@gmail.com> <xmqqk01eqr3m.fsf@gitster.g>
 <d61a2393-64c8-da49-fe13-00bc4a52d5e3@gmail.com>
In-Reply-To: <d61a2393-64c8-da49-fe13-00bc4a52d5e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rubén

On 22/01/2023 23:21, Rubén Justo wrote:
> I tried to maintain the relationship and the role, too.  Just introduce
> the helper, as Phillip suggested and I think it is a good idea.

When I suggested adding a helper I was thinking of something like

static const struct worktree *do_find_shared_symref(struct worktree 
**worktrees,
  					  const char *symref,
  					  const char *target,
					  int ignore_current)
{
	/*
	 * Body moved from find_share_symref() with a couple
	 * of lines added to support ignore_current
	 /*
}

const struct worktree *find_shared_symref(struct worktree **worktrees,
  					  const char *symref,
  					  const char *target)
{
	return do_find_shared_symref(worktrees, symref, target, 0)
}

void die_if_checked_out(const char *branch, int ignore_current_worktree)
{
	struct worktree **worktrees = get_worktrees();
	const struct worktree *wt;

	wt = do_find_shared_symref(worktrees, "HEAD", branch,
				   ignore_current_worktree);
	/* rest unchanged */
}

The aim was to avoid changing the public api

Best Wishes

Phillip

