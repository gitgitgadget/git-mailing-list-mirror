Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF49CC677F1
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjAMSBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAMSAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:00:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751988DE8
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:54:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k12so2086332plk.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z73pjSjLl2MyLayrZqc3UHQCmF/zEk8T1oNJn902xeg=;
        b=dZS1k0BiY5BocUYkSg51hVCYZuSEG5PdoMkePpCkZ1ztbCFqIGMpb7ShD0lXO8s/j/
         muu2WtInlJoVRPYQVq37jzVBeCx+ZJk53EpG4lRGzkTMPJ9K6uzZMsGAoZXg8DfvYXIK
         obgswnMYPg6NPonBfPku7VeZM47lio7q9gsLE6tbc1KupxQ+SNFur7Gf6iI7NNVR6lGS
         qVooKtJP4/r7i7n1Am5Ytxjf2WGxNeL8u/g4HqZSml5AvbDxiwDjD3i9cQNonpAkWflQ
         XxT0RvQDTNyxn5b9+S1NlGED9fts5uOmqb9yIBKH1dvr2ph9mKl0fcBTMLtDIsAppunw
         LpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z73pjSjLl2MyLayrZqc3UHQCmF/zEk8T1oNJn902xeg=;
        b=3q0Zu5WVQhM6ZxuMxfxdYy/9ZkCJZgPfuLH51EslOqQ2Nlkjfs/WmEkqRz0LP6HVae
         zq6d8S0GUn+RaQfwy2PNwlJX/FLkCzOj5XNqyvj90GI7HOtYbwWtA8GEbi2ARHwGkXlT
         pnFF7DSZyt8MHcPvCTFpjOLeWl0hjwZg3yPkxr2Mu5PoVFQvPQscjQ3ihe6YCBz1VJFj
         J11X9konm24ern9dJsh2/GWN3tM6hLISqhtZs0P0vNKAoWAkC8r33wMoFuR6QHowNbAv
         PDG2MJTV3GSnkcwTXrslSKYaAFE1Q1pYs7kCe2TFpVRkAfBjt0q4XHPAr/yCvEiAERgW
         YuTQ==
X-Gm-Message-State: AFqh2kpSClgTP2rRjQ9aNBeiU6IvbrH9+8Nc2QLb4ddZSZ/st50/pHUg
        +edASbMHtdZN+bBsmKlp2X4=
X-Google-Smtp-Source: AMrXdXv+XKXnwkxPVw0p0SuQeqr3wd6yCBe1N42VQvkVzrNlMrKO686HpcioWEFd8qEaZ8+Ytp445Q==
X-Received: by 2002:a17:90a:1bc9:b0:229:305b:5f60 with SMTP id r9-20020a17090a1bc900b00229305b5f60mr2276514pjr.45.1673632467116;
        Fri, 13 Jan 2023 09:54:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 8-20020a631448000000b004b25a51d6f4sm9070984pgu.36.2023.01.13.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:54:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     muzimuzhi Z <muzimuzhi@gmail.com>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix non-existing config name
References: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
        <xmqqfsclzlqx.fsf@gitster.g>
        <CAEg0tHT5PD4K89E3fcNq_WbaLPHozLi-PsJFDsQrzkGi7Na9jg@mail.gmail.com>
        <CAEg0tHQtf9G0N24Xfe-gvRM1AFaiS_ApcuQ8hZtsZAeMhhVWAQ@mail.gmail.com>
Date:   Fri, 13 Jan 2023 09:54:26 -0800
In-Reply-To: <CAEg0tHQtf9G0N24Xfe-gvRM1AFaiS_ApcuQ8hZtsZAeMhhVWAQ@mail.gmail.com>
        (muzimuzhi Z.'s message of "Tue, 10 Jan 2023 05:38:59 +0800")
Message-ID: <xmqqo7r248x9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

muzimuzhi Z <muzimuzhi@gmail.com> writes:

> Somehow My last mail failed to sent to Clemens Buchacher (drizzd@aon.at):
>
>> 550 5.7.1 <drizzd@aon.at>: Recipient address rejected: mailbox not found
>
> I found two lines about Clemens in `.mailmap` (see below) [1] and
> drizzd@gmx.net was used last time when Clemens mailed to the current
> mailing list in Feb 2019 [2].
>
>     Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
>     Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
>
> Thus I added drizzd@gmx.net to cc.

Thanks for the above explanation.

> yukai

Is that your name, or is it "muzimuzhi Z"?  Please see and follow
Documentation/SubmittingPatches:[[sign-off]] and [[real-name]]
sections.

The patch, including the proposed log message, looks excellent.

Thanks.

>> Replace non-existent `branch.<name>.fetch` to `remote.<repository>.fetch`, in
>> the first example in `git-fetch` doc, which was introduced in
>> d504f69 (modernize fetch/merge/pull examples, 2009-10-21).
>>
>> Rename placeholder `<name>` to `<repository>`, to be consistent with all other
>> uses in git docs, except that `git-config.txt` uses `remote.<name>.fetch` in
>> its "Variables" section.
>>
>> Also add missing monospace markups.
>>
>> Signed-off-by: muzimuzhi <muzimuzhi@gmail.com>
>> ---
>>  Documentation/git-fetch.txt | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
>> index 63d9569..fba66f1 100644
>> --- a/Documentation/git-fetch.txt
>> +++ b/Documentation/git-fetch.txt
>> @@ -251,10 +251,10 @@ EXAMPLES
>>  $ git fetch origin
>>  ------------------------------------------------
>>  +
>> -The above command copies all branches from the remote refs/heads/
>> -namespace and stores them to the local refs/remotes/origin/ namespace,
>> -unless the branch.<name>.fetch option is used to specify a non-default
>> -refspec.
>> +The above command copies all branches from the remote `refs/heads/`
>> +namespace and stores them to the local `refs/remotes/origin/` namespace,
>> +unless the `remote.<repository>.fetch` option is used to specify a
>> +non-default refspec.
>>
>>  * Using refspecs explicitly:
>>  +
>> --
>> 2.39.0
