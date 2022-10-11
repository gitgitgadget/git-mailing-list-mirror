Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8151C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJKN4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJKN4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:56:31 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1584E43
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:56:30 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oiFkC-000BYY-Ak;
        Tue, 11 Oct 2022 14:56:28 +0100
Message-ID: <85046d94-fa83-db7b-df64-27cf928fd08e@iee.email>
Date:   Tue, 11 Oct 2022 14:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Multiple --global config workspaces?
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, Elsie Hupp <git@elsiehupp.com>
Cc:     git@vger.kernel.org
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqwn96x61t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2022 06:50, Junio C Hamano wrote:
> Elsie Hupp <git@elsiehupp.com> writes:
>
>> I structure my cloned repositories based on the remote host, e.g.:
>>
>> ~/Repositories/github/cloned-repository-name
>> ~/Repositories/gitlab/other-cloned-repository-name
> The above is by definition not "global" (aka "per user").
>
> "--global" is for things that are of your personal preference, not
> "when I am working on this project, these settings apply" (which is
> suitable for "per repository").
>
> What you want is a way to say "when I am working on these projects,
> these settings apply".
>
> One way to do this would be to have
>
> 	[includeIf "gitdir:~/Repositories/github/"] path = $HOME/.githubconfig
> 	[includeIf "gitdir:~/Repositories/gitlab/"] path = $HOME/.gitlabconfig
>
> in $HOME/.gitconfig and then write in these two extra files that are
> conditionally included whatever settings you want to use for any and
> all repositories that come from GitHub or GitLab.
>
> $ git help config
>
> and look for Conditional includes, perhaps?
>
>
This use of "IncludeIf" for the Home/work case also came up in a recent
Git for Windows discussion
https://github.com/git-for-windows/git/discussions/4058

That discussion was about the trickiness of quoting when on the
different Windows terminals/shells as the config string gets passed
around (IIUC).

--
Philip
