Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2AF20248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfC2NQO (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:16:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46939 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfC2NQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:16:13 -0400
Received: by mail-io1-f68.google.com with SMTP id b9so1651797iot.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLce4ijUhtTzWN2qvZJ0H3t6UlRTdHHjtI6DmYeXt9A=;
        b=0C/IQW34ppq2aGeYOsn6ZpK0DjXU6XLM/CsDbom58y/NJ1WxsK3uLf9sTfP6EprKf/
         VD0guP4WYiNcpTs9oecLhQsBKbwntC8Dh7vPgGupASR8ZcFRqoy5M5WrQdtxlMRNLgRB
         uYUqVMIaNYzGftJBYWuaTmcuRdXYz1gzNQAyDsKen4AnpWcXNaZIwNx9qTWuxx9uSY6R
         wlw/WTD88qHzl9D3MS3CUkFloGllDVoaNmC9u88/pvNs5x9wOKXqh2HlQNvg1fDgF0Jz
         KBfsdTS3P1hA7we0m2Dml3rz21uOox29JUO13e2DKyXj049zdf2EUkX2JLVnT9Aln4WE
         9Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLce4ijUhtTzWN2qvZJ0H3t6UlRTdHHjtI6DmYeXt9A=;
        b=cXnolq4NRiZVH5gVQxHrNPggIo3IiBE1bWdPLhpW1dz/MF2JpBt6fb2k9bBwIWVp4X
         Fj3bpHuP9difawR8+S6wHdkgua7tcH+MDyRemS23qy/AN3/behyILESxyNz3RFeHCV6e
         tiUj3PrIGOq23saAjy/PNd0VIdRimuteFwLhNvRz7sNSa2q91zodl27EoVI03XfaE3eh
         8G25g3gOYXabF15QDp7pbZkMF4NxGgN8rmxWk+vqV/u5rf0imIqCVrttlcWlc6xqqTVv
         67N1cFnzrN8gaUOIzrCwZZtMR2/qg2dZ0O00GPUEuosOI7Nd6DTCxv+8wwQdP1MK5qo6
         C+Bg==
X-Gm-Message-State: APjAAAU+o+XhT+IPNpvI1uf85HIeHrrJPV+JVYHbMHM1ec4umfICaMAN
        sjB2wHAyGkip/2de9I6BC7sI9AqBdb9xfkC8GI0Vcw==
X-Google-Smtp-Source: APXvYqxTTMLytrtbLGvaSgkVIpW76nTxaalK1nCZCtMVvUNkyzce6PusAsMcqDpIiJ6X85nCc0Ymw7IOyjqDok5OrfQ=
X-Received: by 2002:a6b:e305:: with SMTP id u5mr33789191ioc.262.1553865372835;
 Fri, 29 Mar 2019 06:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-4-matheus.bernardino@usp.br> <20190328221910.GL32487@hank.intra.tgummerer.com>
In-Reply-To: <20190328221910.GL32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 29 Mar 2019 10:16:01 -0300
Message-ID: <CAHd-oW4dpr9bp2fgYzwzz1NcpXGnD3o6phcY8Dek5T6rahMX3Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 3/7] dir-iterator: add flags parameter to dir_iterator_begin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 28, 2019 at 7:19 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/22, Matheus Tavares wrote:
> > Add the possibility of giving flags to dir_iterator_begin to initialize
> > a dir-iterator with special options.
> >
> > Currently possible flags are DIR_ITERATOR_PEDANTIC, which makes
> > dir_iterator_advance abort imediatelly in the case of an error while
>
> s/imediatelly/immediately/
>

Thanks!
