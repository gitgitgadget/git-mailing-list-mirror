Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73AD21F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBHU36 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:29:58 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33542 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeBHU35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:29:57 -0500
Received: by mail-wr0-f196.google.com with SMTP id s5so6093147wra.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6SQx2vOBGPokaaEwH3UXXj4G/DBs3QZ0TdzAGy1atIg=;
        b=fZYXK5S8H18kT70MS5lHbfTQY4E/g5iZgjTTKv6FUm5nWOKckskIq7RYVkaV3bo3Qb
         oK+fKx2MG1txrh5TzDHazpZ+OWuaDBchPzUZIlToNMa9mhORsYJbf8MtYYpRjIxC4w98
         QwtepgCOXvGH3zqNhRC0uURmiJEp19OgNdMHF51dDxCRQKINdLsGHjelEdvS0J6VfKO0
         XnnwNC/VnHJNPAgE271IhOBTpwIyauavL4bE4j7QcpG4k5mFN+Q3EGkxyEd01pSAYA+y
         NFjca+MihRrShzW+eqVA3/RFKaqFh11fbrHr5wvlIdbKAeVbY/zYbd2OifRXK7JzGHRO
         h9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6SQx2vOBGPokaaEwH3UXXj4G/DBs3QZ0TdzAGy1atIg=;
        b=oCnDK/ebtgRO0CRXtiSESV2znfhIGcaO8TeXcHAiXkVzZ6x9p43ESnESIwTfR8en7F
         nkbeUO2uBZ5cEL6SKeWRKvVBnS9pma4vFXqr9CWjEhRjXuKin7wbtKhRhypiorb0qi6V
         CBAb6FfbDXDBAY7AF286vqOH/md3qYYjzqsnXwMX6X786kqMYAKElBbrPV4B6Uq680qJ
         N5aPtkb5e6el+KLFHiDEoG81EIpk7B1ymAV2Ab2rkrFFn3wfWeLo7/QH5QePHibpnrts
         j52jgk2emtGuIPoroWTZ5cTt5UIf5v5iKAs3skdHORa554KxJySvPuDWbAW7fIrH1axY
         m81Q==
X-Gm-Message-State: APf1xPDuPoA3dT5tWBi6PrPDye4TshkuLdf6QslJ4704RWa3o1s2WdnG
        KlxdWSHxRNzXIsRox9Bb41U=
X-Google-Smtp-Source: AH8x227zpbxoI1Ks+zBPwqffOgFHjof/QwO00S+xbcgPYDS7829m0j/lP/hQW3pA5X97Srev/bnhQQ==
X-Received: by 10.223.144.198 with SMTP id i64mr415256wri.6.1518121795514;
        Thu, 08 Feb 2018 12:29:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g7sm1026826wrd.3.2018.02.08.12.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 12:29:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] docs/interpret-trailers: fix agreement error
References: <20180208025614.872885-1-sandals@crustytoothpaste.net>
        <20180208101358.af4ecca9865dca4f04431bce@google.com>
Date:   Thu, 08 Feb 2018 12:29:53 -0800
In-Reply-To: <20180208101358.af4ecca9865dca4f04431bce@google.com> (Jonathan
        Tan's message of "Thu, 8 Feb 2018 10:13:58 -0800")
Message-ID: <xmqqeflvql6m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Thu,  8 Feb 2018 02:56:14 +0000
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>
>>  Existing trailers are extracted from the input message by looking for
>> -a group of one or more lines that (i) are all trailers, or (ii) contains at
>> -least one Git-generated or user-configured trailer and consists of at
>> +a group of one or more lines that (i) are all trailers, or (ii) contain at
>> +least one Git-generated or user-configured trailer and consist of at
>>  least 25% trailers.
>>  The group must be preceded by one or more empty (or whitespace-only) lines.
>>  The group must either be at the end of the message or be the last
>
> Ah, good catch. Maybe "a group of one or more lines that (i) consists of all
> trailers, or (ii) contains ..."?

Your version reads better perhaps because it talks about "a group"
without placing undue stress on the fact that the member of the
group are usually multiple---I guess it is better over Brian's?



