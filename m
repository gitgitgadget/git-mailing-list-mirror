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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7AD1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 05:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfJKFBR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 01:01:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45531 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJKFBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 01:01:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so3864754pls.12
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZmUHEqJ03WfpjNmzrMCrjldrnjxZOo3dRnkd3E1jSk=;
        b=mAvCaPGFoxIL9U+UWS4so48YZt7RQSNxKBkwaiNeguQqekkaZlsqKmRCJsZPlQ7wnQ
         N6S8d0GweWq+6AUJ3gAS6ZcNJV9LV6u0exv799Vn9SPQK9S1/WgEox0tb84ZTVyd/yyt
         lqXFrQ2+p6wrP2CAaG0ZEg3HRJU7dO2oX8FCBYCR1jNL81No3AF16wUvH25uKPWpuRW2
         uoFKjb3+1wu/rJ96k9iskoADI2mU8S5XSMz7qr+e+1kQK2z1pc99kII+hOUtv59S1dyT
         klQd24N+s8gyWH1FaMXcs5SrgR5kkSQEH/gkkggonFH30GfT/IjpNQN8KmHvj9uFjElF
         neVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZmUHEqJ03WfpjNmzrMCrjldrnjxZOo3dRnkd3E1jSk=;
        b=HRE8V4Uv42KNJSTW2gS4YzBzGIpzMYgFHwLu/rwK3mWIOBTQwVPnlzxgQEIEkR6ypU
         2VDxlaKdfEh9a7n7wP/zrC30GMtt/jouaNOOYJjanE1x+A5hLNhaxJy2zWvLJJOYNkVM
         wST+lkVaDPcbZpGP8NojbpFxH/gy91T7L2CufjQscGsvbHKhj54nHO6eKnnAlNb+bYU7
         mcRVjEJSNVTmwp3Fp8Vimng95H9sEjcrmD+AZl/GvBOOCplHXncFwhDWXi05aKUm/yj+
         MaYeACJt+h39JXU1XCmKnL/UfoPdEIaMeiENHiHlyJphcGME/fN3I8IIeQy5nIiV4+xH
         dtkA==
X-Gm-Message-State: APjAAAWWvsFAXuZ6YM9xzPVmDYPhba051shiWjtQ+Hm/p5GVIXC+sQPW
        koiVH6Nqe7ZHN3KVHWU58HPkH+Ba
X-Google-Smtp-Source: APXvYqzWUUwP03t4PrjDHpM72dueuUhZvJdeCoL9ArUdihN2fWPBzFEIOT0LJ7WJNbnMhwUoMDSz4g==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr13452810plo.84.1570770074804;
        Thu, 10 Oct 2019 22:01:14 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id y66sm7641033pgy.23.2019.10.10.22.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:01:13 -0700 (PDT)
Date:   Thu, 10 Oct 2019 22:01:11 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
Message-ID: <20191011050111.GA94866@generichostname>
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
 <20191010230550.GA42541@generichostname>
 <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 10:42:20AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > 	static int calculate_width(const struct strbuf *row)
> > 	{
> > 		int in_termcode = 0;
> > 		int width = 0;
> > 		int i;
> >
> > 		for (i = 0; i < row.len; i++) {
> > 			if (row.buf[i] == '\033')
> > 				in_termcode = 1;
> >
> > 			if (!in_termcode)
> > 				width++;
> > 			else if (row.buf[i] == 'm')
> > 				in_termcode = 0;
> > 		}
> > 	}
> 
> Not every byte that is outside the escape sequence contributes to
> one display columns.  You would want to take a look at utf8_width()
> for inspiration.
> 

Heh, I guess you're right. Looking right below the definition of
utf8_width, I realised we have the utf8_strnwidth function. We should be
able to just call

	utf8_strnwidth(row.buf, row.len, 1);
