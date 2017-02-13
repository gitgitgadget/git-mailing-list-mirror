Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39751FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdBMSrr (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 13:47:47 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36397 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbdBMSrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 13:47:46 -0500
Received: by mail-oi0-f66.google.com with SMTP id u143so279547oif.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VGi33PvPzLY0scc/gFSrLduZLYJDScjkvwbVSWX4l8k=;
        b=RnRtH33AY3NfhDTPlZkMhRHe4d4/B3DZMtzA6o4lhqdCxSLfwwUrmQ7U53zqp6n1PR
         GQSxPtWK7vN/fznGlrWr83FSHp+sA0rYI4C5ceAdpgGJoP7mcFVVf0T1VLjKpzt2H7NX
         lredrVRtIeoEksijuQhAxvMllUnqzv5TqknZw40Bo/CnA/SPmLbQ1P+Xss7x4SPDWTkg
         ccCl/ZFvYG4iG7NIyT4B9BrxtQhAO4krCK3NOLdfW2qO1ozUpni8Wcx7sc1k4VdgHmSg
         eJ0HQ7wVk9FGekQzlau9eTzQci/HXpXK1dkvmyodJHCp6z206Bf4iRm6980x7MJ5ub0E
         cBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VGi33PvPzLY0scc/gFSrLduZLYJDScjkvwbVSWX4l8k=;
        b=cNSvcwQAeVToxBlfrrvSb4BzIN9nvdonu2yFGEKEsq8VrBHbOVF5rNjeiV15nYG2T/
         Gvm3IuPPMKj0rnMGWwGmC3gon17/vakyfwrlEUJvBsKv+qyNgBSlremDbt4UbvDWN15C
         NPIL7W1u9B5kSbyJBeUMrsRL4XRdIiSp3nU0AULRXhYx7edF2kIvm/XCjp8YDUOzMo8X
         0J2Q+0kvcu/9aZwBXZAIN245cAlzpJYPkKaQoh4ntCa426QPuzRyJ0V/trZsGe8xQIJl
         /O7LPcvSwrlRD3iBR7YD/vl5X1D/E+yehYbDJ8JTFSNlq5VFFOPPGGiWip/mz8Df0n1D
         SUjQ==
X-Gm-Message-State: AMke39kfyF3dv/G8QWIGpwKkpJbjJa6xyxcbIMocEWKl4a+gWcM1U6xZHACAgrVerox+dw==
X-Received: by 10.84.232.202 with SMTP id x10mr5100356plm.119.1487011665655;
        Mon, 13 Feb 2017 10:47:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id p14sm19235155pfl.75.2017.02.13.10.47.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 10:47:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git remote rename problem with trailing \\ for remote.url config entries (on Windows)
References: <da730b21-58ae-bfa8-705f-7669c0f56764@syntevo.com>
Date:   Mon, 13 Feb 2017 10:47:43 -0800
In-Reply-To: <da730b21-58ae-bfa8-705f-7669c0f56764@syntevo.com> (Marc
        Strapetz's message of "Mon, 13 Feb 2017 17:49:44 +0100")
Message-ID: <xmqqo9y6dj1s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> One of our users has just reported that:
>
> $ git remote rename origin origin2
>
> will turn following remote entry:
>
> [remote "origin"]
> 	url = c:\\repo\\
> 	fetch = +refs/heads/*:refs/remotes/origin/*
>
> into following entry for which the url is skipped:
>
> [remote "origin2"]
> [remote "origin2"]
> 	fetch = +refs/heads/*:refs/remotes/origin2/*
>
> I understand that this is caused by the trailing \\ and it's easy to
> fix, but 'git push' and 'git pull' work properly with such URLs and a
>
> $ git clone c:\repo\
>
> will even result in the problematic remote-entry. So I guess some kind
> of validation could be helpful.

If you change the original definition of the "origin" to

        [remote "origin"]
               url = "c:\\repo\\"
               fetch = +refs/heads/*:refs/remotes/origin/*

or

        [remote "origin"]
               url = c:\\repo\\ # ends with bs
               fetch = +refs/heads/*:refs/remotes/origin/*

it seems to give me a better result.  I didn't dig to determine
where things go wrong in "remote rename", and it is possible that
the problem is isolated to that command, or the same problem exists
with any value that ends with a backslash.  If the latter, "git clone"
and anything that writes to configuration such a value needs to be
taught about this glitch and learn a workaround, I would think.

Dscho Cc'ed, not for Windows expertise, but as somebody who has done
a lot in <config.c>.



