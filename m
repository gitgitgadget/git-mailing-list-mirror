Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D692023D
	for <e@80x24.org>; Wed, 17 May 2017 02:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdEQCkP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:40:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36527 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdEQCkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:40:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so20830138pfb.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0N50kCn1PMx5KKswiHOqjQl7aunhe7efDxk0Whxuwko=;
        b=cyaC7wMfTk1B1AwAqppJ01bLmUEhlL4FOObiKV8r03o4indhllBPNuiFjvRbADUL5I
         n3B8dEwFfh3tODVvWylKNrPqobpvP1asAavDzUDa733RkGGLtpES788FlaS7uGURTCie
         mqqyJ8K877dLzpw204E4hzZvRQhzFvE9SZQCP5NdRgRPxHfL+9z64YK7LOlT6ZPeQ2fa
         0TFGp4xcV20IdqiWyDLbn4KiZWzYNCC/+UzMRe6Ly3VG4/R8x4HkhVPhX6PY0g9il/5N
         5lwoK7AYKvhmSjgfFCNJpx9iK9QEvI3P5wRW0zGhYXSchIzLJvvPHcpVsdADtFJRq9lq
         FQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0N50kCn1PMx5KKswiHOqjQl7aunhe7efDxk0Whxuwko=;
        b=NQOJme41Fa4TpvPdV4+A5tkLltNbxZ/StgEj+yIVRCPJPPLFXNIQimy8sp+XhK7u7s
         BhW96VFW31zFwygN602VED+oQerDY0EHI5+VJA5qtbWK6w96l/IfGU2HmWZnDLE6SluQ
         BD88WjB0Q6QZZSuGzEPtbNxyRcnj5RgMw8KPuf6FxKu5BbVK1eZKomhKq5FakknltUdW
         yd5tT+B2+DPEJKmtmpFBUYsZpn2mEzxFqZ50pJlJ+qXKX9cMhbRQCw6YxGFOxj/ULR1Y
         Gu+hk1SqzHxTb3VuvLl6sbaU+1DyYmDcMI4N5Ah+Aupje7cMaxLJW4gaGg2P1SW+RbER
         Qfug==
X-Gm-Message-State: AODbwcAyNg5aKCdkNnwW1ydttU6ibKck5sifZ56dCKw/O3t7FeX3aFqB
        1KIrWWa/MjMUyQ==
X-Received: by 10.84.222.131 with SMTP id x3mr1444259pls.33.1494988813512;
        Tue, 16 May 2017 19:40:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id i63sm608801pgc.26.2017.05.16.19.40.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:40:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t5545: reduced test coverage
References: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
Date:   Wed, 17 May 2017 11:40:12 +0900
In-Reply-To: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 16 May 2017 16:55:43 +0100")
Message-ID: <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hi Junio,
>
> I noticed, when comparing the test-suite output from v2.12.0
> versus v2.13.0-rc0 on cygwin, that t5545-push-options.sh was
> no longer being run. (Well, now being skipped because it can't
> find a web-server). Prior to commit 438fc68462 ("push options:
> pass push options to the transport helper", 08-02-2017), this
> test file ran three tests on 'local remotes'.
>
> [I used to test with apache on Linux, but during an OS upgrade
> (some time ago) I decided not to install apache just for the
> git test-suite. (I used to run webgit and cgit, but no more!)]
>
> I suppose it is not a major reduction in test coverage, but I
> don't recall any discussion about it and I wondered if it was
> by accident or design.
>
> ATB,
> Ramsay Jones

I think it was combination of carelessness and not caring about an
incomplete platform environment well enough.  

It appears to me that only a few tests in the entire script wants to
work with HTTP server, so perhaps moving them to the end, together
with the inclusion of lib-httpd and start_httpd that 438fc684 ("push
options: pass push options to the transport helper", 2017-02-08)
introduced, may be sufficient?

Thanks.
