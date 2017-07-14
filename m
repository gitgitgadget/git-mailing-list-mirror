Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9F220357
	for <e@80x24.org>; Fri, 14 Jul 2017 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbdGNRyN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 13:54:13 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34806 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdGNRyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 13:54:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so11735631pfe.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Hu+W1BFLPzf7ieUudOQwkERm9/CaH+L8d+253jIA6Tk=;
        b=fnzo94kNcHTKvIgW5LeqnD71v9/zwRw8dcJb7yqhA1zAr32athbb0CkyMKmTYC54qs
         fdaw4A4ZfzOibIB9BTXpFqtz5K2D2QWZt28N8ks1YHsl6mvXAyC/DGZsAyfE5c5Aysde
         vhaH1drvaU2GZt4W64JvMTJABHybX0aX4+Cy3sBVfkO6y03kj0P660g00exyPU5CJaZf
         Hu2IdLbLqfq0ZQJ4JBO+PgaCZtBhbaDTP8L97R4ps9pUQ5Yf8ZPsleUwQa7ozQ0ok2Vx
         zX/Cvt++XQtNt44kGjC9b+/jr2w1hH/n8DG56++2w4P0KERa4WqmZ4eF+fL51XPE+MsF
         u3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Hu+W1BFLPzf7ieUudOQwkERm9/CaH+L8d+253jIA6Tk=;
        b=eO/ULRkshnkzye8F+53E5hyV/lf3FjAYEvjcWRHKJcw//wmXWcIUO8IcLpqyBCjPXo
         PYzeKDTdJd4exkKd8CKlyQiRr6yTiUprJQximF2isUt1nXZ+f1SnnjQTC15pOCXb/7Ag
         eEF2K7tjoO++fL00lb7JMa5gh/BeVdPf7DXgOOssOdjD99U9M5Pt3Lk9fKThsn5kISOa
         OQxYdkUEeT+XtaPzZUxGSLr0X9iK/kurtDaHW1qCCLk9lf6ih9OSCzMgNPIRh4i472e2
         6i2KAX6E8k8+FftYxWpOL3rG7hlJNYZtsxyh7qZ/bq1am13PIKTyd+WQK/wCFskdnK8T
         F/9Q==
X-Gm-Message-State: AIVw111VVOxVGcMFp1hJfh7ywaUwtgcngtOOhgL4DWwFKYeXAMG34t5t
        YDZxomint48igw==
X-Received: by 10.84.128.76 with SMTP id 70mr17560420pla.229.1500054548717;
        Fri, 14 Jul 2017 10:49:08 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id r73sm21712118pgr.32.2017.07.14.10.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 10:49:07 -0700 (PDT)
Message-ID: <1500054552.18990.8.camel@gmail.com>
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info
In-Reply-To: <xmqqiniww37i.fsf@gitster.mtv.corp.google.com>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
         <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
         <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
         <1499969722.5973.2.camel@gmail.com>
         <xmqqiniww37i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 14 Jul 2017 23:19:12 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-07-13 at 12:23 -0700, Junio C Hamano wrote:
> All good points; if it bothers you that "commit" and "merge" define
> "emptyness" of the buffer differently too much, I think you could
> persuade me to unify them to "the buffer _must_ contain no bytes",
> i.e. not special-casing sign-off lines only "commit".
> 
Intereseting, let me give it a try.

To persuade you with this, I have to convince you that the current
behaviour (special-casing of sign-off lines) is defective and/or
biased. It really is for quite a few reasons,

            * Though it's not apparent, it indirectly seems to be hindering
            (to some extent) the idea of including the sign-off (or) other
            trailers which *can't be modified* by the user.

            IOW, the current behaviour seems make the contributors/users
            falsely believe (at least to some extent) that git *does* have
            trailers for commit messages and thus preventing them from coming
            up with ideas that could make "untouchable trailers" a reality.

            Thus, consider "the buffer _must_ contain no bytes" hoping this
            would initiate a "Butterfly effect" :)


        * Looking from an implementation perspective, it's biased in that
        it checks only for sign-offs. Making it work in general is
        difficult as there's no standard definition for the term
        <trailer>. That's because it varies with respect to usage, I
        think. Different people/projects may consider different lines to
        be trailer lines. A few examples are,

            * Bug:
            * Fixes:
            * Change-id:
            * Helped-by:

        Moreover, some people may wish to have commit messages that only
        have such trailers (e.g. "Fixes:"). So, it's difficult to do a
        generalized implementation that aborts when the message is empty
        or consists only of trailers.

        Thus, consider "the buffer _must_ contain no bytes" because it's
        not easy to define what a <trailer> means and special casing
        "sign-off" is biased.


        * Imagine a hypothetical version of git that aborts when the
        <message> is empty though a <trailer> is present. This would
        quite possibly instigate controversies as the "hypothetical git"
        reduces the "valid commit messages" and would quite possibly
        reject a commit message as "empty" (which is uncommunicative)
        though a previous version (which did not have this change)
        accepted a similar message.

        SO, bringing in the Occam's razor, let's choose the option that's
        the simplest and makes the fewest assumptions.


Thus, I conclude that the considering a commit message consisting only
of <trailer>s as empty isn't a good idea and should be dropped.


-- 
Kaartic
