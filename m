Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8CD1FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 07:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbcLLHQz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 02:16:55 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36236 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbcLLHQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 02:16:54 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so10007404wjb.3
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDOlXbXM0/RH1sU+KIVKVmAoJf/+6+zp3IyPsIwAJD8=;
        b=zwwW/yxIoQFk6LFZAxcXnyDKkb+c0y2YXnJGS6IkbHE8kaMT2tyxDNkf57eFwHJooL
         0dV2OTeNzMhgumxqcKT2kY58qBZQCrdBYd8do7hxVD6b3I/dMCor1J74tcD5QA2itBqQ
         2NjPFC6euuKvo4mL2J9kwl3SVcmT2FByzhMs0cC3VEN+AiPwbRUyDyz0Dt20d+LGY86i
         cgoO8svSc59cY67iE4BpLXpAkjTcLurNKrJhqjqJD1Co9GgHVQSaXBkNiIJ0mYqqHDm1
         hD5hy55q684jyJ3ywBIVGf5oBmNJRSG4mAucexV43bE63/daS2j8Lt40InG42UemZ8d6
         JRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDOlXbXM0/RH1sU+KIVKVmAoJf/+6+zp3IyPsIwAJD8=;
        b=T1ynwUoUmNN17Yr20Pt+v6VX7kE+IiOA7xsLj53fngTE2EyuWa9AJ6Xw5nhx091lRS
         tWaZCFaMsjN3JCPVocvgq1rUuPE/jbvYaz9nb5/piARzFr+Xd0Y/fKGp0/vygoplBULL
         ehdllx649GVBAqHTXtNAuBoL7DthO1VWSoXYkb2CElvCs/VAXGhNeWZsLAMCf0AaGcQg
         1FN+vd0x/bTtECgbS1oqyHC3CBaPRxEKlX5V9SWmMncgVRp70rDi4aLBZUpR+wInv0Ct
         v7xyLqdzaLNwh73PCjD+4XcqXLClZHLHfAHqCyvZhKAz+H+BOKZqPfbGtus8I+P7nQ44
         LFaQ==
X-Gm-Message-State: AKaTC03Jkt48vzJh/ll1PJ1CUEY8XlGUstogruXlF1gYLWJ/j88TcODwtrINJy0EsYa1Zg==
X-Received: by 10.194.149.143 with SMTP id ua15mr93391621wjb.48.1481527012725;
        Sun, 11 Dec 2016 23:16:52 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id f134sm33910200wmf.19.2016.12.11.23.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Dec 2016 23:16:51 -0800 (PST)
Date:   Sun, 11 Dec 2016 23:16:46 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] mergetools/tortoisemerge: simplify can_diff() by
 using "false"
Message-ID: <20161212071646.5bqnnjpfnmnj6fm4@gmail.com>
References: <20161210032144.25503-1-davvid@gmail.com>
 <20161210032144.25503-2-davvid@gmail.com>
 <37d8bc43-9f24-b8e8-cb52-de9cc9b2adde@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37d8bc43-9f24-b8e8-cb52-de9cc9b2adde@kdbg.org>
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 09:15:34AM +0100, Johannes Sixt wrote:
> Am 10.12.2016 um 04:21 schrieb David Aguilar:
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > This patch builds upon da/mergetool-trust-exit-code
> > 
> >  mergetools/tortoisemerge | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
> > index d7ab666a59..9067d8a4e5 100644
> > --- a/mergetools/tortoisemerge
> > +++ b/mergetools/tortoisemerge
> > @@ -1,5 +1,5 @@
> >  can_diff () {
> > -	return 1
> > +	false
> >  }
> 
> Why is this a simplification?
> 
> My concern is that 'false' is not necessarily a shell built-in. Then this is
> actually a pessimization.

The "simplification" is semantic only.

Motivation: if someone reads the implementation of can_diff()
and it says "false" then that communicates intent moreso than
reading "return 1", which a programmer unfamiliar with shell
conventions might misinterpret as boolean "true".

I care less about semantics then I do about making things better
for Windows, so we can forget about these two patches.
-- 
David
