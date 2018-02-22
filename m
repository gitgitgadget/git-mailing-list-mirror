Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA2B1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBVUVB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:21:01 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39342 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBVUVA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:21:00 -0500
Received: by mail-wr0-f195.google.com with SMTP id w77so11848108wrc.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=99bQwvJR0ohU87FeTwfBda6Uj/6fnJ8x1yBeo839YTE=;
        b=Zg+kCAgp8xIxviEjbnyBjRL3d8ieZjdpYR+wxe58oyRIBI4NfC4jUGst+eTjwRKUwd
         tZb6/y+EKaD7vvJYnyatJSga8Hv/oo1vy/c6uL2RgbAljg9DmWCl2y6U3iKQ0ehX1VW9
         jzfDpkjAo42HkbEPrCcaAEcJUUI0a/XDF9fbYaUcNPegiW+MRBJZMRk+Qne1lQ9KpeuF
         5YuaJBqBwsvaV1IjcqIRVw+RwzjDNXPVa/3Bpwh6esOyAtuxFl0nGGHpPm3bA5UmbWYs
         vzctyeWMvVmJGrOPEK6cnZoj5BBfeuuxnzh7vDne3w5IZeh46gh7ByLP/8MR6Xf1X1jU
         8mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=99bQwvJR0ohU87FeTwfBda6Uj/6fnJ8x1yBeo839YTE=;
        b=g/SftzWmU5MgTOnOOhBrANisX7TaX7BXNVtKi+sTGmPzgoMLQJRQTYcr9V2RLBRMbG
         M6TPlrfrTCtUPXFzJIBGdFE9zQJq8Xon8DxIrq0VmDsPStH/IUCqfdszidPCWqkECG+P
         oac+gElAKqDLBAXfTQYsB3aHR/F63GaWbQZRz3d5KOuvPbwVYrxpCmpP+8MvYJ2NLxj5
         YQS6Jz7/FShhONfBs45a6Q2480gly2cuHZXXZBBG3Z92KSbrA4PyxYrPazomkYT1Bv7D
         ocY2QtrDZc/uhc7IBfINW7S7lq+F9HSxpz+MuOSlxcieiKOjzw9EmdyyPwyuX65LQlpc
         82Ag==
X-Gm-Message-State: APf1xPDih90Da6jc6Yq4uRiwnxinJj4Hu7IXaC1cKqVT6dCAnpH6xFW3
        xXMFF3ZTZ2Qkz4AeYRyK09YkikLL
X-Google-Smtp-Source: AH8x2257Km5We4yZ/tnAYHF1aAfBMHs7+JNNDXOmdSZFAM9xJRXDBoJJ/+itQxPs2Lz1UVCNSf5kWA==
X-Received: by 10.223.143.76 with SMTP id p70mr7435672wrb.87.1519330859229;
        Thu, 22 Feb 2018 12:20:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n20sm1057762wrg.84.2018.02.22.12.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:20:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     marmot1123 <marmot.motoki@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Fix misconversion of gitsubmodule.txt
References: <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
        <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
        <CAGZ79kYLtXJZA865DS2JRi1RRw_L0t=f1iKJzvN+Uyroeg-pbw@mail.gmail.com>
Date:   Thu, 22 Feb 2018 12:20:58 -0800
In-Reply-To: <CAGZ79kYLtXJZA865DS2JRi1RRw_L0t=f1iKJzvN+Uyroeg-pbw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 22 Feb 2018 10:38:00 -0800")
Message-ID: <xmqqy3jkvkr9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Feb 22, 2018 at 12:52 AM, marmot1123 <marmot.motoki@gmail.com> wrote:
>> In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions `submodule’s`.
>> It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.
>>
>> Signed-off-by: Motoki Seki <marmot.motoki@gmail.com>
>> ---
>>  Documentation/gitsubmodules.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
>> index 46cf120f666df..0d59ab4cdfb1c 100644
>> --- a/Documentation/gitsubmodules.txt
>> +++ b/Documentation/gitsubmodules.txt
>> @@ -24,7 +24,7 @@ On the filesystem, a submodule usually (but not always - see FORMS below)
>>  consists of (i) a Git directory located under the `$GIT_DIR/modules/`
>>  directory of its superproject, (ii) a working directory inside the
>>  superproject's working directory, and a `.git` file at the root of
>> -the submodule’s working directory pointing to (i).
>> +the submodule's working directory pointing to (i).
>>
>>  Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
>>  and a working directory at `path/to/bar/`, the superproject tracks the
>> @@ -33,7 +33,7 @@ in its `.gitmodules` file (see linkgit:gitmodules[5]) of the form
>>  `submodule.foo.path = path/to/bar`.
>>
>>  The `gitlink` entry contains the object name of the commit that the
>> -superproject expects the submodule’s working directory to be at.
>> +superproject expects the submodule's working directory to be at.
>>
>>  The section `submodule.foo.*` in the `.gitmodules` file gives additional
>>  hints to Gits porcelain layer such as where to obtain the submodule via
>>
>> --
>> https://github.com/git/git/pull/459

Forgot to say something of your own?  Perhaps wanted to (1) show a
sample of a better log message, (2) say "Acked-by", (3) re-raise the
point that the same "error" already appears in the same file and it
is better to clean them up all at once, or (4) something else?



