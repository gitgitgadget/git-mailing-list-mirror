Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CC31F462
	for <e@80x24.org>; Mon, 17 Jun 2019 06:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfFQGDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 02:03:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFQGDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 02:03:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so8448148wrl.11
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8gPgufJjbIi+KGSORxKZZujYZjBNYhT/Ta90cGHdUQ=;
        b=aFWLUU/Uv9kb5+/Q0dhwdcm3pIJ+8eBjROb5R7UTeYoZmN4etkgcKi/8AX3656LKI7
         iqYNr1PbLldLctv9pTB8g1XuPMGQDQeeD1YnSUizQXEd2U8uXDPUMYER60WPyfuXPbIA
         izudXH8V3X1fbybXmnLdx8fL27pZ/e8KGpB3fOe8t2Zvxer6aA1R32wmzoJY4SWfeM6K
         mXk3S5qN73RDn0H/ZiiWDkAlK/5pWQXF86oSMHDVBdbfAOG7fY2IAGPqRPa5QTpN2EDZ
         rrGrRzpDc4jB2I1mu08Smu8yCVCZ3OmkZhGASr/ZQHnEGd9vubvLpxYqqi8xBOB0Skmw
         XiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8gPgufJjbIi+KGSORxKZZujYZjBNYhT/Ta90cGHdUQ=;
        b=bAAhUOUKExLEsUte+DsNw31XS7sogWL5yN3dPcihPkLrsyCKpFHQeDmE04wFFq/EuC
         7a34ndAwKA5/8b+PzcXxT2PnrdeY985T1FaV/gvvLmf0IFWf7r9yNE747z24GDGhJNRg
         g4Uz4Ukdy2u9rEs3Z6O4OGqMdiqmkXMiKg0AMWe0Ixo0Ler2uUCEZPi35IDNoTZlU1cz
         9yBALlKjD7sJRt30EuJkVzv149ANaAj+PZGjSEQEIdXzJaGkfmethSUUO5/e3hE4Ejc4
         7nzFyNouyt/Sy/UVPzyfqw4LCxmduR22M3IvOYTRP0JN4A3afKB+kfYNDLLut9glmtax
         ifBQ==
X-Gm-Message-State: APjAAAUhTJetudqRM4uoeA30IYrK4RskWiziaat3eeQgyjogA/nGY9hJ
        Dmw5+vNobdFQLtb3c8uFpbk=
X-Google-Smtp-Source: APXvYqz/TI+n+ERQKrQnHfHlT60ftAUplKpnPL/A95k+0rL11/izZISlNLcgB+lKVZ/P9f2rIkEYDQ==
X-Received: by 2002:adf:e288:: with SMTP id v8mr9576918wri.339.1560751394150;
        Sun, 16 Jun 2019 23:03:14 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id g11sm8510885wrq.89.2019.06.16.23.03.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 23:03:13 -0700 (PDT)
Date:   Mon, 17 Jun 2019 07:03:11 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        ungureanupaulsebastian@gmail.com
Subject: Re: [PATCH] stash: fix show referencing stash index
Message-ID: <20190617060311.GE28007@hank.intra.tgummerer.com>
References: <20190614074207.mxidz3h573mtd43x@glandium.org>
 <20190615112618.GC11340@hank.intra.tgummerer.com>
 <78f730f1-d40e-1415-b6a6-4a1b224e7818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f730f1-d40e-1415-b6a6-4a1b224e7818@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Andrei Rybak wrote:
> On 6/15/19 1:26 PM, Thomas Gummerer wrote:
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index ea30d5f6a0..3973cbda0e 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -708,6 +708,24 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
> >  	git stash drop
> >  '
> >  
> > +test_expect_success 'valid ref of the form "n", n >= N' '
> 
> If ref is valid, 'n < N' was probably meant here.

Yes, indeed.  Thanks!
