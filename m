Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5221F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGW3Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:29:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34066 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:29:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so5431240wmd.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 14:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZVES83GRTePTHSLGWov5q3pdcPEk6P+ONO09FP+qTko=;
        b=ilqqhylI1xecclsH9larNyHP4cjYfiPoEviwKmHkOKznIHpzEM3G0bgiTs5uFzva0O
         1coQf3TnQW4PLyzZot611AkzO9m8FQJQ/O1TsPvl2q+sQnMGUOzkZHh6096drf+sG6gZ
         V8zTnul/Umv1fk2YikYyFWfV+SFAqvKKBrGig2ZTkd3p0m+qs9v9Z3I5U5yEb6iq8mjb
         3yxB+4O77aVvxcEb/IyyaYhyVB4tc7U/dU0H5ZZaCHVMtuhBxp7RGg9Roq6uKAjvtgm1
         RTPz2peJqkta3ZK0HQ8A/h2kxRXoyej2wSEmQN2eqm8bTp4eJV6J97MQdTfY8zxgIkYS
         okYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZVES83GRTePTHSLGWov5q3pdcPEk6P+ONO09FP+qTko=;
        b=KOqS7h77oqFnraUmeG4LckpTqPGy6HjJS1Ayd/Kr0nRv0rt8bjpDkbSjxkPaHapxzI
         nnH3VSc53ZhP4ngqmgzqCTTIEhwUXOmBACg+e5xvbhsrzAeWP5oeJQM5J29DLj58nfTi
         ZGO8gEmn/0KyBgJB+pv3eElyqBIDOeKT5Oo2JFAWOz2lcjo8lZmzy58R50p9w5EAcZJh
         7tJW8FFq39ntcExvTkNfIpppYnNezwKfLQbE37MuJiVyYXF0BpDnUGQQMUpn4giHw6Y1
         iY0B6xzgywGxwF7Q5olTBDyH8+hDu1DD8BGKUg+oYgEmmfdiVYiBbSWxN89bQygqY1Hx
         V/5A==
X-Gm-Message-State: AHQUAuYO94SWhYmoHB57tvsh9knloum8EZIlaF0eP9lfqHaSZ9VELvBX
        ZhgCtNeL41gvxc1bPv9tZFM=
X-Google-Smtp-Source: AHgI3IZ3855e1/CmnS/qLzXPWhyV97ANTFybtZz5GY5wv5ixuktM4ro8k2jnTI3kvaWU+HDbhN0THg==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr9053744wmk.139.1549578562897;
        Thu, 07 Feb 2019 14:29:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c18sm479922wre.32.2019.02.07.14.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:29:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] submodule--helper: teach config subcommand --unset
References: <cover.1549521103.git.liu.denton@gmail.com>
        <cover.1549534460.git.liu.denton@gmail.com>
        <e90dfe992e96b33f167d08fe51df49ab1d10ef23.1549534460.git.liu.denton@gmail.com>
Date:   Thu, 07 Feb 2019 14:29:22 -0800
In-Reply-To: <e90dfe992e96b33f167d08fe51df49ab1d10ef23.1549534460.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Feb 2019 02:18:57 -0800")
Message-ID: <xmqqpns3mdvh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +	if (argc == 3 || (argc == 2 && command == DO_UNSET)) {
>  		if (!is_writing_gitmodules_ok())
>  			die(_("please make sure that the .gitmodules file is in the working tree"));
>  
> -		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> +		const char *value = (argc == 3) ? argv[2] : NULL;

This introduces decl-after-stmt.  Move it before the "is it OK to
write?" check.

> +		return config_set_in_gitmodules_file_gently(argv[1], value);
>  	}
