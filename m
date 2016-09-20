Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5941FCA9
	for <e@80x24.org>; Tue, 20 Sep 2016 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbcITGv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 02:51:27 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33719 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbcITGvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 02:51:25 -0400
Received: by mail-yw0-f194.google.com with SMTP id g192so359372ywh.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 23:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8gWdI4q9MtM24ltwIR7a18ZCH7EIUvWxgqO62GOLSa8=;
        b=ONcrWZ7qUPIT4mtC9QeqhjlF+BSPBwoejVZkaMZ06QVa9cNkk95pOs7IF6XYP/b1Zl
         49JHBO2zqZ/NadQpsqNTWvzH32fL6WwVBvfa0j3kr9WoH6vSqmhCyApA3oAQrVqWE2FA
         27eFFkCmincpaeYoIgR2Be3JvNFCzdl0tOQ7TlOQIeubUu9TRq02mEK73fsjhSeXKbtw
         uIqDVqydL6O+ij2VWnhY5tfAu6j8MLo2aDEs426Vhig6Z8PpuYtfl+eJV5XY85Ud+4Ox
         /1RjC3/gHiFAXRtVp6PGRnJkxd72TyghStDEy0Lnslw1joLo8nii4b7sXcSJzii9bTxj
         Iuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8gWdI4q9MtM24ltwIR7a18ZCH7EIUvWxgqO62GOLSa8=;
        b=UCXVyYixD5+ztPS+sxMg+RaTF5EY0gSYm8qeXh59+WvVanopmr9ZLzbYrSVl29FMmL
         WcsHUAUssVMeH/IAe4M5RS/2hrcvzwL2jN2QABaIGdAmLFquuzKak2jFevZBBT6gmq1w
         8JFwPD6DGTd+SCwnINo7d7M8x7F5qhGeJZ6mttOaaZ4T3LyYLbSqTmt4J+hJ4K94ODdT
         srkaBe6Up+aYYnA/18C6amKxNYS4xHgG8Z0qqZtCI0ryq/s+7yYzzbdclZ75GN8GrIFU
         4QwO9tBSnjEGDBB8FRxDrfrSN3hQju/XLIiFdc17dYEoE8X4HXF3Qkvc0/qwlVezezaj
         MDXg==
X-Gm-Message-State: AE9vXwNGoQasTfC/8sevS73+A8eVoOIv+nO0JGrjs/IY0jNgr1xsYGruT/Jkh0qWZqcP3zuICMGmS9jxdqWNhw==
X-Received: by 10.129.78.18 with SMTP id c18mr29014158ywb.160.1474354279111;
 Mon, 19 Sep 2016 23:51:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 19 Sep 2016 23:50:58 -0700 (PDT)
In-Reply-To: <20160920013704.7hk2creytmfrla6h@sigill.intra.peff.net>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com> <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud> <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
 <20160919234022.GA29421@cloud> <20160920013704.7hk2creytmfrla6h@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Sep 2016 23:50:58 -0700
Message-ID: <CA+P7+xoQSV99i0ntsw8P+p3K21FGCi9kkhqTq7tC3rSCMcLL5g@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC PATCH]
To:     Jeff King <peff@peff.net>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 6:37 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 19, 2016 at 04:40:22PM -0700, Josh Triplett wrote:
>
>> >   - there are a non-trivial number of patches for other projects (JGIT,
>> >     EGIT, StGit, etc). This is somewhat unique to git, where we discuss
>> >     a lot of related projects on the list. But I wonder if other
>> >     projects would use subsystems in a similar way (though I guess for
>> >     the kernel, there are separate subsystems lists, so the "to" or "cc"
>> >     header becomes the more interesting tag).
>>
>> The kernel mostly uses "[PATCH] subsystem: ...".  Occasionally I see
>> "[PATCH somegitrepo ...] ..." when it's necessary to explicitly say
>> whose git repo the patch needs to go through, but that's pretty rare.
>
> We do both. "foo: blah" is for subsystem "foo" of Git itself, but
> all-caps "JGIT PATCH" is "this is not even for Git". I don't know that
> the kernel really has an equivalent.
>
> -Peff

[net] and [net-next] are for the *tree* not the subsystem of the tree.

net: also means the networking subsystem, but it's different you might
have a new feature and say

[net-next PATCH v2] net: my awesome new feature.

Thanks,
Jake
