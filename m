Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5EDD1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 20:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeI2Cgv (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:36:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI2Cgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:36:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so7600751wrh.7
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6pD3OnqqmdACRD81Vyw0gxV6wl9jXONKM8BWDaueTDs=;
        b=GUVw+r9FcfDgNts9hLn70CwVhsI5X3mfRIp2PxhlCJWfmsNUu7ZSmplfMSX78c/r+w
         4RfdkaBMKEXBoFDf1/oFF+AdYspAkdzDaHpcU/UZfx739xfzQlnYsja5nT6Cl48TRHxs
         kvNiapmgKVabOYoTymwpKTH4sH8QkjXGWbJSeOKe/NIidM9SRybbyYsFver8m2ANvCl6
         0aGfEufmV9yGsGH9kK1MsaBabkeCLj6ZJNqGslfU7Fw9XO/16w06QJ/UJLoT0N1rlgxb
         +Kj5PzJd52oOqvCCflHqQ0DkJsE8tGV4HS98j/2p8uyhX1/WT2WHRAPmlSzfOKkD3R7J
         yWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6pD3OnqqmdACRD81Vyw0gxV6wl9jXONKM8BWDaueTDs=;
        b=RliwP1OMbkFVHRglhfEjucU669nCojV+f/Vs7njsfXyL+Zghptd3YkohpCJWepMppl
         IPC6kZXw0QqVAijOpKvykeRRJSIbNYArMZvMlfR4PyL4EwMKYO7QxM/ffNkdJfoZ3OYW
         fIF4oLnDCPYTycWUE0GU1KTQXcfTKxeP87dH/iwiuyN03XdgTubEcaeBF7lkeAU7q0bu
         8Kami4s+Jhw1MKNYg0AkvTCz0B8SJTZy1BLZ1hSgtUOfm9BzOjHZSA9McyEzirDzrVmX
         HiCGAwET26zsbkyx58+ZfNenbcqFhkjGh9q+fpD4UwVTlZt7mDtwHzHYNcGS2D1oezyw
         fMGQ==
X-Gm-Message-State: ABuFfoiNjlWmGZPwTbX9YyphzmV7qZEH6dpu93Xb06Od9FyKx0tCICkx
        SSXRfmfAPEfDJcWl0OIA/ss=
X-Google-Smtp-Source: ACcGV61DAFYnqUeXLX8DahqEBoFo7M7TlLO7Rb1As5VfCIBFYAaiK1BhI0FdWepucHqw5ToJbxJmXw==
X-Received: by 2002:a5d:5391:: with SMTP id d17-v6mr118212wrv.191.1538165487958;
        Fri, 28 Sep 2018 13:11:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y128-v6sm2089071wmy.26.2018.09.28.13.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 13:11:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH] strbuf.h: format according to coding guidelines
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
        <20180928173033.159192-1-sbeller@google.com>
        <xmqqr2hdbdp8.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Sep 2018 13:11:26 -0700
In-Reply-To: <xmqqr2hdbdp8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 28 Sep 2018 12:54:11 -0700")
Message-ID: <xmqqin2pbcwh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> So let's format strbuf.h in a way that we'd like to see:
>> * omit the extern keyword from function declarations
>
> OK
>
>> * name all parameters (usually the parameters are obvious from its type,
>>   but consider exceptions like
>>   `int strbuf_getwholeline_fd(struct strbuf *, int, int);`
>
> I am mildly against giving names to obvious ones.

Just to make sure nobody listening from sidelines do not
misunderstand, ones like getwholeline_fd() that takes more than one
parameter with the same time is a prime example of a function that
take non-obvious parameters that MUST be named.  

What I am mildly against is the rule that says "name ALL
parameters".  I tend to think these names make headers harder to
read, and prefer to keep them to the minimum.

I actually do not mind the rule to be more like

 * Use the same parameter names used in the function declaration when
   the description in the API documentation refers the parameter.

That _forces_ people to write

	/**
	 * Read a whole line up to the terminating character 
	 * TERM (typically LF or NUL) from the file descriptor FD
	 * and replace the contents of the strbuf SB with the
	 * result ...
	 */
	int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);

which is mostly equivalent to having a rule to always name all
parameters, while still allowing "sb" to be omitted by rephrasing
"the contents of the given strbuf with the result ..." and I
consider that a good flexibility to have.

