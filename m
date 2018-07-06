Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165291F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeGFVZw (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:25:52 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:42707 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbeGFVZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:25:51 -0400
Received: by mail-yw0-f202.google.com with SMTP id r144-v6so1787201ywg.9
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=VLEUWSPdgDLipryQ+7QLbqpLtQDRajWR4ZfU5fWSO78=;
        b=r/EzSPPs+zFDbNWfdS8K9XsLEicA/T9dQpEjjuyTcSB+Pcb2jkG1zh+lSnEZyRUKpp
         5aRlcyxEFNsjx2SQcW+s4ZHFacozV9mRtf8gnGSQ4fgoyLrTUWJ8tKoovLXvJVyt2ZP9
         1vUcr1WaWq4saDr+3sVFaTj/SxmGi07mzcoRjQsAPJB7lRILgC0SnnYWrVdribOF+Jvs
         a2yT9ofTxfKMzSttSOo8o3fVCLH4UMMiONeT0DTJwPgkhoDksPDaYedzz29M1CZPUrmF
         3PG9v8APzma84Vn4QoB40l9S8PPDmFqIAcYNN6axZzwgYkE7ebjokfZl2+qk5XnGzPj3
         IgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=VLEUWSPdgDLipryQ+7QLbqpLtQDRajWR4ZfU5fWSO78=;
        b=iSPpjklSrO3CuQjY0plQX9CnuxsoWBwFL2iK0tf2JpbmlcH5bjxkbSJ6gVuFp7AB/H
         HZaLeC0gFN2Wc6WakdYw6joI8vUIxve+pHIejISqTRGPkHfzV0otUJnf3l+9cg/YM6ck
         bMcvdX5pCVp64VE606JW2qiATba8+xKVuPkGUVFXoTpJzg2P9L+fzzxKYKgwq6vhHGaE
         DLHCL7VoiGsXCVDm0kbiFHoGveH93EjLGBwYj8oH5HHRALFFwZFvXD80Mt61RJ0D3M4s
         eMZyeLTEDFGdvTPu/WRCNFcs2SZWo3gcx3BYf24FpM+J4HFAcXb3E+aaoMqp3nFTFl16
         Cy2Q==
X-Gm-Message-State: APt69E2yToHSbK+uvm7+t4nR0O6+x23lth8fl5tmUvBjQg66KWGsvoYs
        7XVCHyZ/zn7f52u/Hg+hwaExc+PbWY/FYlNcAdFB
X-Google-Smtp-Source: AAOMgpfQfPFsQZwQVWcM21XtEa+RG0Dgq2Tk2+uths30HsT/bdL7teWQE2Jwn9lwG+SOjq1FtRPj1Iof7gBaTQUTLHJW
X-Received: by 2002:a81:ad64:: with SMTP id l36-v6mr3148396ywk.8.1530912350683;
 Fri, 06 Jul 2018 14:25:50 -0700 (PDT)
Date:   Fri,  6 Jul 2018 14:25:46 -0700
In-Reply-To: <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180706212546.178115-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmph, the approach taken by these two patches smells bad.
>=20
> When a blob is deliberately omitted with --fitler=3Dblob:none, the
> fsck that encounters an entry in a tree object that is about that
> expected-to-be-and-actually-is-missing blob does *not* complain and
> that is by design, right?  Na=C3=AFvely, I may expect fsck to follow the
> same principle--when it encounters a reference to an object that is
> deliberately missing, refrain from complaining, regardless of the
> place the offending reference was found, be it inside a tree object
> or a ref.

The difference between the two is that this tree object is from a
packfile with an associated ".promisor" file, indicating that the
destinations of any "dangling" links are promisor objects (and thus,
fsck and others will not complain about those). We don't have such a
mechanism for refs.

This was a tradeoff between the desire to still detect repository
corruption whenever we can, and to not impact performance greatly when
operating on a partial repository.

Besides the solution in this patch set, we could (1) allow any ref to
point to a missing object, (2) allow a subset of refs to point to a
missing object, or (3) have another place in $GIT_DIR that can record
the hashes of promisor objects. (1) seems contrary to the repository
corruption detection goal that we have. (2) is plausible, but we would
have to figure out what to record - it's fine to record the RHS of the
default refspec when we clone, but I don't know what we should record
when the user subsequently runs "git fetch origin
refs/heads/master:refs/heads/master". As for (3), that would require
another repository extension since we wouldn't want an old Git to fetch
into a new Git repository without updating the promisor-hashes file -
but at this point, it seems easier to update the protocol instead. Any
comments are welcome, and I'll think about this some more.
