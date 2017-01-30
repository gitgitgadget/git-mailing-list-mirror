Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139461FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbdA3WWO (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:22:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34284 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdA3WWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:22:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so24415606pfb.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FvRkl9nCg8xbX0cEXL3H5Y9X872AeihA/bSAwe6Bp2Q=;
        b=k1K3wUlIgKtMdX29LQRvtuIFLzD4sbkb43HW/Rtf+Fg9lQFrpXvlk/9mvlJMeDlYEp
         c/OUNs2yaNY5JwmKlGR14t/xzxzS7dhYqDYTAV+59+OXGajh9/4NH8EnnZuQZut21iIM
         Xtgjf2DbH3CU6skIdO9Ld1hzHKI4K8nGY2YKe6z8SlauYTnPE/9A1CJp1qFNmQke7H2L
         fl/Y8/7bkMtQktIeJUYwHnbeMKspUgRo3NUF6JtTbIlcc956W4cEiqsuW3w1wCpv5F9x
         XDHoNEpx2YWpoY7OjAf927Oiy8gzifomDq5JnBZ+MyMlwQrNVv6aXt3I6d5u7X2FwLs3
         q6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FvRkl9nCg8xbX0cEXL3H5Y9X872AeihA/bSAwe6Bp2Q=;
        b=M1Q+jmIqumoNHyX6h/shPZ2u6N7pwPLf04yN8HN0ayAX8+Ob8ikdVhPDI+szIaJamV
         wHUS1QCpMGZFV38VtyK5i+62LvU2iDBfO4+/M57CIC138J9+z8G2QsX7qNQn6zewP4bo
         H8oimABZ+ID7UZaM5G9umU13sJ553CnkYiHKmvs0H4ljy+5lNbsbDFWWfPaOMa72znK6
         6AOFSnuCmlmEXjjW6dfsWBXV6+JYYZX3YzLhEY0xejbHsZ2+YDNcQGi3u8pJks5yHgny
         3eGJS46YQxP++mpciyswi9zOoRFOQmz+ZFMJPld0VYhtrLOECtoQgwHK4rJqYNS5FOHr
         jgng==
X-Gm-Message-State: AIkVDXL1GUoRYfyycf2IPmK1l/seYb1+JxcSL6KVTzxvsmIgcS6PpL3/DBZ8O1xaL9n9wA==
X-Received: by 10.99.155.18 with SMTP id r18mr26056190pgd.193.1485814931578;
        Mon, 30 Jan 2017 14:22:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id s136sm35158013pgc.38.2017.01.30.14.22.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 14:22:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] use SWAP macro
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
        <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de>
Date:   Mon, 30 Jan 2017 14:22:10 -0800
In-Reply-To: <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 28 Jan 2017 22:40:58 +0100")
Message-ID: <xmqqr33ktch9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>  		if (tree2->flags & UNINTERESTING) {
> -			struct object *tmp = tree2;
> -			tree2 = tree1;
> -			tree1 = tmp;
> +			SWAP(tree2, tree1);

A human would have written this SWAP(tree1, tree2).

Not that I think such a manual fix-up should be made in _this_
patch, which may end up mixing mechanical conversion (which we may
want to keep reproducible) and hand tweaks.  But this swapped swap
reads somewhat silly.

> diff --git a/diff-no-index.c b/diff-no-index.c
> index f420786039..1ae09894d7 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -186,9 +186,8 @@ static int queue_diff(struct diff_options *o,
>  
>  		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
>  			unsigned tmp;
> -			const char *tmp_c;
>  			tmp = mode1; mode1 = mode2; mode2 = tmp;
> -			tmp_c = name1; name1 = name2; name2 = tmp_c;
> +			SWAP(name1, name2);

Curious that mode swapping is left for a later iteration.

> diff --git a/diff.c b/diff.c
> index f08cd8e033..9de1ba264f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5118,13 +5118,11 @@ void diff_change(struct diff_options *options,
>  
>  	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
>  		unsigned tmp;
> -		const unsigned char *tmp_c;
> -		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
> -		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
> +		SWAP(old_mode, new_mode);
> +		SWAP(old_sha1, new_sha1);
>  		tmp = old_sha1_valid; old_sha1_valid = new_sha1_valid;
>  			new_sha1_valid = tmp;

So is this one.

> diff --git a/merge-recursive.c b/merge-recursive.c
> ...
> -			tmp = ren2;
> -			ren2 = ren1;
> -			ren1 = tmp;
> +			SWAP(ren2, ren1);

A human would have written this SWAP(ren1, ren2).

