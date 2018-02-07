Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF70F1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeBGUrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:47:06 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35033 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbeBGUrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:47:05 -0500
Received: by mail-wm0-f49.google.com with SMTP id r78so5896707wme.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8vommcE9QMIPi4SDsXw/76BKZGHYvz/WepjUy+cJIao=;
        b=Vn+j47THbQs0NXeaMwp7dRuRoy6JPdoW8VtUVRD/BzUMg7vCaVdeu9KndnWSBfP1Y5
         GXVtPUiFhe0Uz2zP0rBf+ezpJSu4G8C3CeKBrnREbVgfcXg4rj7U87tSvrlODy0TQLX/
         CQYBXIkgcWLPWq14ybq1rEKjSGGd/8L5sVoLwZxqtZhNU4CFHqKb4AfkAMdJDt7SEzQO
         Dw3SY/PuWwc1ozcGI70hb8ct0fve6oYskE/yKlXvEMNca8Pvz2aKETZ4Da+/XnbEit8x
         5TpJtpgU+002BGyRsIVymsY4Bnaa+v4RcFTvCGEQSAEyioD92qTbE/3LoPlTIaPzS3h8
         bBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8vommcE9QMIPi4SDsXw/76BKZGHYvz/WepjUy+cJIao=;
        b=c9t7qWyA0bU84aUeGIimTEQEQz+2isb620Eh2yGJ6cqL6+kcvNefEXb2pdcxBJFPTD
         FvdU1IPwtkePAT0bes72fFLQvKPFfH7TPQTQMHbBu8t8aRpgoFh/JbG67mkI7gC/I1wY
         QLJwUgZjKnpS9wYPiaPbd5XKKIAoUyIIas8NrvazdUGnUYfrAj4iIjA45vm94+lC54c9
         uuHlfnt9h0lIkrLvXWfHOD4JjpE0pBZ3iU9x5zzOwrhbCRuNe4xOn/baqiCfkmMFoeM5
         nTLs0Th9Z9sD5gxMsXiR7YFbMeJbo8pCbF8uANdkd8BkKuNmkJZU5RXclKceRljQS75Y
         E1Kw==
X-Gm-Message-State: APf1xPBQ57u14+DwSbDAJVdSD073C7jgGAVo0HoRE0fqxVl/G0g/Gd2C
        4uPQiqKOs9Jr2C3Gzk0tog0=
X-Google-Smtp-Source: AH8x226ANnt+nV6s5mjNvuUda05rD09ve5jM6oUa3jZy4Radk08Y3/UNBfpdff1DmnuUBQ5130lWVw==
X-Received: by 10.28.106.26 with SMTP id f26mr5568114wmc.36.1518036424231;
        Wed, 07 Feb 2018 12:47:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j31sm3806095wra.97.2018.02.07.12.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 12:47:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCHv3] tag: add --edit option
References: <88e7c122-599f-4ab1-6d65-c75f7a3ae8bb@suse.com>
        <CAPig+cQ=Uvp5k7NprzqU1Cfi1b0jj5T63Nxzqg+O5ucinD9fmQ@mail.gmail.com>
Date:   Wed, 07 Feb 2018 12:47:02 -0800
In-Reply-To: <CAPig+cQ=Uvp5k7NprzqU1Cfi1b0jj5T63Nxzqg+O5ucinD9fmQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 7 Feb 2018 05:00:45 -0500")
Message-ID: <xmqq7ero7cjd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 6, 2018 at 3:36 AM, Nicolas Morey-Chaisemartin
> <nmoreychaisemartin@suse.com> wrote:
>> Add a --edit option whichs allows modifying the messages provided by -m or -F,
>> the same way git commit --edit does.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
>> ---
>> Changes since v2 ( https://public-inbox.org/git/e99947cf-93ba-9376-f059-7f6a369d3ad5@suse.com ):
>>  * Add [-e] to git tag summary
>
> Thanks, I think this addresses all my comments from previous rounds.
> Just a couple minor style issues below...
>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> @@ -452,6 +452,21 @@ test_expect_success \
>> +> +test_expect_success \
>> +       'creating an annotated tag with -m message --edit should succeed' '
>> +       EDITOR=./fakeeditor     git tag -m "A message" --edit annotated-tag-edit &&
>
> Whitespace between 'fakeeditor' and 'git' is a tab but should be a space.
>
>> +       get_tag_msg annotated-tag-edit >actual &&
>> +       test_cmp expect actual
>> +'
>> @@ -465,6 +480,21 @@ test_expect_success \
>> +test_expect_success \
>> +       'creating an annotated tag with -F messagefile --edit should succeed' '
>> +       EDITOR=./fakeeditor     git tag -F msgfile --edit file-annotated-tag-edit &&
>
> Ditto.
>
>> +       get_tag_msg file-annotated-tag-edit >actual &&
>> +       test_cmp expect actual
>> +'

Also, GIT_EDITOR takes precedence over EDITOR, so these two new
tests should use it instead, just like other existing tests do.

Will try to amend locally before queuing, so unless I botch that (or
others find other things to tweak), no need to re-send.

Thanks, both.
