Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F591F453
	for <e@80x24.org>; Wed, 17 Oct 2018 09:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJQRfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 13:35:12 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35333 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJQRfM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 13:35:12 -0400
Received: by mail-wm1-f45.google.com with SMTP id e187-v6so1436039wmf.0
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fbhhO4P1WzCw7jpWgm86cOh7tOMQu5rfXGs+UgyFBl0=;
        b=jbksCzlCtfkI07/5W/xKMUdprMfhAFDhosHMBnRNMVhTcEgmU9AebtYNw4OTaDE8uO
         TJMmjhNmU6nc8BMDd8iPF0sZncscvVXvXMSmx7wsSv26qyB+6kkH9H2Fp4FglKlcR+im
         06Z0Cvj8u1ZCIXY01vZomiZWOlP8U46j8hKd/MIz29NiqzGbIexE9ZRm2wMyiUa3nlAH
         U46t9T/2zy1/a+aEX275QqLAz12py0crvliXN3fYxT4DiBVyfUIqrVLt3bGmz/DtvD4c
         oN6iOyr7IcmJggy3Bw3tH4RbG8m51q5aM6M91/KVh99jpPFg3YgW/OBNL7kajoF5on38
         SdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fbhhO4P1WzCw7jpWgm86cOh7tOMQu5rfXGs+UgyFBl0=;
        b=B/ycU+oHClwL0zLBGtPQqodWIAJGlUxZPIBgf9wAAs9NlV4sr0xNp0boo0wMMPO0m9
         A2E7tDuCkjtwuvBJ5kpIgHy/zoyvn7Jolrmudv7cQEeQB+shXhAjfWhlUp+Oq0BCjmF7
         uVOvBrvmvwieiW/FYj4HkTbI50JRVXu6jATS/PmtD5RDA2UnGVUJfCVA2FQGuuQe2B9V
         689OQE44N5SfV7kAq3Xg7UYdmZxUB5Zr7NOoogx/wL8fUO+nh+h8oTnE+VV2KtUpitJo
         48OilbKsQlxNfcVQ93bHp3C/yi4Quqwf8xpu8ymSltpkc+79+y7DVzvTwoPGXOGJjgEq
         D65w==
X-Gm-Message-State: ABuFfogN7lgnH0T/jtgdBMWwBkX82wdUjWWlX/vWA/VVIany9ok/TWzN
        rPLrmtCREcgltYqlFfdQUEk=
X-Google-Smtp-Source: ACcGV61/R7wo6q7BUHPM3q9RaIlGnNQbZBJ77QFMw43yf/w/DAWDQxjvHwwYqDpk6fTGzhDDQ1B9Yg==
X-Received: by 2002:a1c:2984:: with SMTP id p126-v6mr2134399wmp.5.1539769219044;
        Wed, 17 Oct 2018 02:40:19 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id n11-v6sm11945319wrx.17.2018.10.17.02.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 02:40:18 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:39:43 +0100
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v4] branch: introduce --show-current display option
Message-ID: <20181017093655.GA11811@rigel>
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com>
 <20181012133321.20580-1-daniels@umanovskis.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012133321.20580-1-daniels@umanovskis.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 03:33:21PM +0200, Daniels Umanovskis wrote:
> Intended both for scripting and interactive/informative use.
> Unlike git branch --list, no filtering is needed to just get the
> branch name.

Are we going forward with advertising this as a scriptable alternative?

> +	} else if (show_current) {
> +		print_current_branch_name();
> +		return 0;

Do we need the slightly different check done in
print_current_branch_name() ? A very similar check is already done early
in cmd_branch.

builtin/branch.c:671
	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
	if (!head)
		die(_("Failed to resolve HEAD as a valid ref."));
	if (!strcmp(head, "HEAD"))
		filter.detached = 1;
	else if (!skip_prefix(head, "refs/heads/", &head))
		die(_("HEAD not found below refs/heads!"));

What's being proposed can be achieved with

+	} else if (show_current) {
+		if (!filter.detached)
+			puts(head);
+		return 0;

without failing tests.

--
Cheers,
Rafael Ascensão
