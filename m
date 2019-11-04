Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506021F454
	for <e@80x24.org>; Mon,  4 Nov 2019 06:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfKDGXg (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 01:23:36 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38567 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfKDGXg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 01:23:36 -0500
Received: by mail-pg1-f173.google.com with SMTP id j30so7107712pgn.5
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 22:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eJGc7LKoFSAQh3U5pnxpg9tqulEY+yyaFuRorTfEWYk=;
        b=ixJPiLyTJkSsFFFu993qrJYx659mza6D3UJlNF13ubijuT+dElEjfzly1zx3tb1sN7
         f9x43KSMEo+ku4mfRgGoibGYYjoYcVXFTaBZLOKLwPGR3uUtNsda/ngXu4B2wy0THoQM
         gq1ZA27C+7HH8nnZ+hlc2rR2Vb8h9WCNoxRYAB+S3ld/YejnAGsSKNm+n4ctQLTEe3+9
         40hFcJ2n/y2S7lo5XXGBKKP91j1IiPmEnhstVSHDLghGXoRNCkFjh2+gI9aVpzkI4nUP
         htsjN5y4PhoWrxdR5y6DrV8qdQGhhK1xfTi+whmMDqtNw5ywAZQP3G711eLJE8zdCSvN
         Ujtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eJGc7LKoFSAQh3U5pnxpg9tqulEY+yyaFuRorTfEWYk=;
        b=DgVqyt1ICVwULXWMxqe+gQlVb+dyrhwIEMu+YWQ4gH/A/cSTjipJ23YUexCAVq5RtB
         On0XeZhNGz6kM1MThmhv7LC+ZJzE4xUOS/zrjg2hnHldm8AyWdr8V4AYqkNkGk9iYZsa
         HVRRqLEWMDP5Kg1BqgJjmgIqlUz1/nzMZOXE85TC6rU7qmKE/nONLUEvQCxCeXbGd50e
         0/NfHc/PnmlZcKXE/nv/6lb66lsy74g9o+3dbWAeM3Uokovt4wFLBhqJ04DJWlcvuKOW
         CC80cQUiEnr3cCnueYn2DCyWkeINbjln/yl9x8cz4U6GRWG1YrTd4w17d9PeCYzty0mu
         hFdQ==
X-Gm-Message-State: APjAAAWv9Z9rQvsHp3095/zYpO5cb6cRdAoIRRlhOo5y3Yl8EL2UOiI4
        L0bJTjQLqcrmCEOtFrlzHVSioQ==
X-Google-Smtp-Source: APXvYqwYgE4S7+lsuP6O1SoFfUNFaBqAxLJSI13Y1ic5n5BtJVyUSYZKUWqmC4GvyeY1gSShkWOmtQ==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr4618830pjr.25.1572848615383;
        Sun, 03 Nov 2019 22:23:35 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5975:7f6f:59ab:7646])
        by smtp.gmail.com with ESMTPSA id 82sm17334631pfa.115.2019.11.03.22.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 22:23:34 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sun, 3 Nov 2019 22:23:34 -0800
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.24.0
Message-ID: <20191104062334.GA49488@syl.local>
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
 <20191104054924.GA47418@syl.local>
 <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 04, 2019 at 03:18:32PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Thanks for a great release. As always, your release notes were
> > very helpful in putting together GitHub's release highlights [1].
>
> Well, thanks for writing a version readable from humans ;-)

:-).

> My reading hiccupped when my eyes reached this part, though:
>
>     ... commit graphs can represent an order of magnitude in the
>     performance of loading commits.
>
> There is a word, perhaps "improvement" or something, missing in the
> sentence?

Ah, thanks. It must have been dropped in one of the rounds of review. I
added it back.

Please do let me know if you find any other such typos :-).

Thanks,
Taylor
