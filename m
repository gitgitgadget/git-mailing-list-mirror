Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E915D1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750779AbeBUVo0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:44:26 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45916 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUVoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:44:25 -0500
Received: by mail-pf0-f195.google.com with SMTP id j24so1208955pff.12
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqwQaczBnM2M30be4pGdGVSVIgwTzewf6P4sCwxdZyQ=;
        b=o5eCDO6J6yowJdstFGbNPrzOzXKracPy4+xpRSZQScitFPIlrz+e9m0JOMufeIj2ph
         2SvRkwnrrgIPhI8vCRoXRep/hdWt/jZrbNDiCBHbVdvli/AnPbwGnvr1Q2Ix2BJXZ7JY
         gl/QAENohVOqjIX9BB8KCElbfmTBOLIoCTrZ+qv3L+lD+X0Qp6VVKJSk6uB7Vhy9MBej
         8okgWKs3BEBTRH4lJUZgbP+dFboWh65z3ISDb4JU+sxZjUilzziUH5k+B3/RjEhi1+OG
         HqbhDgOHFx5FNLH7t2qdjBGBbXu/mccPqBhFN6wUahseUOMrtyBBXs7oYrFpzFx7gcWc
         Xi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqwQaczBnM2M30be4pGdGVSVIgwTzewf6P4sCwxdZyQ=;
        b=Q+jGs/RiM5L8udVKjrSSPQjA8TFzoykSBHKma09HHwnTAmaMiqeHc8gASBryVJF+iB
         WfueFkawfO3Yrf+ZtPATqQ0w08itrdIOoLyZU6LIK9PXS89jnfZyTiDL83M07WVOzM8C
         yqeVaNIgP0/rOFV2txjU4yDh07NYNzHBZABqcZBYEQO1zsZLn6O9MAVjchxZiPEQKMwj
         WDz3/wVo7RjYIlLiJP455YIGLe8lOGAmCIr10hOoMuxElqZyHqti/YD19sLiWS+GiJrW
         BcmfWv7AQXke9CZuc/3eakSwSqRdPYjOkcHIZ8+PQrfOiRV3g0B0bZzOyv6QF9lZY/OA
         ixbg==
X-Gm-Message-State: APf1xPAGIn0/pRJ4HL8zCP6aPIn0KCIUGpOqK6t6t9UW7/08IFC3DAaz
        kW1YH31zqPfEYYmFVR9TfuYymQ==
X-Google-Smtp-Source: AH8x2269HSX63WKZMYm1Q9WT9ZbwJSGdb5B43KyZk5x7D7YdkuKAzzgrP0sypzkBTN68XDb4vQJ5ZQ==
X-Received: by 10.98.14.200 with SMTP id 69mr4574735pfo.168.1519249464805;
        Wed, 21 Feb 2018 13:44:24 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id c14sm24941473pfn.185.2018.02.21.13.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 13:44:23 -0800 (PST)
Date:   Wed, 21 Feb 2018 13:44:22 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-Id: <20180221134422.2386e1aca39fe673235590e7@google.com>
In-Reply-To: <20180207011312.189834-5-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-5-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:41 -0800
Brandon Williams <bmwill@google.com> wrote:

> In order to allow for code sharing with the server-side of fetch in
> protocol-v2 convert upload-pack to be a builtin.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

As Stefan mentioned in [1], also mention in the commit message that this
means that the "git-upload-pack" invocation gains additional
capabilities (for example, invoking a pager for --help).

Having said that, the main purpose of this patch seems to be to libify
upload-pack, and the move to builtin is just a way of putting the
program somewhere - we could have easily renamed upload-pack.c and
created a new upload-pack.c containing the main(), preserving the
non-builtin-ness of upload-pack, while still gaining the benefits of
libifying upload-pack.

If the community does want to make upload-pack a builtin, I would write
the commit message this way:

  upload-pack: libify

  Libify upload-pack. The main() function is moved to
  builtin/upload-pack.c, thus making upload-pack a builtin. Note that
  this means that "git-upload-pack" gains functionality such as the
  ability to invoke a pager when passed "--help".

And if not:

  upload-pack: libify

  Libify upload-pack by moving most of the functionality in
  upload-pack.c into a file upload-pack-lib.c (or some other name),
  to be used in subsequent patches.

[1] https://public-inbox.org/git/CAGZ79kb2=uU0_K8wr27gNdNX-T+P+7gVdgc5EBdYc3zBobsR8w@mail.gmail.com/

> -static void upload_pack(void)
> -{
> -	struct string_list symref = STRING_LIST_INIT_DUP;
> -
> -	head_ref_namespaced(find_symref, &symref);
> -
> -	if (advertise_refs || !stateless_rpc) {
> -		reset_timeout();
> -		head_ref_namespaced(send_ref, &symref);
> -		for_each_namespaced_ref(send_ref, &symref);
> -		advertise_shallow_grafts(1);
> -		packet_flush(1);
> -	} else {
> -		head_ref_namespaced(check_ref, NULL);
> -		for_each_namespaced_ref(check_ref, NULL);
> -	}
> -	string_list_clear(&symref, 1);
> -	if (advertise_refs)
> -		return;
> -
> -	receive_needs();
> -	if (want_obj.nr) {
> -		get_common_commits();
> -		create_pack_file();
> -	}
> -}

I see that this function had to be moved to the bottom because it now
also needs to make use of functions like upload_pack_config() - that's
fine.

> +struct upload_pack_options {
> +	int stateless_rpc;
> +	int advertise_refs;
> +	unsigned int timeout;
> +	int daemon_mode;
> +};

I would have expected "unsigned stateless_rpc : 1" etc., but I see that
this makes it easier to use with OPT_BOOL (which needs us to pass it a
pointer-to-int).

As for what existing code does, files like fetch-pack and diff use
"unsigned : 1", but they also process arguments without OPT_, so I don't
think they are relevant.

I think that we should decide if we're going to prefer "unsigned : 1" or
"int" for flags in new code. Personally, I prefer "unsigned : 1"
(despite the slight inconvenience in that argument parsers will need to
declare their own temporary "int" and then assign its contents to the
options struct) because of the stronger type, but I'm OK either way.
Whatever the decision, I don't think it needs to block the review of
this patch set.
