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
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3C51F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfJGRMz (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:12:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbfJGRMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:12:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so7515016wrv.7
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbQHeiNzlU2Mh/3/FkO2JevfcXVrT8hdH3Y4+Cpp4RI=;
        b=cKFAXBD5bSxl8TwMfi0SlUz9nCRKRejjPy/E7nM5huEXat3pNQhoHveF+dwIuaD5yt
         DE0e/f98X5C/OY3BpXsGDpXd3Ccm7IK4STV4FM5YdCQ+tdLKlD9hD7t2IDbq04K4JrzB
         N8xGG7ZpTFaD8Sw/qheaP7dHmyXn7R3gX9f+cC9wcVJdKki4qnXIZYMiyOThyA6SozOB
         8TVp5q1so3NbnZrpVs8Qt/bpj/IglWQwXz3KUkR1Ma9FguU5ejIgS/5lX35xQPqUU+Xz
         sLwjfTZJ597EvsBUnHFU++2N7ivbDvY6AbPB9Sry709vnFD2QyYOQUWBvG/M563rDg0z
         DWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbQHeiNzlU2Mh/3/FkO2JevfcXVrT8hdH3Y4+Cpp4RI=;
        b=ncO5/+vVBswv3JfgiP4yZz9ngzyWrdQDrPa5ShyglF9qKjtcjBoMkNYxOnDO1a7QP/
         ofgejSYoAluFD1gN+U7Rvjnvldho8fsk9qXU2bbjNr/9bw2v/IoSapEt4t2TsXgE/Q2D
         VRq+Ww141rfqBvnOtQOj/5JfC2Ant7Z0nRvenB9CP8zi0W0nEpgZ3abMSeb0EAf15bNq
         wktY3QkHCUK1poI1MkFW+i7FhuZ/RWHJJ3R13xWGCFBNhgIfJN4Zk56RQKZ6WnmOPGmw
         v9JuIAFmLjeEAuF/ZThu/1OonrJwKDvwseZzTZfqOjkexOeEDXkXctyOhpy/ho7M+Mi0
         jtEQ==
X-Gm-Message-State: APjAAAXi6f42J8Ckijj4TUXrm8+7nVCQghM+op+D3+DncpbemNciBLO8
        /OuG9r6wv9tTP6YRLvh5a/s3v/2I
X-Google-Smtp-Source: APXvYqyGyzJ6FGgh6/MqaNx5W21xlQcCr6L29VATbhjprDpjdbY5lwr/0ZjOec80xCUvZfPoSjyC1g==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr22043333wrn.97.1570468373171;
        Mon, 07 Oct 2019 10:12:53 -0700 (PDT)
Received: from szeder.dev (x4dbd6b2d.dyn.telefonica.de. [77.189.107.45])
        by smtp.gmail.com with ESMTPSA id q15sm32407138wrg.65.2019.10.07.10.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:12:52 -0700 (PDT)
Date:   Mon, 7 Oct 2019 19:12:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Baker <williamtbakeremail@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
Message-ID: <20191007171249.GB11529@szeder.dev>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com>
 <xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 02, 2019 at 02:43:48PM +0900, Junio C Hamano wrote:
> William Baker <williamtbakeremail@gmail.com> writes:
> 
> > Although my debugger might not be the smartest, I haven't noticed any
> > downsides to switching this to an enum.
> 
> Well, if you write
> 
> 	enum { BIT_0 = 1, BIT_1 = 2, BIT_3 = 4 } var;
> 
> it's pretty much a promise that the normal value for the var is one
> of these listed values to your readers.  But bit flags are meant to
> be used combined (after all, they are cheaper alternative for 1-bit
> wide bitfields in a structure), so it is misleading to use enum as
> such.

Having the combination of enum constants with power-of-two values is
not misleading, but rather an idiom.

Back when debugging the racy split index issues I only saw gibberish
like this:

  (gdb) p ce->ce_flags 
  $2 = 469762048

With an enum I now have this instead:

  (gdb) p ce->ce_flags
  $2 = (CE_MATCHED | CE_UPDATE_IN_BASE | CE_STRIP_NAME)

The latter is about as many times more readable as the int value of
that 'ce_flags'.

The sooner everyone gets on board with this the better.

