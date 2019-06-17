Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1158A1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfFQS01 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 14:26:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36074 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfFQS00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 14:26:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so2991812wrs.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xn3xFioLZozTN0LSF2lLkRlslI8DXW+4v94tOS1Q0dU=;
        b=ZxfFYJr6g96gh8ngNdeFaXacHPnIpKGMgBm9HmETKjbgvhnvA5OUVAscRjETTzkqh2
         nrFnNhAh5joo0FOGWBfWm8AwCe2ik2V03TUOys0NHUK9XgFtkRhNFGhdSXMQzsMr0ob8
         FT21o8VxdpWP2nQNXvq/xKMlgSYCCjQ5zgxLAuNWn0W6YDIHmbHUB5dPqLdcQCyvLDzQ
         cWCgaOLifEBDTdH6ptSG0QhweOkdskWcBgGMeYYh+EqP84aL5QKAQT+khSi8XVcQ3sUO
         ONeCDnVw255L5g29qAWbWrup9sIHXW1fxztTq7gtA5mv4HKQaN0IxmdDBFnxj6BeNWfj
         mNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xn3xFioLZozTN0LSF2lLkRlslI8DXW+4v94tOS1Q0dU=;
        b=mB7iD/Qg2RWTkJ76wH35GkHp2iXYt/JEVRvRDu88tFWiL0r+crcyY8Tm5Y5JQip1K9
         +B9/TPvm/6nYSfgDClnvURIrcIPhw8d8yQu+xACFqrGBXxXDDhGZgr/utr9O9jUVeYvI
         73wSftzGS7nzEim4KvnTqAG5yjEz6LfDyVohpdz7HiwLy39sqMGTA1K3gLe5SeJFhU8p
         MYioJbGmLEZLQIQ5qDKgtIMh+yuyf4KuYDrIXLD7uLvd/o1Pwu1xJita6gUBYbtIGAE4
         gNExGM7l2QK5zUTa6qNeuGa+JmZB9WxKEUpCekdphNWgwluzcB0Ubj0siMmmyL+wADdR
         kl9g==
X-Gm-Message-State: APjAAAVCkZWAQhBZRrc4Dr+ymkQzMDa6KL5P8KL9sqWemN1RzX7vvJgV
        tMq9I04Wqyt0wGFriyObN6g=
X-Google-Smtp-Source: APXvYqyrWJzbA97vkwa50Nw/S6r+Uv3/NfT+ynKRla/I6neLita3I+dSkRIVRqjVinf5MukXHX5bxQ==
X-Received: by 2002:adf:ebc8:: with SMTP id v8mr21928597wrn.46.1560795984560;
        Mon, 17 Jun 2019 11:26:24 -0700 (PDT)
Received: from szeder.dev (x4db66496.dyn.telefonica.de. [77.182.100.150])
        by smtp.gmail.com with ESMTPSA id e11sm12639824wrc.9.2019.06.17.11.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:26:23 -0700 (PDT)
Date:   Mon, 17 Jun 2019 20:26:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] kwset: allow building with GCC 8
Message-ID: <20190617182621.GI31952@szeder.dev>
References: <pull.265.git.gitgitgadget@gmail.com>
 <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
 <20190614095308.GG31952@szeder.dev>
 <xmqq4l4suovx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4l4suovx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 09:12:50AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> Now, the proper thing to do would be to switch to `size_t`. But this
> >> would make us deviate from the "upstream" code even further,
> >
> > This is not entirely true: upstream already uses 'size_t', so the
> > switch would actually bring our copy closer to upstream.
> 
> Ah, earlier I said that within the context how kwset uses obstack,
> it is perfectly proper to fix it like the patch in question did, but
> the upstream already using size_t changes the picture quite a bit.
> 
> I do not mind updating our copy of obstack, but make sure you pick
> the version with license compatible with ours.

The licensing of obstack.{c,h} didn't change, it's still "GNU Lesser
General Public License as published by the Free Software Foundation;
either version 2.1 of the License, or (at your option) any later
version"

Note how the first patch updating these files makes only superficial
changes to their license notices:

  diff --git a/compat/obstack.h b/compat/obstack.h
  index ced94d0118..811de588a4 100644
  --- a/compat/obstack.h
  +++ b/compat/obstack.h
  @@ -1,6 +1,5 @@
   /* obstack.h - object stack macros
  -   Copyright (C) 1988-1994,1996-1999,2003,2004,2005,2009
  -       Free Software Foundation, Inc.
  +   Copyright (C) 1988-2019 Free Software Foundation, Inc.
      This file is part of the GNU C Library.
   
      The GNU C Library is free software; you can redistribute it and/or
  @@ -15,89 +14,89 @@
   
      You should have received a copy of the GNU Lesser General Public
      License along with the GNU C Library; if not, see
  -   <http://www.gnu.org/licenses/>.  */
  +   <https://www.gnu.org/licenses/>.  */
 

But I rather like Ævar's idea of simply getting rid of them :)

