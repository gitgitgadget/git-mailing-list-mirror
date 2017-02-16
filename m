Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100E91FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933566AbdBPVUB (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:20:01 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32939 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933107AbdBPVT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:19:59 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so2406469pfg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O9OrS3Rc+q/AHnJQCQ00RHG7HT8D5RHmmKB2iKK8r8M=;
        b=MollcAehsEH7cHbBAzMNft4rea7EBKNQ43FKk1+makKN7Lv25Fkf/fB5P3NU05jnxO
         Imc33nOTOAyXeAowlzlb5TQERwI6Y7++tPuvpf2FnnCbYXpN61WlcTfZkandY0Tm/4Yt
         b/q9oEITcAiptQXcEP+dPfoMlrvLnJ1eB6k8fOgEFjgj3fI/MKz5X/cE1TzZ5BzfmV+o
         YBMn7qYem3uQDGK+UxcdagyLG8R09Gx3RmgAAU2UHdz4pR+fZ1zOm+NIq6zrnW6DFvqk
         X+NU7xCbVzzEEMDLU+Ts3ERsMn0m/+HAC2jbvAT56vckT5HOHnm0T10Mj+e+HrJn5jpC
         Qqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O9OrS3Rc+q/AHnJQCQ00RHG7HT8D5RHmmKB2iKK8r8M=;
        b=Sxv+KdgULh6jFRB4R1d9+VTanlIvNWFDLmuey6avQcI5PgHj4VxbAjI4nnA1X15FnF
         EO3Z7acm+ptNJ8p2HVUIhgbctZPgPEMw8bKb8zFNVK+cXVftcBbqoArmiD/L8+gg0k26
         0Z+NRJiPmSsPG4u4sAB2+jHafaUqF22IkckDxUnJ5CT/Ji73xAfIdeW7SuuyKOYDRMQl
         7wtXjukimRNfaWArA1rHTh9hcDa5i/ViQVnnRRxytVb6keBPFvGejcNxxgezfa09vPCw
         ZwsR6uIIZJFdx0yv06A/qE64GXZ4EWaEttpcHXlj0or/6ipoUN5ohj7FFLfiriu5hsfx
         wjcQ==
X-Gm-Message-State: AMke39nKYyFAyK4igDAypVcCV3DQaBQ3oXAzT+uJDi85J+LW3kPhX7L7XHh6j+RL3xlnNQ==
X-Received: by 10.99.177.79 with SMTP id g15mr5488989pgp.185.1487279999078;
        Thu, 16 Feb 2017 13:19:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id 9sm15255578pfk.121.2017.02.16.13.19.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 13:19:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        sandals@crustytoothpaste.net, jrnieder@gmail.com, bmwill@google.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH 11/15] unpack-trees: pass old oid to verify_clean_submodule
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-12-sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:19:57 -0800
In-Reply-To: <20170216003811.18273-12-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:38:07 -0800")
Message-ID: <xmqq37fdx282.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The check (which uses the old oid) is yet to be implemented, but this part
> is just a refactor, so it can go separately first.

If this didn't pass an unused parameter, then the change is just a
refactor, and I do think such a "just a refactor" can be a good step
on its own to keep the future step to manageable complexity.

With an unused parameter being passed, I do not think it is a good
logical single step anymore, though.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  unpack-trees.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3a8ee19fe8..616a0ae4b2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
>   * Currently, git does not checkout subprojects during a superproject
>   * checkout, so it is not going to overwrite anything.
>   */
> -static int verify_clean_submodule(const struct cache_entry *ce,
> +static int verify_clean_submodule(const char *old_sha1,
> +				  const struct cache_entry *ce,
>  				  enum unpack_trees_error_types error_type,
>  				  struct unpack_trees_options *o)
>  {
> @@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
>  	struct dir_struct d;
>  	char *pathbuf;
>  	int cnt = 0;
> -	unsigned char sha1[20];
>  
> -	if (S_ISGITLINK(ce->ce_mode) &&
> -	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
> -		/* If we are not going to update the submodule, then
> +	if (S_ISGITLINK(ce->ce_mode)) {
> +		unsigned char sha1[20];
> +		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
> +		/*
> +		 * If we are not going to update the submodule, then
>  		 * we don't care.
>  		 */
> -		if (!hashcmp(sha1, ce->oid.hash))
> +		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
>  			return 0;
> -		return verify_clean_submodule(ce, error_type, o);
> +		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
> +					      ce, error_type, o);
>  	}
>  
>  	/*
