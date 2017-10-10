Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7D020437
	for <e@80x24.org>; Tue, 10 Oct 2017 21:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbdJJVUx (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 17:20:53 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:43842 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756550AbdJJTvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 15:51:44 -0400
Received: by mail-pf0-f182.google.com with SMTP id d2so15137378pfh.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sG2mC9liwWu49ong4VjAhz6Ag1D7VsV6oZFKVkkRFuM=;
        b=ITQZs62Lb1uOqozjFv6fV/SLgQDGgx2qMTuXhyekoq7VOpn7EBJcBCj5i/PzSCkBLp
         fK/AiYcYK2UY5kDkO12bHJbhSInl/iRgjMp8i7f9uK0DSpD8DaLVV39PFkcJ0/ATTV+D
         HqAsBFHDh5k3jsNBrm00dYWF0kIdcwOwRXb7TLwPpnDITGW3N27xOs1dnKIzXdBs7kGk
         YF6wDLkpLTLhR1dx0v64BTEnVUwuWL61xLkKcMTsSJxPeq3fppk/3Gk+t0AD8a+tBGZn
         fOQ/pfdrdtaElyZd+otJTd+15X/u7IyA5+Jq2I28p+/S6n0taY9MUbpzUxqBCA8De4dw
         9ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sG2mC9liwWu49ong4VjAhz6Ag1D7VsV6oZFKVkkRFuM=;
        b=IHMmDVihXr04EJWdEKVgcP8xjlgE7Tkb6ku3LW3vDua+XXyrCXLGhYhE2JUG8FDpTo
         L62T/q6PXQ6M7WU/dvAkMIE13GqCWnjrXfKOLbnO7vtqDDz+fksZHxVU0OX+JweKpEeg
         mYtwVqfpdqXBSR9a0fYLQkQJ8qvGB92lxiIjOBZOA/ZNxACZcPxnKWN7n1cw1sLU7a4e
         yRlkteCsAhSs0KPcFwU4Fm+6mp4oQYAhiAHcsJgLxd/t3jk8FvW5wvUsqzTmpEM1fXY5
         GiNn60IByHDghpCOYZkiqwcFBTbqot/z7WnESTbYDJTtW4G6ZlqPME2PwfUHlsApfAk7
         fKwA==
X-Gm-Message-State: AMCzsaU6lQ6Mnn5TgLraA6tEWkOoXRUW9LOyI3gUgzOhgNS9bq4fGdNc
        pSUgvaHSj1cE0t/Y6gj/Qr6Gog==
X-Google-Smtp-Source: AOwi7QAw3YLanHezXZ27eZJZpyHhfXvAXZP7y54JmXFPutSR8UOzJ4OKwHt0yYmImN0Xo9Zo2ZRGIw==
X-Received: by 10.98.65.27 with SMTP id o27mr14643456pfa.327.1507665103653;
        Tue, 10 Oct 2017 12:51:43 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:961:a8fe:b03f:d840])
        by smtp.gmail.com with ESMTPSA id p70sm22787933pfk.130.2017.10.10.12.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 12:51:42 -0700 (PDT)
Date:   Tue, 10 Oct 2017 12:51:42 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention
 mechanisms
Message-Id: <20171010125142.87959e72be8ea5f4abdda0e6@google.com>
In-Reply-To: <20171003201507.3589-4-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-4-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Oct 2017 13:15:00 -0700
Brandon Williams <bmwill@google.com> wrote:

> +enum protocol_version determine_protocol_version_server(void)
> +{
> +	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
> +	enum protocol_version version = protocol_v0;
> +
> +	/*
> +	 * Determine which protocol version the client has requested.  Since
> +	 * multiple 'version' keys can be sent by the client, indicating that
> +	 * the client is okay to speak any of them, select the greatest version
> +	 * that the client has requested.  This is due to the assumption that
> +	 * the most recent protocol version will be the most state-of-the-art.
> +	 */
> +	if (git_protocol) {
> +		struct string_list list = STRING_LIST_INIT_DUP;
> +		const struct string_list_item *item;
> +		string_list_split(&list, git_protocol, ':', -1);
> +
> +		for_each_string_list_item(item, &list) {
> +			const char *value;
> +			enum protocol_version v;
> +
> +			if (skip_prefix(item->string, "version=", &value)) {

After writing some protocol docs [1], I wonder if this is also too
lenient. The code should probably die if a lone "version" (without the
equals sign) is given.

[1] https://public-inbox.org/git/20171010193956.168385-1-jonathantanmy@google.com/

> +				v = parse_protocol_version(value);
> +				if (v > version)
> +					version = v;
> +			}
> +		}
> +
> +		string_list_clear(&list, 0);
> +	}
> +
> +	return version;
> +}

Also, in your commit title, it is "extension", not "extention".
