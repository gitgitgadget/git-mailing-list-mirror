Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBCE31F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 11:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLLpD (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 06:45:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLLpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 06:45:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id l1so2793721wme.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 03:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJktCuZ+cj7gjRrRXN8cHq7PjGW4+4atS0Bwpz6hXSg=;
        b=tU43IjEcx67rartm2w07minaABDdvEqkS6QDrJqCquST6PS5ZnKyns3M6Gg4RijpFi
         5TdPDTX6RKiejNenbzvCmdBwqO0kcIez8tcbUE8G6IUY7MQxJNIuj+AFgx1qI3bkoV7P
         rKBPM9SaBceyQLIACNl9T/dlHGVaeKZvAr4uMQdEkPgzg0N3PC+DSl30zLZy8/KkLIai
         AoJVfIJO+QfvJkzSuO5Ppc5q37b+hsZtGDCWYPRwnFjcdHDXSnpza+UWG9q1EUxFVGVt
         Jybc1RZTcEmqU2xhXzMa6WRJFWwOqfvnwG/9rtZul70BOAifeCQzzgkQlHUSxzxR+aT/
         l8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJktCuZ+cj7gjRrRXN8cHq7PjGW4+4atS0Bwpz6hXSg=;
        b=UkA1snQlfdV7U/AmtLcZlUnc/Y3/RP9VBs3qm/90pAXU0UryLblFPkiS8hWYV67iht
         OWJG96yGzptRyP6n7/8nJuXNxv2c+sTIYERANP64wLe/8kh/MwzysdACKAR7bvKdmdA4
         zT+WUzaJC/dmLGT7JRzdND27eH3/3eq9SmifX0w0eZmZ4sBUhH7PPJcqoEmvS2/xXgDD
         35Xmf7g7cmMnp68Nv+Yhar/XV7UcNgFNNKPW4JhZYMSlx5Sp3Lhiivu1Er9Bkw1yrpKZ
         FYvDb5KQrQuazslNHJAyg0KuXMK8e9RPLEC9wRlcxjpdytLfQRs7Z9lb90+WmYbdDKWq
         HwGQ==
X-Gm-Message-State: APjAAAVxyelrCi3rcdDmGO7rI8nHFdpFN3RHbc5JE05+R6IUcS5wq4pu
        rzYrmDmQ61RiORByYYgXQ1yGpcFY
X-Google-Smtp-Source: APXvYqyDsBTkhF/7p6FD6nJVMFvhzEBtX3TY3iZUTkrDtMrOKOgyuLdJ6zqaiPkYM58/9HE8eJYHVA==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr3523296wmh.152.1573559101507;
        Tue, 12 Nov 2019 03:45:01 -0800 (PST)
Received: from szeder.dev (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id g133sm3279147wme.42.2019.11.12.03.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 03:45:00 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:44:58 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191112114458.GP4348@szeder.dev>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <20191111090418.GB12545@sigill.intra.peff.net>
 <20191111141805.GK4348@szeder.dev>
 <20191111142904.GB1934@sigill.intra.peff.net>
 <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
 <20191112105759.GA9714@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191112105759.GA9714@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 05:57:59AM -0500, Jeff King wrote:
> On Tue, Nov 12, 2019 at 01:13:58PM +0900, Junio C Hamano wrote:
> 
> > >> We can't use oid_to_hex() because we don't have a 'struct object_id'
> > >> in the first place, as sha1dc only ever deals with 20 unsigned chars.
> > >
> > > Ah, you're right. I admit I am still getting up to speed on all of the
> > > new hash-agnostic versions of the various functions.
> > 
> > Thanks.  I've amended this one and the range diff since the pushout
> > yesterday looks like this.
> 
> Thanks. This first hunk is what I would have done:
> 
> > 1:  8a030f1796 ! 1:  02d21d4117 hex: drop sha1_to_hex()
> >     @@ Commit message
> >          hex: drop sha1_to_hex()
> >      
> >          There's only a single caller left of sha1_to_hex(), since everybody now
> >     -    uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
> >     +    uses hash_to_hex() instead. This case is in the sha1dc wrapper, where we
> >          print a hex sha1 when we find a collision. This one will always be sha1,
> >     -    regardless of the current hash algorithm, so we can't use oid_to_hex()
> >     +    regardless of the current hash algorithm, so we can't use hash_to_hex()
> >          here. In practice we'd probably not be running sha1 at all if it isn't
> >          the current algorithm, but it's possible we might still occasionally
> >          need to compute a sha1 in a post-sha256 world.
> 
> This second one is OK, but not entirely necessary:
> 
> >     @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
> >        * buffers, making it safe to make multiple calls for a single statement, like:
> >        *
> >      - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
> >     -+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
> >     ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
> >        */
> >       char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
> >       char *oid_to_hex_r(char *out, const struct object_id *oid);
> 
> This one-liner leaves the types of "one" and "two" unspecified. :) So
> it's not wrong to use hash_to_hex(), but maybe it's better to be pushing
> people towards oid_to_hex() as their first choice? It probably doesn't
> matter too much either way.

Yeah, most (over 96%) of the hashes that we print are actually object
ids, so oid_to_hex() is the right function to use most of the time.

And because of this the updated "since everybody uses hash_to_hex()"
in the first hunk sounds a bit wrong, because barely anybody actually
uses hash_to_hex().

