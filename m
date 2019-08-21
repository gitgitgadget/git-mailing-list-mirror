Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BA71F461
	for <e@80x24.org>; Wed, 21 Aug 2019 14:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfHUO4U (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 10:56:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39325 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUO4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 10:56:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so2459323wmg.4
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6q3C/W4CUJmYqaZE0wOZY6c+IyqMNwfmnqTFPvKz+o=;
        b=SAztHgCxb0L8DPXsb4tDGj+0PROVfKjHKuxtSlt5K03ErHk8lcSAQDe+rVgt/e33mt
         KFKy7ulfwgQQDvUcmJSUeFweOrDrMzbgcYtRoHG5z/M/JkRKpDOSPYp3mHTl4B6p5b5i
         6zd+chKsjsvhkFTFMklqs2uDeUdHlkBGxwqNURrIHsrt+9PXprjoe5vfTHCuWR3MyxW+
         Kemg1+iOW9FEykuCz3CFEM0NCuXBoBVqlvvyGTgiJCNmdfoYVUc89srygLleaZxb53rE
         Q1V2S210TxrId6dC9plfG87wpgZLt5JgVjmg19l5eRF0wZ6QDamZWZe3PkCLua/KRZhp
         y1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6q3C/W4CUJmYqaZE0wOZY6c+IyqMNwfmnqTFPvKz+o=;
        b=I46b8TQHnkLgjKbMnNNHH6/7SPe0lW+ZH9SVT9S4Pc9jLWmRSVFk79Pq9U4HQTHSn5
         ZJEyXJwCUWMJkrDlZbg8/I9e6INu+KW3ntSYqVi/5q976MXMsHJFbFd85JsjLwAaam+2
         ClEWlcp+2jA9cNUhaCRq+4+bB2zZFs5ZmQC+T1ZyTzZlbfuQY5kNK6CbqIYG5wLVz3jT
         8oAK4I7zMvlOdNEfzPsVgq/zHmWqGIxO7RsQGUaGWjezUjo8BUXJbUTE1kU8k/5xX+3H
         Twft14u86zAHs1wL8/n8MzI5jrguv9dOdLaT1asxSgzuqoUBEQERFpP8hAdbntXMCimZ
         n35A==
X-Gm-Message-State: APjAAAUTKT97LhDpC4t//aePqBNBV1V/HC8/+QnsDfv3/2SpPf7PzQWz
        fd+9a1VkJa+JBbRP2kgGeac=
X-Google-Smtp-Source: APXvYqxz+lkCmO9iOjzxG9S2bAV6ZUV0ZEuysABEECfcmqGZbgF91DPx1qoP5qCGmeWAogZeIFebBg==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr459782wmc.153.1566399378249;
        Wed, 21 Aug 2019 07:56:18 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id 2sm26465269wrg.83.2019.08.21.07.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 07:56:17 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:56:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
Message-ID: <20190821145616.GB2679@cat>
References: <20190820065625.128130-1-t.gummerer@gmail.com>
 <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aea64308-fcba-77a1-1196-182b35ad405c@kdbg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/20, Johannes Sixt wrote:
> Am 20.08.19 um 08:56 schrieb Thomas Gummerer:
> > Fix the test by updating the mtime of test.r, ...
> 
> > diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> > index e10f5f787f..66f75005d5 100755
> > --- a/t/t0021-conversion.sh
> > +++ b/t/t0021-conversion.sh
> > @@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
> >  		EOF
> >  		test_cmp_exclude_clean expected.log debug.log &&
> >  
> > +		touch test.r &&
> 
> 		test-tool chmtime +10 test.r
> 
> would be more reliable.

Hmm, is touch unreliable on some platforms?  I didn't think of
'test-tool chmtime', but I'm also not sure it's better than touch in
this case.

To me te 'touch' signifies that the timestamp must be updated after
the previous checkout, so git thinks it could possibly have been
changed, which I think is clearer in this case than setting the mtime
to a future time.

But I'm happy to change it if there's something I'm missing why
'test-tool chmtime' is better in this case.

> >  		filter_git checkout --quiet --no-progress empty-branch &&
> >  		cat >expected.log <<-EOF &&
> >  			START
> > 
> 
> -- Hannes
