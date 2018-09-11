Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02021F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeIKV60 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:58:26 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41771 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIKV60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:58:26 -0400
Received: by mail-wr1-f54.google.com with SMTP id z96-v6so26812885wrb.8
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o5Zs+C2L/FFgrFZGeMfPHD81KO3k53EBSpZmaj4TTCQ=;
        b=AaT1e5cVS2Apbf/oEJlGIhbhJXkStR9QiV+d8YknekbsOxkyQ+87f99Focv6LWbVi4
         QjpmVfHe/IeI3ALwboUAmrr9fS7LAOaXI3jBU0DK9hhqRzPoBzmHt6Ssl7nBiu2Oo/AL
         g8amGLQOJygvBqS5aGZ8jFTto3QwSeVn0ERRFtCAgatfBqyHY6Vs3MlQ6BJqagSB1EBH
         8+tJn5aP38oBHmq/jzrQmHt4lKDS7zhe2iA85ejOnqijkB4NWh5AbT1zQxCHK4YTsXLb
         zR6PFAT/DZFuKfIfov2Te27tDk0jvaQiVimXzgjQEN8K1UXdX13swI7amgyM2BS3EP/c
         1DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o5Zs+C2L/FFgrFZGeMfPHD81KO3k53EBSpZmaj4TTCQ=;
        b=AFz0MOXUd63zDyzVR3eaPmDIHrL295SyIQdDAPh+JKY9jPZK3o79wB8iz3amhZhAaK
         n1Rx128aqew8ycxF+9Fi9rgEs1SUJ6gUuJ5LOlEo13RqcILHRVPQtTyCRGCAWE4hG/xw
         1w+xA5HGvDagzrLVYmu3Z7ckOj7DbLlH3kNNhu4px7DZ4D6dzcuetICKtPFyBipe1Zyl
         g+m0ZBT5J5NJVA1HmXTVem0qWGzSZyoZFAa3rsJ7PJJSkd/eXlFRjGw/OwvxsuqoZpXh
         jeTqb1Md73+TmaYIJLsqVTM28FOI7jShvLvV+262JE5zr6cuz6qPV3v667MbojKxwo42
         WkrA==
X-Gm-Message-State: APzg51DaAfd7341JD9RQ/7P7QAkiTJtYbUInRz7MJEWeuqG5X3IX22Pc
        h3DY3PFHq5zKV5Rc4HL5QUM=
X-Google-Smtp-Source: ANB0VdavuUA4n434OHJnyYSud1zfE41bdNFg9jO+Q9kESMGAeVqiik/idwPNaEPKi8yZoi0niFvmLg==
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr20146974wrn.123.1536685093427;
        Tue, 11 Sep 2018 09:58:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v21-v6sm16394240wrd.4.2018.09.11.09.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:58:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
References: <20180826100314.5137-1-pclouds@gmail.com>
        <20180903180932.32260-1-pclouds@gmail.com>
        <20180903180932.32260-25-pclouds@gmail.com>
        <xmqqo9dd6kx1.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZhQJ7TbTuuDO_k-p80rGnOTjVcHf0aoq2+=pG4bwetNA@mail.gmail.com>
        <xmqq7ejz4pvq.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CepuW3DG2AbMiHdoUELHfBmMSZDtPJMzLRHUWwshvivw@mail.gmail.com>
Date:   Tue, 11 Sep 2018 09:58:11 -0700
In-Reply-To: <CACsJy8CepuW3DG2AbMiHdoUELHfBmMSZDtPJMzLRHUWwshvivw@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 9 Sep 2018 10:05:01 +0200")
Message-ID: <xmqq1sa0q8d8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> In the end, there's no variant, only one function that always takes
> 'struct repository *' and I wanted to keep the shorter name 'rerere'.
> But let's go with adding repo_rerere() and deprecating rerere(). If it
> turns out later that repo_rerere is too long (or it's repo_xyz
> everywhere) then we can do another rename.

Yup, I am not opposed to another rename after the dust settles, but
do nto want to see it as part of the series.

Thanks.
