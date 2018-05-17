Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6B21F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeEQW4y (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:56:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40365 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQW4x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:56:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id j5-v6so11806900wme.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CsXxsxyA1O8dGoDXmffhykxGS5ViGhX0DkTHkPKCdgM=;
        b=HPaNebc8iYX4ZwmSiozSWQP4IyvAXN1Rdv3JKBjUqi71nQp5leBqfEfKgIjNxgQrXD
         FZzUNzTIWHijt9buF9XGYNpOQx7eP7p49hh4dqzxNk80B4sZ2n7QfbJKPu16OEP5LZF1
         KUgkbd+Z9zWZIjs2JbePAPoBvsJZWgqjlRxYnuw/GuGcNEwOBc7VQM6ejVuUCVCAul02
         ZTA/jdelgDGFa3cYeyDXdoaON9k3Kc8bnOprzT8lHQ8MOxjvbf2TyR0NxsqUla00JT1k
         hcTjpyvHCxvlYsWrdwOjr9j+942Oo0nGxASxSGRksJnraPJF0kJpL2E5Qlmh6A/1CINO
         FdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CsXxsxyA1O8dGoDXmffhykxGS5ViGhX0DkTHkPKCdgM=;
        b=dBRCTDmQTIEccecpLWfU+KZpooBwO6Yfj6yFB1lhfJ85KKVzvHkprpaaxMg78ohOzf
         RTmQ/wXf6zYjDE5oPK9BESE05NCeUutB766N3ckAnAYuuU5lOlg2Br2c6lGa1tkHiVoG
         884fIwv/s2Pq4Pl4o5jL2OPCnNJR+s3uyL2euv2osI7/dXxJbio/irf3u9kUi5MRWTOd
         JefpgDSgzajamIRsMM7DgIe/lk+P5G8fr2GmLdVZeL2sY+sXHTSVQNCSoNCLZxS2OFP0
         nuuFG4KB+7gaRQmXl2Fx3+jd8K4kmeJmElpW5nVijLceFmPO8q8ndMd6ZW0k+dx0MQh/
         nakQ==
X-Gm-Message-State: ALKqPwedQHr15g5HPHTA+ybLXJMP5LBzFecVwbxrI2WfqpdzicLPs84j
        DOh0zIFMpaW50uEYQIiTnzI=
X-Google-Smtp-Source: AB8JxZqOPEWQxT7FC8nx21tc66TLB1z8BoI9zsgHz3MmWrtfQCcJJfov5Oy3QoGPJxmha5bCliOC0A==
X-Received: by 2002:a1c:5ec9:: with SMTP id s192-v6mr2789194wmb.54.1526597812319;
        Thu, 17 May 2018 15:56:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8-v6sm11533954wra.58.2018.05.17.15.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:56:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
        <xmqqbmdd6hb5.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 18 May 2018 07:56:50 +0900
In-Reply-To: <xmqqbmdd6hb5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 18 May 2018 07:36:14 +0900")
Message-ID: <xmqq7eo16gct.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>> * sb/object-store-replace (2018-05-10) 2 commits
>>>   (merged to 'next' on 2018-05-16 at 41bbedcc81)
>>>  + replace-object.c: remove the_repository from prepare_replace_object
>>>  + object.c: free replace map in raw_object_store_clear
>>>
>>>  Hotfix.
>>>
>>>  Will merge to 'master'.
>>
>> Please do not.
>> (Or do, but then be prepared for another hotfix.)
>>
>> The commit sb/object-store-replace^ needs more free'ing and shall be
>> replaced with
>
> Please do not replace what already hit 'next'.

Here is what I made these two into a relative fix on top.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Thu, 17 May 2018 11:29:57 -0700
Subject: [PATCH] object.c: clear replace map before freeing it

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object.c b/object.c
index cdf520084d..97245fdea2 100644
--- a/object.c
+++ b/object.c
@@ -480,6 +480,8 @@ void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
+
+	oidmap_free(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
 
 	free_alt_odbs(o);
-- 
2.17.0-582-gccdcbd54c4

