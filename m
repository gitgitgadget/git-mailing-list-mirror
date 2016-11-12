Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083E720489
	for <e@80x24.org>; Sat, 12 Nov 2016 06:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936601AbcKLGLh (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 01:11:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33892 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935582AbcKLGLh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 01:11:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so1695397wme.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 22:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGymUIA6G8ZBNqG4qsj+zoMGC3toB3nz8u1Iau4u8Wg=;
        b=JCbSEIu010fFszyASfubpef7WzFl6gV+1u7fnpKd9P94zCO6kQVeLLEWVwxUq1vVWb
         sZf/3w/3E3PpfeGAhQKaZ/iS2B6HgmOybpI6JcU+MK0/UPNd8GsTkdxMHxU1nhIiTODN
         n+P4V7GgOT59v1UKyzvchKk3TCdVUTuh8M4jYGhySLA7Va4l9lw7doVEiizMVoHPKdz/
         1qJEo+i9UoSakblv/8IJTMHOKMY19RcFezG7CCEOPCZ9+DS8tfcKCLg0KxazfPeox1rT
         dLlzgwk3MTLa8+TQqsgu31RYEZ4nRJlK0ATJW8yJv1nOw04pHmb3+LP/9lS60NCUY+u0
         vsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGymUIA6G8ZBNqG4qsj+zoMGC3toB3nz8u1Iau4u8Wg=;
        b=X0BDJXSIcnSFOpok+VPM7IrB00rUpBuPC8Ik3Jre3U0eYzyLYjv2eZHpzon2QvaBAW
         4u+NAbcQlQ+x+dwByZDA1Hm2ekOKk3F1diMHel8WV0vD9/NTjTUqTxDz1ywa2vFsdVVC
         Mz7DPukiVYY0Vpk19tPOCgvd7C5A49FHPQOgYKJVhtamrztRdP4GGU5NQU1GP2clIO6f
         fS1shNyFGJwwD846uJhR3IMq18aNOGDFzoUQEa46oldfsgW8USDA6pEvT1CMUGLYUJm+
         9YKIjT9QwPXMH9d7MmI3HUC8gsB9CrT/OBlWJJ/nlZpStI1NyRz26hhfKvHAPqc2Tg3v
         atvg==
X-Gm-Message-State: ABUngvcZfOBPtd7VLHKNgMPNhUnkX4x3xUnSpbVTNOio3pnDHjQTFaGqhbcpLiid/x9f0w==
X-Received: by 10.194.175.42 with SMTP id bx10mr14466374wjc.47.1478931095137;
        Fri, 11 Nov 2016 22:11:35 -0800 (PST)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id l67sm22698007wmf.20.2016.11.11.22.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Nov 2016 22:11:34 -0800 (PST)
Message-ID: <1478931094.12153.3.camel@kaarsemaker.net>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 12 Nov 2016 07:11:34 +0100
In-Reply-To: <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
         <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-11-11 at 13:27 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > No tests or documentation updates yet, and I'm not sure whether
> > --follow-symlinks in other modes than --no-index should be supported, ignored
> > (as it is now) or cause an error, but I'm leaning towards the third option.
> 
> 
> My knee-jerk reaction is:
> 
>  * The --no-index mode should default to your --follow-symlinks
>    behaviour, without any option to turn it on or off.

ok.

>  * If normal "diff" that follows symlinks by default has an option
>    to disable it, then it is OK to also add --no-follow-symlinks
>    that is only valid in the --no-index mode, so that we can mimick
>    it better (I do not think this is the case, though).

It does not, so no new option.

>  * Other modes should not follow symbolic links ever, no need for a
>    new option.

Makes sense.

> In any case, I'd advise you not to reroll this too quickly and
> frequently until the end of this cycle.  During a feature freeze, I
> won't take new topics in 'pu' as that would add more things I need
> to worry about, and if you reroll in too quick succession, it will
> become harder to identify the latest set and queue after the
> release.

I'm in no hurry, so I'll sit on this until v2.11 is done.

D.
