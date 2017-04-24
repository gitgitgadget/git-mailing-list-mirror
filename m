Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8CE1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 09:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168006AbdDXJ24 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 05:28:56 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36806 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167957AbdDXJ2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 05:28:47 -0400
Received: by mail-yw0-f180.google.com with SMTP id l18so16021677ywh.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+0Fkd2rIfuBxZPxWvmCuO2nZBzgUdBGwXvOUj7ladNs=;
        b=MeDhKaqJUgsTSc/ztkdNhM8apdyd3HJ9F5eyZoMnB4z9onmqRAKHvDN2OyAHnLa4Qu
         Go32gQdLG5HP/gW7Yz+Rjno+Pk4albOC7wJSBFd9n9IpRN5xlK+h9d5qRaqGMoxx5e3g
         +uUR1I9AsWQdSvFy1OyDPx7hmTgt/hphKV9QGtbE4vF71czIK3pGlCtQz5+I3SR3O5Q2
         p16b7sfVfvfCLWgsuogbIsXKsPK2ipzH/Mmlf0Gpt56ECFNMlVIwFhxHR4aCAZAtqHOF
         eU7NcZYw72RsB7SO7kVguHNn4Ua38XHcxSqi5oVpaOeQFFZZD6BKGIOqzz8LJ2R3MX05
         YTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+0Fkd2rIfuBxZPxWvmCuO2nZBzgUdBGwXvOUj7ladNs=;
        b=Hm2T91uJ/k3+8T7FfETe3z6aN0M/PLvscCLg9eekHm69DOmCQ3mMo6WjTlXVYhgvno
         FOZsEfcw6PW7TRGa1xizjBkHwrCVlDEdC5GRfHz3skuAgHnwPDhYdEVSoFJnbfPGxXSX
         F3yxWoA1CxHZNjxLSkZs8PE6JxeNFv4dpoeVUmqKHAFFxygetA18aPRGHcuPggr+Aluj
         NhelQ74UNRt/oiI5qwDgqxYvcXj9uZcYCfWlAL0chsZqF7mX52lVZbdz9P++Ufr85GxN
         l3cXWkBuMqxgBSgDnUV27xgUUg7YsYdOC0kJty9X3HyZiPlBhDaMLepIowvC/0ey7di4
         Ljvg==
X-Gm-Message-State: AN3rC/4NtCc5pN1AYvY63adiUIwpASCCKFI7IERV8n4iCJGUQR8JGkrM
        7JHhl2TfIYEJyWDuiMLo/nnBRPpDhQ==
X-Received: by 10.157.63.156 with SMTP id r28mr2839377otc.225.1493026125491;
 Mon, 24 Apr 2017 02:28:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 24 Apr 2017 02:28:15 -0700 (PDT)
In-Reply-To: <CAH_OBidR8ewMO_B0HM2SU=B+uV=kRjpOKVMcvohEkZ1PSgT92w@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
 <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
 <xmqq60i2im72.fsf@gitster.mtv.corp.google.com> <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
 <CANgJU+WbbF2yzg53D7NasN_nxqytOh=UoutmMPak77JhiJHx4A@mail.gmail.com> <CAH_OBidR8ewMO_B0HM2SU=B+uV=kRjpOKVMcvohEkZ1PSgT92w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Apr 2017 16:28:15 +0700
Message-ID: <CACsJy8DPtfyAAX_cmRLib=eKPMWnew5CsYDV6V3xTTiEg1Kksg@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     shawn wilson <ag4ve.us@gmail.com>
Cc:     demerphq <demerphq@gmail.com>,
        "Fred .Flintstone" <eldmannen@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 3:33 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
> Late to the party, but I too would also like json format output (mainly so I
> could pipe stuff to jq instead of looking at the man page for which %thing
> I'm looking for). That said, it's not at the PR level of want for me.
>
> OTOH, format=xml would be even more handy IMHO... Which I see has hit both
> SO and this ml in the past. Either way /some/ machine output would be a good
> thing :)

Personally I'd rather avoid linking to another library just for
json/xml formatting. libgit2 would be a great place to have
functionality like this and it looks like you don't even have to touch
C [1] to do that.

[1] https://gist.github.com/m1el/42472327b4be382b02eb
-- 
Duy
