Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5191D202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 14:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdGFOaf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 10:30:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33915 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdGFOae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 10:30:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so523133pfe.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=pBpg63IypL8AjFyTa8HNRvLKA9cYafwsHDCMpQkH3wo=;
        b=hWjxdQsRCLhpcUbQIfimA706jeFlwRSL6OOhF/ANu1XMsO31N+zr1Cab3uu+UsQ4/S
         VAUmJyAjZK0CdUcJ8esRSQiWs6slnjOywNOSJSsEhCl1dY+msdfyKgT5xroq+XvZBlPb
         sTOQzyQT54ZG3IdS+IFOZ/Tx8fZ1zCIdAB72f+9N/SnMrGk8Sal4LyV6+zeD8dEsrLGn
         5OOIM8WhYRLX84c07xGWlWDrBwTjXm6hiQgT2/bvfJUgYKcBX2LvayNCJ5UlKke7K2xc
         heBZJP72OWNsmXOvLUVN0ejfWnttQRTPW+LqC6iH6z5vh3Cwyhwf/qQfws6vN7lyruTF
         bLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=pBpg63IypL8AjFyTa8HNRvLKA9cYafwsHDCMpQkH3wo=;
        b=jNgjtAsurk+2jRSL/gGtJay1Kj+eH5wnPcYfn6pf80psrjl7zlaGz0bkraDkl/U5Rb
         X9Lq3G9WhUAFG+Jf++6FCH98rSRk4VL5c8WRYbRMWWocvbp3Cp3poQoASwhQeyRgGQb3
         jnCGYdKXQN5+s+iPkhir/hsb4pwhvxrDyB4kt4TKTcIIVJT728yeiZcZ04CdUjoqsb3H
         khXt1xNGeq8kegXbqoDkEy6dKWGjU8RVdpcu/q45lfCco0RbeCGzfQGTeNoszdmL5gr7
         OhXud6URBsP2LeTjb2TUFkfGZYWXO70hgVBF8wIaJOKi710tkaPhdTlqj6QNNOBMg02O
         J7hw==
X-Gm-Message-State: AIVw110s+mjH6SvG7OWC1Tp1eY5uh2QTdA12vQ7xDhrXUGBoy0ohBR/D
        8it+LUAOPqSkfljQaQI=
X-Received: by 10.84.169.67 with SMTP id g61mr26135228plb.155.1499351433792;
        Thu, 06 Jul 2017 07:30:33 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id e13sm551169pfh.96.2017.07.06.07.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 07:30:33 -0700 (PDT)
Message-ID: <1499351436.2239.7.camel@gmail.com>
Subject: Re: [PATCH] hooks: add signature using "interpret-trailers"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Thu, 06 Jul 2017 20:00:36 +0530
In-Reply-To: <58c71fab-d93e-d6f0-2df2-654f08a667b7@ramsayjones.plus.com>
References: <20170705170034.20899-1-kaarticsivaraam91196@gmail.com>
         <20170705173508.28711-1-kaarticsivaraam91196@gmail.com>
         <58c71fab-d93e-d6f0-2df2-654f08a667b7@ramsayjones.plus.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-05 at 21:14 +0100, Ramsay Jones wrote:
> 
> On 05/07/17 18:35, Kaartic Sivaraam wrote:
> > The sample hook to prepare the commit message before
> > a commit allows users to opt-in to add the signature
> > to the commit message. The signature is added at a place
> > that isn't consistent with the "-s" option of "git commit".
> > Further, it could go out of view in certain cases.
> > 
> > Add the signature in a way similar to "-s" option of
> > "git commit" using git's interpret-trailers command.
> > 
> > It works well in all cases except when the user invokes
> > "git commit" without any arguments. In that case manually
> > add a new line after the first line to ensure it's consistent
> > with the output of "-s" option.
> > 
> > While at it, name the input parameters to improve readability
> > of script.
> 
> I assume each occurrence of 'signature' in the commit message,
> including the subject, should be 'sign-off' (or Signed-off-by)
> instead. Yes?
> 
Yes. Thanks for pointing out a possible way in which the message could
be misinterpreted.

-- 
Kaartic
