Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391551F428
	for <e@80x24.org>; Mon, 10 Sep 2018 18:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIJXbZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:31:25 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39780 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbeIJXbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:31:25 -0400
Received: by mail-pf1-f176.google.com with SMTP id j8-v6so10900299pff.6
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RtsyjUfOiyFhTOwU6ZFeBlFVf7b9LM1plwLcphC+JGQ=;
        b=nyPa3vb7wCkFywKCvI8Cc4SuoXrZlzO+yxlnd5UPazBAAA3VTPNRZm1kvR2iCGH8vK
         gJ+czqcmOjyqfUc9jzu01DmYRo22SFOppTT5Q7SRiNDdmKB3yTSW4E+OLVgZOALgqbxv
         8DVSMxVEiE5C7p8VTcLabbY9J7LkaeXxYTYWbF26YwkaIxU2gFQ4feVMkS1G+BMiMaiW
         Cqmn2Efhjzj1ULOhk56wG44Ia+VagOopk5jiRYBeTGYa6+r9jBH3j4iReDNDSJDxNnXR
         4/znmtyYckwaDKLh4JFNFDSayI3iziDfSlcGwmFKmJI/+PJQic9/3CE2uF8e14KN25nq
         98NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RtsyjUfOiyFhTOwU6ZFeBlFVf7b9LM1plwLcphC+JGQ=;
        b=nfC0yB76X8v9/tcaWiYaTe6wnciu+eLcCHSQGHjSCyYBhUwk3NO7mn/5fOxzRka1uF
         YxpHVRZSlztUD0Yc73uPssNBfzjoABnZ2vNq7KOzJH55DTua6Eu0jEofe9HQk0Hu1Xit
         wiF56LdZQMGc4ChoWOEuZVB8dH+G8evhcBPFp+TryTnAN6kN8X0SuC/MKjdC0qnpEVCJ
         Ol6A0EZXi0XE2wsBdr58kSPTQETYxBM02xzrXeRvkNa7HFw4GmQ2mAlnOLFBotl/j864
         NuFkmopRjU2RLYzViKsdKx53U9ci69loJ219AsCDoMcKqNFKL3BK9AW/x6fygvdNmtL1
         vdRg==
X-Gm-Message-State: APzg51BiQBS0rzzMp8IKtbfwWP1FNxn7At/nrkZfI8JNhSCAgOTWPl9J
        AmtMlps1MjXvKey6L5egVIJ2Phyh
X-Google-Smtp-Source: ANB0VdbaAEnROeh3Y2MAIlTL8zt75KF04Hs6zzZcvs/wn5DwAKY/2nIlKyeMei/D2FDXqc3ZS5zpYA==
X-Received: by 2002:aa7:84c2:: with SMTP id x2-v6mr25290619pfn.220.1536604560597;
        Mon, 10 Sep 2018 11:36:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c1-v6sm33671567pfg.25.2018.09.10.11.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:35:59 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:35:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stas Bekman <stas@stason.org>,
        git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180910183557.GD26356@aiede.svl.corp.google.com>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <20180908212256.GB31560@sigill.intra.peff.net>
 <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
 <20180910171422.GA26356@aiede.svl.corp.google.com>
 <xmqqa7optdbs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7optdbs.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  1. Treat single-quote as worth quoting in config.c::write_pair (line
>>     2516).  This would already help with the original issue, since the
>>     config would say
>>
>> 	[foo]
>> 		bar = \'baz\'
>>
>>     allowing a quick diagnosis.
>
> I am mildly against this, as long as you feel that all the remaining
> steps need to be marked with "(optional)", because this will give
> readers an impression that somehow single-quote is special.  If we
> do not intend to make it special at all, we shouldn't.

That's fair, especially because it would be inconsistent with shell
command language, where single-quote inside double quotes is not
special:

	$ printf '%s\n' "\'"
	\'

(I realize that backslash means something different in Git config; I'm
just saying it would be another source of cognitive dissonance.)

Updated proposal:

  1. Treat strings starting or ending with single-quote as worth
     quoting in config.c::write_pair (line 3269).  This would already
     help with the original issue, since the config would say

	[foo]
		bar = "'baz'"

     allowing a quick diagnosis.


  2. (optional) Warn if a value is surrounded in single-quotes,
     encouraging using surrounding double-quotes to disambiguate.

  3. (optional) Error out if a value is surrounded in single-quotes,
     encouraging replacing with or surrounding with double-quote,
     depending on the user's intention.

  4. (optional) Start treating wrapping single-quotes specially
     somehow.

As before, I think step 1 is a good idea, but I'm not convinced about
any of the later steps.

Thanks,
Jonathan
