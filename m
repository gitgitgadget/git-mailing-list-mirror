Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DC41F403
	for <e@80x24.org>; Wed, 13 Jun 2018 16:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935864AbeFMQBf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 12:01:35 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36902 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935697AbeFMQBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 12:01:34 -0400
Received: by mail-wr0-f169.google.com with SMTP id d8-v6so3336641wro.4
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BN23ij6UTNwtI+rEpH37PYk6eBLQerqAbjQcYSKCAL0=;
        b=jYX+StaCFNV+7raldy3y3QrdKAmJgPGd5QHpnFisvFlCperQHxA+7YVcwkrL+xYFLn
         oyRuvqf+O9kSuN9CSYyd5v32tn7AA4PT20Krz0qLWWE4J3rgm1Zld8sy/Wkzo4K6m8MD
         7PbCyhBOoQqmCdwg6d++fptF7LFeQv4fyYpnLqHUD1xWEtT+NV5HufFqEOW1++ZTc+zU
         OumzmFAFT2IZFxwKc/FN1g16yBhni4QxWb76u+D/qt17uap28Y47G2LHOyvHCiiqCJZs
         iaYvSpqvvty9wMu7kBaJk8Y3N9vuqbU9lrtwFGkvAzhOngA5078Ex0iYHOZ1hDFsxM2V
         dnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BN23ij6UTNwtI+rEpH37PYk6eBLQerqAbjQcYSKCAL0=;
        b=a9Pqd2UzcBaZdPxU8s2TwS04EJp6bJOMXMD+0ZP7cDLpbc9fDYlF/68aEXXBOrdENp
         dUqup5KtpBWvvVA0pYDnxaPpREXZmxNZBgJp1HXaTaLYL85jiHHikahtMRnfHbAG+GLH
         EfpjXuT83ZOPayhnelpQbX9tppVI0PF/OQAzy4KH+lgBjV/ZLTbyliC9xQD7KHmtytF6
         Iy1Nn5V8ARJIbxrXJUeaBsg79R0eau/JQN4i1kRJ/sci6woKjb40o4fMc4HQsWXG4qdu
         Ek7wwn8aB0PnLimTvnZWlx0Qf9lVJaPNUPsiodPLynboDr/2LRpXSYm97RPYcgCSqT6E
         EVmA==
X-Gm-Message-State: APt69E1ehWIoHw2IZyqJpXX3Pyjz8Mojra3UTedkT5Wq/MUq09zJvRez
        EjrEk27ZF07joKz5SVEmXZ4=
X-Google-Smtp-Source: ADUXVKJxiNJFRp9cLKodiJfBrT2TZyzx57CWcqnANdR6triLCJVBkPVXFZVXLNbdUMKuYMB6OhU5Zg==
X-Received: by 2002:adf:9487:: with SMTP id 7-v6mr4976205wrr.82.1528905693083;
        Wed, 13 Jun 2018 09:01:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a17-v6sm3266390wrr.81.2018.06.13.09.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:01:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes 2.18: clarify where directory rename detection applies
References: <20180612235755.11309-1-newren@gmail.com>
Date:   Wed, 13 Jun 2018 09:01:31 -0700
In-Reply-To: <20180612235755.11309-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 12 Jun 2018 16:57:55 -0700")
Message-ID: <xmqqtvq67k10.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Also, since the directory rename detection from this cycle was
> specifically added in merge-recursive and not diffcore-rename, remove the
> 'in "diff" family" phrase from the note.

Thanks.
