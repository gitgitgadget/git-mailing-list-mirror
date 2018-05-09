Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9AB1F424
	for <e@80x24.org>; Wed,  9 May 2018 22:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965863AbeEIWjM (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 18:39:12 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:45549 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEIWjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 18:39:11 -0400
Received: by mail-io0-f176.google.com with SMTP id c9-v6so817089iob.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkQFmkIt6M6MQ25KHSnzhlpAEwzSXk54y2c4367FeW8=;
        b=uOWY2UQbpCW1bH702gWgZEi9fPjVPKFkGCNwHpRKzkdsqs5C+eD0mF+nLzSp9J2qvj
         PXOfc/XAk0CO80S42Mmf1FQ/72vl0rq1hhCR56hANSahLrvlHL8F36rOqGs+/ft1SAdm
         DRPyZ41x0vc/eFI40maSNwULf5MixXN4S0Y8XlG9yAK8aECdCg9s6+pYpxOTlZ1DhEp9
         rdG2RDoz4/W+dunB3UTIMkQgbw/gzbauf4Bc1dCl6L6n/BoPILhl0SdnZVPiv7s4SaiK
         MnUV0d7W7VZZFGSYdqMCb2txSzOTz85+t7dQIarvNjZ0Q6bG8G7BsoWELr660g86+sfu
         fsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkQFmkIt6M6MQ25KHSnzhlpAEwzSXk54y2c4367FeW8=;
        b=f/k2BF5GvWoRk0v77ulEUImK6FHszI1MwbFTp7C/lxsz1nWxFDqBklLJV+rFDC0gSz
         J1m+NVuXfe/x27UBenFf92Ydi8dHXFb4xYPTt8HABkI/3NqXMjJn1ov3a3X0Ag3eHZwD
         GV4RxFxHF5QlgsBNjB6LBoYZgSR5Flz59HDuvxLXtfnFD+EST4Ak5pw8KX4ZENaJQuh8
         jngr2GJdmfQvi1ZjNu/aPUmZfGGeivdGVIUKCRoYnJ5xU+C2Eiwz8wpVF1sUP9XYRHuJ
         XiWIs7iy2YNDlXLNmmDFzVB8239HMwkKBhPMgcefu8WBeU0XS+zqIHrAJPFiNbdoSsRY
         x8TA==
X-Gm-Message-State: ALQs6tDSowjpXrdDg0w5cXTuu4vqbZ3D8NOZrmjnuN02zTtjCHt3hAza
        sFuvk5Fm0qGvInhMACe4i9mJUE4kLd7q7nfMEjgV92k/
X-Google-Smtp-Source: AB8JxZplW63Pc6ucJtFn69HRRavQOzKdkxa14DLI/U3/60ejzVZMPiL+XqfvlwfAgWgYm3DI2+LQmFQBVabq56JsXrw=
X-Received: by 2002:a6b:27d5:: with SMTP id n204-v6mr50657373ion.206.1525905550936;
 Wed, 09 May 2018 15:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com>
In-Reply-To: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 09 May 2018 22:39:00 +0000
Message-ID: <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>
Subject: Re: [Best Practices Request] clean/smudge configuration
To:     rsbecker@nexbridge.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 3:09 PM Randall S. Becker <rsbecker@nexbridge.com>
wrote:

> The question: what is the best practice for versioning the parts of
> clean/smudge filters that are in .git/config given that only some users in
> my environment will be cloning the repository in question and that I
really
> can't put the entries in /etc/gitconfig or ~/.gitconfig because of
potential
> conflicts with other repositories that might also have clean/smudge
> definitions.

Depending on level of trust, one approach might be to use an [include] in
.git/config to include a file that's in the repository. Something like:

[include]
     path = ../path/to/config

That way that part of the configuration can be derived from the
repository's contents. If you checkout a revision where the file doesn't
exist, then Git just ignores the include.

You're trusting the repository's contents, though, at that point; whatever
is in that file will be included in your overall config and honored by Git.

Bryan
