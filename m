Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770C01F954
	for <e@80x24.org>; Mon, 20 Aug 2018 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeHTRsD (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 13:48:03 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40066 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTRsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 13:48:03 -0400
Received: by mail-wr1-f49.google.com with SMTP id n2-v6so2706046wrw.7
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AtPXTRfc01shOuxj6xQqZgiDCFMAKgpAljVoiVrJMtU=;
        b=lmGe1Cf66937QlDHwrt5KsVIqMPZfn60Nu6NKpkbyfEqerraIWUmVTsnIj6pMc1r8/
         GJhX/TVnEmQrq3mprA9pHFU+ZmjvA8sLlfXkan5YoicQ+7L1aaxw2j2zMCeEptfwTGg5
         lfVFLitmjnTfDZ45jdvj/KBUuSWudPhGY1rlBAjghdwXNtxF+LaL9VTLP2duW1T0bch2
         7gJxYtgjkIiYNnoPUIL1C/ymlbrCEf21d7SEx0io1f0eSGKkoM+aXLx8T1JKCwxYSbe1
         BKYf7FIeeqtmPJ0dGNnXInNGjxI9o1q+cmk8vIfj2iTtXfuXFqLvxX4feTODYLqhdZsm
         YpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AtPXTRfc01shOuxj6xQqZgiDCFMAKgpAljVoiVrJMtU=;
        b=qXMueXptvoyljOhriIXJcwnNQho0SJL6uv6ikVENXxWc3pepSCOeQIO/byaDSl+9nW
         lg3LQi2f4Ez4TRHcdv+w8ky/TrYxhPQHD6h0jqLH+v6CT6akyFEdHVYwH2BFurV80ehb
         lcfCAUCtEn2TkJ1Xq6HdUiN5e2m5t5/41ywxisKvYF5+em+uiRex8Z4RmirjX1vwGRfD
         RKl65y8pjB/lN2YhRsv5V7AFTxWccPfgKFy1def9ibF0dEWSV6QTET0JFeTM4xcaNJKj
         PbmcENAbysEfNSQ18LSk+y4pOelSxjseLBbo7l3C4ZOd1AvYUTjO1DEjdm3mtcXL5d2w
         aJ8A==
X-Gm-Message-State: APzg51Akk5jbQjMt7ob7UP9cYy4PUflSv86aQYp8uRzz/3mPGUlkbAYs
        3JWU+aQFEUI+E65NZiMHAeg=
X-Google-Smtp-Source: ANB0Vdbp/PxIU2oQv6wLOXGFnlzCxuJjLBfDEMsW47NhR3ki1NxlfOxOyC5sZDfXqMv35iKj4tKNHw==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr8515061wrj.275.1534775528631;
        Mon, 20 Aug 2018 07:32:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l24-v6sm9794592wrb.65.2018.08.20.07.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 07:32:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote sideband output
References: <20180807125108.104293-1-hanwen@google.com>
        <20180807125108.104293-2-hanwen@google.com>
        <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
        <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
        <20180818060911.GC241538@aiede.svl.corp.google.com>
        <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
        <xmqqin47acir.fsf@gitster-ct.c.googlers.com>
        <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_NEBeiHWeC8BLKeBhTq_zA2iN2cTrENfPTdfykyM5uduQ@mail.gmail.com>
Date:   Mon, 20 Aug 2018 07:32:07 -0700
In-Reply-To: <CAFQ2z_NEBeiHWeC8BLKeBhTq_zA2iN2cTrENfPTdfykyM5uduQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 20 Aug 2018 14:21:21 +0200")
Message-ID: <xmqq6005cdnc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> @@ -84,6 +86,9 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>>         for (i = 0; i < ARRAY_SIZE(keywords); i++) {
>>                 struct keyword_entry *p = keywords + i;
>>                 int len = strlen(p->keyword);
>> +
>> +               if (n <= len)
>> +                       continue;
>
> I would suggest
>
>  if (n < len) continue;
> ..
> if (!strncasecmp(p->keyword, src, len) && (n == len || !isalnum(src[len]))) {
>
> so we colorize a single line that looks like "warning" as well

That's the kind of thing I would have mentioned in the initial
review of the feature, and I do not think it is a bad idea.

I do think it is a bad idea to roll it into this patch, though.


