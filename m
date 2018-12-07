Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2551B20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGWeK (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:34:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41406 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:34:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so2307821pgh.8
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8GU9UEYT5N03rkpwdIveAr9b4UuOQPV8eSnr6W61v4w=;
        b=VvZ6VO36zq/yXfx0AN69Q9iG20vkuBjLQVcC1xu+lWx1gempFdRX/gaV6ykusNMOtg
         4Vd3v5P2BSevgbHhm/Yi8dydCOK8dVa1gH9AunT52bubzk4JidAShm3eQqq3lov7v9R9
         LZiYjdYBiwElNi/Z7q/ABxCdK0edFncACS04XcEmTHeiWt6umx0HEKRuzuphNZFXCAdz
         j9jYLZ55oDD+/UcYpa8Ip/i+ICT99Ji0/WKo+rR5u6GIdC8tVhgC9SFLa243Y0qXcCdV
         V+jAjvHSbThA4uIW2AlStX4FJjBSFWiefRqsYwD9TE728r5uv339Vzd6r4IMjYBVULZr
         +Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8GU9UEYT5N03rkpwdIveAr9b4UuOQPV8eSnr6W61v4w=;
        b=GjtD7dK+zDB7c/WGWE7+ZOrcGBzyCNrz4frhegIq4/q9Bp8teut+0++N/SuWWRzWXX
         yY+7t6Pd9TrVO3mOQhcJhlOVD42KmZi13B2XxxZj6v3nMlfG5I9GgEuRpjj/Er+X9h1W
         L1RQ8CJjRvnBh4dlDOP8u6p4W1GDfDlQYk1HEr5t9pWAPXXy06rYm0q/WRdBGOJgfFv/
         jKEW0QBexfZsn/USq4sFDeWYdnpqba2ETaYRrmA42I4xnVlkOcfG5XL4hZlN1HDi0LTb
         ND3lipzD7sNLPIn0WHSy0ix7vxt/YFNS63X3dfhpoi/C8bU0k4XJxTsJpjE+pOzop+ht
         mgQA==
X-Gm-Message-State: AA+aEWa9oEdvO+3dH4F+L9ay2CnZhJaZ1hn+9Bq0E17HHn9BAlNz3+sT
        geACWq1ED9uEvZtTuctrFKQ=
X-Google-Smtp-Source: AFSGD/X5ovv1YqhKbUQurEUiviGeH5Frd76s3aUWUYrw2KNg1zDDOIFzZeXD1uRrqvCvOAI5bEFuYA==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr3464390pgf.402.1544222048647;
        Fri, 07 Dec 2018 14:34:08 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r80sm6421914pfa.111.2018.12.07.14.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:34:08 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:34:06 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: RFE: git-patch-id should handle patches without leading "diff"
Message-ID: <20181207223406.GD73340@google.com>
References: <20181207181942.GA6411@pure.paranoia.local>
 <20181207220116.GB73340@google.com>
 <87tvjpx9fy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvjpx9fy.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Fri, Dec 07 2018, Jonathan Nieder wrote:

>> The patch-id appears to only care about the diff text, so it should be
>> able to handle this.  So if we have a better heuristic for where the
>> diff starts, it would be good to use it.
>
> No, the patch-id doesn't just care about the diff, it cares about the
> context before the diff too.

Sorry, I did a bad job of communicating.  When I said "diff text", I was
including context.

[...]
> Observe that the diff --git line matters, we hash it:
>
>     $ git diff-tree -p HEAD~.. | git patch-id
>     5870d115b7e2a9a936ab8fdc254932234413c710 0000000000000000000000000000000000000000
>     $ git diff-tree --src-prefix=a/ --dst-prefix=b/ -p HEAD~.. | git patch-id --stable
>     5870d115b7e2a9a936ab8fdc254932234413c710 0000000000000000000000000000000000000000
>     $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~.. | git patch-id --stable
>     4cd136f2b98760150f700ac6a5b126389d6d05a7 0000000000000000000000000000000000000000

Oh, hm.  That's unfortunate.

[...]
> So it seems most sensible to me if this is going to be supported that we
> go a bit beyond the call of duty and fake up the start of it, namely:
>
>     --- a/arch/x86/kernel/process.c
>     +++ b/arch/x86/kernel/process.c
>
> To be:
>
>     diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>     --- a/arch/x86/kernel/process.c
>     +++ b/arch/x86/kernel/process.c

Right.  We may want to handle diff.mnemonicPrefix as well.

Jonathan
