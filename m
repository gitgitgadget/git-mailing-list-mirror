Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0BA1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeFYWgo (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 18:36:44 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:55379 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeFYWgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 18:36:43 -0400
Received: by mail-yb0-f201.google.com with SMTP id y16-v6so1999183ybk.22
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 15:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3S/nLkM+e3sZ58ZRqhO5bXe9SRiOevGOccOyV8nGUqw=;
        b=DOlvj1DHVX8nS2Z0WFnVl63Ddb9aOus31ab2wJJGoDS1tl1DVuXf6gh44pkyOJA3ch
         5t0oBONUZtIpSx+Q3oJ6UtsC1/qTwx+yJrrf5sIwS6+Zdwl6LIGsGafOjk6a5dr1T4QH
         EOyh6CgCeZaazP4xutUJZ3s74FKwzVLyzWSEDP8/WPW/aQJiDSyghPZJt9+SBkE2ejox
         WoUECYm0ufucFobiByJB/qUlgLFSheYKhnpU42Vp0dV/kLiBFmXI8MZy8pWIlA9UzWi6
         Pmn2MGbX/XvgNi4F3KoQRFkzthaeTLJ+rvFhgSMv4MF4uYYnN16kIas0KMgUSWub7OeH
         UBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3S/nLkM+e3sZ58ZRqhO5bXe9SRiOevGOccOyV8nGUqw=;
        b=r+m5BjJ3MNN8LkRf9U2motjSnd4M69jXZ/e2Me9wmnPf0FwDn81qmVf8l5f3HaNBxI
         8NS8cXApwkTMAAWOApYfS8X0wS9E5elicEUQrUWIyu1X14wlrPgSRS9MAkBeG1PGC4XP
         i3JpRvREF5g2JoN5ks1DFxMaN/FUPd1t+sANfbqzmB3eVvi8j92JizsJSl5I4oyNq8nE
         TzDbpfZJ/gtHYUQ/xsYAQeuzxIS4Er+SoYKoriFstNr6IO5JwSXIH3dhzL5OMXR9Z5NK
         T5gIiTyWhhmSAR/50NEWugz8seBDW/dKPJvX+Yvnzbkq+h5itv3DHuFlrCXQnXIW3ALY
         QKSA==
X-Gm-Message-State: APt69E2cX8W7pX8hnJ8D9Qb4cwrcFY3JOvvhjnqCMFkyvACMshpSJZO9
        3pQOyvyNU2AZl1APgZ4qI6YbRppA5/ACS8WfTDsn
X-Google-Smtp-Source: ADUXVKJD4gjVZWcnodl6fg85TMD2i4qXHJcpN7rnv1+STelrLAk89dbnFbWyBcoUUFZMnho/C70PXITXndjihQOt/sCK
MIME-Version: 1.0
X-Received: by 2002:a25:ae25:: with SMTP id a37-v6mr3879782ybj.41.1529966202704;
 Mon, 25 Jun 2018 15:36:42 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:36:39 -0700
In-Reply-To: <20180625185332.164142-7-bmwill@google.com>
Message-Id: <20180625223639.203642-1-jonathantanmy@google.com>
References: <20180625185332.164142-7-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v4 6/8] fetch: refactor to make function args narrower
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Refactor find_non_local_tags and get_ref_map to only take the
> information they need instead of the entire transport struct. Besides
> improving code clarity, this also improves their flexibility, allowing
> for a different set of refs to be used instead of relying on the ones
> stored in the transport struct.

I see that due to the narrowing of get_ref_map() to take the refs (and
the remote) instead of the whole transport, the computation of the refs
(including computation of the ref prefixes) is also moved from
get_ref_map() to its caller, do_fetch(). As in a previous patch,
get_ref_map() is only used once, so this movement is safe.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
