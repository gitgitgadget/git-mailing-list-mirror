Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84241FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbdJVFA3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 01:00:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43434 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdJVFA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 01:00:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id a8so14800520pfc.0
        for <git@vger.kernel.org>; Sat, 21 Oct 2017 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=jOtT8MNIZElIvtCyYGFGWj02SKllRe9Ndbjl7wNuC2E=;
        b=b5lk2Nn5iYI85rtk1gxJq3TO77CpN8L2uqhOW7kUKsHMbi1b5L47wgt7m7+w8k2uGE
         /vCtZza5Z+14JU+R1sXq6cupXcEHNonIBcBWZ+mODAx+U2UtrJJjER1P0WyzSCht5Sry
         x5GbQU0D1enwRfpmljX7XFUi6699EKocRN+b8TqhSqKqHGfmgdm3vfKp9Ad24vbDt21C
         Ora3tg81JJaNxHxHeYeDb6+zULs1OPU7oUj2A34MRQeDvBJrR2QCafdkj0ZoVEX7fb8Q
         4OT8cf5iFqIcL5eVygeEC3eIC8SZRp+m8ppwWDxhLaM9kl35IQju+zCXr4DvEejq0/WT
         mXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=jOtT8MNIZElIvtCyYGFGWj02SKllRe9Ndbjl7wNuC2E=;
        b=RymGVvrqo7sJyGVxTXHKit8BnVR3rwkcHrM8zmpVcQlGHnH9h4ZilWFbz/sor98fiy
         VDR1n6D8vLdlDwdSJ30Wy96RYb+2Krt+eO3MhH3tJmXYuEQ/bwx/UoyAbiUDWllXVMro
         9ZnJOuTnmcUrSMliRgUuDT/J6r5Wyug3ZdyDrGcsgAAXvrnpHWjpTNGtOJMVCKVfUOAu
         argD5Gpf+Ts/Mt5nGpHk+pytDDlZU9dsdMYjuCiBJ1vzI4iIVbWF1uN+qzLdxa8HUBKX
         8EHHCV8t/5d9ypz1jei6/05m3im9qj0qK8TMaaZ5xJ4N1upYACsHL1PUPqtauWwwBBPt
         3xUg==
X-Gm-Message-State: AMCzsaXP77zWH89kylFVJPj53+md8F8wYGHl69LwMtKTbOE2cm6kgEOk
        iip+FHd66XwcNAMT/4yR9Ig=
X-Google-Smtp-Source: ABhQp+QOm3sew2XKyEwqN9mNRKnmyFdJgnJmiPsJkQdIWuR8G1VceTThCGJoYxGQ5RrMHx2DEW5zIg==
X-Received: by 10.159.252.133 with SMTP id bb5mr5831359plb.415.1508648428063;
        Sat, 21 Oct 2017 22:00:28 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id z8sm7665960pfl.135.2017.10.21.22.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Oct 2017 22:00:26 -0700 (PDT)
Message-ID: <1508648422.2152.7.camel@gmail.com>
Subject: Re: [PATCH 3/3] branch: forbid refs/heads/HEAD
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
In-Reply-To: <xmqqpo9gg9pa.fsf@gitster.mtv.corp.google.com>
References: <20171013051132.3973-1-gitster@pobox.com>
         <20171013051132.3973-4-gitster@pobox.com>
         <20171013131501.3qarwhanktfvgjqd@sigill.intra.peff.net>
         <xmqqefq6v5qj.fsf@gitster.mtv.corp.google.com>
         <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
         <1508561424.2516.19.camel@gmail.com>
         <xmqqpo9gg9pa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 22 Oct 2017 10:30:22 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-10-21 at 17:57 +0900, Junio C Hamano wrote:
> ... The code may already
> handle it, or there may need even more code to support the rename; I
> didn't check.
> 

As far as I could see there the code does seem to already handle the
rename. This part of builtin/branch.c is what seems to be ensuring
that,

        if (strbuf_check_branch_ref(&oldref, oldname)) {
                /*
                 * Bad name --- this could be an attempt to rename a
                 * ref that we used to allow to be created by accident.
                 */
                if (ref_exists(oldref.buf))
                        recovery = 1;
                else
                        die(_("Invalid branch name: '%s'"), oldname);
        }


-- 
Kaartic
