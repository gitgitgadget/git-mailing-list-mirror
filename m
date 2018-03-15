Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3AC31F404
	for <e@80x24.org>; Thu, 15 Mar 2018 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCOVXK (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 17:23:10 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:42490 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeCOVXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 17:23:09 -0400
Received: by mail-pg0-f49.google.com with SMTP id x2so3263846pgo.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XVvzVdb5uvuV8dOCUDVpUjvHuq0rokl+FMCV8gxnFzE=;
        b=RMIo//UWRwooq28CnXh2qh1Bm1RWpFrmmirIivyFAEgTvcJ1WqgIukGBcPXlnRKnub
         3P6p1P/2tbTPbUPol94JfhBaLtPGVcL3VEqnzCT4c+tegBEY9521RzRA1ELoJbzkZUo8
         +p5ERCR8bJ224pI7hUm/YfeFbGsyoUS4Vz71W2TpXYC4K5kaCXbh6NvM20RE6rHUfDQf
         NETceViDM7Rz1u0bSCynn+yz5yG9STg6bVUVVvT6YmVm5e6/v1K00DR5wP4sx6WCjHe0
         sCK7gkgMO1TOIwZlHyVZZ5zit/DTmmlavddlpxnWUlpeHB90qqAXzHSEY5Ibw3i4GtZ2
         oUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XVvzVdb5uvuV8dOCUDVpUjvHuq0rokl+FMCV8gxnFzE=;
        b=WAovPnsAOVH1n3xXd/B1LPj57VSY0w5XMxizTK3zSikSuyEX9Hv7PiukzEV1zTUIBw
         inQkoIvIiNUNrXQDMx1EpcSBvAPpLb/oSVei/B/Kg3u1Eqq5MhkJDXP0bo6T0VD+6fRL
         fDfr1WyjvKfrNPgWOwCBK18v+nQfR0JW2raE3/S1DFauMcma0sfkJ5ys+WhYUNXLWFJP
         pvMUuzUJwrqCjTmAYYAws0L82julSmBRa9gSQY44U34ZuF6scV2QePxVXrt0qPpzHkB9
         NBXUD/pEsBI0KEXlsLxUywPK9Ws7lekX4cqQE8nV3jhdNL1KZUs5aLimyKLsbw2e8MSP
         aMSQ==
X-Gm-Message-State: AElRT7Frjd8+yUnFKcz5VFeVwmWmsdPOfj7NT47XVteuz9SMeERQQZgK
        LOKJH1kE56Vv4bdfhWpVJLjgy2PG
X-Google-Smtp-Source: AG47ELvkHxTiE1elVr4ogBQpWMXRvk4oZA+snxNR6shXotZLx9agJIKcO+unCsSIXDAt3or2Zs24Mw==
X-Received: by 10.99.102.132 with SMTP id a126mr6436064pgc.385.1521148988814;
        Thu, 15 Mar 2018 14:23:08 -0700 (PDT)
Received: from rem2ua0031cfw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 191sm11759911pfv.167.2018.03.15.14.23.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 14:23:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqmuzh5alb.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Mar 2018 22:23:03 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <BA576CCC-CF0C-4D50-AFC8-5C8FC7F59697@gmail.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com> <20180309173536.62012-7-lars.schneider@autodesk.com> <xmqqmuzh5alb.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Mar 2018, at 20:10, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> +static const char *default_encoding = "UTF-8";
>> +
>> ...
>> +static const char *git_path_check_encoding(struct attr_check_item *check)
>> +{
>> +	const char *value = check->value;
>> +
>> +	if (ATTR_UNSET(value) || !strlen(value))
>> +		return NULL;
>> +
>> +	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
>> +		error(_("working-tree-encoding attribute requires a value"));
>> +		return NULL;
>> +	}
> 
> Hmph, so we decide to be loud but otherwise ignore an undefined
> configuration?  Shouldn't we rather die instead to avoid touching
> the user data in unexpected ways?

OK.


>> +
>> +	/* Don't encode to the default encoding */
>> +	if (!strcasecmp(value, default_encoding))
>> +		return NULL;
> 
> Is this an optimization to avoid "recode one encoding to the same
> encoding" no-op overhead?

Correct.

>  We already have the optimization in the
> same spirit in may existing codepaths that has nothing to do with
> w-t-e, and I think we should share the code.  Two pieces of thought
> comes to mind.
> 
> One is a lot smaller in scale: Is same_encoding() sufficient for
> this callsite instead of strcasecmp()?

Yes!


> The other one is a lot bigger: Looking at all the existing callers
> of same_encoding() that call reencode_string() when it returns false,
> would it make sense to drop same_encoding() and move the optimization
> to reencode_string() instead?
> 
> I suspect that the answer to the smaller one is "yes, and even if
> not, it should be easy to enhance/extend same_encoding() to make it
> do what we want it to, and such a change will benefit even existing
> callers."  The answer to the larger one is likely "the optimization
> is not about skipping only reencode_string() call but other things
> are subtly different among callers of same_encoding(), so such a
> refactoring would not be all that useful."

I agree. reencode_string() would need to signal 3 cases:
1. reencode performed
2. reencode not necessary
3. reencode failed

We could model "reencode not necessary" as "char *in == char *return".
However, I think this should be tackled in a separate series.

Thanks
Lars
