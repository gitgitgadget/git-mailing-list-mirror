Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59FA1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 11:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIQQtI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 12:49:08 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34354 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeIQQtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 12:49:08 -0400
Received: by mail-oi0-f53.google.com with SMTP id 13-v6so18568324ois.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=r4Iva7WUYoZ9ilzGvFYsVDFGaW1UMjx35sa8J/qTxsU=;
        b=kkVSC2qOixBW6gRpH8ZVRX/e/oEKdjb9xdgzKkK8GKLxaVVEEqcRHo49Oh8RTWQ5My
         JMpUanpyyAir327EMY8wTJ6N18yUQYGnKrI19DaxyD2vNGOFNSQC6vsLIvRO9WFJT4bA
         56wjK6+6g7GNlrXgXFXS8wUTcozSY4JcCCR6NLNkYiBXkD/qzrvdZ+r+vxSdl/JL5/33
         Qy4T7xZfRRPEMKQzY5cw438dCIoxHePmI2itB9/TSdQXf9wJ3EvWXgL/6Cx0sL0K+YzG
         O/JpSNm18eRSEjwLen4D6XOcrxIGHXHr6hA3OlURnmlroRtR02a0Q2NJ+t1rWzqVZJ2D
         OBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r4Iva7WUYoZ9ilzGvFYsVDFGaW1UMjx35sa8J/qTxsU=;
        b=ZInFqc+Hs79UraRx8db3s4o0yLJWQ67lX9wR54P5jsODc6onFoJzYq+ZwUjjOQcaO9
         gwOEgj+2GTVOqCGMo/FRGff3jmICFIMGsAWp08rLO/VxQ3A/EUZGQD4oLLvgf8I4ab9h
         9s+BSUuV4y1BVsUgMwaBtQITwHc1VQqy2xQcaH4AvBPIWKGdg2tbngGeC64z362UDDss
         7ou3Ngmj64/hGWQCHofKfX8r94v56oAyrBGFLLQI+ODrMq743HTr/KcMLmah8UFCp89o
         ppavUw3yqx4aLofYSFgt8gpWJNEai05IRbEjPFk6D7cn8cNQnzgAZa80b2IIx0dMzo7j
         /1Jg==
X-Gm-Message-State: APzg51ABojphbEMNHl+6w2prKAGWFogbtd16ie4RSxv1rTl+ZbwIuWpo
        ofIska0IycUe2jsG5yqv9YL8pZfskWoQ2sR4UdutR9xM
X-Google-Smtp-Source: ANB0VdaaC28xulgjfbBW00vQJ2ynQJN/kmHkF3kUgkOdJg/eJ0wpq4J98jK1st1ucyQmPVu/YopNy2hj7k19aFFCvjg=
X-Received: by 2002:aca:f2c3:: with SMTP id q186-v6mr17576578oih.193.1537183334325;
 Mon, 17 Sep 2018 04:22:14 -0700 (PDT)
MIME-Version: 1.0
From:   Nikola Milekic <nikolamilekic@gmail.com>
Date:   Mon, 17 Sep 2018 13:22:16 +0200
Message-ID: <CACU07Yt5vh36tHcHxV-b_5MNLc-RzqGQ7=nkJq-DTqNgmYP+wA@mail.gmail.com>
Subject: Differences between git show HEAD and git show head
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Windows, when using multiple workspaces and git 2.19.0.windows.1,
'git show HEAD' and 'git show head' return different results when
executed from a secondary workspace (the one without the .git
directory).

'git show HEAD' shows the HEAD of the current workspace, while git
show head shows the HEAD of the main workspace (the one with the .git
directory). I find this to be highly misleading, especially for users
like myself who are not used to typing HEAD in all caps. Is this
indented behavior or a bug?

Thanks.

Best regards,
Nikola
