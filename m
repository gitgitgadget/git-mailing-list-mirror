Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4BD1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbeGKRxL (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:53:11 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42834 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732987AbeGKRxK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:53:10 -0400
Received: by mail-yw0-f193.google.com with SMTP id y203-v6so9464530ywd.9
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOz6tyIBkYdlPr+tGieYoiVvvhzdCITFRItioasWU+o=;
        b=X4PNIoDF1hegvEHnZfzlaCxYSnQM2b2YaUQVs+XD0DE3nas40pjy5745uEz1E9LSiH
         Dp2Vt4zJZ2aiaeEJHhiMWXodVfO1eCMhmSbadRBe4wytTnaQxBHLA5DMZZKLMaQx78vq
         ILhEAX5ByNXBoSLrYoEwxBlf1BUo8H/jtCXdschTAE4614meKsUY/+GU89oZirMuyejw
         CP1T7vaFxvU/eBqkAII0+NlyNtQQcavSlmTUAWWL/CecEVj0VzZHnsUqQgF1il8q+3BX
         zpSEbm3Sv/JDs5eWO2MFkB6mWIVSz0CVOlG2dJjABXiL3v+uctG69/pbOiEL5YbCUQw9
         2jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOz6tyIBkYdlPr+tGieYoiVvvhzdCITFRItioasWU+o=;
        b=GIR43+GuDL7OxtetpnIQb/ERo0M3rpNpzv8G//LNam/NHYpSr0JoIMZFD4ml11EpCO
         NS5I+2H2DLKTTInKTsPqrfHxu0zTfzcJKSGMlZeNtPMYMnNBd/PwrFHZ9Dn9R45j/t1c
         iljCjpQhgugSgBbzL0wi6cTsZmFpebcLyzqQiZ7dsIz5asz5x7fEjUqe5dXQsEXnimX0
         uk7isYpgNHstWaDHbqZsNdUth9EkintFNE9UBh3FmVaB4ZMfnGYPae50G/29kWp8V7Ok
         dfwamD7DkC8ep2Si3iAG7Qz3NhHb01GDc0L9I6Df+4owhMI4mEiefN9njqIO4va7iCig
         bucw==
X-Gm-Message-State: APt69E1DalW0cynPw/jEQ+cdjXYG3VRBU0CQbGl6ElftjG58lST1bxme
        ugXag8/KxF3mo2sA19JKntjLQYPBZglbgYRmAxomxbwzFh0=
X-Google-Smtp-Source: AAOMgpd8gOMc8w2Dcp09HP1+prfA0liag8calNu35pY902Nu5Gq5Ld7Tsp/WabYLARQ+ERhxhwaGIeD8TShrGY8kl38=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr14828359ywd.414.1531331265730;
 Wed, 11 Jul 2018 10:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.8.git.gitgitgadget@gmail.com> <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Jul 2018 10:47:34 -0700
Message-ID: <CAGZ79kaYpw9t3kCvPnDiLc5z7cLFsVQv4XJDAff_T-bShEjPoQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 10:35 AM Junio C Hamano <gitster@pobox.com> wrote:
> To be honest, I am not sure if there still are people who use
> octopus

The latest merge with more than 2 parents in linux.git is
df958569dbaa (Merge branches 'acpi-tables' and 'acpica', 2018-07-05),
although looking through the log of octopusses I get the impression that
mostly Rafael J. Wysocki <rafael.j.wysocki@intel.com> is really keen on
these. :-)
