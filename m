Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B69F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 09:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeGJJTi (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 05:19:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44860 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeGJJTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 05:19:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id d17-v6so3968979eds.11
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0/iZG49n2CV4mjd1FBWEz1jiGIx4oSDayw4OtBaVgc=;
        b=qj6DsfAqXZfEmcNDxN57EX6cdnnbBvtDIw8qSD4jLchlww3TqI53R6ykiVq5QpvOWt
         xNU0iiCErIKXQCXjPJrD0SpWgv8CrI4rOGKGHCdtAdA5U6FQaZ1kT9k5AgJYMJmzlrdk
         pVHLW0IYHmL/wtyaN4xG2cfKGsNcT7VkpSe21r5aORKcGtl7r59n9fnRwV6It9YXHQZi
         nRF+5KE56KjrKED/wRXxY8XdD8pu4mMQccVXBA2dkSP+Sr0YK0Ba3h6fcOVSBMPovXRx
         mwyj+8CM/uCWWon8YfpXaBL8iKcQWmepQlKEXdjQrBY7ma7DWn7QOXRgSiSnbcO4RLEs
         vfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0/iZG49n2CV4mjd1FBWEz1jiGIx4oSDayw4OtBaVgc=;
        b=PQ6unl249W+R1h8mNlFbs9VpTDqqSGryie6IavWrLtda8upF+goW3My/4AwNSa+SyQ
         1aJnYN+fH5PWfRyIOLCRL1XRNXyt0gXSPu4zJ+QbYmhlq5Vr18vsSTbiQrwcFf7Ouka4
         Xid3+jicaz6DFq0ic2f2bLuXo6XGgAc7hIDJMlVtiQClPDBGktKERXFaj//7lbyr+GXI
         e2weW76crUEzN/d8YzpEYdj2KqA4qL3MxfiGutHGKzMsVZfPH6v68kQvXeBzhCj7zoRF
         uwewPMFSCe/QXWO3WbswmhJHWSQCIAo9DMERk2H6gnMbOi5r2FwUTWj/epV4s2izdt7k
         8lHQ==
X-Gm-Message-State: APt69E0W5xCqanGy89tNc5wpwPIaCYwRAo3wIRyuHRMnw8rjsUN2LaHL
        MH8F4GVUm7piB9fP28XMYSBjmA==
X-Google-Smtp-Source: AAOMgpfksNHRKziltyEgQyIKV0h28gaYqwjpfbUi/bfbH0MZULxcCM8RfcKa6+cpyp9vXupMTh2WBQ==
X-Received: by 2002:aa7:d60d:: with SMTP id c13-v6mr23402129edr.301.1531214376637;
        Tue, 10 Jul 2018 02:19:36 -0700 (PDT)
Received: from localhost.localdomain (x4db10d5d.dyn.telefonica.de. [77.177.13.93])
        by smtp.gmail.com with ESMTPSA id b18-v6sm8582160ede.21.2018.07.10.02.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 02:19:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] ref-filter: merge get_obj and get_object
Date:   Tue, 10 Jul 2018 11:19:25 +0200
Message-Id: <20180710091925.11061-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com> <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>  static int get_object(struct ref_array_item *ref, const struct object_id *oid,
> -		       int deref, struct object **obj, struct strbuf *err)
> +		      int deref, struct object **obj, struct strbuf *err)
>  {
>  	int eaten;

Here the variable 'eaten' is declared, but left uninitialized.  This
was fine until now, because ...

>  	int ret = 0;
>  	unsigned long size;
> -	void *buf = get_obj(oid, obj, &size, &eaten);

... this line used to set it anyway.

> +	enum object_type type;
> +	void *buf = read_object_file(oid, &type, &size);
>  	if (!buf)
>  		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
>  				      oid_to_hex(oid), ref->refname);
> -	else if (!*obj)
> -		ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> -				      oid_to_hex(oid), ref->refname);
> -	else
> -		grab_values(ref->value, deref, *obj, buf, size);
> +	else {
> +		*obj = parse_object_buffer(oid, type, size, buf, &eaten);

However, with this change 'eaten' is only set here conditionally: if
read_object_file() doesn't return a valid object buffer, then 'eaten'
remains uninitialized.

> +		if (!*obj)
> +			ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> +					      oid_to_hex(oid), ref->refname);
> +		else
> +			grab_values(ref->value, deref, *obj, buf, size);
> +	}
>  	if (!eaten)

And ultimately this condition could depend on an uninitialized value.

>  		free(buf);
>  	return ret;
> 
> --
> https://github.com/git/git/pull/520
> 
