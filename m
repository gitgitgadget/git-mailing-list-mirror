Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2E81F463
	for <e@80x24.org>; Mon, 16 Sep 2019 12:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfIPMHR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 08:07:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45133 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfIPMHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 08:07:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so4119572qtj.12
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/4qe5vKKuH4oxqhwkFatlpPuiESe0RNIvSdadiZSrk=;
        b=omqjNp0aQZPQeHAWiykaAcQ2SDzDsckljmlzF1GRiOdAL+4AcjpTAIKyxOQLrc4DaK
         TELBnc6oXEVRUK9N+kD/OAjJBihOIZSIs6/vqJNXpRAei6mnwVdQOHpmogx8+jEMfgnk
         mmpH95+SoVqK9Pxt232M8Mu3iPdShbNwtZjFnlsJ0KwBvUqFBR4+yDhrkSnA4X1Mzvl5
         1cTqzYpL1XE9VT9WHxDg/TrVTXxLHu1QZgmOPe4dLu6YCEtuAkJn7hXWG7ArHYp0wZ5a
         rFv066VZ9LnFyAyViFwBgJJIR8acdUMW89DVkVjul4s6jkoZsub5+/gsM05uHJGTmx+3
         7Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/4qe5vKKuH4oxqhwkFatlpPuiESe0RNIvSdadiZSrk=;
        b=hnEDu0iRL+24MF8qK9kxlmF3oGjpUOBIwsJvRDfHKW4rtPMbvGPYX88J7PHiT4yRr5
         vsAA5o0SjBkfXoePEClE2ZHi4QTDzXq53QhcsKva0b1aegqObwV9iI3QDj7ki9Gu2u/g
         MS8KDex1S1VWhjzrcoMJh2Z+iQF+py93snxRuOjRtuF9Zm3eObbml/smxkHuIj+tq6Yk
         bOYjG8mDca7hHtNKI7Ameyxa7Ri/3eB3wVH8KvEdUqqa7xDmNupMzYVOz9n9ihXOwkzZ
         WwJmfnPRphudzEblRemnRvv8iaCWZG/AE7GjUBb6IrUHFofY5aAbXuU2Oz9gC6Cuvr0v
         64hw==
X-Gm-Message-State: APjAAAXmjP0m046Wmtxa2eDuwqBpho4x/aUd6DP9t9WYWXrAncyo7Xhz
        xDhExlbdR0JVzbYIEIYKRnc=
X-Google-Smtp-Source: APXvYqz3RlUozEGDXzUhCn0LPGj4Tss0VIHtiFCpRsxnT9HgNKPe6lMYmtCVA/eI8bq5O1ChWBIHBg==
X-Received: by 2002:ac8:100d:: with SMTP id z13mr16772981qti.224.1568635635612;
        Mon, 16 Sep 2019 05:07:15 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a11sm17751227qkc.123.2019.09.16.05.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 05:07:14 -0700 (PDT)
Subject: Re: [RFC PATCH v3 3/3] trace2: write overload message to sentinel
 files
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     git@jeffhostetler.com, szeder.dev@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
 <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
Date:   Mon, 16 Sep 2019 08:07:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2019 8:26 PM, Josh Steadmon wrote:
> Add a new "overload" event type for trace2 event destinations. Write
> this event into the sentinel file created by the trace2.maxFiles
> feature. Bump up the event format version since we've added a new event
> type.
> 
> Writing this message into the sentinel file is useful for tracking how
> often the overload protection feature is triggered in practice.

Putting meaningful data into the sentinel file is valuable. It's
important to know a bit about when and why this happened. A user
would be able to inspect the modified time, and the directory info
you include is unnecessary. The data you include is only for the
log aggregator to keep valuable data around overloads.
 
> +`"overload"`::
> +	This event is created in a sentinel file if we are overloading a target
> +	trace directory (see the trace2.maxFiles config option).
> ++
> +------------
> +{
> +	"event":"overload",
> +	...
> +	"dir":"/trace/target/dir/", # The configured trace2 target directory
> +	"evt":"2",		    # EVENT format version
> +}
That said, do we really need to resort to a new event format and
event type? Could we instead use the "data" event with a key
"overload" and put the target dir in the value?

Thanks,
-Stolee
