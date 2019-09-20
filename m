Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311561F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405316AbfITRKa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:10:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391787AbfITRKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:10:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so2989396wmc.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TVNNgI33y0/glGCH4afNtcGakCwjlK9EmXC+Gow0EYQ=;
        b=F2aXuKFy+XdOWO9PnOw4Ro5VVIc9AElrBIvNXK8trr2YKa5BZ05oiv3iod6IJsL3NC
         yeIR3G0/3p1enY1X0E3cD0Ds2FPysoFbXtgvXoajKkuGDU2C4L3bTyjFu3IgtBxfyBw8
         RpnRbHE3MKSEwasia39QjWLy+olbdJEcWNsBqw1HXtoswA8u/uVkDq9zQGOy+rGc0ggv
         f0WIO57IuXXwV1wgx7qdBlkeuIJ4pvHNxgvku2EgfhamEXeYy+k5jeVLxXNsEjkIaRR+
         e+F7RJfYUFeCZEAWxMD8UIktK482A7Jgn3poprPNQPP/4RvaONeVAEYmuYkQvLmlniXa
         LC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TVNNgI33y0/glGCH4afNtcGakCwjlK9EmXC+Gow0EYQ=;
        b=UN4/vg1DSp1STcPEtb28uVzBJILvZpfccwnpksuyJ3QqqA2r7u6RrPX/LvxRCfXXdU
         Stf/VfH7HZp2hKbnvzMt+nglhByV2ZtVqVEk60UWI+og2YibwFhGoGkGg6GQHfdeGcV3
         enJVfO3t/NFLPGHGpCiXvm6lzQIuvxHZlAd6OTFqO1hN1Rn5fv05WzHOLPDZQxW33BHf
         uT5v0uvzlL3/c9vxVXI9aBYyAt8abWZFAd5+uGqs6VsWNMfsgNxfsGSg1W6xFaHtF8+7
         WpP1RFGY5ELGZ0pS58u7r+pbLUb2XwI8uw3XuKt1Tr58CYvAP1LKwBDSmqvycO644Cmn
         LkcA==
X-Gm-Message-State: APjAAAUfFG/9zjXrhYziMvcwReqB9wloTeoqoEkMHq3toAP6c9s+cQW/
        OygksnwgZIAxYxyXVdyz0sVQizjn
X-Google-Smtp-Source: APXvYqy1MmA6HhHqcIAM2g9CXi1FD0GEKKRbWJdzqRzYm7VahjJCS4IxilSZ8MI7+vRV7PkDbDQONg==
X-Received: by 2002:a05:600c:10cc:: with SMTP id l12mr4144850wmd.165.1568999428184;
        Fri, 20 Sep 2019 10:10:28 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id t6sm3727691wmf.8.2019.09.20.10.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 10:10:27 -0700 (PDT)
Date:   Fri, 20 Sep 2019 19:10:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 03/15] name-rev: use strip_suffix() in get_rev_name()
Message-ID: <20190920171025.GB32474@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-4-szeder.dev@gmail.com>
 <bc885655-7b86-86b8-a653-5eecca56bfb2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc885655-7b86-86b8-a653-5eecca56bfb2@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 06:36:30PM +0200, René Scharfe wrote:
> Am 19.09.19 um 23:46 schrieb SZEDER Gábor:
> > Use strip_suffix() instead of open-coding it, making the code more
> > idiomatic.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  builtin/name-rev.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> > index c785fe16ba..d345456656 100644
> > --- a/builtin/name-rev.c
> > +++ b/builtin/name-rev.c
> > @@ -317,11 +317,11 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
> >  	if (!n->generation)
> >  		return n->tip_name;
> >  	else {
> > -		int len = strlen(n->tip_name);
> > -		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
> > -			len -= 2;
> > +		size_t len;
> > +		strip_suffix(n->tip_name, "^0", &len);
> >  		strbuf_reset(buf);
> > -		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
> > +		strbuf_addf(buf, "%.*s~%d", (int) len, n->tip_name,
> > +			    n->generation);
> >  		return buf->buf;
> >  	}
> >  }
> >
> 
> This gets rid of the repeated magic string length constant 2, which is
> nice.  But why not go all the way to full strbuf-ness?  It's shorter,
> looks less busy, and the extra two copied bytes shouldn't matter in a
> measurable way.
> 
> 	else {
> 		strbuf_reset(buf);
> 		strbuf_addstr(buf, n->tip_name);
> 		strbuf_strip_suffix(buf, "^0");
> 		strbuf_addf(buf, "~%d", n->generation);
> 		return buf->buf;
> 	}

Oh, I like this, thanks!

