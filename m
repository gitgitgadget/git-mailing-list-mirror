Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD0520401
	for <e@80x24.org>; Wed, 21 Jun 2017 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbdFUOfe (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 10:35:34 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33299 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbdFUOfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 10:35:31 -0400
Received: by mail-pg0-f52.google.com with SMTP id f127so1124216pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=uNDbpLAARo+78aYNCzvNyZ7I4LqEXMQP6UBjyrCuwi0=;
        b=btye+MmVY7HkK+ymS7VpzzO7uILKTvUUGMKucoZfXbnri5Tp9yhCba8tvISMb9SsCt
         /pBD+p9jaTU8mpjKvDcpZ/kFaAavrpze4SmUytlTNrrh1xmzzx61OLvkzIZX1ZRZAKRF
         pF+aH9JRKOtva4HbQ9151oLMX6U9Dz0cW7CbSpwVClMGCcy0Bg0xbqowzKISG9dPw7dw
         6nWqMsDGKqIAT+gJloypofQRteI2ddMjQT/g/pOm/Mct+iV3wQ0SeEIZ0tm6pCO21Svj
         iPbvhLHfNDAeJHcspXY9sXbLKKNVkq/YaJL0oSWMJJgSzbajIiUpsYxMPNn3/PbZXBeC
         RicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=uNDbpLAARo+78aYNCzvNyZ7I4LqEXMQP6UBjyrCuwi0=;
        b=LWEPgLBl2J/w7gYLufRCU4A+U9FTGcsw1499m3xoxl961CR9Zki5oAFyg4B+DiRnrR
         Wdvx3xK6iwCq9YDVB8YUwvLL12NbfTE9Hxq0NnLvMG4xz0bE0WYS9XdXVs7dRn2d7eTL
         yu+rUvhfHFcFk+KX2tslmfhL9lYMQ8s2sUkOYRLwRaCK0MkdNELaCak7bc4bEOproqA+
         /lxYyYJQ6A9IL4DHAHLM9z+LnJ2Y0rv5+t4rJMLRXYabpFFH19qa/3hFN9pxhh3Fva+J
         bdOPYQfi/5FcWwWKRdKR8C29ZWizzKyHqNZrbCMcbAy6BxIokKDkPtPAHTLYtvRoKAiX
         rkYg==
X-Gm-Message-State: AKS2vOyH9oIiR6K9CgAW1+0vCOVKy9qeOcAfs3DuuK9IArh/qGfFgmVu
        DH2xVMCBpYXGJd9VRJShFw==
X-Received: by 10.98.139.11 with SMTP id j11mr4666490pfe.18.1498055725361;
        Wed, 21 Jun 2017 07:35:25 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id 66sm33742903pfm.82.2017.06.21.07.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 07:35:24 -0700 (PDT)
Message-ID: <1498055714.20886.1.camel@gmail.com>
Subject: Re: [PATCH/FINAL] status: contextually notify user about an initial
 commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org
Date:   Wed, 21 Jun 2017 20:05:14 +0530
In-Reply-To: <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
References: <1498012463.1487.2.camel@gmail.com>
         <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-06-21 at 08:07 +0530, Kaartic Sivaraam wrote:
> The existing message, "Initial commit", makes sense for the commit
> template
> notifying users that it's their initial commit, but is confusing when
> merely checking the status of a fresh repository (or orphan branch)
> without having any commits yet.
> 
> Change the output of "status" to say "No commits yet" when "git
> status" is run on a fresh repo (or orphan branch), while retaining
> the
> current "Initial commit" message displayed in the template that's
> displayed in the editor when the initial commit is being authored.
> 
> A few alternatives considered were,
> 
>  * Waiting for initial commit
>  * Your current branch does not have any commits
>  * Current branch waiting for initial commit
> 
> The most succint one among the alternatives was chosen.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
>  The 'FINAL' part in the subject is just my opinion about 
>  this patch
> 
Just for the note, the tests passed locally and all travis-ci builds
jobs succeeded except for the one in which the 'GITTEXT_POISON'
environment variable is enabled. I guess that isn't an issue, from what
I came to know while digging about it.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

