Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4721F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391898AbeHPSS1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:18:27 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36720 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbeHPSS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:18:27 -0400
Received: by mail-it0-f51.google.com with SMTP id p81-v6so7171501itp.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlyoQcZJBS+IVZE9uS0jbNx6Zft6G847IIg0lROsyRk=;
        b=ZLTYp/JxVt2TPbYz6SL8IqPx1qKt9pKEscskQ285w5s76fAMcTltsGgtIbAMQw9sei
         S54dph0hz5V8fE5V7I/3qDpPs8paBf+Lc3XBCkK9CDIf9TZwqIh/wI6FRVfiMa7offhM
         FVwd0YpM6C5VkXFz4PYpPxLFeC4oL0MvKeKxAVBSAO8uFKUD+sCYNGYOcraQ9LOvz6yN
         yRwttLBVHA0s1OzLJ5k9RcTukzDfiLmq/REVIBG5ich2wCysJTdqyoGm/CTyPaHfSFG1
         W0P3dc5HfO5dFj+1NPDgoa/mAbdnhuEP1Sdb2thm4QXggc4BR10GtTTtmUoAmjUE1FV6
         cEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlyoQcZJBS+IVZE9uS0jbNx6Zft6G847IIg0lROsyRk=;
        b=GpM2dsu2aB+rSrbTjBZ2CdTBRYrjLG+Xk+S1wVFmWH0Pvngq9gztLWwHoTF6bfgCbi
         J8JRFMWjr3nW7DN8aYVw0h4w3jIzejRYP77HAnsyKaoa/Q+YQRBzEFr5nS8hQzqQlEcd
         l+CmBUeKqesPdHdcF1pQpniUsBWjrOeV4yoFXy7i3ikgEExufDC9QzwPpDQbDIMpRPUY
         wc/kXOqtpf+XzvpgYA5+CIKhAiEmsSG/gqpoCxXjL+q1EHT6hhg+O1RYVa+57TlbV3Et
         dvK5sDX5JIsjSWFZLRS7ni7xW720nSSl07kYG7gsAOyE/JURzJyY3fy3aqpdylA1fQrC
         KGOg==
X-Gm-Message-State: AOUpUlFRh2iv8trFdt4ITGCTgGJ/KRZX8oQb3tBtnRMmot6fjFYKQywM
        Vn6iqPvzCsPnDzay08Y88WxJ4OneZygIXWGz56Y=
X-Google-Smtp-Source: AA+uWPy+ah6MViDB7iRSAAOh58RvumVx5Hm9xxGssGvtxixIfWgmGD59vhbmbZTTFwwM/RNWLuCQh/NpACamfE94jNY=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr25989806jad.94.1534432759737;
 Thu, 16 Aug 2018 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
In-Reply-To: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 17:18:51 +0200
Message-ID: <CACsJy8Dukjw_PKQXMTxwd_C3juA_0cqZSjb=1L2wKqtJoC3rkQ@mail.gmail.com>
Subject: Re: non-smooth progress indication for git fsck and git gc
To:     Ulrich.Windl@rz.uni-regensburg.de
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 1:10 PM Ulrich Windl
<Ulrich.Windl@rz.uni-regensburg.de> wrote:
>
> Hi!
>
> I'd like to point out some minor issue observed while processing some 50000-object repository with many binary objects, but most are rather small:
>
> Between the two phases of "git fsck" (checking directories and checking objects) there was a break of several seconds where no progress was indicated.
>
> During "git gc" the writing objects phase did not update for some seconds, but then the percentage counter jumped like from 15% to 42%.
>
> I understand that updating the progress output too often can be a performance bottleneck, while upating it too rarely might only bore the user... ;-)
>
> But maybe something can be done. My git version is 2.13.7 (openSUSE 42.3).

Is it possible to make this repository public? You can also use "git
fast-export --anonymize" to make a repo with same structure but no
real content (but read the man page about that option first)

> Regards,
> Ulrich
>
>


-- 
Duy
