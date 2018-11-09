Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1FC1F454
	for <e@80x24.org>; Fri,  9 Nov 2018 02:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeKIMfw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 07:35:52 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37178 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 07:35:51 -0500
Received: by mail-wm1-f53.google.com with SMTP id p2-v6so616341wmc.2
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 18:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YCPjZ1wZv1EXvr7wtUHuVQWxei9fj/K7SZtogsfIt0M=;
        b=HC+KmduiLZ4HOc8MlY/g4p062/OHXnxSKC4ZMHn4ZO1yVTI5cFchOAbxtkzZupTjZw
         h0mqprbJwFAKheipcoAN/CsGUF82g9UFwuZ2Z0j85ARXFCSjAWEKWDJasPsUGIKK+zHi
         d8fat96PVeobz2Y4grHwIcVpmklaOzBPvOCu4fBCasQxHxykHqDHVaRX9XFx49Hrbgwi
         WSt03sFsldZFRh7K7coWl1nOO8XHrZUsrJ6/pjZyQjwIQ73JBHvJ4f8kg/cin6m1d/KS
         DrLGSKXuwtjPEGRlUI19LYznYGR7UwqKiqdjeblBOwS2/ZYluvivmT+asqAY74QGParR
         8tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YCPjZ1wZv1EXvr7wtUHuVQWxei9fj/K7SZtogsfIt0M=;
        b=gz2YkDOKEeJpCnq30TwisDUnFTro5AwiiahmmLf1opnUxtsng8vmNM59+v7/u3rQZx
         uP2Cj4ATP8NrXg3GXWy/NrWRoDj9alQAPnmrm+wpKwhQUFmgNgCAGh8JNgGuUb30n7tJ
         094DGx2vYQ1k0hAAKWlTuuQn1WmbjgwWLDyHGk6vR4ywLZ8EnP4i5MnTu4IY2ESChgXV
         RYBbzpsG7lelSyKhpY7vR1ADQ1oJLhe9LrfNlp8zHEgFA71wVkX1hyMjovKzHkI1pwmI
         cbUjWR5YhFsGdc0g8R0D/ydYiY20LTisktN0/WAnYmYppsJ7nobf8YUFLqRok5OLIxI6
         IEVg==
X-Gm-Message-State: AGRZ1gIV8+ebPjbB49y8P+580DRtwvriCp2JQEFDnzH23UDkGv2jQoz+
        tpU2RWJ1wDH75WWD6JibWqI=
X-Google-Smtp-Source: AJdET5fXLEjYNu8AG92Rf9FTZazagnhtUBkhcBGzT3cF0t5tGOrrqcbUOsi5o9ISgIm0qYng95j3Xw==
X-Received: by 2002:a1c:87cb:: with SMTP id j194-v6mr2882107wmd.2.1541732236118;
        Thu, 08 Nov 2018 18:57:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6085033wrq.80.2018.11.08.18.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 18:57:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        charlieio@outlook.com
Subject: Re: [PATCH v6 1/1] http: add support selecting http version
References: <pull.69.v5.git.gitgitgadget@gmail.com>
        <pull.69.v6.git.gitgitgadget@gmail.com>
        <93fda67198441c159bfcf1dfa467ad76f3ecba76.1541660405.git.gitgitgadget@gmail.com>
        <CAPig+cRpH0k-qams+_1LK9p8hYzBhD-bG3waNLeCSzYWNY41rg@mail.gmail.com>
Date:   Fri, 09 Nov 2018 11:57:14 +0900
In-Reply-To: <CAPig+cRpH0k-qams+_1LK9p8hYzBhD-bG3waNLeCSzYWNY41rg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 8 Nov 2018 13:02:04 -0500")
Message-ID: <xmqqva57556d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -284,6 +285,9 @@ static void process_curl_messages(void)
>>  static int http_options(const char *var, const char *value, void *cb)
>>  {
>> +       if (!strcmp("http.version",var)) {
>
> Style: space after comma
>
>> +               return git_config_string(&curl_http_version, var, value);
>> +       }
>> @@ -806,6 +834,16 @@ static CURL *get_curl_handle(void)
>> +    if (curl_http_version) {
>> +               long opt;
>> +               if (!get_curl_http_version_opt(curl_http_version, &opt)) {
>> +                       /* Set request use http version */
>> +                       curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);
>
> Style: space after comma
>
>> +               }
>> +    }

Thanks, both.  This is almost done, I think.
