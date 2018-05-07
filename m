Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3941D200B9
	for <e@80x24.org>; Mon,  7 May 2018 04:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750811AbeEGEjm (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 00:39:42 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:38207 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGEjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 00:39:41 -0400
Received: by mail-wr0-f173.google.com with SMTP id 94-v6so25807640wrf.5
        for <git@vger.kernel.org>; Sun, 06 May 2018 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pfXTQc+Bzgmx3QqsSRih+0F1cbPhMLd8fFVXFuhzYyc=;
        b=Xt1yxe94qrPlv8NQNwBXnDgCIHK1d6vvqUXJBbXkoYZmaYeZvHN+oi72NFVzp5HmYy
         qhOxPYWb4JdpvAIst4d3UngOd0BUpmfSXXQJx16JCbp2E1FBVYKVAWNpP65C+HMcCUJ6
         y6v9JURP3Iw31Hx3m1DeSuzhQy8MmG3Wr3MPoi6Hqy6wYRGEsJejKXDtErx3QVcFXIhb
         8OFKhcZPbsny56BcM2i+CuODEDFpSHuR3RSlJ0+8hbzb56L7HMNng4y36jHgH0xBJoNl
         SoQNi3EyDsXRyDhemVhzlUnLLx3IjWLfR9Y5f3vcEXKirQklQO0Ty4/HX3RILFoHQ0p9
         dv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pfXTQc+Bzgmx3QqsSRih+0F1cbPhMLd8fFVXFuhzYyc=;
        b=j0JO4K2yj5OvCcHL6MV/JomcD23sZLvFA8mm8QaQ84EMZgqOTs6r1wKFFFVU/96kSV
         8WGYuuhv9i2J+mtFEQVVyq6Kx22RnGi7N3l6XblzmvxtHtx1FaW7RS95ResGbHzRijYW
         ndDTb9L1e2XhE3lFpa0Np6Bk8ExzUpPFJJylVuxZ5LU7yWJLTVJTx7TErFiV1Ry9P6z3
         zwTQsbMbOrGhAg1AjKlkiXT0cPfiwEvmpT8LE76L/trKCNeSqlpD1iNp+wsukAffXQNk
         WNLt+ZUMcKx6cbImu78iy1y4bGQ9Iw4O37hV93iTUimB15xwnF9/WM2L+dBqaKV5fZib
         Phtg==
X-Gm-Message-State: ALQs6tCNGMprEzeuWc6JyG9OiY5k7G/weqZTYUXRMWxgJ4cWz5AOEHUr
        86B1HfgzYvIucTculCcSqkYWa1Ud
X-Google-Smtp-Source: AB8JxZqMwzi4z4oU2bH7RiwA3uQFj8dyl3NtQLOIJNoE3to16bjSciuVJ9zlf4dButNTU2oinFtc3g==
X-Received: by 2002:adf:e6c6:: with SMTP id y6-v6mr13811139wrm.35.1525667979968;
        Sun, 06 May 2018 21:39:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i30-v6sm43886485wra.38.2018.05.06.21.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 21:39:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEL2xnU11jg838k4LGy-4iSJGPk=uQpJLaip-7rSP2KFw@mail.gmail.com>
Date:   Mon, 07 May 2018 13:39:37 +0900
In-Reply-To: <CABPp-BEL2xnU11jg838k4LGy-4iSJGPk=uQpJLaip-7rSP2KFw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 4 May 2018 11:04:07 -0700")
Message-ID: <xmqq1seoqdti.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Junio,
>
> On Sun, Apr 29, 2018 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * en/rename-directory-detection-reboot (2018-04-25) 36 commits
> <snip>
>>
>>  Reboot of an attempt to detect wholesale directory renames and use
>>  it while merging.
>>
>>  Will merge to 'next'.
>
> Usually you have a mini-release-note in your "What's cooking" emails
> next to the series, so I'm assuming from the text here that you might
> just be intending to re-use the release note you used with the
> original series.  For the rebooted series, it is probably worth adding
> something to the release notes about how it also fixes the
> unnecessary-update issue reported by Linus

Thanks.
