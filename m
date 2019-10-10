Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DB41F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfJJXFz (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:05:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39254 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJJXFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:05:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id e1so4617713pgj.6
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jeq3ZfPXwRj/c83Ulryqbd5j1nY4vpQpPOa4qORZ40U=;
        b=ZcB1vsxoeTMn8nNtaQYARL97OimAjBYtJZccMmyOz1oJc6SlBn18rNngECpHffHQcc
         XJr01mwqFQQHe4RLMMC9X/ykOad6MZl5YZxsk0EIAf9dgt8k65piz79JYi95NgoyfjpB
         StGYA8Cp7KUqIvPCGdpmNnG+EL815Psb6molK/lahCoLUkgHnrKu5YcZIMUeVGfkJ0ww
         3tk9EADJmoVZA/nrzE4m7UTCR9gIdG5Crj0biNqavhcgbgA8dgIj2ezbdCyrxszZMm28
         bv5XbyIvn1fGwzc3G4+fITlTP7ZuvX2tzZpL3epq9WBX5TbLPwp0qd7ZwQyOmdypAF/R
         6BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jeq3ZfPXwRj/c83Ulryqbd5j1nY4vpQpPOa4qORZ40U=;
        b=pyl4X6M+PS1zHtfkAUiUqGFDu/UxqKOt4/SSFJ81UfDfjPTZ0oWQwX1EnaXpOuiCuc
         PpBl2A9jHHYs0H/y4SQTL5hW4YtGGmxYEH+jgohwlFTowzZVv+R5L1K4VSDTqPREfDj4
         T5+rqM1u7kE5MOqyBo4qaSq5bM2wn2bVkS7oo0y7OTJzl2xryW/HxyWj+NYu2JxfcZph
         dgpg59ZQCfBcwU+Ux1X1BGBH8QZTgGKDPrPJkZk7p+ML1a9OhmYcTKohvxzuC5Q5krk5
         tpxzXKbJPShVZB2Pdg4bfSdyriyoABNcYUNfyUrBoTpNXA22JSafheT7vd2p6BHVvqhn
         7V2w==
X-Gm-Message-State: APjAAAVQk9nbUaY/MZ7aJ3p5fMoMYrTCMYEu5mRDIv598Gmoo3a5rvQI
        49PcZRclizKjhjZDcRkGplqcm9eJ
X-Google-Smtp-Source: APXvYqwG5I0JMbF2YM5s+AqM85G48aHSBN7R80tYI0u0SIF9kdumqv/Mnf/mFEPc/clRBaexWEzg1w==
X-Received: by 2002:a63:a35f:: with SMTP id v31mr1280466pgn.51.1570748753625;
        Thu, 10 Oct 2019 16:05:53 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id d20sm8799351pfq.88.2019.10.10.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:05:52 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:05:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
Message-ID: <20191010230550.GA42541@generichostname>
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Oct 10, 2019 at 11:07:35PM +0200, Johannes Schindelin wrote:
> Hi James,
> 
> On Thu, 10 Oct 2019, James Coglan via GitGitGadget wrote:
> 
> > From: James Coglan <jcoglan@gmail.com>
> >
> > All the output functions in `graph.c` currently keep track of how many
> > printable chars they've written to the buffer, before calling
> > `graph_pad_horizontally()` to pad the line with spaces. Some functions
> > do this by incrementing a counter whenever they write to the buffer, and
> > others do it by encoding an assumption about how many chars are written,
> > as in:
> >
> >     graph_pad_horizontally(graph, sb, graph->num_columns * 2);
> >
> > This adds a fair amount of noise to the functions' logic and is easily
> > broken if one forgets to increment the right counter or update the
> > calculations used for padding.
> >
> > To make this easier to use, I'm adding a `width` field to `strbuf` that
> > tracks the number of printing characters added after the line prefix.
> 
> This is a big heavy-handed: adding a `width` field to `struct strbuf`
> and maintaining it _just_ for the purpose of `graph.c` puts an
> unnecssary load on every other `strbuf` user (of which there are a
> _lot_).
> 
> So my obvious question is: what makes `width` different from `len`?
> Since we exclusively use ASCII characters for the graph part, we should
> be able to use the already-existing `len`, for free, no?

From what I can gleam from looking at the code, `width` is different
from `len` because when we're printing with colours, there'll be a bunch
of termcodes that don't actually count for the width.

I think that we should either leave the `chars_written` variable as is
or maybe calculate it after the fact. Here's an untested and uncompiled
implementation of something that might do that:

	static int calculate_width(const struct strbuf *row)
	{
		int in_termcode = 0;
		int width = 0;
		int i;

		for (i = 0; i < row.len; i++) {
			if (row.buf[i] == '\033')
				in_termcode = 1;

			if (!in_termcode)
				width++;
			else if (row.buf[i] == 'm')
				in_termcode = 0;
		}
	}

If we include this, I'm not sure what kind of performance hit we might
take if the graph we're generating is particularly big, though.

> 
> I could imagine that the `strbuf` might receive more than one line, but
> then we still would only need to remember the offset of the last newline
> character in that `strbuf`, no?
> 
> Ciao,
> Johannes
