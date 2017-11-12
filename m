Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E267201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdKLNdX (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 08:33:23 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:47000 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdKLNdW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 08:33:22 -0500
Received: by mail-pf0-f173.google.com with SMTP id p87so9992479pfj.3
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=ydvyeUk1HPkuqjF4vHn+rdEeA17fDIfVMu8jo3fFYzQ=;
        b=mQF28XmEw4ysGhU3tA7h1yki7ilB2WaN9lS5bvVWD6u4D72jDHBhkK16xicv0Ejkqf
         Mx+dKWV4VtisAUQzxts6ohsTIesi75AE6dDktZPSXoFzYeEUyWsxhzvvCnDAgRWrzX9D
         ja0DBe7XcttwVkEgP0JprSVJL1hgvjk588AD/a8SdTZxlBJkXxU3Baeo5OsLYGL4GrKr
         uZLgqql4R1FVxjiem1JMT15ETfsXNisyWZJzqITBl5nUnH+hRzRhQFlrfdmPyu8/81Rc
         YjGOkj42C66dLzcQ0pJ8qBSk31phmB8/NdmAZSQr6sOHwBmRmfyj2UbHI7qZlhN9UUqh
         nMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=ydvyeUk1HPkuqjF4vHn+rdEeA17fDIfVMu8jo3fFYzQ=;
        b=hyQTjZShpMJVeZ7wVEU2A8K+5GfezWKOo90g/+i3ngbw5b0KtEhnaUpJdmeBSiXJZX
         qDejivdSVpD3Hz4IUKFBs1c2hznRp9+GC+LtkOdLrpWeL5mB9txBn1/LseBocPDlCD6C
         /TKKTUuTORZHjU8U6WM2uo/AjaPrHZGj8NjGjDpOhdHY0FCHAGEgy1De3zEWPNSnshOY
         Gz33bADMy7Ah3VQJFc5tu69XEHX2pOsVdYIZXDLxrEsNHvFWWX2y3VFJuhaVuMwOAEFN
         1CBLBcfDgAo0PQP1TStuhsMB5pvO/vp9RFprwyqwU+Kc59kZOdBRKgo6iM3TrDsJQc2k
         r2iA==
X-Gm-Message-State: AJaThX4AcprU17u/pQB4FDOKFcZoUBJfcRhvqxU3ZmJ4xZKKr4ol7l8w
        c9jn+T2XInaK61WlCaDH3HJwnSdf
X-Google-Smtp-Source: AGs4zMYRoC7r0PWG/OSl4rNVWPEzN4Iuxy9j9fnHxinUSv/9StN9zhx1C3AcAjDC5TyPieOjAjNeQA==
X-Received: by 10.99.95.143 with SMTP id t137mr6028606pgb.442.1510493602114;
        Sun, 12 Nov 2017 05:33:22 -0800 (PST)
Received: from unique-pc ([117.246.57.0])
        by smtp.gmail.com with ESMTPSA id p189sm20386566pfp.127.2017.11.12.05.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 05:33:20 -0800 (PST)
Message-ID: <1510493595.2683.9.camel@gmail.com>
Subject: Re: [RFC PATCH v3 3/4] branch: introduce dont_fail parameter for
 branchname validation
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqq7ev4jga9.fsf@gitster.mtv.corp.google.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
         <20171102065407.25404-4-kaartic.sivaraam@gmail.com>
         <xmqq7ev4jga9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 12 Nov 2017 19:03:15 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-11-06 at 11:24 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> We usually use the word "gently" to when we enhance an operation
> that used to always die on failure.  When there are tons of callsite
> to the original operation F(), we introduce F_gently() variant and
> do something like
> 
> 	F(...)
> 	{
> 		if (F_gently(...))
> 			die(...);
> 	}
> 
> so that the callers do not have to change.  If there aren't that
> many, it is OK to change the function signature of F() to tell it
> not to die without adding a new F_gently() function, which is the
> approach more appropriate for this change.  The extra parameter used
> for that purpose should be called "gently", perhaps.
> 

Good suggestion, wasn't aware of it before. Renamed it.


> > +	if(ref_exists(ref->buf))
> > +		return BRANCH_EXISTS;
> > +	else
> > +		return BRANCH_DOESNT_EXIST;
> 
> Always have SP between "if" (and other keyword like "while") and its
> condition.
>
> For this one, however, this might be easier to follow:
> 
> 	return ref_exists(ref->buf) ? BRANCH_EXISTS : BRANCH_DOESNT_EXIST;
> 

Done.


> The names of the enum values may need further thought.  They must
> clearly convey two things, in addition to what kind of status they
> represent; the current names only convey the status.  From the names
> of these values, it must be clear that they are part of the same
> enum (e.g. by sharing a common prefix), and also from the names of
> these values, it must be clear which ones are error conditions and
> which are not, without knowing their actual values.  A reader cannot
> immediately tell from "BRANCH_EXISTS" if that is a good thing or
> not.
> 

I've added the prefix of "VALIDATION_{FAIL,PASS}" as appropriate to the
enum values. This made the names to have the form,

    VALIDATION_(kind of status)_(reason)

This made the names a bit long but I couldn't come up with a better
prefix for now. Any suggestions are welcome.


Thanks for the detailed review!

---
Kaartic
