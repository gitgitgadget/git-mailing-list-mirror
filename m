Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B179B202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 06:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCLG3b (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 02:29:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56035 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfCLG3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 02:29:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so1300415wmf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 23:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d+JGoeWB+q89ELTeBV1J2yGOZwn64tZuNSDJWfCl5dw=;
        b=sNkpo8HSub5AaaS1d3X6iE56Lf1FOI2BGRO4j/0B8SpJLkoECYH1WbEien9vF9BByU
         cDRZiGIoYW82TT/YUYWvvhmx28RFwNNR/XugB9zXIpdD5MJ4RKGNWqbfLpOma1n3Yfad
         toGFuVO5j9QA+MVl3Y7yzJHTcmGqhP6627lyjoVs3SPwesF8bf14FeEPn+V1WXlPFFGF
         Njgl0fQRAGb2Y81w0GG6uYqZkAuJhf42Hs48crUmzGtER8WQYQ+Dp2zXwapxczrbLSup
         bqRqRMZusVUfhB+mU4lydCyuy3+HsonZERZeeWFXrV6erAxDuz/qZFWlZ0dowzjxIbB9
         JPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d+JGoeWB+q89ELTeBV1J2yGOZwn64tZuNSDJWfCl5dw=;
        b=aMXUvHYJFmrVN8wDt+mjvLIgkQwSsO9IJ4JdEI2yHg3LHiSX3Mc85YY6++5JgaYtLv
         peextS4YvSs6pLybFXLyYiX+d6oY/b8q6odaejcUzH9dIrtaUljFfFwBe8aKveHxH8P4
         P1wO36KV0Yh870B9Y1DdyWnmi67KXgEZnNWUDhtIXkLPpe9h5R8/Vph6bkOo8V5luJwL
         fdOVxiD0afSPZg4hVyH/V5PIb8BtiBN93GzePM/1ScKFE5Oy6CvGBocBOw2RFYpdTrsA
         GvPZ0/PiEjdAetGRuy2gw7N6dH8zu5OL/zxK1iKzrLhB6+1oxrZmXiPOJFB0q5cgESDn
         u/Zw==
X-Gm-Message-State: APjAAAWoVybhO1+foFZCut/hel1VTzFhTHP0B7+0bnGgYAWVNpTHyMAn
        +MJCQU3zOwXNhaeoGYnfwNU=
X-Google-Smtp-Source: APXvYqwCAJgZLO7BNT5kqCcZcny6mB2hw5b2VK7DQFn5LUgszyhsJLAllbeDBHyFdodzhxKs4XQ/pA==
X-Received: by 2002:a1c:304:: with SMTP id 4mr1016463wmd.97.1552372169026;
        Mon, 11 Mar 2019 23:29:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f191sm1351565wmg.41.2019.03.11.23.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 23:29:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 7/8] sequencer.c: define get_config_from_cleanup
References: <cover.1548219737.git.liu.denton@gmail.com>
        <cover.1552275703.git.liu.denton@gmail.com>
        <ced1df0fc76c97c9896b6cbb5b4154532461716d.1552275703.git.liu.denton@gmail.com>
Date:   Tue, 12 Mar 2019 15:29:28 +0900
In-Reply-To: <ced1df0fc76c97c9896b6cbb5b4154532461716d.1552275703.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 10 Mar 2019 20:42:46 -0700")
Message-ID: <xmqqef7cip13.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +struct cleanup_config_mapping {
> +    const char *config_value;
> +    enum commit_msg_cleanup_mode editor_cleanup;
> +    enum commit_msg_cleanup_mode no_editor_cleanup;
> +};

Is this code using 4-space indent?  Please don't.  Also, I found
that Eric's comment on naming gave a good suggestion.

Is the cleanup_config_mapping[] array we see below supposed to be
constant, or does it allow further runtime configuration?  I am
assuming the former (i.e. when the user says "default", then
editor_cleanup will always become CLEANUP_ALL and no_editor_cleanup
will always become CLEANUP_SPACE), in which case, I wonder if we can
be more explicit about constness of the table.

> +/* note that we assume that cleanup_config_mapping[0] contains the default settings */

That sounds as if it is bad to make that assumption.  Be more
positive and direct to clearly tell future programmers what rule
they need to honor, e.g.

	/* the 0th element of this array must be the "default" */

> +struct cleanup_config_mapping cleanup_config_mappings[] = {

Do not give a plural name to an array.  Access to an element in a
array "type thing[]" can be written thing[4] and can be more
naturally read as "the fourth thing" (you do not say "the fourth
things") that way.

An exception is when you very often pass around the array as a whole
as one unit of datum across callchains.  

> +	struct cleanup_config_mapping *default_mapping = &cleanup_config_mappings[0];
> +	struct cleanup_config_mapping *current_mapping;
> +
> +	if (!cleanup_arg) {
> +		return use_editor ? default_mapping->editor_cleanup :
> +				    default_mapping->no_editor_cleanup;
> +	}

No need for extra {}.

> +
> +	for (current_mapping = cleanup_config_mappings; current_mapping->config_value; current_mapping++) {
> +		if (!strcmp(cleanup_arg, current_mapping->config_value)) {
> +			return use_editor ? current_mapping->editor_cleanup :
> +					    current_mapping->no_editor_cleanup;
> +		}
> +	}

Ditto.  In addition, perhaps split the for (...) like so:

	for (current_mapping = cleanup_config_mappings;
             current_mapping->config_value;
             current_mapping++)
		if (...)
			return ...;

> +const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode)

static???

Is this really getting "config" from "cleanup"?  It rather smells
backwards i.e. grabbing the clean-up settings from the config system
to me.

> +{
> +	struct cleanup_config_mapping *current_mapping;
> +
> +	for (current_mapping = &cleanup_config_mappings[1]; current_mapping->config_value; current_mapping++) {
> +		if (cleanup_mode == current_mapping->editor_cleanup) {
> +			return current_mapping->config_value;
> +		}
> +	}
> +
> +	BUG(_("invalid cleanup_mode provided"));

Is that a bug (i.e. programming error) or a bad configuration file?
I think you meant the former, but then I do not think we want _()
around the message.  Instead, however, we may want to show the
cleanup_mode that was provided, possibly with the available values
in the .editor_cleanup field of cleanup_config_mapping[] entries.
