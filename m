Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBC7C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 03:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbhLWDLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 22:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhLWDLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 22:11:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA3C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 19:11:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p14so3293193plf.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 19:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T6034cKWeyb975qgD9BT+Wc7Ac7Vcy69D5gQUriw9D4=;
        b=hagRHgCuy2cYMqOOlgLiLYTRGEMxkbM7RPjMeWUwT5kSEVjQGvLsDIlmZF+NV2JYjd
         mquEi3SZcPP+goXKTRtm4znUZwwZgI4+K2kYEp9+5L0Z5BakqsFe/GlZrCHW5A8ONElh
         2j/21LhuRTml4M/+uzRuDT+K1dA/10lrUZLLkDMuBMjEx1jwm8BV8eJFUjOw4KPAxYJ+
         uzUBmCzpJZyoYq0jNoY+iv+iGyTOvxJ/F1x53wmtm/BQDj8SUtaeD6RL5ASad6ohNhiP
         RaidyT3pQFvAobnkdbkJbAEV5hEEBXUK8bOG/pzTMozc0LAEhEc6NqQj/OeNYaP8jDb7
         UsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T6034cKWeyb975qgD9BT+Wc7Ac7Vcy69D5gQUriw9D4=;
        b=weQ9GaGHy5L0DfbdDpWoXmwu5O1qy0EaoroNj2v5M1p88ZcN8YSlQwasWZ8SMBiy7b
         5iuvfXq2ob/WFAMpNLrUfUS0MT3SCXp/6NR/ji7U4Y9CZ6/ZAxP1KEth8S88jTHc6W9E
         nF7c6VtJbWw5DLXG+ZlwSMwjXF4XR7DWYCqIK/2fjS4/JAlJ5upZa/OzJMSSP0RzDbrh
         RLN+1ongww9PBrTMpkrBMCTBSuDA/QHmPAUm5pQB+Q49Pq8Fs3219CLFeMhp/qkY2iU0
         bgVNcsn8UxFBuFrvzBO4No7nPZkBUEoyTGY2W+ibmbF5aSsi3WJp/Ysh64O4lEyyhFSc
         vd2w==
X-Gm-Message-State: AOAM532E/mCfu4htAfjQJmL6xg3PcFnSpbdlOpMp9hZjz6rHc6XSezBB
        uPgoMEZVlK75Pf/dO+z3saz1ely7gunWYA==
X-Google-Smtp-Source: ABdhPJwUMzHPIKLVYeuySw9AO0Tl7QwyhI5wk5jUrRIZcOaRvgqHtzut4BlaeaVt8nlan+797HVcrw==
X-Received: by 2002:a17:903:2404:b0:148:db27:981a with SMTP id e4-20020a170903240400b00148db27981amr638348plo.31.1640229094730;
        Wed, 22 Dec 2021 19:11:34 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id q21sm4438475pfu.176.2021.12.22.19.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 19:11:34 -0800 (PST)
From:   Lemuria <nekadek457@gmail.com>
Subject: Re: Rebasing commits that have been pushed to remote
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com>
 <xmqqlf0cjuwx.fsf@gitster.g>
Message-ID: <d51b7981-5034-b34c-42d6-ad8b80a378c1@gmail.com>
Date:   Thu, 23 Dec 2021 11:11:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqlf0cjuwx.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alright. I'll take this into account. Unfortunately, before you got to 
me, I reworded the commits on my local and pushed them to the remote, 
which resulted in a messy history with duplicate comments.

The project in question is a public project of mine, and I'm the only 
person actively working on it, so I guess rewinding and rebuilding is 
acceptable per my standards.

But at least my GitHub page has more green on it!

And I definitely will rebase -i and push -f next time I need to rewrite 
some remote history.
-----------------------------------------------------------------------

On 23/12/2021 3:34 am, Junio C Hamano wrote:
> Lemuria <nekadek457@gmail.com> writes:
> 
>> How do you reword messages of commits that have been pushed to remotes
>> (in this case GitHub)? Do I simply perform an interactive rebase
>> operation on the commits and simply push?
> 
> It is up to each project if it is an acceptable practice to
> rewind-and-rebuild a branch that has already been published, but
> if the projects participants are OK with it, then "'rebase -i'
> and 'push -f'" is how you would do it.
> 
