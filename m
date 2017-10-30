Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B83202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbdJ3W1a (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 18:27:30 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:54057 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932513AbdJ3W13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 18:27:29 -0400
Received: by mail-io0-f176.google.com with SMTP id 189so30786488iow.10
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbez/m66k0dOLulR3cVhN9WH3y45wvXuP4rd3lnNn9g=;
        b=Ay7RDuoXgNjQ5n84tybp0cyyD4lyorHJ2j8Yb55LPxcXGgvn70UAXY94kgO12TQ57X
         u3PvXbaMoG+68aL0HrLsxouODbF8yxEt8ywFJnzE+nwxiYUqJp87nNhFRxakby3zxaJN
         6dMbUtB7HkzVWnwW6AdInN1FT+KOPVk1Ko9ItueUlXybQfbxN71M4FJ+swQtEaV5Xh6D
         nBOeOtw64c6hPm+vVOCe88LrXQoq/ftN5uiNvtKOt9tAQ2xRZo0W3xVFaoWvgLfAIvpO
         svBS36nVDad5quXkPPk1Fbv4CrGpz9RGRZ+7ylWBWJF45zn4iilwwxbMuzXH7EAv7/7k
         ObDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbez/m66k0dOLulR3cVhN9WH3y45wvXuP4rd3lnNn9g=;
        b=exV+Bq0pb/y+3YWXgaNKvxsCCkwfalJt6OKr3DjBljoWdQhg8y2PK6Wd/x8mTR/1TX
         f5OSuuRqM3aZpdeAUcoRFYTvLprWs6ja4OFNryF2NKXuqxeT2C0Sil3KgLqj8kg8FWBT
         HBVsEUmUDHWET1sRc1XaY9EgPDSzDUyeAyDoxm+A1UL1/fI1EV2T0pcKQf8eMnLZuXBp
         HP7bBdxh53GrCqxjjMs6tmSA2wJ1cmJ2T7gZQ9MTV7KhTc/1S3l99lA4/6Y0MFEMx24r
         c6J5eg32hTCoOAW+cjLql509ABet//DlC1sxYNTN9GkqorvSjjDV4LC/MuVJdah9C0wA
         U7gA==
X-Gm-Message-State: AMCzsaUeyy2GVTypFvq8/9aYrFddWHutRnbXiv01U5Y/VqxveMF3VIaK
        UEJMw/D9LtBTGrCNO0wAYNQ=
X-Google-Smtp-Source: ABhQp+SLEHPPMalfdOQSXmS+QOVe0GeEtlhhOx59s6WchJwkCHDCq83bTvVFMnxx4FKGhYmtC9v3CA==
X-Received: by 10.36.178.77 with SMTP id h13mr401629iti.114.1509402448899;
        Mon, 30 Oct 2017 15:27:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p84sm157182itc.3.2017.10.30.15.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 15:27:28 -0700 (PDT)
Date:   Mon, 30 Oct 2017 15:27:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
Message-ID: <20171030222726.g26nryjxktyj27sd@aiede.mtv.corp.google.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
 <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> As for how this patch set (excluding the partialclone patch) interacts
> with my fsck series, they are relatively independent, as far as I can
> tell. I'll rebase my fsck, gc, and lazy object fetch patches (but not
> the fetch and clone parts, which we plan to instead adapt from Jeff
> Hostetler's patches, as far as I know) on top of these and resend
> those out once discussion on this has settled.

Selfishly, I'll make a request here.  The only part of the series that
overlaps is the max-blob-bytes part, right?  Would you mind re-sending
the remainder of the series so it can go through the "next" ->
"master" -> etc process in the usual way?

My selfishness comes in because this would reduce the set of patches I
have to apply locally to just the max-blob-bytes part.  If I
understood correctly, the rest of the series was something everyone
agreed about, so there's no reason not to pursue including it in
"next".

I'd have the same request for this object filtering series, but I
think it's already happening: the patches in this thread so far do not
allow omitting some blobs from the local object store, so they should
be able to go through the "next" -> "master" -> etc process as well
without having to wait for the fsck patches.

Thanks,
Jonathan
