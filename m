Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E130F2023D
	for <e@80x24.org>; Wed, 17 May 2017 03:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdEQDQP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 23:16:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33327 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdEQDQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 23:16:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so38582pgc.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 20:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5o/8UJ/g5xymc8/m4kabuYhSuyaMrPrDleshtsPDEFA=;
        b=VJN47b59/f6QIWPzTXBLTGznLEMArXS8/S1l3F2uChwYEJ7xNM6/WUSh7r71dR7tal
         1y+8pTEw/nDB88LCDV64Vi5ujDC4uhEIN47hZVX3th/AIIYtJe0YTg0DMAOeoQwXPkHj
         EOLWYiFg32exH6VWBTkgqci0BuOMpPxOYqWCSLaISUuA9pw9e7ym5kdfvb5f3mIYUUqZ
         JMb3vkurHbRFb34Bes/31s+n92wi+V/2d3h2PQnTDR0HV1Rgq4aH4fLRR+OWBlyTRI8i
         hO5XQ2z2VZltLfHUuEnB+w/hGvMiA8N0JLO5pLB75mWflyMG/aTt3xc9B3S7nkn/sijz
         FBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5o/8UJ/g5xymc8/m4kabuYhSuyaMrPrDleshtsPDEFA=;
        b=Gf+VjLxHysaZaz8exs7qp/1CAG2L7kkIYmkKxGtPG5SvgAWkC82h0w2qOKAI03TWpH
         g2+jwXruDpWXmvI8/m7uZqoHXlOZfhVrRVMOsnf0XUsgtMGnvyLvW6ZsaA7Wf14vZ+Gg
         gX8PJG18Dq+Ih8fklHK8/75pySHXdf+XJFYvK9eTtSuvXLVXkQfXP94M21hivb2Vu7wZ
         DoOn1hS+cH+uz6730sTLHdbtEHHPKH6dokd6vxrt1jpZvg94O7OEsyWHsvovwvKMkl91
         AeDCMBHVxWe/Fm3OLns6QaGxBXP7yLzdnnD7uvEsugNXCbMXGRp9huezSb1HRkaJh0GP
         t89Q==
X-Gm-Message-State: AODbwcDfBabO8vOjzcHdhxOsiDJP4iv56ynTVScDah+9vnhTUc+XyyoK
        Wo5mlIMq3mCcYA==
X-Received: by 10.98.219.130 with SMTP id f124mr1351330pfg.171.1494990973463;
        Tue, 16 May 2017 20:16:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id o76sm700951pfi.119.2017.05.16.20.16.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 20:16:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] completion: add git stash push
References: <20170516195945.745-1-t.gummerer@gmail.com>
        <20170516201211.GQ27400@aiede.svl.corp.google.com>
Date:   Wed, 17 May 2017 12:16:12 +0900
In-Reply-To: <20170516201211.GQ27400@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 16 May 2017 13:12:11 -0700")
Message-ID: <xmqqy3twxjer.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Gummerer wrote:
>
>> When introducing git stash push in f5727e26e4 ("stash: introduce push
>> verb", 2017-02-19), I forgot to add it to the completion code. Add it
>> now.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both.  Will queue.
