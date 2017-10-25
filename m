Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD9D1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdJYEFZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:05:25 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44843 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdJYEFW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:05:22 -0400
Received: by mail-qk0-f195.google.com with SMTP id r64so28983106qkc.1
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nRkrW5LToQjrWryI7HSu3vCyiTnSxyDLZJYcfD89i8E=;
        b=Quxu9a5+/CV4gHubb64xNnhgAzyC+KXMYX8S7mbFS78KHBWS7ea6m5eMDga8Je6/m5
         9PORr2/qYRdjfa0RFE3QrAaolaJBzGjo/gueLPJnnGTNksIUqkgdFr71RDrp8vex7LmY
         6NCrcU0ehBUQzXrqhshD5ynxjsV7bKfqMHYS7cToP9eV5bWaf86RPBjefTs6gvx3cduw
         CymQC+CAqF4ieP1jqhW/9uNOQ2TMvbbF62TFBIS3KB88K5uKrvbHOOhUjP1nJzqnqO38
         hN92ie8+wGTrYtBSX5RuT4CveGF/fJe8H/SaxYpArCm333V4lJnAZ3haX330H60MqZwR
         x4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nRkrW5LToQjrWryI7HSu3vCyiTnSxyDLZJYcfD89i8E=;
        b=LpYUNEpxmmNGpbK1E8C45Ta4YT5vRJQOY70OyGJS3C5mKbIWB1Pk4mXfKJw5Ja9Nh2
         iM4XQldnyZQGBefe++6bcOu3ESlGS9ujkL4a93zAGvHlm5HzF7NY1LsrlBwa+S5jN5rH
         U3ikkJe6d0Zco8N7SrzqPAUK745PDfGky85pC/ttZbZAuJaf3Vkr7xVKka9C58WuNNbr
         mtdgD4h+pKJHpEuGk2feKd60P6Za4bAO6A6w9eAsQLgIqCu3r7fCJbL+Cv3LTB1rpFAc
         3xX4x18xEjJys27/OYL6V/Adjl8WgmfZx0Cqee+dzLb8xtNxNroX8StTx+ic2T51aliU
         MUog==
X-Gm-Message-State: AMCzsaVG0/wrXIF4gnP4sZgOuV/SzJHSpbFCdsJ0rEgHhs0yLyK+7M2H
        YkMcsQYfLh1hx2QBhyIthp/KFsfAuA1Dq21e4V4=
X-Google-Smtp-Source: ABhQp+QFn4ZJt7ZgcCut8GBBqmqeqwoVoNQqflvK/PxuWL6xtIsuwR5AaV7eDq2E7mTQtxkuOXI897Ho6QhWH7ZHwcQ=
X-Received: by 10.55.139.70 with SMTP id n67mr1114077qkd.135.1508904321285;
 Tue, 24 Oct 2017 21:05:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 24 Oct 2017 21:05:20 -0700 (PDT)
In-Reply-To: <20171024185332.57261-2-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com> <20171024185332.57261-2-git@jeffhostetler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Oct 2017 00:05:20 -0400
X-Google-Sender-Auth: cgQnJgxIUHLmteyOfQavYUpv27U
Message-ID: <CAPig+cSPwSq1s5EhnQA+K-zQJ_+LrTLJFA9n8fj+W9jtdpA+PQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] dir: allow exclusions from blob in addition to file
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 2:53 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> Refactor add_excludes() to separate the reading of the
> exclude file into a buffer and the parsing of the buffer
> into exclude_list items.
>
> Add add_excludes_from_blob_to_list() to allow an exclude
> file be specified with an OID.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/dir.c b/dir.c
> @@ -841,6 +856,38 @@ int add_excludes_from_file_to_list(const char *fname, const char *base,
> +int add_excludes_from_blob_to_list(
> +       struct object_id *oid,
> +       const char *base, int baselen,
> +       struct exclude_list *el)
> +{
> +       char *buf;
> +       unsigned long size;
> +       enum object_type type;
> +
> +       buf = read_sha1_file(oid->hash, &type, &size);
> +       if (!buf)
> +               return -1;
> +
> +       if (type != OBJ_BLOB) {
> +               free(buf);
> +               return -1;
> +       }
> +
> +       if (size == 0) {
> +               free(buf);
> +               return 0;
> +       }
> +
> +       if (buf[size - 1] != '\n') {
> +               buf = xrealloc(buf, st_add(size, 1));
> +               buf[size++] = '\n';
> +       }
> +
> +       add_excludes_from_buffer(buf, size, base, baselen, el);

Seeing all the free()'s above, at first glance, one wonders why 'buf'
isn't freed here after add_excludes_from_buffer(), however an
examination of that function shows that 'buf' is assigned to
el->filebuf and later freed by clear_exclude_list(). Okay.

> +       return 0;

Should this be returning the result of add_excludes_from_buffer()
rather than unconditionally returning 0?

> +}
