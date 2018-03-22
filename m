Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217CA1FAE2
	for <e@80x24.org>; Thu, 22 Mar 2018 17:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCVRL7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:11:59 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34200 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeCVRL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:11:56 -0400
Received: by mail-wr0-f170.google.com with SMTP id o8so9480068wra.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/mLpxgbIHRJY4gv6AOxEnFArshvrnJK7jPXaUFrEbSU=;
        b=QLq4G9sJeWEj6Qgwn2ySn2m7XqLPzQb3w5BYbi1+n+LRUmL1AA8cCBB02Fh8keZtQl
         ReNWvugwPyi9wN3iFfFg/mfulaa/KSUV9I65KFOajfWnlse1xOYsw3MxI4caxaY+zief
         CJVN1txeFJCtE7dPaw6e8zSGJkkiMnBBPZWfNtg8GvBur52FitcCua/28I9Cprv4PGgp
         q5oF9vrfsy1L5j0a3nJHrUReTQXyg/NyTk4BngIeXlHpt3b4zyrtkHp1VMIRxc1LaiPg
         xydHyaWhaFhnFvXIol7SKWoRNtHx/TN7MVZ4ITK6FUQtVDAVvKszR0ZsEimtAEFUd0jl
         i5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/mLpxgbIHRJY4gv6AOxEnFArshvrnJK7jPXaUFrEbSU=;
        b=VdWZ1Z3RUGgwwJ0Iq42aadjC/+AeoUpSuZKz2dMG6SRaWCm+t3Nxe6egziRqSaRLop
         U2lF0kgBrEuc76jcpw9HrgxER69bfEeKcj3MDl3zjbE0c0fgKiq7e6Z885H/0Aybc2rP
         j9Trjw6OiOhg42H78L1H5Rx9qOdDNk8OdqlCvc4IXAyzU5uJJKy/5WGt26mhZ05OMq2w
         0QSwmanvqULzhjW99WP4XaaJAI3KZ0zjOz/EPokkAee2avL4Te81FBBOLkjIFYQaKmH+
         FZMsCHU7InMvgcwQA++YcIUQ6du2BweaygiiU70zjOPeE2ngsm1ctZF7uuo8vJLekprm
         p7aQ==
X-Gm-Message-State: AElRT7EzNNkl0HqWR5ZMoiYCUL4T+t7oVws4RV/gKyr27addxcBRZEd8
        sebHma93DJzBrZy38Ov/GfqxVYN3
X-Google-Smtp-Source: AG47ELt3OLOsK/6MIO+1m34GfeXx7WYGI5h0g7qjvYPkmxQ3qBI8EUmeAfdj8GeHCR338JgBrx/kYA==
X-Received: by 10.223.164.26 with SMTP id d26mr19828541wra.199.1521738715270;
        Thu, 22 Mar 2018 10:11:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b8sm6269174wrf.29.2018.03.22.10.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 10:11:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: add option completion for most builtin commands
References: <20180321193039.19779-1-pclouds@gmail.com>
        <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
Date:   Thu, 22 Mar 2018 10:11:53 -0700
In-Reply-To: <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 22 Mar 2018 06:12:58 +0100")
Message-ID: <xmqqy3ikkpba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> And that pattern repeats throughout the patch.  I wonder if we can
>> express the same a lot more concisely by updating the caller that
>> calls these command specific helpers?
>
> Yeah. I almost went to just generate and eval these functions. But we
> still need to keep a list of "bultin with --git-completion-helper"
> support somewhere, and people may want to complete arguments without
> double dashes (e.g. read-tree should take a ref...) which can't be
> helped by --git-completion-helper.

Hmph, I actually did not have 'eval' in mind.

Rather, I was wondering if it is cleaner to update __git_main where
it computes $completion_func by mangling $command and then calls
it---instead call __gitcomp_builtin directly when the $command
appears in such a "list of builtins that knows --completion-helper
and no custom completion".

