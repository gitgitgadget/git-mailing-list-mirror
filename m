Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA761F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030250AbeFSRCx (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:02:53 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:41296 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030247AbeFSRCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:02:51 -0400
Received: by mail-ot0-f173.google.com with SMTP id d19-v6so458616oti.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+tUIDKY2cGIdIbcWqrQGu5lm2JB56vKcNreHDKgyBzY=;
        b=t9+PrjoU+7S5DTg4LUEVH9vC83wt7cx35uOL4lnF6PP5rPTn58Dbm5sgYW4LBrVMgh
         tZgngZbiGoHK/dqmBI9/0iMBHY0HdE0XXqSeTHWqeyHU9mB8g2AIE/O2cK6cfOOEREFE
         pLfLW6mT5jUjSWKMesK1RAeCoyfuwEuKkL66f5SzOBHDgJVwgZxVBVF5nEniQS/KTWdj
         1+iVUYbz2Lu9fyd3va9ifSk/b0QtQTIgj6/8ShgsBSKfINpDWHSEJqm6Q2qh6YjWrS+h
         BMFi9LsWouqPhOYPvBn2oTcXIOoZ3jTAJGhtaX1EEpPwnsp4ICPJTeLOWMnztEkBGTfc
         N/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+tUIDKY2cGIdIbcWqrQGu5lm2JB56vKcNreHDKgyBzY=;
        b=BnX6+dqxiB0ZVOcyaw6JH8xQrXnfPTVZ6MMYaFhp4++hGUdTbGOjrQBErm86HMmb3+
         UawWkHltwhJ2agM9lmw3lt6KTavLDYe1aRIU0S+FRPHec8CMaTPs3LUt3wrxNi+GRj+s
         ZH+Y+OKAaSu5l8DCnmfpgGdfJSamoNuU4+WVCwwL6+G6byySJw31qu+y8iyxYb3O9qu3
         fErvJR0bpC37X3YKOfW9kpD/L0/RKGGtegv/f42BVYSJCvDOL51U8vlA338GSyy65Osg
         ABzkzUKfnV6xyM2iv0eF2GGsonKhcD578ixRMCyr25uxYdH/Rs/DGi9amfnJj+mWDIp/
         QU6w==
X-Gm-Message-State: APt69E1k28BTaBJ+Km7ViK3oaZGaP/Flylg1TuynyKjiWDOFwdHb3mn6
        imlBbVZ/s4ItzCK5pcCkIf811g==
X-Google-Smtp-Source: ADUXVKLJw1fh7mnHDw4zi1YcfhDKQUuGQphhQdIZOCK6REE6bcTBC/yp+4u289C/iI2fh/qbFJHTnA==
X-Received: by 2002:a9d:60c9:: with SMTP id b9-v6mr10134301otk.116.1529427770730;
        Tue, 19 Jun 2018 10:02:50 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id k133-v6sm66787oia.36.2018.06.19.10.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:02:49 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 19 Jun 2018 12:02:48 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/7] grep.c: expose {,inverted} match column in
 match_line()
Message-ID: <20180619170248.GA37277@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <d0a6b3ca2a8e67c6a5ed4d2c56c5121d4bc3554b.1529365072.git.me@ttaylorr.com>
 <xmqqwouuvi0e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwouuvi0e.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 09:49:21AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  	case GREP_NODE_NOT:
> > -		h = !match_expr_eval(x->u.unary, bol, eol, ctx, 0);
> > +		/*
> > +		 * Upon visiting a GREP_NODE_NOT, imatch and match become
> > +		 * swapped.
> > +		 */
> > +		h = !match_expr_eval(x->u.unary, bol, eol, ctx, icol, col, 0);
>
> A minor nit, but the comment talks about something that are
> different from the variable names; perhaps you called col/icol with
> different names in an earlier incarnation of this patch?

Good catch, thanks. I've amended my local copy.

Thanks,
Taylor
