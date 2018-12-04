Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EF5211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbeLDAWB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 19:22:01 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34354 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 19:22:01 -0500
Received: by mail-ed1-f53.google.com with SMTP id b3so12410298ede.1
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 16:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pnCdKw3B4p1XuSailnIJrffv/8adXJcqc7wPnV1JDY=;
        b=qIrxCEJke3ir5xORKoeAOV5FErgqXTYewe9/5FqrbtBIQrRytHOdGSkE70Dy3ugaV6
         /2Aq5zLvvds3TpR3MkxyVL21uCyd8DhSh95IoC+uzhxF3obgGgsWmAFGVGExT9dWQpbp
         o4gbVY3HgFHDyq5u0Oer38Dx7rbF5Jrkf0xQ/EUo3XAsb4Ei17maBqMWmWIgc/DvB7mT
         ldKQ4JyAJkjSUwjaQ0g2HNdV88SVrCaeUxyCqMGGZygwI7SU+VF1U9BXpglSeUgkM8yv
         neUPox6UEzgUKZ//p3+Le7Htf6vtgeGP2vMbgi9JgBAQ1xBTI7uheOixIBS//3ufdpy1
         amiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pnCdKw3B4p1XuSailnIJrffv/8adXJcqc7wPnV1JDY=;
        b=qH3QtkmQc0S75ezZ3UWo9MVVXWVPAszZgVDwaEtbg5zQiJ9P9fOGeuUOY8YWIiOtLJ
         riEkG9iBqF3g7eUE4jn/coNwD4I+5xrzV5S4v9jhauu7O0d3UkmxlZ445HAaDDjV7Vxo
         02jEVHlWs5eGD5EAz05HvjL0I87NlKblwKW+QA5VVXvoNdfDBW+j4zs+Spx2USacTWFp
         xCo0pchzXEvziIZ/llpItWSRp38pmYyYeLrcYhV/4I7HdWYN54njh8yiThpWy0W+oMBH
         5GoNpFylXGWcTUrubw7cIGY16fpav3SlV0U4BBz7g/hzzgXo0LVXqGEy/HH7VD7UZok7
         WLwQ==
X-Gm-Message-State: AA+aEWYlCJ2WrKPKFEMLv8+oECSIr0d4Xnwv3lmwJuXbNS1ayp2aFF6U
        w0RP56nmAEYBLGXW9pFwMIYyiQGDqFtcU6tlcCjRCw==
X-Google-Smtp-Source: AFSGD/Xa4+QODYwsn37gUOgTHB7zcMEmexdtbo7Mgs0YzXQGQPijWJeho4v9XJBDPs0MNkmJczRLqUTvDcdEEFtQSHQ=
X-Received: by 2002:a17:906:1b12:: with SMTP id o18-v6mr13955543ejg.65.1543882918214;
 Mon, 03 Dec 2018 16:21:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com> <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
In-Reply-To: <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Dec 2018 16:21:47 -0800
Message-ID: <CAGZ79kafqUcT96zzkEmhpUaUj7v83sdrGboSk-hrA8r-nC=ggQ@mail.gmail.com>
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for bringing this design to the list!

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 345c00e08c..2cb1c41742 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -313,7 +313,8 @@ header. Most sections are sent only when the packfile is sent.
>
>      output = acknowledgements flush-pkt |
>              [acknowledgments delim-pkt] [shallow-info delim-pkt]
> -            [wanted-refs delim-pkt] packfile flush-pkt
> +            [wanted-refs delim-pkt] [packfile-uris delim-pkt]
> +            packfile flush-pkt

While this is an RFC and incomplete, we'd need to remember to
add packfile-uris to the capabilities list above, stating that it requires
thin-pack and ofs-delta to be sent, and what to expect from it.

The mention of  --no-packfile-urls in the Client design above
seems to imply we'd want to turn it on by default, which I thought
was not the usual stance how we introduce new things.

An odd way of disabling it would be --no-thin-pack, hoping the
client side implementation abides by the implied requirements.

>      acknowledgments = PKT-LINE("acknowledgments" LF)
>                       (nak | *ack)
> @@ -331,6 +332,9 @@ header. Most sections are sent only when the packfile is sent.
>                   *PKT-LINE(wanted-ref LF)
>      wanted-ref = obj-id SP refname
>
> +    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
> +    packfile-uri = PKT-LINE("uri" SP *%x20-ff LF)

Is the *%x20-ff a fancy way of saying obj-id?

While the server is configured with pairs of (oid URL),
we would not need to send the exact oid to the client
as that is what the client can figure out on its own by reading
the downloaded pack.

Instead we could send an integrity hash (i.e. the packfile
downloaded from "uri" is expected to hash to $oid here)

Thanks,
Stefan
