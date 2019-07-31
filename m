Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADEED1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 18:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfGaSe3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 14:34:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45354 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfGaSe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 14:34:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so32460108pgp.12
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sPbmyVhtR+sZcYbQI4y+pwYPDRhryt085+LU67zK1Kw=;
        b=Tg3FmKByNu8O5RPy7Zt0V1naFr8lDXOuMf9lWAnyqgSg2mY9Cqhk93V0b88+77J0ZH
         zKBhuGQZkwhqaHlziuLVdj0rh+Mv5w48eWpx1At+Eo4DvKu0oWbwIElVgewL4sNzy572
         kL2gocfLF+uhg/Mu17SalIJhrGXj7V6YquwRIJxFi9sO6fNIGx9BkiV9rf5KDHYSNAvX
         6zxH/61VKTcBNScXduZtRg028vK2v9ufiJrMxF6TcQFSP5vJnY7196cGWL+aowPQgaxW
         Q246ucUjPVPl7J/f5rB9JIiCNffA0sVRD1esZRpTUpWG9Q2/iQrl3gOi8DCAQVJdmUbi
         z8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sPbmyVhtR+sZcYbQI4y+pwYPDRhryt085+LU67zK1Kw=;
        b=sENWWThxvYRF2ieurGRqzc8IPFgCELa6RYaz9YFMbnPJi0Dan5/iCzJv84eiXuzt2c
         xkKk9TdCqQSjWIEmNhDzw8WuF/iiVzLY6g07IM8PkMrd8PkDoucgOjjaPSjgvkW/U7UM
         Gh1fZzkdugRmiOGr7PtrTqfwQivbDkYnDZS3MErfEBjjiEldLCT6Mlykd22BFJNrWjia
         DeR/+xkqYx5hwuiiUqHv1Pn4iO6/Bh/CliaFwmYi4OEWlJ4iJGHFA2FgfDrlTMRsWOCX
         1a0uA6LoWpXleY3q2McqfgFOSsHAJQRUqGOnwT23fSxtWcSfo6c314LtkkyH1Q70NIEj
         KIPg==
X-Gm-Message-State: APjAAAWzgOsBF+FiA5A2eEHBRxDs9Fe3MkwQg2yblC+gTQuztiRHp46K
        E16NtcVV5YdqDga5Y5FSuS3T+A==
X-Google-Smtp-Source: APXvYqzT9vEboR1/LUehhNvoacO0tcG7FyTGPqWDj9coXRYLSJ8PUrCWeyXXDX8I1PDJXnQ7V/eFow==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr4133229pjj.13.1564598066668;
        Wed, 31 Jul 2019 11:34:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id m16sm69323615pfd.127.2019.07.31.11.34.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:34:25 -0700 (PDT)
Date:   Wed, 31 Jul 2019 11:34:20 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
Subject: Re: [PATCH v2 4/4] t7503: add tests for pre-merge-hook
Message-ID: <20190731183420.GO43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
 <cover.1563490164.git.steadmon@google.com>
 <69dc3696e715f9be9e545e0142244e16bdd489cc.1563490164.git.steadmon@google.com>
 <CAN0heSoU7XUN8GOFzzBrLG0RbY65hhYUn_-_Ax1DfFsNZ64hpA@mail.gmail.com>
 <20190729234319.GJ43313@google.com>
 <CAN0heSodNUQ4eoipj7dVi7kr-NhHNyppcMm_SYpGTr_xZbgZHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSodNUQ4eoipj7dVi7kr-NhHNyppcMm_SYpGTr_xZbgZHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.30 09:13, Martin Ågren wrote:
> On Tue, 30 Jul 2019 at 01:43, Josh Steadmon <steadmon@google.com> wrote:
> >
> > On 2019.07.29 22:04, Martin Ågren wrote:
> > > This script seems to me like if it passes 100%, we can be fairly sure
> > > we're ok, but [...]
> 
> > Will squash these as you said in V3. Will also think about whether
> > another test approach would make more sense here.
> 
> Thinking a bit more about this, this test uses two identical hooks, runs
> some commands and verifies that "the" hook was run (or not, with
> --no-verify). If the implementation started calling the wrong hook
> (pre-commit / pre-merge) or both hooks, we wouldn't notice.
> 
> Please forgive my braindump below, I'm on the run so I'm just throwing
> this out there:
> 
> Perhaps (first do some modernizing of this script, to protect various
> setup steps, use "write_script", etc, then) make the existing hook a
> tiny bit pre-commit-specific, e.g., by doing something like "echo
> pre-commit >>executed-hooks", then at select places check "test_cmp
> executed-hooks pre-commit" (against "echo pre-commit >pre-commit"),
> "test_path_is_missing executed-hooks", and so on, coupled with some
> "test_when_finished 'rm -f executed_hooks'". Then the tests added for
> this series would use a very similar hook, appending and checking for
> "pre-merge[-commit]", That should make us fairly certain that we're
> running precisely the wanted hook, I think.
> 
> Martin

That sounds like a reasonable approach, thank you for the suggestions. I
will work on this for V3.
