Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409821F453
	for <e@80x24.org>; Thu, 20 Sep 2018 22:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeIUD42 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 23:56:28 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43513 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeIUD41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 23:56:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id u22-v6so8699834qkk.10
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AriTFsMqL6P2w4TfqDuBumT7dtur91WHqrGwlTly+wc=;
        b=sNy3VjcMmcqC2vJ2fQUJ+0uQUevUCV1lEcXpVyEqp4f4nVrZjqUFaay9+tBwA69Vg0
         Xl/y2EqTGVNmnrvMZQxcsFmQ42C7CRhImuHBCONY+/qM3I+woOhotuM6ZCgkN/Fm5R53
         5b1NjWW21CqoQFwBlVUrWiOxbSNNzXAG1gjVhp/Np57hxqDgK31YxzpCi+xc2/xCd+WV
         qIx2fh5Maf/Suz40z7vMwWmkD1H7Xul3GqS0L3aFjFIDZmtT/OvS4wJGAa/OJVJ2wuHf
         iccO/xBDSXu+QegsaC69u1miLeJF/zIj6IH1XbYUXK5Wz1Rucgdi/g7czOf28IAk5fIR
         HuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AriTFsMqL6P2w4TfqDuBumT7dtur91WHqrGwlTly+wc=;
        b=juxp9NGkKg1/gLsPFqIrr9afKlx+A+69F1NMq4hswUgInDSl+oiSrYYgYqEPsQCxMW
         sQleXlzdlzZju6iNgTPWhelvjOYoylPwyTssharu8StxHO5iJ4hM+MOLclf0tvdrQrxA
         ibVQzGRTt9oVVupqL4Q2Sm5/zf3Q/K6rm7F2um0fdnhhievuaxr7m3BrOElDR8QictLQ
         ep4iA215vmW5plV2KeECDXuaIemZe5qOYj5EXvHc3BcSQ0JkLkvRffMeo+W6HyvSOQyI
         8wppx4QW+qqHcgpgbQwD8pc/FClM7Mk1IyHy25mHTmqGh5DGLxtqUxcBO0MBk8qMA2EF
         70OA==
X-Gm-Message-State: APzg51BC0Znqp3BXnunzjwV+kZjOhT3SPUHrX2lBtMzSaRyCMC9VrNiW
        0rufVV2y4QzNW7cF/iaKgEgNpufcQ32qZxSZSudo
X-Google-Smtp-Source: ANB0Vda4ux1ZuS6EhdUZGV2A89ftgj1eHi1OWhxc3/cDO9VimPb8DToex2m3JVGDsF5F+H9WuFu+MVWvElUe+gtMuaFP
X-Received: by 2002:a37:4a49:: with SMTP id x70-v6mr12650270qka.60.1537481447953;
 Thu, 20 Sep 2018 15:10:47 -0700 (PDT)
Date:   Thu, 20 Sep 2018 15:10:38 -0700
In-Reply-To: <xmqqh8ijzyep.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180920221038.74193-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh8ijzyep.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: Re: [PATCH] fetch: in partial clone, check presence of targets
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, matvore@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +	if (repository_format_partial_clone) {
> > +		/*
> > +		 * For the purposes of the connectivity check,
> > +		 * check_connected() considers all objects promised by
> > +		 * promisor objects as existing, which means that the
> > +		 * connectivity check would pass even if a target object
> > +		 * in rm is merely promised and not present. When
> > +		 * fetching objects, we need all of them to be present
> > +		 * (in addition to having correct connectivity), so
> > +		 * check them directly.
> > +		 */
> > +		struct ref *r;
> > +		for (r = rm; r; r = r->next) {
> > +			if (!has_object_file(&r->old_oid))
> > +				return -1;
> > +		}
> 
> Because check_connected() lies in the presense of "promisor", we can
> defeat it this way, which makes sense.  
> 
> I wonder if it makes sense to do this check unconditionally, even
> when we are in a fully functioning clone.  The check is quite cheap
> and can reject a ref_map that has an object we do not know about,
> without check_connected() having to ask the rev-list.

It makes sense to me from a runtime point of view - the usual case, for
me, is when we're missing at least one object that we're fetching, and
doing the cheap check even allows us to skip the expensive check.

The hard part for me lies in how to communicate to future readers of the
code that they cannot remove this section to simplify the code. We would
need a more complicated comment, something like this:

 /*
  * Check if all wanted objects are present.
  *
  * If the local repository is a partial clone, check_connected() is not
  * sufficient - it would pass even if a wanted object is merely
  * promised and not present. This is because, for the purposes of the
  * connectivity check, check_connected() considers all objects promised
  * by promisor objects as existing.
  *
  * If the local repository is not a partial clone, check_connected() is
  * sufficient, but this loop allows us to avoid the expensive
  * check_connected() in the usual case that at least one wanted object
  * is missing.
  */
