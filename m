Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E72F207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 22:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1174221AbdDXWh6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:37:58 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34576 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1174193AbdDXWh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:37:56 -0400
Received: by mail-io0-f181.google.com with SMTP id a103so203768739ioj.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lpqyE2B149/d4zs/t373muEAt0REjn2vqEL9yvvDuLk=;
        b=IEzGE3ab3iBbitCFLPwsf5mkbHRQ7K58D0TOZSUa5mb3JpBTYJpZZ7Bh216lL5BIw5
         Llqfm8rP4SPFI9fBxJkWekLve1EByDtRSyntvxzPRmNwmsBnpX/5SE0M+531I6l0FiP/
         sR7BHCgvXLn0ZNMWg0OSIb9hboG/blPoqgj3hrFJjpOY7Qav9hUljpL7gjX4ywBaAQqU
         MlmZ14raDn+gSbokRKJqrY+hQI5J3xKcaA91zRuVKLvqnKLfsAQ2XZfk005XSugkV8QA
         +imTC/BHCDDk1dYEiplRVSv9F8SLUsXwv6kwX4hU6nzvtzvcL9RVGY455EC1Jn4fmgPB
         yZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lpqyE2B149/d4zs/t373muEAt0REjn2vqEL9yvvDuLk=;
        b=b3MvkaSP28fJTAnjS2xT5DLoRsTdJMQKJuIAe6yUaDDQWMZogDGxWDI5UenENTdBCf
         wvRUWZEFTiA1OEVp0N/SJSUkPdSyAwTqvkzECiG9m33vAVC7hyRUjvIIH/jnMmwtG87r
         NEncFBnc3dZzlir/Nq3BCuEoCVZtqhEOLdj7DWmTxX0qlaQf9j2AKNkO+7wt0UBsBNF3
         yibmzN1KB4Vpqws/IgaYvcIKzSBj3p6WLFqFBuNvOK1vSLkBiEkw59KMPr1LjRMJlk72
         nHecdb4QWnkCoAJdRaJnVP7hXWByiJWDAoDIY96Pxcfhr2SwPq9mDaDCU+Lwo5cHVMLN
         DMmQ==
X-Gm-Message-State: AN3rC/5yN6dzwWcXYirUzM5GP3eEOoBe8FJ8Q6i2TPaLJpicB1PteKvY
        VVTZv11dGIDfYCVv
X-Received: by 10.107.48.144 with SMTP id w138mr9732441iow.30.1493073475352;
        Mon, 24 Apr 2017 15:37:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3165:1f91:2c02:1f0c])
        by smtp.gmail.com with ESMTPSA id 123sm8612946iow.28.2017.04.24.15.37.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 15:37:54 -0700 (PDT)
Date:   Mon, 24 Apr 2017 15:37:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: Re: [PATCH v6 00/11] forking and threading
Message-ID: <20170424223752.GB105623@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19, Brandon Williams wrote:
> Changes in v6:
> * fix some windows compat issues
> * better comment on the string_list_remove function (also marked extern)
> 
> Brandon Williams (10):
>   t5550: use write_script to generate post-update hook
>   t0061: run_command executes scripts without a #! line
>   run-command: prepare command before forking
>   run-command: use the async-signal-safe execv instead of execvp
>   string-list: add string_list_remove function
>   run-command: prepare child environment before forking
>   run-command: don't die in child when duping /dev/null
>   run-command: eliminate calls to error handling functions in child
>   run-command: handle dup2 and close errors in child
>   run-command: add note about forking and threading
> 
> Eric Wong (1):
>   run-command: block signals between fork and execve

Just as an FYI there's a bug with this code where it'll try to execute a
directory.  I'm adding a test and fixing it.  Since this topic is in
next I'll base the patch on top of this series.

-- 
Brandon Williams
