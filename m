Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1211F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHCUhj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:37:39 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42127 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeHCUhj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:37:39 -0400
Received: by mail-wr1-f45.google.com with SMTP id e7-v6so6243526wrs.9
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TrmNjM9T3wU3djmREAJg8C/tLDiA2vojeF34Pz3CZqo=;
        b=BqN7MiG/TZywYd07DxGx3NgI61eAopcL1iLWEop31LaAp6r41v2jXXS0rRPS6HT/m5
         Mq+7mlNyGOWjOIZ/5G7qa7XQg4M6E2L5Ak92fI4bIqI6vcEsOoDKmykoGVDTCL1Gal+9
         SFGz8zdGe29hU4kS1TuT9RiQoTA9RJWA0gc77D/gu6yQGZ2l3T1/32VYyOEZO9oIgHJb
         gLwzG21RvWKuqTNiBThnzjz1qRxpSHGnkGyvb6/ENuW7EVLnHc1v7nJSWj+6eGwThhpK
         YB0uRkZuQnPziXswAZePi6uqZzxagtkbEiYk2bXKTHFRAH8Prr1RQ0Wbu9oW6Vc/hiXF
         nuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TrmNjM9T3wU3djmREAJg8C/tLDiA2vojeF34Pz3CZqo=;
        b=RBch8SHZd98jxZcMp/CFPZjPuB7g/rBoM6sSqcf93q3yfP+vE4KzsCweVahGxa0Q/j
         Sr8ece/RmJayBIWta8F0wNM6+eUgEQoQ7P8zedENdxHbTjGHQna6J/1ssVIXYe6haba1
         by/PMJFM5jaWzFzf3A7EBen9z4M248TVKQQHtZ02x3T7gEaXm4Z31QVmLOKN8lS4lSZU
         vYCCRa+NTvl+1jgGcCBaKcktjevLopMTNE+DXoj2gLyc90rra6pnCkTYy6r/O6BZAgzl
         rCXgDLpa+ORped0Q8vCXKdPt4rkyHL1FKQF5lUHbgBWUliwsbRsOCokgQx2OzkQZNUGv
         gXiA==
X-Gm-Message-State: AOUpUlErjvrxGphUMe0zHWOC8tCI6rDicylRxXBxM+2QCk0psmzeBtTS
        AQII5JmPbo5KbDjWEpA2lpA=
X-Google-Smtp-Source: AAOMgpenXIdNZEFXp26rNRvIAO95BbBeJrFcpDbZFJmrCKYnwK7QQslHX0IzN2FGQ4HbFAtDGW9QmQ==
X-Received: by 2002:adf:e405:: with SMTP id g5-v6mr3399425wrm.96.1533321609845;
        Fri, 03 Aug 2018 11:40:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c129-v6sm192983wmh.2.2018.08.03.11.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 11:40:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <20180803180912.GD106068@genre.crustytoothpaste.net>
Date:   Fri, 03 Aug 2018 11:40:08 -0700
In-Reply-To: <20180803180912.GD106068@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 3 Aug 2018 18:09:12 +0000")
Message-ID: <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Thu, Aug 02, 2018 at 04:02:36PM -0700, Junio C Hamano wrote:
>> --------------------------------------------------
>> [New Topics]
>
> I had expected to see
> <20180729192803.1047050-1-sandals@crustytoothpaste.net> (the refspec @
> handling) in this list, but I don't.  Were you expecting changes or
> additional feedback before picking it up?

Neither.  I just am not all that interested in seeing @ used for
HEAD in the first place, as I find it quite confusing.

