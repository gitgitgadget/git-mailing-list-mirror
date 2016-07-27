Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD2E203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 14:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbcG0Oke (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 10:40:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35573 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030AbcG0Okd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 10:40:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so6801306wmg.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 07:40:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RGVL5uSg4rptgfaEr+p1NuuF/xNwhYYYaQcGVdZxXPU=;
        b=DHc0/ZcdA3ONXaU8EM11MmnjuIUUSv/s6m6akPkVlXubwbJJAhs7pXMaS7jfbW4Qbg
         bCSgn7BM0vvBbRWzMtM9khlGasf6/dxOiNvBoaeV15siWRMbDel4WyCp0wyaQ1nRBDSI
         MorfGY7Yc9l4Lg3u+51I5+PP5lH7exA9hP2RzQ/KLFnskAlz0PExSGjBwHNltyUEcXg8
         onMTx3dUHXbnetgKJimDLgWDDIuPmDgwCg8D2apNs/q9Z7oRA/D2Sd7+gS8QZGyDaukx
         yglB1nkShnxEgpA9phOk/8hZDs20i0L7JEBIXJWCXC5REmriNcLW+mMxCLtkDlLO0Ojb
         bgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=RGVL5uSg4rptgfaEr+p1NuuF/xNwhYYYaQcGVdZxXPU=;
        b=PjTUzYKjEBdkmULxN2aEQ7V1aRvhNPeqTL5lRP+0WmKMhXFpZ22GtCdrqf6ZEE68wL
         CoCiwkgaSXNNxK2+OkbtptNPrF2fg3D9Wbbju+3ri9uBuIdhCWvcQGk4OlNBQL2KLoCw
         TtvjmzZ1Vy6NI/yY6hvxL9g/M1SEKcLgvpsraOwrgDmNktzwJYIrJsSUzBdSCSevRDGF
         ZPvrkuP/GnqiApd/ejw6QOcEX7IeL5Zmt3LkA+6iGDvK+avTQ2WjTFVWl9j/q5NRLgur
         yZnG/ERyGgepo8EI/2rrecAiGx71PDR6P248VHvF866pDgjTRO8qV+ShwYefJ5FrWnhB
         GgRw==
X-Gm-Message-State: ALyK8tIshVBmwmWCv/UL32mDk8TLsrnXuJWHr2/aC0bEHytgbu4sUsQ2gULQF4gTKvbApA==
X-Received: by 10.28.113.151 with SMTP id d23mr55600231wmi.89.1469630431765;
        Wed, 27 Jul 2016 07:40:31 -0700 (PDT)
Received: from [192.168.1.26] (eps206.neoplus.adsl.tpnet.pl. [83.20.60.206])
        by smtp.googlemail.com with ESMTPSA id uo4sm6700356wjc.36.2016.07.27.07.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 07:40:30 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree
 setup
To:	Max Kirillov <max@max630.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
	<pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
 <20160720172419.25473-4-pclouds@gmail.com>
 <20160727041058.GA9015@wheezy.local>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5798C7D1.4010405@gmail.com>
Date:	Wed, 27 Jul 2016 16:40:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160727041058.GA9015@wheezy.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-27 o 06:10, Max Kirillov pisze:
> Hi.
> 
> On Wed, Jul 20, 2016 at 07:24:18PM +0200, Nguyễn Thái Ngọc Duy wrote:
>> + - `remote.*` added by submodules may be per working directory as
>> +   well, unless you are sure remotes from all possible submodules in
>> +   history are consistent.
> ...
>> @@ -1114,7 +1114,7 @@ cmd_sync()
>>  				sanitize_submodule_env
>>  				cd "$sm_path"
>>  				remote=$(get_default_remote)
>> -				git config remote."$remote".url "$sub_origin_url"
>> +				git config --worktree remote."$remote".url "$sub_origin_url"
>>  
>>  				if test -n "$recursive"
>>  				then
> 
> I don't think remote.* should be per-worktree. 
> 
> * note that it is sumodule repository, not superproject. It
>   does not even have to have multiple worktrees.
> * it is quite bad to have it different in worktree, because
>   git fetch then results in different ref updates depending
>   on where it was called. So whatever issue it was intended
>   to solve, it hardly made things better.
> * I'm not sure I know all use cases of "submodule sync",
>   but as far as I understand, it should be called when the
>   submodule repository stays the "same" (however user
>   defines the "same"), but older url does not work for some
>   reason. Then I think it is correct to change the remote
>   url for all worktrees.

But... I don't know how sane it is, and if anybody uses it,
but one might want to use different repositories (different
forks) for different branches, and thus different worktrees.
For example the 'next' branch might want to switch to X.Org,
because XFree86 is moribund, but keep the old repo for 'maint',
or something like that ;-)

-- 
Jakub Narębski

