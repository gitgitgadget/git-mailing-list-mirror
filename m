Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B241F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIEBXv (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:23:51 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46756 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIEBXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:23:51 -0400
Received: by mail-wr1-f53.google.com with SMTP id a108-v6so5298651wrc.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tlBjXSXv6e7XVNIH2YgZa76j/ttLXDy4K/XzuVG6VNg=;
        b=CfDduRWoLUlRG4eZNQ2ZbJXRa5/2w0z/gOeiacKqpiRNFGIVgxn4RmbF6IRKHJTAXp
         UaJqQ1YgXe/PuytVke9OnqJzhzIPe5iC6VZmucFfYgDEG0WSMXD8FeECytL0coKSbYEq
         B77iyBTSL0t/f3oaNv+WI8DXcorqBjgFeOoqNNDJA8GJoeq1BBF6zAQAeZRL7h/UDQ3i
         MBGS0mErhx5n8b7zvRb6OQDgJyfG/rtLDgftzjLjBLN0Mq6xJqiAvYe0P2ip5c4ls0gV
         P68hO9WRgv2llJFSmi4nYfLUMkxtIHj2gydMfSRDdUtfywD5WH8MwHr5rokZWtNTxqRg
         b23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tlBjXSXv6e7XVNIH2YgZa76j/ttLXDy4K/XzuVG6VNg=;
        b=ch0KWFr3QEPxnNPJfZp3RdOKTUTXPi8Edu2SoGjxqRpeKDeF3SY+ihGELIwZ02PwYz
         +VcF58/NiQg2Xsv926/ffJlpzh6D9dfX7bzLuP75BedPRlLB4qIeZGtojuPCJn9SnOXJ
         uhf+LEhhWVPP+8x/QqxFEPKHksFcNwz/IAjI2Zk0iwQSd/tLRzjLDIBXSsNqH9EXBMqB
         Hb58DktebLAy3U5XQvpDARhKlmzr+glgvOxmwFXC5hC0JE1WVfDKgYGFTULbTByY24xD
         n/9UXQYljlsQWHD0ugpGOUivsGAib9nVrwukX3wyNiED4JGfjBs7wTlgyoaNKAsNMYWB
         XCyA==
X-Gm-Message-State: APzg51DQYEPicND1vETC5udwsfAmam5ZzOqf6DTmL1qqKynjvXbDUOHw
        CgFU48xY6pLfGdVa0SfekGXP+JmX
X-Google-Smtp-Source: ANB0VdZWYpq+K2y5vi12zXcq5sfLWPgEINbpQKqyMv/J3e6af3MBb2jNbwUgglDy3BscfKk16QxeoA==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr23889463wrm.143.1536094619806;
        Tue, 04 Sep 2018 13:56:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j66-v6sm29564213wrj.28.2018.09.04.13.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:56:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
References: <20180826100314.5137-1-pclouds@gmail.com>
        <20180903180932.32260-1-pclouds@gmail.com>
        <20180903180932.32260-25-pclouds@gmail.com>
Date:   Tue, 04 Sep 2018 13:56:58 -0700
In-Reply-To: <20180903180932.32260-25-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 3 Sep 2018 20:09:32 +0200")
Message-ID: <xmqqo9dd6kx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The three functions init_revisions(), diff_setup() and rerere() are
> prefixed temporarily with repo_ to avoid breaking other topics which
> add new call sites for these functions. This is a temporary
> measure. Once everything is merged, it will be reverted and the new
> call sites fixed.

That's a sensible thing to do, but isn't it too late at 24/24 stage?
IOW, doesn't in-flight topics break if up to 23/24 of this series is
merged?

IOW, the one that teaches "work in this repository" to rerere(int)
for example should have introduced

	repo_rerere(struct repository *, int);
	#define rerere(x) repo_rerere(the_repository, x)

in its own step, not this late in the series, no?

> diff --git a/apply.c b/apply.c
> index fc52993548..fdae1d423b 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4632,7 +4632,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>  		}
>  		string_list_clear(&cpath, 0);
>  
> -		rerere(state->repo, 0);
> +		repo_rerere(state->repo, 0);
>  	}
>  
>  	return errs;
