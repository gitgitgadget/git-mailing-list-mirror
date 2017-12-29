Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6521F406
	for <e@80x24.org>; Fri, 29 Dec 2017 02:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbdL2Cti (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 21:49:38 -0500
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33375 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdL2Cth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 21:49:37 -0500
Received: by mail-ua0-f173.google.com with SMTP id n6so13163044uak.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 18:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n7Huuo9pB9tSFuobSOA1a5RIHg8az/8dN9K8L8YZZaY=;
        b=W1EhbNdV9R3SMdnj6njX1sIVSh4TSdkvsZZ/XI9ohy1dVdwc19BJ2ohZ2XNGj6F0Sc
         QLoWogph+u43059LGrmxBu2dE3EK0LbHVDNrosYITl1FYFwpf6IoXF8E9wEkOXm1VREf
         1aeXUQPnP8yqCgHdAUIlXiEv+DNL1ABollnXajSuTHaRDWgsUetr/kBwMdHZbOLgRvcr
         /wclOHoONJz4vvoYZNn8KwwZ5wYzWb/o0baVKxcy3Oc80+A9I2GOPqMF6oP1AAJNkFoD
         n/gasv4xpAxQoH9zWu1q8pzBMl0JBHmn9Nm+mHQjjPm96DMI9Ni2+zADkzXO430tgm0Z
         BBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n7Huuo9pB9tSFuobSOA1a5RIHg8az/8dN9K8L8YZZaY=;
        b=P6Iuv5q67z6hKSGI0eGTBV0w1a80Q0q08spXl+jzVW9nP2Gi0umWMavB4XK9nIQLBV
         gBNrKutnT0dkLJNvP2dQYc0drIe7hkpaSfVJVTXR82XhIhdX2+nCwcoaUwWuYFpRFJbo
         MPws4cgW728uAb+Aq3S8gxKak4dQvzDx9DAPquvOBvrm/L92xYCu1q4c/VTFvvqh+PUk
         JLmDnVhUOVUGiEkpxrAA6FYyW53gjidTiuNsUOMjcx23YfrMv1rDN39B6FRPZDzUHm/C
         P3AkOLm05WuocB+YeGxOlm5JMGITTBxa1uXPDA996OiDOALO7dpR4jNLYIUmrqf/wEzu
         S7Zw==
X-Gm-Message-State: AKGB3mLMvJO4PkfQwaCtXe5lnnM/JpBjik3gSCbC6VcXvo+bm2YKoxg/
        cNMVDLnIPRR+DPbJ7knC6qvT1IEtbQSNZiMcj2U=
X-Google-Smtp-Source: ACJfBotBnX5m6xqz/82BFvHumBx0ELNN8seRimtxsUXhXT5p1rVQ4oa+Oyn07zvHcpKulYcOkjSGukUNNgYGXJ688R4=
X-Received: by 10.159.59.234 with SMTP id y42mr32017149uah.123.1514515776461;
 Thu, 28 Dec 2017 18:49:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Thu, 28 Dec 2017 18:49:36 -0800 (PST)
In-Reply-To: <xmqqtvyzslcz.fsf_-_@gitster.mtv.corp.google.com>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com> <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com> <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
 <xmqqing6cje7.fsf@gitster.mtv.corp.google.com> <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
 <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com> <20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu>
 <xmqqtvyzslcz.fsf_-_@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Dec 2017 18:49:36 -0800
Message-ID: <CABPp-BHTZrNonnJrWfZg+_xCrO+o_uNjx4nbwuVHF4qVGe01cA@mail.gmail.com>
Subject: Re: [PATCH] merge: teach -Xours/-Xtheirs to symbolic link merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Yaroslav Halchenko <yoh@onerussian.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 15, 2017 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The -Xours/-Xtheirs merge options were originally defined as a way
> to "force" the resolution of 3way textual merge conflicts to take
> one side without using your editor, hence did not even trigger in
> situations where you would normally not get the <<< === >>> conflict
> markers.
>
> This was improved for binary files back in 2012 with a944af1d
> ("merge: teach -Xours/-Xtheirs to binary ll-merge driver",
> 2012-09-08).
>
> Teach a similar trick to the codepath that deals with merging two
> conflicting changes to symbolic links.

Saw this change referenced in the "what's cooking" emails and decided
to review this.  The code changes look obviously correct to me, and
the testcase looks good too.

Reviewed-by: Elijah Newren <newren@gmail.com>

(and perhaps we should also add in "Tested-by: Yaroslav Halchenko
<yoh@onerussian.com>" ?  At least, that was my thought based on
https://public-inbox.org/git/20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu/
)
