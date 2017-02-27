Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6A420254
	for <e@80x24.org>; Mon, 27 Feb 2017 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbdB0Vxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:53:30 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33044 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdB0Vwg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:52:36 -0500
Received: by mail-pf0-f194.google.com with SMTP id p185so1263910pfb.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mrf0AD7sP8P0GPOsGG06fieju5eRShYJ4mZq/mFz2dM=;
        b=stxmI7MHk0wRddZ9orG8pSCK7GTt5tXvRv3E+P/DIS4D5vYmAdET57MG1Sz/rooLs3
         7Zq9h/CJlzo7nLcr+ozbITAKRgQq7nyLkAwQH3JxXh3qfXszbjKMW3TkADbNrK4a0kZB
         kOTPDQnfrZlJehx36E9bN8U6mUR8gGZUJq7jZbjr+Cj25Qsz8h6rydBiWDzr2Zh7OgV0
         ZRAWcWt7V+mnmUR88nuhq0yBNpl6maLkOP5qPJPiHiRXBdUDIDFqft57Ikp4Vx4vSHQB
         52LY+80c7ix6cD3DrIT4Sbu4Ivg5rGdYwQgndC17tJUwkPXrlTGvCn3KpVUAczhtVzEb
         SGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mrf0AD7sP8P0GPOsGG06fieju5eRShYJ4mZq/mFz2dM=;
        b=JPILhPHHvzXS+pb0LK1ffjnUvkaQp/9fdKP3EwRz+lRhVwa6tLSulPJD3i3ktE6XQt
         h+8lWyZQna8QvZHA95h4mo+YU3xpfm6F3f5ZSs0r5yYfZM/mW7AAZSLuQvtfE+Hz9Skm
         NrJegTDdBfUaoExJyfbppNgL0P2wru4IK8E92+0sllKTw6Fni2afWPML0wNyR1rxZMR3
         eULlWqIy3iRvqb3LJruNLto+lrI1YOJ61viOFbMFc3oaYS3p2s5tvVpaIsyvlVIm/Thg
         VoDlS9UR5nWZWlcahmv03tl2zjXfaIkc16ttQlGObBCLEnJRcGMzwiEXnv9Ceafaobx0
         youw==
X-Gm-Message-State: AMke39kcLgRuIQGhohUZTZz+I6JzBEknMASBf5r1KuybNaAI3XdZCDsvMTd+LGQA8/eSfw==
X-Received: by 10.99.120.65 with SMTP id t62mr23490614pgc.149.1488231868548;
        Mon, 27 Feb 2017 13:44:28 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id 9sm32356045pfk.121.2017.02.27.13.44.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 13:44:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
        <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
        <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net>
        <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 27 Feb 2017 13:44:26 -0800
In-Reply-To: <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 27 Feb 2017 13:19:29 -0800")
Message-ID: <xmqqefyjnwat.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  I suspect that calling interpret_empty_at() from
> that function is fundamentally flawed.  The "@" end user types never
> means refs/heads/HEAD, and HEAD@{either reflog or -1} would not mean
> anything that should be taken as a branch_name, either.  

The latter should read "HEAD@{either reflog or -1 or 'upstream'}"

Or do we make HEAD@{upstream} to mean "deref HEAD to learn the
current branch name and then take its upstream"?  If so @@{upstream}
might logically make sense, but I do not see why @{upstream} without
HEAD or @ is not sufficient to begin with, so...

