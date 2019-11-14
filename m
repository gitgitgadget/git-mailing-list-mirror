Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF221F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 00:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKNAiD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 19:38:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40131 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNAiD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 19:38:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so3988094wmc.5
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pTjguS9a10a5EIziygQvKGqb2kS03S+jfoTmcmtRhno=;
        b=PIPjhF/BnO4tD4hwF+DeknXK/+P0PNt8SYhKaaxmQio5/lW15ggRDTclB6ofCGJbDs
         jq06i5Nsp5Y/TdtpEj4rLIJIppT4pe7RhXilnvwn+0NMnsnC0xM/oKasNuXaY9f3t2Fo
         KTC3Mz0DS2MMl3mk0zZzsfRl+0YU8LKBd4DrKGNhSJ9y+0wuQF7uzdbitw1yvtiPjsgB
         kx2Xypny2/1Z944t/+GyqIyRQhy4l51svnrh/BTcU4Q05wSXP8fOBOoDmGGJb3dJYqTy
         9x8/zaUQkVz/Md2pYD5YLcbcejXgEAB5owl4t10BVMSiDftc20+1yUnKqjFi71iEUNKS
         SZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pTjguS9a10a5EIziygQvKGqb2kS03S+jfoTmcmtRhno=;
        b=RuFBA2groqBFf6u3BdIS4NRYBqYgP0HhNkFQtEEhkeqVv2q229RY378TKqdkVPRIFv
         5dpA9W2iOAqRvN/HQlpehZfjAkjibfMHhZAwCuWupxnsEs+5O502y63vZzAPu9LY+M5c
         kve98AErNKXeowZkeSOQukXoKScbExCI6L+gXNX7IC/pEhSuLq/AkvtDjGcPpByqOxJV
         CC25dAVAF/k5HB3gKTIHIBgDC26G0uSoqoBZop8vXmuZGAjE7sS6lau1IklMtSHi044c
         zFpA5UAFy/InfIjBvco/a8h7yA60NJ1oHD0/7UIKP0FOfjN6Y6dxSuP1qdBZagiMH/Hw
         s5WA==
X-Gm-Message-State: APjAAAUnDuQlb2HRsJLrrB9i/QqdDfzKrCODFSbs8fxKF/Kke0jZMHgi
        K8ALzcjC9709bpp6MJQtaAo=
X-Google-Smtp-Source: APXvYqyzObDDQL5VN/S+BHCsUzKBMqEK4i6LseCCYlvtGAirkkoxc/zOwcSmrja9QVSn2f98sWCjyw==
X-Received: by 2002:a1c:60d7:: with SMTP id u206mr5497194wmb.101.1573691880854;
        Wed, 13 Nov 2019 16:38:00 -0800 (PST)
Received: from szeder.dev (x4db60f58.dyn.telefonica.de. [77.182.15.88])
        by smtp.gmail.com with ESMTPSA id x11sm4831316wro.84.2019.11.13.16.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 16:38:00 -0800 (PST)
Date:   Thu, 14 Nov 2019 01:37:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, g@generichostname,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
Message-ID: <20191114003757.GR4348@szeder.dev>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
 <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
 <08afdbcd-5972-05f9-ec8c-b12bd29d9030@web.de>
 <xmqqftiwl02i.fsf@gitster-ct.c.googlers.com>
 <20191111234710.GA23111@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111234710.GA23111@generichostname>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 03:47:10PM -0800, Denton Liu wrote:
> On Sun, Nov 10, 2019 at 03:25:41PM +0900, Junio C Hamano wrote:
> > René Scharfe <l.s.r@web.de> writes:
> > 
> > > Hmm, that's quite a lot of code to add to the formatting code with its
> > > repeated special-case checks.  Why not implement it as a built-in user
> > > format, like making it an alias for something like this?
> > >
> > >    git log --format='%C(auto)%h ("%s", %as)'
> > >
> > > We don't have %as, yet, but making --date=short available as a
> > > placeholder would be a good idea anyway (patch below).
> > 
> > Yes!  Implementing the 'summary' internally as merely an alias to a
> > canned user format does sound like the right approach.
> 
> We don't have any canned user formats currently, do we? I'm trying to
> figure out where to insert the code to do this.
> 
> Is the idea to just insert a row in the builtin_formats[] table in
> setup_commit_formats() with the `user_format` field populated?

Yeah, it's as simple as adding:

  { "reference",  CMIT_FMT_USERFORMAT,    1,      0, 0, "%C(auto)%h (%s, %as)" }

Works like a charm, I've been using it for a few years now:

  https://github.com/szeder/git/commit/3604d0c28e7e2da5415986468994ef71a972e4ed

but never seriously considered for submission, because I didn't want
to argue about removing the double-quotes around the subject, and
couldn't be bothered to check the corner cases (e.g. what if a user
sets a pretty format alias with the same name in the configuration?).

