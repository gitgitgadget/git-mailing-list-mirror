Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266041F453
	for <e@80x24.org>; Mon, 28 Jan 2019 02:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfA1CFV (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 21:05:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56057 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfA1CFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 21:05:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so12199255wmc.5
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 18:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=fhacsAJYrFtNXmIAJREUvwlJ+oBC4a0YQbx7b5azitM=;
        b=swKEeO0R1GUVBIl7Bjw7URK/9YX5bAgVBTPgIOUEYqIjHn8xHGnd5zx8ra9RvdmmtE
         PgMotfDAmbZyYVhMn7DDK3gkyor/AF09YDht+V1ipuWyKbU26VFR++ykFpcIXg/pkENW
         7QA+CEth9xAFyqf9oq/yfaj8VN4XDZuEGj2/UXcEYCUo+vfp5KeE60IaflVFcBMGYatR
         oRveQryY73l6MOck9ERTxTyH8ymHLDxoo9lbXW1H2It4aZm60bdTK79RXSNt6jPEKnx3
         wlkHwD/990ywg1nHBp2Sou3E9JhwYVU5vEw4cgRbLxfmxMCgZirSz13PwACC/WXm17w9
         9OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=fhacsAJYrFtNXmIAJREUvwlJ+oBC4a0YQbx7b5azitM=;
        b=kxDymwBHLIHkLLJCU+fHQj+VPXuXwNFMhJd+xpUF777ZORghoe23QwPD2iVhjUPF49
         JsuqIWE1mCRGzfu04RnLFXGtQ57QYHsLn85Wne6lmj4m6mVUHXRDvrbZju2PBkKZBJ7K
         D3JXd/tvdZwu/mu+J6SmL7ko7yV/vTI/zrL/cmxUtLnvyzyvwowlUQxe3a/EUbZ0ogac
         A4TTrNzpAqxubhUZPJXlm0/Bxhk47LphxcLAwMlvWu3DpM/MPpmxtit8mvYr0nt/+TY8
         4yoyLhCQ12Dy5VdC6X706PXGTZ4dzVPFalu1vmUJ3KadPe4fmZIkdUyWZ12BlgVxM3YS
         AlRA==
X-Gm-Message-State: AJcUukfUWR9yAgazbVyigsNasD3D4ZJgwwx42A97iTWz3XrSn3vItc6u
        qzL2+3o/P9i4agXzLbo4CMg=
X-Google-Smtp-Source: ALg8bN5UY/DSPg1Mglv1c/TzeLfPp5nNIIcZVScvxdq+DKO7c4oqlk6nxsmgwiWu2iB6Lomnq758Kw==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr15145431wme.104.1548641119039;
        Sun, 27 Jan 2019 18:05:19 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k19sm190466955wre.5.2019.01.27.18.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 18:05:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/8] evolve: Add support for parsing metacommits
References: <20190127194415.171035-1-sxenos@google.com>
        <20190127194415.171035-4-sxenos@google.com>
Date:   Sun, 27 Jan 2019 18:05:18 -0800
Message-ID: <xmqqef8xcza9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sxenos@google.com writes:

> +/*
> + * Search the commit buffer for a line starting with the given key. Unlike
> + * find_commit_header, this also searches the commit message body.
> + */
> +static const char *find_key(const char *msg, const char *key, size_t *out_len)
> +{
> +	int key_len = strlen(key);
> +	const char *line = msg;
> +
> +	while (line) {
> +		const char *eol = strchrnul(line, '\n');
> +
> +		if (eol - line > key_len &&
> +				!strncmp(line, key, key_len) &&

Use of strncmp() here forces readers to wonder if and why we are
preparing the code to allow NUL in key[0..key_len] (as line..eol
would not, because we just used strchrnul()).  But because key_len
was computed using strlen(key), there is no valid reason to do so.
If the code used memcmp(), it won't waste readers' time.

> +				line[key_len] == ' ') {
> +			*out_len = eol - line - key_len - 1;
> +			return line + key_len + 1;
> +		}
> +		line = *eol ? eol + 1 : NULL;
> +	}
> +	return NULL;
> +}
> +
> +static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
> +{
> +	while (to_search && index) {
> +		to_search = to_search->next;
> +		--index;

Style: unlike some C++ shop, we tend to use post-increment/decrement
when we do not use the value.

> +	}
> +
> +	return to_search->item;
> +}

If a maliciously crafted parent-type field has excess ' ' to make
index larger than the number of "parent" field in the commit object,
the while() loop terminates upon noticing that to_search has become
NULL.  And then this return statement dereferences that NULL
pointer.

> +/*
> + * Writes the content parent's object id to "content".
> + * Returns the metacommit type. See the METACOMMIT_TYPE_* constants.
> + */
> +int get_metacommit_content(
> +	struct commit *commit, struct object_id *content)
> +{
> +	const char *buffer = get_commit_buffer(commit, NULL);
> +	size_t parent_types_size;
> +	const char *parent_types = find_key(buffer, "parent-type",
> +		&parent_types_size);
> +	const char *end;
> +	int index = 0;
> +	int ret;
> +	struct commit *content_parent;
> +
> +	if (!parent_types) {
> +		return METACOMMIT_TYPE_NONE;

Unnecessary brace?

> +	}
> +
> +	end = &(parent_types[parent_types_size]);

Unnecessary parenthesis?

> +	while (1) {
> +		char next = *parent_types;
> +		if (next == ' ') {
> +			index++;
> +		}
> +		if (next == 'c') {
> +			ret = METACOMMIT_TYPE_NORMAL;
> +			break;
> +		}
> +		if (next == 'a') {
> +			ret = METACOMMIT_TYPE_ABANDONED;
> +			break;
> +		}

The parsing of this seems somewhat loose.  If there is 'x' on the
line, this loop spins and consumes it without doing anything, which
means that the same commit with a parent-type field can be encoded
in different ways by adding arbitrary number of 'x' just after SP
after the "parent-type" keyword, no?

> +		parent_types++;
> +		if (parent_types >= end) {
> +			return METACOMMIT_TYPE_NONE;
> +		}
> +	}
> +
> +	content_parent = get_commit_by_index(commit->parents, index);
> +
> +	if (!content_parent) {
> +		return METACOMMIT_TYPE_NONE;
> +	}
> +
> +	oidcpy(content, &(content_parent->object.oid));
> +	return ret;
> +}
> diff --git a/metacommit-parser.h b/metacommit-parser.h
> new file mode 100644
> index 0000000000..e546f5a7e7
> --- /dev/null
> +++ b/metacommit-parser.h
> @@ -0,0 +1,16 @@
> +#ifndef METACOMMIT_PARSER_H
> +#define METACOMMIT_PARSER_H
> +
> +// Indicates a normal commit (non-metacommit)

No C99 // comments please.  Not in the header, and not in the code.

> +#define METACOMMIT_TYPE_NONE 0
> +// Indicates a metacommit with normal content (non-abandoned)
> +#define METACOMMIT_TYPE_NORMAL 1
> +// Indicates a metacommit with abandoned content
> +#define METACOMMIT_TYPE_ABANDONED 2
> +
> +struct commit;
> +
> +extern int get_metacommit_content(
> +	struct commit *commit, struct object_id *content);
> +
> +#endif
