Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F79C1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 07:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeJMPeS (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:34:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMPeR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:34:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so15701194wrt.2
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qWDvIhx9U/9LJbN5W6Nd6hXRPH3Q01IvjL41lxzZHIw=;
        b=QkinTY+ajdQfrj+JzUp1s6GNNqHOfRWToSV8dcqr46aCUd+GA28lE+RDidZuHD4WUH
         itJWz6zNGEKa8VMnwe/aJbIi++EI9lMPDhct7Q1J5s/sENFaojBk1ucmJFIH3QlJBk+F
         gyj/c6APWKdSZ+k/S2+jB01JvOVIFPmS+9lHqbSyiks5dIIR1wQmYkysRcFvA6cbjhuX
         NGpoMwITdXy/LPZ+I6dV7vfZQTN9lY6LIMjDM1Nf6SxdiaUvRtoXKkejhhLoSEmZBPQR
         t3ml8wryPQEQHZTeXUTMWz/UT4wnV++Szwp4DoqplDqjPb1KHo/KC5RRvuEcUgNIQwtx
         7CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qWDvIhx9U/9LJbN5W6Nd6hXRPH3Q01IvjL41lxzZHIw=;
        b=N8G+YnjLn5TVMxI1SuJS2VaxWQynxV294SdCfL1NCLw5mJDCbE47+VeEW66z+28w4c
         bWpltp4C6fq3nKBzsAkWEmgjbspS9TP9eH1i0lKvz6aUHboiJzosopj4wwyQyJLDohPd
         Dm3l4QArRhhAhTd5WD6l1vr2UOKoJSbgD6z2Xjnx9A/wqKPFlDq3Mp2F0/qHjJ5/eV/R
         svdNxGs3uZV4iHcttw0ewqLRuzBsGNdnwdJ+raG6MlZOhVxrc4EXe0AdjmeyCAwaQkoW
         HPi9/TgTQdT1CiyP1B9UOyvF++sCfuLsA0Box3a9IxBIBCSnL0eS4x5qNecyd/s9Z658
         oLlA==
X-Gm-Message-State: ABuFfoiy6aAvve/TFztoSYNmcn3fO2KoZ+ig+9EAzP52J9cuUwVtXDaM
        PKxjRMwTOeHO0nN3MgyGzl4=
X-Google-Smtp-Source: ACcGV62OXD1Ve8Ko6QeP2P2Di0wYBqLCIgy9WUIYQltA/8MIME6O9imvfXtz/8/JXsNvMqLsmSJolw==
X-Received: by 2002:adf:90a2:: with SMTP id i31-v6mr7214266wri.77.1539417486549;
        Sat, 13 Oct 2018 00:58:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b139-v6sm7132731wmd.36.2018.10.13.00.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 00:58:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
References: <cover.1538516853.git.steadmon@google.com>
        <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
        <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
        <20181003213349.GA32105@google.com>
        <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
        <20181005001817.GB32105@google.com>
        <CAGZ79kbSF5XM72SOQH7XNyjeCLqQ+AuxOqMPTspjOgk-jEgrzw@mail.gmail.com>
        <20181010235303.GB12177@google.com>
        <20181012233207.GE52080@aiede.svl.corp.google.com>
        <20181012234504.GC12177@google.com>
        <20181012235333.GF52080@aiede.svl.corp.google.com>
Date:   Sat, 13 Oct 2018 16:58:04 +0900
In-Reply-To: <20181012235333.GF52080@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 12 Oct 2018 16:53:33 -0700")
Message-ID: <xmqq4ldq9t2r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Josh Steadmon wrote:
>> On 2018.10.12 16:32, Jonathan Nieder wrote:
>>> Josh Steadmon wrote:
>
>>>> For now, I'm going to try adding an --allowed_versions flag for the
>>>> remote helpers, but if anyone has a better idea, let me know.
>>>
>>> I forgot to mention: the stateless-connect remote helper capability is
>>> still experimental so you're free to change its interface (e.g. to
>>> change the syntax of the stateless-connect command it provides).
>>
>> For v2 of this patch, I ended up using GIT_PROTOCOL to pass the version
>> string to the remote helpers.
>
> Makes sense.  Thanks. :)

Yeah, it does.
