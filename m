Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060EF1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 22:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfAGWSd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 17:18:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAGWSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 17:18:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2302318wml.2
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lp0gibfZ5Ri4riJJDuH/l6LfTnBiHUT/+36GabGEgIM=;
        b=AfaHyeLOFxsZ/gC+EI9P/wXtYoZhzgmOUxP7/l9ABNMOH7BhO288KoZslTxrHE5X7J
         CWlDVm4KjzreMflOiyFCoJukKKIkofsxOpIbhpv2PO0551cPgjiWZMl6b6ZAgjl+5H+z
         kCbrQhk2DIbhe7aluNgx0o9GlU1qkVa3Nh7qcZp7rlxZb6//F2LPD6fr0sEAIfJAQ9Cb
         z4Ndfd2jOv9xr+h/7ARESn3rY+rZuO5V4ToF0lXznBH4iKOi5Eqvyaz07zurwt1Uu3UO
         2OO5HeNdnSXXPiOgnpucx/jQCHAwRoWvkUOthRdtYZ+5zTsCQUfa4h3OBfaMeGGMSL5l
         FdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lp0gibfZ5Ri4riJJDuH/l6LfTnBiHUT/+36GabGEgIM=;
        b=cBgBHUlnZET+crGXJvMAO3P3DkMw1vZVDLdM+v8gMAG9KsLOfKW+oUCNG4Iugvjvqi
         hOhaNdxTr+kQ25CLEp279H7Y1Ys0b6nbEaIe50rjSkdkrS5m6B77Z6Yoi4DDgcln/gq1
         /XwASmH2Oh/kQaYgR+sioT/+9MggrONBHGdMugnZqEC/YEAoOfG3KcoBhPWZKlHCT4Rm
         uXrP4jBLayRQZUPXb/UM9Bl9PySi2B2avg7my05bSaWoZlZN9RlKSQS0hBShebaORoIf
         Qt3gnGdarMN2PeFGstAqobb2fVPuVLVKgtlmhjD9++uJ1YZw2/GzxYowp5HbF7UMa28r
         8k/A==
X-Gm-Message-State: AJcUukdtFRt14iUfzZTYN6EKig8zidt4pzszRwHV0RWePEpbc44rxtFt
        WEgtaxKmkiInqHJslhJ1qdA=
X-Google-Smtp-Source: ALg8bN5BFfPIt9HUshIost9fYbLASM/2tFxNCUOrJGFiz0TekbgRraBuFQqt4QznGtaOhSVC9EfYoA==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr9747315wml.121.1546899510647;
        Mon, 07 Jan 2019 14:18:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e27sm57423411wra.67.2019.01.07.14.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 14:18:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] filter-options: Expand abbreviated numbers
References: <cover.1545261186.git.steadmon@google.com>
        <d324e7836928940a4df0b43da3ffeb8526feac61.1545261186.git.steadmon@google.com>
        <xmqqsgyaircj.fsf@gitster-ct.c.googlers.com>
        <20190107212517.GA54613@google.com>
        <xmqqva306rsy.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 07 Jan 2019 14:18:29 -0800
In-Reply-To: <xmqqva306rsy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 07 Jan 2019 14:12:13 -0800")
Message-ID: <xmqqpnt86rii.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>>> > -	`rev-list` for possible "filter-spec" values.
>>> > +	`rev-list` for possible "filter-spec" values. Clients MUST
>>> > +	translate abbreviated numbers (e.g. "1k") into fully-expanded
>>> > +	numbers (e.g. "1024") on the client side, so that the server
>>> > +	does not need to implement unit parsing.
>>> 
>>> I suspect that it is too late now to retroactively say "MUST" here.
>>> The best we may be able to do is to say "The sender SHOULD send a
>>> plain integer without unit and the receiver SHOULD be prepared to
>>> scale an integer with unit".
>>> 
>>
>> In that case, do you think we should also specify that units should be
>> interpreted as powers-of-2 rather than powers-of-10?
>
> If we do not document the number scaling elsewhere, then we
> certainly should, but I somehow doubt it.
>
> Documentation/git-config.txt does list these explicitly where it
> talks about --type=int, but these human-readable scaled integers are
> also used in command line arguments as well, so we may want to find
> a central place that is clear to the readers that the description
> applies to all of them and move the description there.

Another thing.  We may probably end up adding more scaling factors,
but going forward we would not want to require any and all Git
reimplementations to adopt them in lock-step, so perhaps

    `rev-list` for possible "filter-spec" values.  Senders SHOULD
    translate a scaled integer (e.g. "1k") into a full expanded form
    (e.g. "1024") so that an older receiver that does not know newly
    invented scaling units can still interoperate with it, but
    receivers SHOULD accept the following scalilng units: 'k', 'm'
    and 'g' for 1024, 1048576 and 1073741824 respectively.

or something like that.
