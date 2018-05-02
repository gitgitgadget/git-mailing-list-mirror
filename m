Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1A02023D
	for <e@80x24.org>; Wed,  2 May 2018 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeEBUug (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 16:50:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:42516 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeEBUuc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 16:50:32 -0400
Received: by mail-pf0-f180.google.com with SMTP id p14so1412493pfh.9
        for <git@vger.kernel.org>; Wed, 02 May 2018 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsrNeLWJ/ylfYUS438y2QiHXlQduJnbZfm/iW8ozODQ=;
        b=Sp3Il4ZQnqBzkQAJ26mp48rmmRQgU+RMNIR8YEcAEOcNKDWpXAHVdOsrslk8pM/fXf
         +9qLF4oL3XRPvSdYJh5G+ob2W+v2440eR0gOwl7caYdGXW8ag9rZqNEZN2ZOBFhl+eBx
         rX/3Nt+AsxEGFgpz/ADTaH+Lz3wXssuiiO+FA4wfBSdM/mEf6N8xrQxXKz7VHfE5RyZV
         eMC3j+l+dFURNaTEhAH5Bhc7JD9xyqOAEHPa3awjM+7DXeVj9BN0t23w7wtqUAGTCeGh
         EK53gzVGNEi9NfSs9i0BEVv6kgsfbQEsHBATY0f2aitOcYlcIg14NawbuYd63yt+Xhyh
         +Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsrNeLWJ/ylfYUS438y2QiHXlQduJnbZfm/iW8ozODQ=;
        b=AeTZuWmrWuDM3TsnwujQ6SQZkYjuEbuIdLdQOiX3J3DhOMX70i9aegvgr5n72NiXYy
         4vcxjUF/2pKwmlHw1mgy2tL2al8eCfJi9imqDXr6V/OnhTE2zkn8a54oHrmD03e7j4Ug
         fp6+gsLyo24sXruNdzY87FMGpz8H0CYnazLnBPukRKlnVU5OcdhiulQfInWmeEPHwKUD
         Meuj2U59JmoJRZ414D0rKprdRaOHCXHFPPsupWf9ajSTWXw22kvM8+uwvhWDUBtZ9bgr
         FpAVKVYoCjz3ZpWVuXSQwf3kXJCts6+BjGW6yKKVO+jVXGXgYuIIWC7/HERNfJTehvUQ
         /7zQ==
X-Gm-Message-State: ALQs6tCmKYDhaMHulaapPTo8+04FQOpv2YDsYtIYlUPAfKZSTVNciHcS
        mjLk3MbdzJUmYndv0lOrI5eCiQ==
X-Google-Smtp-Source: AB8JxZoGjlQlFVlDjC/+cmbdnQzgyneGSYkwanH8yQ3QvNrD+BlUVbU1bUU0YPJrmln51MZFmMbFSQ==
X-Received: by 2002:a65:590e:: with SMTP id f14-v6mr17353622pgu.282.1525294231437;
        Wed, 02 May 2018 13:50:31 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b29sm25386659pfh.155.2018.05.02.13.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 13:50:30 -0700 (PDT)
Date:   Wed, 2 May 2018 13:50:29 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jamill@microsoft.com
Subject: Re: [PATCH 13/13] alloc: allow arbitrary repositories for alloc
 functions
Message-Id: <20180502135029.051dcaed75b18fb95ae6b28f@google.com>
In-Reply-To: <20180501213403.14643-14-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
        <20180501213403.14643-14-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  1 May 2018 14:34:03 -0700
Stefan Beller <sbeller@google.com> wrote:

> +void *allocate_alloc_state(void)
> +{
> +	return xcalloc(1, sizeof(struct alloc_state));
> +}
> +
> +void clear_alloc_state(struct alloc_state *s)
> +{
> +	while (s->slab_nr > 0) {
> +		s->slab_nr--;
> +		free(s->slabs[s->slab_nr]);
> +	}
> +}

These functions are asymmetrical. I understand why it is this way
(because we use pointers, and we want to use FREE_AND_NULL), but would
still prefer _INIT and _release().

>  static inline void *alloc_node(struct alloc_state *s, size_t node_size)
>  {
>  	void *ret;
> @@ -45,54 +63,56 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
>  	ret = s->p;
>  	s->p = (char *)s->p + node_size;
>  	memset(ret, 0, node_size);
> +
> +	ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
> +	s->slabs[s->slab_nr++] = ret;
> +
>  	return ret;
>  }

This unconditionally grows the slabs for each node allocation. Shouldn't
more than one node fit in each slab?

> +extern struct alloc_state the_repository_blob_state;
> +extern struct alloc_state the_repository_tree_state;
> +extern struct alloc_state the_repository_commit_state;
> +extern struct alloc_state the_repository_tag_state;
> +extern struct alloc_state the_repository_object_state;

(Context: these were in alloc.h)

These seem to be used only in object.c, and only in one function - could
we declare them "static" inside that function instead?

> -struct object_parser *object_parser_new(void)
> +struct object_parser *object_parser_new(int is_the_repo)
>  {
>  	struct object_parser *o = xmalloc(sizeof(*o));
>  	memset(o, 0, sizeof(*o));
> +
> +	if (is_the_repo) {
> +		o->blob_state = &the_repository_blob_state;
> +		o->tree_state = &the_repository_tree_state;
> +		o->commit_state = &the_repository_commit_state;
> +		o->tag_state = &the_repository_tag_state;
> +		o->object_state = &the_repository_object_state;
> +	} else {
> +		o->blob_state = allocate_alloc_state();
> +		o->tree_state = allocate_alloc_state();
> +		o->commit_state = allocate_alloc_state();
> +		o->tag_state = allocate_alloc_state();
> +		o->object_state = allocate_alloc_state();
> +	}
>  	return o;
>  }

I don't think saving 5 allocations is worth the code complexity (of the
additional parameter).
