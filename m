Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC72F20A40
	for <e@80x24.org>; Thu, 30 Nov 2017 01:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbdK3BIX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 20:08:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45281 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbdK3BIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 20:08:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so9874905wme.4
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=x/PmzK4bjjQJACVzVYTFzto1hmJWVC6QMbPe/4zv+a4=;
        b=nKISJGU8lkJ47GnOAgz/PNzgT8KdxP0rT2GpjhcKy+aU9AnJTeRMWkykmALJikFV6T
         KoVRsTe2MWWvzd3wDIRhepX7rYuKpTnFpSAKCC6yZmKOCITV8dJqMLLOsrniI78N990T
         5agDknWRf0PhKv9Vp+QG1wZiRqmvqQfmbKcSwvTnp4gy0z2IWj73fei1OxtAEhUtYrEY
         WCPYTzuSmoAEl1IC/2f5kE9GdNs1SferdbkHMcFJwMg2iksDpJwh1LWna44lRCP3qwWm
         +Hq9ZSL3lP10Yj83ZJM1R0CFd+pTX6KLSFlufy+WAXi6dqhOm0mDvHzyXiv+ifARuoK2
         O3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=x/PmzK4bjjQJACVzVYTFzto1hmJWVC6QMbPe/4zv+a4=;
        b=hRjyCXuS3AL5kOKlciDPHVhyTyzIdHfZvep1PGIXPVi/tbYBevilSGJ01cDO3cgY/7
         vcPdPMe57h1P6NxU/4OfOL0f4/XFnotm/N+To3pFQOHFiFJfaiH8+NIJRcHD3iQnxScg
         zDY5M7clI2qPapi4+lkSAz6kKnKtVGbzbrLdG2QQd4oBogeRdTUQM1NTirBqV0xaKMw/
         smPfRopsewLdplBsgRdkbb4vEdrgLbwgGNlRkgu+9zkxC0OpWEYHzqtX2x9nDmpDxWsD
         BCswgU5oHnA7JdYeaEflkhdB3LHIV5fjFYFDE7mxgHdyeA3F55+u/LU53MWw7Xu8VSuY
         KnwQ==
X-Gm-Message-State: AJaThX6l4vgwo9IUGmEzdrryWk4grtPsK1oQiz8gGOCAlVsMFG8Z1/Ec
        ne8vjSPt12iVdxycICio1y89qA==
X-Google-Smtp-Source: AGs4zMasjOA1fXvyrsvBBKgm+zO8irZQawxoNZFlgoYNvo52WzLc4nTrCBw9CbSSWPAqJQzNynCC/A==
X-Received: by 10.28.235.22 with SMTP id j22mr489017wmh.68.1512004101255;
        Wed, 29 Nov 2017 17:08:21 -0800 (PST)
Received: from localhost.localdomain (x590c6a79.dyn.telefonica.de. [89.12.106.121])
        by smtp.gmail.com with ESMTPSA id r19sm1211776wrg.83.2017.11.29.17.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 17:08:20 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Robert Abel <rabel@robertabel.eu>, git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: fix reading files with windows line endings
Date:   Thu, 30 Nov 2017 02:08:11 +0100
Message-Id: <20171130010811.17369-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.441.g0a121d649
In-Reply-To: <alpine.DEB.2.21.1.1711291519290.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> > index c6cbef38c2..71a64e7959 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -282,7 +282,7 @@ __git_eread ()
> >  {
> >  	local f="$1"
> >  	shift
> > -	test -r "$f" && read "$@" <"$f"
> > +	test -r "$f" && read "$@" <"$f" && export $@="${!@%$'\r'}"

I don't think that export is necessary here.

> As far as I understand, $'\r' is a Bash-only construct, and this file
> (git-prompt.sh) is targeting other Unix shells, too.

The only other shell the prompt (and completion) script is targeting
is ZSH, and ZSH understands this construct.  We already use this
construct to set IFS in several places in both scripts for a long
time, so it should be fine here, too.


Gábor

