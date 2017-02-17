Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID,URIBL_DBL_ABUSE_BOTCC shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF771201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964799AbdBQWxT (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:53:19 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35084 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935107AbdBQWxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:53:18 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so4933329pfx.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1wnqfAng5+p0YXe0JQb03mIzvzcEbJ3PRFP3vV6INuk=;
        b=PI9chW7j25CxZ5QJviI12sBHRcq4VpdH6FFkPXEm3dOU4iqY9mNOdCpsnPSUhkXwS9
         47zO0tBcFBsSITkvpoTIFlNn1vAmxB3smPRru3YEzm9DAXpGFs2GO7onN9/O8mLTKvjF
         HVzimePvhSy7QozNAi4Nj4246ae9T3uwjEsM8beyvxKgfu3GBWx2N513LZvQwU9WE43O
         R55ShtAUvKKZir47tPcDFjKbSEEUFi9AcUgWN68BvAw/0dyaG1eaieD1p478zx7+y0SI
         PfN9F/LNgVuE+tpXvD/RJjkQRE60VgU2VW5xdKuifci92fXCL1jdc1aosjLsv/j6rs0d
         MRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1wnqfAng5+p0YXe0JQb03mIzvzcEbJ3PRFP3vV6INuk=;
        b=kmYdrr1qV+dwxbWKeNqMgeBvyMcJLyLoo1JLia9fVeeL3NHZ3Jva4VFHgKqGi9tuO7
         XCgjDIjPtUcM59atCaPYPWPSZL4hD7bfV6ekmOZPuSXTkvgrnYhw9Kot2ryZYcM28WYZ
         foRMb46CjnJ8A+zkSWVK636T1YwmR+/dJLUrDx+LeB5LmcfktLWnARSaoQzzKNQlVfXQ
         HSU/R2bgAnLyApX47r+GdUv9/LwqvfRjtnYN71Pa4gBkiiq7ktBYME9idrLQhryahWZp
         wtRKBNXnP8+msZJWlw/ClYxumj/MT6oW5j/TF5JWyDkQJ06b0JzbuME/UheFnvzexDKa
         xUYw==
X-Gm-Message-State: AMke39miQaQtVWDXOYCsMrYrJgPdHh+LFR8zGs1PK+wwRQamKLsbRFbFsfvYA9h533Zd6w==
X-Received: by 10.98.21.196 with SMTP id 187mr6057228pfv.110.1487371463831;
        Fri, 17 Feb 2017 14:44:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id x65sm21320377pfx.115.2017.02.17.14.44.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:44:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Gr=C3=A9goire?= PARIS <postmaster@greg0ire.fr>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: dotfiles in git template dir are not copied
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
        <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
        <xmqqmvdkqxfd.fsf@gitster.mtv.corp.google.com>
        <9894f34a-d362-7741-b5b8-3743fe8f4e0b@greg0ire.fr>
Date:   Fri, 17 Feb 2017 14:44:22 -0800
In-Reply-To: <9894f34a-d362-7741-b5b8-3743fe8f4e0b@greg0ire.fr>
 (=?utf-8?Q?=22Gr=C3=A9goire?=
        PARIS"'s message of "Fri, 17 Feb 2017 23:37:24 +0100")
Message-ID: <xmqqvas8phdl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Grégoire PARIS <postmaster@greg0ire.fr> writes:

>> I do not think we should change the behaviour
>> to copy files whose names begin with a dot.
>
> So bug turned feature it is :)

There was no 'bug' either.  It's just the way it is ;-)
