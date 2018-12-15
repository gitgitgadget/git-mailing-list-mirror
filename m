Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB1620A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeLOA0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:26:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32887 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbeLOA0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so7042652wrr.0
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mg0EmGzI1tsNNF9giFDT1vs85r5rM2IdnynD+FARxsA=;
        b=ZLuIZiWQoTFWHS2aRptTeiomp3iEj8U9QC/dokk1zyT6V+My6uejz940MkkyZAgOIn
         78KFkGyaVph3AmEGs9zhEhVCVFH6cHTOKBS/PYqnmyDqwG0HVOGh2yXamen7325um+b8
         4V28oztUn9G1XZqNcMrZGkRI8c16u/O+zx+aixl6SRWfw6SZP7GpYwWcZKnhNBqSDW9O
         pyMApRO6/Z9y+5nY/O3PYRqHRGQBts/pPh83JEaoV8yuAD9eNWhqVin4QONOYxDZZU4S
         nkTnncNMKNjOraoIxOUNbxABUQMyI+dkJSCwHJLxXyq4RtWT+Ck5f37I3db1YN3jJv8M
         Q8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mg0EmGzI1tsNNF9giFDT1vs85r5rM2IdnynD+FARxsA=;
        b=JOmPLehIvGxIcP1+kq29O2rm1zIfHU2DdmaTq+wI0EKdjGS60xBBQNJbNqVIEFfI55
         Vw6V3TUMasi2zuaVZx7h4ZxhuJgODYtFDLkIcBDlAeU6C+y3vYOvXu7p6MNqGmEy59eI
         PvegG6/gDu4TE0FlQD5wkM12a/cnw7zDDe95DYXCE3WERqQb50RGPOg995JHpiuddezW
         Du+MOAME7pQWWpteuEAyyTBBciWeDUybSzKEp2C9ldtRUxqz6YL6aySmSI55w8n9hFQ2
         wENXSfuTzHeATy7w0fgL58dAbpUGNBYhMBj9uN5zWvVicC/5wUkes2wZ8ULDFRc70Kry
         pTxw==
X-Gm-Message-State: AA+aEWbRhT7DUk8iWtkyKXbc2bdyzXpI1TUwZILU6oWLwycbhYx0MTan
        bYCfXptU2R24biDlZDG/F0M=
X-Google-Smtp-Source: AFSGD/VGAnJOug0up3/QVFdjUEF0sf2V7vzHTMEyB+kXjDTBIEcmbOkbVl2nk1KfhQEgtul+dxEAmQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr3914945wrs.7.1544833605483;
        Fri, 14 Dec 2018 16:26:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y12sm4468777wmi.7.2018.12.14.16.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 16:26:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org,
        alex.crezoff@gmail.com, peff@peff.net
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
        <1544760713.970.1.camel@gentoo.org>
Date:   Sat, 15 Dec 2018 09:26:44 +0900
In-Reply-To: <1544760713.970.1.camel@gentoo.org> (=?utf-8?Q?=22Micha=C5=82?=
 =?utf-8?Q?_G=C3=B3rny=22's?= message of
        "Fri, 14 Dec 2018 05:11:53 +0100")
Message-ID: <xmqqa7l7d48r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

> Just a suggestion: since the raw signature is not very useful without
> the commit data to check it against, and the commit data is non-trivial
> to construct (requires mangling raw data anyway), maybe you could either
> add another placeholder to get the data for signature verification, or
> (alternatively or simultaneously) add a placeholder that prints both
> data and signature in the OpenPGP message format (i.e. something you can
> pass straight to 'gpg --verify').

Yeah, the last would be the most usable; anything short of that, I
have to suspect that going from "cat-file commit", rather than using
this new %Gsomething placeholder, would be more practical.
