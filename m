Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E5F1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 18:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfBGS07 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 13:26:59 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35081 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBGS07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 13:26:59 -0500
Received: by mail-wm1-f44.google.com with SMTP id t200so935752wmt.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 10:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sOTa9485n+kT9TrT95dKdz1sUIiWGrA2GanlPtFwYqk=;
        b=c+Lv+vrqNXl3tEXOf56MQT/zIsBNNNJvhYFtMOaEp1w785IKnj7XEE4X0GJRKgKXbr
         88w89pDLLc9kwtIVtu/eN43I73p5GJzqDH4ABsyecTtENgOEHV92uSU7UVOk5tQCK2YY
         RcjQJwx3vHgOCocXtJfAjsevfQ351VV9K1TX+0S31QiXmlX+1LPoCQksyx9QJ5LXtjuE
         6BGcMLFcnxQBUm3BApLLvcPItyGgTyYmdGJHePpBCWoT1y0U3gJTd7euXzquRTabcLEp
         wox0gZrNYb5rPD+sZPw27UgTT9ze5BlpEi74ePk7Ncl+/tImThBDjfqhy6XtjTGI/Nr2
         Htxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sOTa9485n+kT9TrT95dKdz1sUIiWGrA2GanlPtFwYqk=;
        b=MmnbKTvHBeaXxutkOsE89M+o2nTtRePuXeqA3qcEPYWr+kfa/7FxtGidfzqnTtHMu6
         H6xjpjSAsTrHCUk6spGFfEtI6vbVdlecCxPl1xBJOJkpg7VHZudSPSr8a28KJcK/m9uJ
         X3C6g8yNoRo0RXXov1Kzb8W6eZHZD7p17IL/a7oD4Tik/ws9THizR+JbYO+eAfgGOv1g
         9Libof+KhAHwEh6SMac1doTtAcDoGzPsT29q9JvnxtcYT4LljOhdJD24eJ6kizqNbyGH
         CyKDUKf4B6cPQE7JWmsVaEmaii8s8qdqm6EW2P4cZEO11a5COdClucGCZ/2shZbMGVe+
         z+jw==
X-Gm-Message-State: AHQUAubtWHOA5h4r45cBdbaEOW5xvrTwlE1ULvy/MhNi08QSAMfxJYx2
        1zHNsgqASJPk5WE7qZXrnRQ=
X-Google-Smtp-Source: AHgI3Ibq3kO1/PH4o4EiwZpBWd7TQ/ve76zWbxK5By2vrlcYtOXoDko26wYJsfL5xe6ntp9hgFgDNg==
X-Received: by 2002:a1c:f218:: with SMTP id s24mr8967108wmc.6.1549564016963;
        Thu, 07 Feb 2019 10:26:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b15sm2444764wrm.47.2019.02.07.10.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 10:26:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Victor Porton <porton@narod.ru>, git@vger.kernel.org
Subject: Re: Proposal: Output should push to different servers in parallel
References: <173ed6e2-7f33-62a0-e1bd-f4663e68490e@narod.ru>
        <878syskn9f.fsf@evledraar.gmail.com>
Date:   Thu, 07 Feb 2019 10:26:54 -0800
In-Reply-To: <878syskn9f.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 07 Feb 2019 09:37:16 +0100")
Message-ID: <xmqqk1ibpi8h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This seems like a reasonable idea, until such time as someone submits
> patches to implement this in git you can do this with some invocation of
> GNU parallel -k, i.e. operate on N remotes in parallel, and use the -k
> option to buffer up all their output and present it in sequence.

Stopping the message there makes it sound like a polite way to say
"a generic tool to allow you doing it on anything, not limited to
Git, is already available, and a solution specific to Git is
unwanted."

I wanted to follow up with something that says "The 'parallel' tool
works in the meantime, but here are examples of very useful things
that we would not be able to live without that 'parallel' wouldn't
let us do, and we need a Git specific solution to obtain that", but
I am coming up with empty, so perhaps indeed we do not want a Git
specific solution ;-)

