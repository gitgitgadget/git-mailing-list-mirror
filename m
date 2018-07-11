Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AAC1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbeGKPrq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:47:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeGKPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:47:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so18650019wrn.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gvgBr/LI8QiVgD1LYAj2NxTshsVb9Xz0fZ/549quka4=;
        b=rjPHg2UvhBNQ1K8R2ftcqEJCmCqpUySu76shQ6PMkE16VNxcNJd8IppU+5mwv1pW43
         v66yL2/Cm+kpqlt/Og9bnVUvitqtnGm9NQsz/bBDJ3p/Y4Znc2lkUNYlnWpRgGmumQGj
         Qi7inRbZdxGScgDiRcEckcnBi5ydOQlVFQ2xezJfrQhQzdqu1WMZ8Ewd1FJZQpZUGuqb
         zOKq4pUcTzbrbJBq75aj3Nhc0D+NcfCy77iQCntmMtc21qOeC9gy3AQCjuN7xbWwSF6h
         45ZZVbPW8peTHnxsdtt4oGBBOquXUh20ezxG7pvf/riYJ0ZNTY3m0WkjbkEx4buRpzTe
         IVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gvgBr/LI8QiVgD1LYAj2NxTshsVb9Xz0fZ/549quka4=;
        b=XD/MA0P26egJZ/AFqA96FIbbs+5lBX9Atfwr8uVMxLUcJnhpvfbLK+79K7WB3OUWn3
         S5G35hHRZATDRiQsc2H2+9jkJIpk7RyYnOzrUUDzJHhY6tByfDR2BdDNpp98LNVuHSKG
         4LPDCPb/c9kDzNxgG37Kp4A8YmQQ0EBDVHrFNYwERQbdVrogD3ZouNyVjsKRzE3FzArQ
         6riud8glGmOjBF6w5VE9zNw/ZlWY9F2YPDBPAtOCPlbaur/EgIfugiGBU16Hy5ya+bVQ
         manNkdeTGYerNviGXpg9ajf8DkGwsCSodXCAJzOlkmvinvMp1wQTmgSfuJAzdZL0RzRb
         3sDw==
X-Gm-Message-State: APt69E3y+orXea6tvgF8t3avqzF+cwo6C6KieJecoK8rbCLtZp0tfdIc
        k+oyYFcHYgv/XAVllbTjnhYzL/fO
X-Google-Smtp-Source: AAOMgpeOyKJ8TOe8Wp0eVuzNfkUa+mUnwTiG5yCJT02tEr//4fBwXXEgcHAWyKl501ylRsOvTEoBCQ==
X-Received: by 2002:adf:8e10:: with SMTP id n16-v6mr21366851wrb.100.1531323769832;
        Wed, 11 Jul 2018 08:42:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1667565wmb.6.2018.07.11.08.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:42:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180709192537.18564-1-dev+git@drbeat.li>
        <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
        <3f0ab3f42606d2251a6574d6fb45bf11@drbeat.li>
Date:   Wed, 11 Jul 2018 08:42:48 -0700
In-Reply-To: <3f0ab3f42606d2251a6574d6fb45bf11@drbeat.li> (Beat Bolli's
        message of "Tue, 10 Jul 2018 09:34:48 +0200")
Message-ID: <xmqqin5l4w3r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> Should we add a "pedantic" flag to DEVOPTS that would simplify
> building pedantically? It would also have to set
> USE_PARENS_AROUND_GETTEXT_N so as to not overwhelm the developer with
> too much output.

That may be something worth discussing before doing; I'd prefer to
wait until these 6 patches, plus the unsized static array one you
did spearately, graduates to the 'master' branch.
