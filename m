Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E1520A04
	for <e@80x24.org>; Mon, 17 Apr 2017 18:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756467AbdDQSVa (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 14:21:30 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38566 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdDQSV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 14:21:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id t189so37488701wmt.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVeBO2FGbuNtTY4MUvC+Ltw4kATn5+ClhfYEph8141o=;
        b=ieRBNf5yBiuDZGkEsgCvnY1TRmZWBya0oQtgwvG1txkAXLgJfY0cLb84JdXrUuSE6x
         WdiCQW7uusSGENPCjP07YuqRwPDJ6tEJZvI9dL0mWTLFOBQXHabHo84mIxWLo9T6+d6m
         EX3MGL+pGQpetOEK9BnnG1+mFGJXQg53a6G0F/Mc7uZX6SsyXr3hITgKRza9NkkozNqi
         0kOFWimQkFBnFfZ9ol/8psBFp1gXt4Y5mRWB586EOl205Rz0TctdfwhX7onot4Fwwvxx
         /UkzLhL+fZhtnxk2yF32pXkqjjGYIwozomoozKNUyq54m6C4T1l1J+rn0n4LUhCrh0yo
         Gh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SVeBO2FGbuNtTY4MUvC+Ltw4kATn5+ClhfYEph8141o=;
        b=slZRSuybVKSmdmYhB1E7MTdOefy9Rad/yuu0aIIZLBaC+7BFgSqsp0isXTbmb2DqY5
         ru6+tMth/GIB1r3f9Cg/cuK93jPzfMPYbwHf1fIF30b/CBg9WrKM4q/iiDxkKAVYJjtQ
         SR0MEQirDwrhV7aK2yY9uIjs8lG3N6756sL/88ltRXZGNQdmx2DkPIiA6iiqDME0tVte
         THKMLxpvPqN27TGLhzp7MI+hxhsZU1ycBuDKAeMNO+gSZP6qnLpSmdRMwcf8ex+rFH+U
         PdrPnXQyOAHpaaudgOTdXTOaYweoZBKOYwmuNayCKTl64lL3bRKFIx+x5XNzaXwGUC2o
         mYlA==
X-Gm-Message-State: AN3rC/5lS+EWKPMM+M60dP+/oMHAAFa8LtRzgTvd1Asa/NrgjDW/fWBK
        Nug5bLcPRE4eKQ==
X-Received: by 10.28.167.3 with SMTP id q3mr7023297wme.134.1492453287053;
        Mon, 17 Apr 2017 11:21:27 -0700 (PDT)
Received: from ?IPv6:2a02:8109:8dc0:a7c:953c:8a46:30f7:d450? ([2a02:8109:8dc0:a7c:953c:8a46:30f7:d450])
        by smtp.gmail.com with ESMTPSA id j2sm15275628wrd.28.2017.04.17.11.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2017 11:21:26 -0700 (PDT)
Subject: Re: [PATCH] submodule: remove a superfluous second check for the
 "new" variable
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
References: <0102015b7aecbf67-2f63e58b-5f75-4c9b-975f-e8e35176d510-000000@eu-west-1.amazonses.com>
 <CAGZ79kb01g0AoD0b+ysqd-H049BAX-j0om2pwPqXA7fXhX2Y8w@mail.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <be511659-83fb-9b34-0ce8-8f6c21b91143@gmail.com>
Date:   Mon, 17 Apr 2017 20:21:23 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb01g0AoD0b+ysqd-H049BAX-j0om2pwPqXA7fXhX2Y8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-17 20:02, Stefan Beller wrote:

>> diff --git a/submodule.c b/submodule.c
>> index c52d663..68623bd 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1396,8 +1396,7 @@ int submodule_move_head(const char *path,
>>                          cp1.no_stdin = 1;
>>                          cp1.dir = path;
>>
>> -                       argv_array_pushl(&cp1.args, "update-ref", "HEAD",
>> -                                        new ? new : EMPTY_TREE_SHA1_HEX, NULL);
>> +                       argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);
> 
> EMPTY_TREE_SHA1_HEX != NULL?
> 
> Can you clarify the intent in the commit message?

Sure. A few lines up (3 lines out of the diff) we have "if (new) {" [1], thus there's no need to check "new != NULL" here again.

[1] https://github.com/git/git/pull/345/files#diff-471db3ea6697763218bb8335a95ece57R1392

-- 
Sebastian Schuberth
