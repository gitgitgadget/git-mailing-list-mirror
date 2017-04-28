Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B784207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 18:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642244AbdD1SFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 14:05:20 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33599 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S642241AbdD1SFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 14:05:18 -0400
Received: by mail-pg0-f45.google.com with SMTP id y4so13131329pge.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x+9ixg3GwARO04+RVZx6olz7Od98yyCTlUftbKlSaZ8=;
        b=axipjz5/S/VpMt16Y2DJiH/0H8V8wZLkedeXeADI6nAncwMA6cze42BhuX3lpXeEjI
         ivdzjkdIOuJJJR8bDASmndpTD+p5l9sSNrBiw7aLM4Fn/eub9gXP5Q1kUQUYoAzFS5Yr
         pdrlrxkcOvdFjcAdx2MrZcNrfKhxCp95465kqodjQprjtfn+gd+JafS2biIuL70C87lD
         ReJjNBGBI1mjV/f/0sPxG5Wo7ffDj+tj4VYPOK6qcHwR4kvXs2tGeIF6pprqUzCFPh6a
         UOmPtC12axRWJBXGu/yAdH0h4QO2KFsBuMTDtvijrFwXirETugNecdpzDotRXh3Y5rhA
         gOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x+9ixg3GwARO04+RVZx6olz7Od98yyCTlUftbKlSaZ8=;
        b=OUNOn6W4w5pNtNNA6CYIqYWbvWHeFHH/Ik3FKCuucuAtpxwEUCV6R7fR4JIgtAZcEV
         UwEPggE4pJbnmINKh5PLQFRxF72+f5YMTFcy67Kq5IridxJRdGkPPczAVuYEmWMf9qyz
         z/aSD4YpY/h3q0UpcSuf5/2FkwACz7IVGh6jWrFiGpqW0Ur5DoraXbnP+rS+KtFdEhpi
         bZ/uLvdHgU+XTZlnTkZ6B9uNllbWVrYMDRfNrVs3JiIO4aJClKOHDmNIAYIQNfsbAAfZ
         mxTXybAkk55r3btTT2cQ2OcPVxXHaClRPTzubP8crWS/EzCWYPfGntmWdgHusI+/BCBa
         f4pA==
X-Gm-Message-State: AN3rC/4AHfIAqU3kKsDas2QkYvmDCorCnIQB8GSo2DDjoLyaIpIeqK1L
        nu1roG9/rJqye0QN5YBPbgJX2jCxVtIV
X-Received: by 10.99.107.198 with SMTP id g189mr13244009pgc.162.1493402717539;
 Fri, 28 Apr 2017 11:05:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 11:05:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704280010160.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 11:05:17 -0700
Message-ID: <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
Subject: Re: [PATCH 00/26] Address a couple of issues identified by Coverity
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

thanks for the reply.

On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I still have to find the time to figure out one more detail: how to
> download and extract the Coverity tool (the .zip archive has a variable
> name for the top-level directory), and doing that only every once
> in a while, say, only when there is no previously unpacked tool, or it is
> already 4 weeks old.

That is an interesting problem, which I ignored as the older versions of their
tools still works once they release new versions. So I just manually check
every once in a while if they have new versions out there.

So if you find a nice solution to that problem, let me know, please.

Thanks,
Stefan
