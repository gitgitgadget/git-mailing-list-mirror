Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4201FAE2
	for <e@80x24.org>; Thu,  1 Mar 2018 09:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966637AbeCAJAr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:00:47 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39505 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965361AbeCAJAp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:00:45 -0500
Received: by mail-pl0-f65.google.com with SMTP id s13-v6so3277524plq.6
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fq7cuMS0uMIckGPWaYfUpGTNcfKGypCm7w4cbW9ZbFI=;
        b=qG0NPrvnwm8cEo5cas7WB+555C3Z69G3pD+Se1Wu2cjRS9eZW0riuGRPtsQpz+SW7x
         J9tZcgKVwQNxf2WuP/iTXpaL/k2YwUf/8A1myc5IoOtmm6uBu31fFCLXEM6ecpMYcFg8
         Rj5lomOYQWZUKH0pN757k/Avh7aAkyQ+eV5/Atpw72EQtXHsRg1p1dIitB1CfknH92Wf
         sVBzI41pkAnyvELYZfBsuYBbZdClacXgZuv6JnP9xThgWFQpGPe4Lyld/cxWY9dFoYyU
         4KTLHXC1X+QjpWTTE/b+Ni6PULKOLzMywumQWlA28DGpZq8dqbcnnSsIcFOD3duF9XLN
         idQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fq7cuMS0uMIckGPWaYfUpGTNcfKGypCm7w4cbW9ZbFI=;
        b=Oe43NYX//K0Jeum7XZd9du8yYN2zkB3PKUqhdlZqlwYhIb11bFIx+lYzgwdj9k4iEE
         R26dr4TE//oBKfMkARltYNqQSfDPE/8bbnn7RmnyroT582sjXIHwQ9Rvy67D/fu7BNAa
         HCCpzDUjrm90tKKdZ+FABBFtnZjyPrSeKuB35xEH2m6uqr7++aVX/1vlcvHT6CTkx9zw
         y8GUzJhIX0IwL6YmToYxkB1vC6GZ1j+o/JJULSKnWtOyqTxnJVEILrIe/mlyRStN/t6p
         x86B5vHtDaucg/8ea/A6Ii9S2h/PFF++4td4puIaBYnETtohIeDVZnEcRpVvv86BpZJI
         yXXA==
X-Gm-Message-State: APf1xPDeqGDgPzwPx0RvD7RkUI81KqGfLn1VXFnO4mOUFtzaP2q1kN46
        aE4DnXOGs7xBhY+W05FJwxQT9g==
X-Google-Smtp-Source: AG47ELuLDZEsBg23Oo6kVMScvcLipiy5x50licputzwe3JA9W4khfdDuZxq81TS6jd5VxaO3VpXqBg==
X-Received: by 2002:a17:902:bc85:: with SMTP id bb5-v6mr1254589plb.425.1519894845365;
        Thu, 01 Mar 2018 01:00:45 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 73sm3379916pfz.165.2018.03.01.01.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:00:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:00:39 +0700
Date:   Thu, 1 Mar 2018 16:00:39 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: Reduce pack-objects memory footprint?
Message-ID: <20180301090039.GA19167@ash>
References: <20180228092722.GA25627@ash>
 <20180228182233.GC15256@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228182233.GC15256@dcvr>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 06:22:33PM +0000, Eric Wong wrote:
> Duy Nguyen <pclouds@gmail.com> wrote:
> > which saves 12 bytes (or another 74 MB). 222 MB total is plenty of
> > space to keep some file cache from being evicted.
> 
> Nice!  I can definitely benefit from lower memory usage when
> packing.  Fwiw, I use pahole with other projects to help find
> packing opportunities:
> 
> 	git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Yes it's a wonderful tool.

> > @@ -14,11 +26,10 @@ struct object_entry {
> >  	void *delta_data;	/* cached delta (uncompressed) */
> >  	unsigned long delta_size;	/* delta data size (uncompressed) */
> >  	unsigned long z_delta_size;	/* delta data size (compressed) */
> > -	enum object_type type;
> > -	enum object_type in_pack_type;	/* could be delta */
> >  	uint32_t hash;			/* name hint hash */
> > -	unsigned int in_pack_pos;
> >  	unsigned char in_pack_header_size;
> > +	unsigned type:3;	 /* enum object_type */
> > +	unsigned in_pack_type:3; /* enum object_type - could be delta */
> 
> For C99 compilers, enums can be bitfields.  I introduced the
> following macro into Ruby a few weeks ago to remain compatible
> with non-C99 compilers:
> 
> /*
>  * For declaring bitfields out of non-unsigned int types:
>  *   struct date {
>  *      BITFIELD(enum months) month:4;
>  *      ...
>  *   };
>  */
> #if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
> # define BITFIELD(type) type
> #else
> # define BITFIELD(type) unsigned int
> #endif

I tried this and got

In file included from builtin/pack-objects.c:20:0:
./pack-objects.h:49:19: l?i: ?type? is narrower than values of its type [-Werror]
  enum object_type type:TYPE_BITS;
                   ^~~~

The compiler is not wrong. What it does not realize is pack-objects
code never uses out-of-range values (OBJ_BAD and OBJ_ANY) but I don't
see how I could suppress this warning. So I went back to non-enum
bitfields.

--
Duy
