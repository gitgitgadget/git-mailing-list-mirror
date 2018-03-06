Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6FE1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 21:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCFVQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 16:16:06 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36288 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeCFVQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 16:16:06 -0500
Received: by mail-wr0-f194.google.com with SMTP id v111so63185wrb.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e33lSBSXxu42HielKDXHEiE0Qg3U9fYtc2umrD4nE+A=;
        b=WJGFdvJwggSVBJUfWv0Je5QLQKFBER2BAKyYs42zKFABT6cssvU1xQxkdaN+PVr9Mi
         RVW8k2BjhCT9WG/oFqmLEBiZwqLVl5EapCZ836IPYEs+L7KsjdQcmvM0cL9chZeai6bm
         /7BSHFuzJrVSwaysgqlld0Suly4HZ2/b6FYvXOW7TQl6ugwzDAL7kJ2O8EM880yS2wuf
         fG3OuwQ/CE3LfdVjENBj/8nQpnyIL9NcTpVXqyzWXE9Qf2b7mW/GQeMW3U4QzHZCbVjf
         5NZ6jrSKSBSxETXFNsk8vMN1iR/NN3b+HnB6kOEkekJzlUjZE4waV4/83zuo/asA1RHm
         ewMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e33lSBSXxu42HielKDXHEiE0Qg3U9fYtc2umrD4nE+A=;
        b=Lh/YrleoXTxUhF7h3jPZKwzlZmiovQbE1EXRbFpL3nvYioag1zYInwFolKNJsdEa/O
         9UirgKLQEC0t/EzZp8F9ZrELR43qNEFZtdXvOD86FwwWGvOpFfwVKv8af6fOukslHkGY
         7u0lEo9OcHE+HQjdTPlUtdP7xaQxdShPO9PCGtzK2NqgajgXLl8Igvw8ZSIuh6NETRkm
         6mew51lfaPyMmxkhmf0xeDLZA0cbLOB3UYT8LzyyjV5KYDpRASWdtLOfBa0NSbSuOXyC
         QtprpYt45gYixysDxhT39QssinpouoD1kQ44JA7Wz+LL5qw9W0jod0cCqhy3wNqc7INd
         mLiQ==
X-Gm-Message-State: APf1xPBz1LjxkI64Y0OtWv81ODqqN9073oK/NSl6ZKsScATIBdw5/QgU
        efPkNruDKMiSujfmB2knkuY=
X-Google-Smtp-Source: AG47ELs6bGoPEC7zvvHRNlKsr1THIudF6qxbMQFxzOnEYVy7pD1sXcNYMjNTeTidLzp4e5kPXQMDkQ==
X-Received: by 10.223.133.182 with SMTP id 51mr15697304wrt.226.1520370964345;
        Tue, 06 Mar 2018 13:16:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h188sm9525462wmf.23.2018.03.06.13.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 13:16:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4] Make options that expect object ids less chatty if id is invalid
References: <20180306193116.23876-1-ungureanupaulsebastian@gmail.com>
Date:   Tue, 06 Mar 2018 13:16:03 -0800
In-Reply-To: <20180306193116.23876-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Tue, 6 Mar 2018 21:31:16
        +0200")
Message-ID: <xmqqlgf43nxo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Usually, the usage should be shown only if the user does not know what
> options are available. If the user specifies an invalid value, the user
> is already aware of the available options. In this case, there is no
> point in displaying the usage anymore.
>
> This patch applies to "git tag --contains", "git branch --contains",
> "git branch --points-at", "git for-each-ref --contains" and many more.
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---

I notice that this version changes the way the case where an
unbiguous long option is given, compared to the previous one is
handled.  And I recall that that single case is what I happened to
have noticed during my review of the previous one, in which I was
not trying to be exhausitive.  

I kind of find it surprising that the one single case I happened to
have noticed is the only one that needed special treatment.  Did you
go though all the codepath and made sure that the ones that still
return -1 (not -2 and not -3) to parse_options_step() are all OK (in
other words, I was just lucky) or does this version change only the
"ambiguous" case, simply because that was the only one I noticed in
my review (in other words, this may still not be sufficient)?

Just double checking.

The changes to existing tests have become a lot less noisy, compared
to the previous one, which is probably a good thing.

Thanks.
