Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C891F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJ3Bcb (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:32:31 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:56319 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJ3Bcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:32:31 -0400
Received: by mail-it1-f172.google.com with SMTP id e17so8710193itk.5
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IBk+Y5UIskD7pUsAce0iPP9ZUG7jKaK14JTwUUmwVCE=;
        b=GZ8m9oeoyAAFHqIFICLPoHYRb5OWK/YMOpAYV92FeqVrZ5Jx4ACACH13hZcMXe20Y0
         Lr1wMpBOf+SbOUR9j13YyYVcct1Pkqae/b2Ca1PN2FWrYOewPJDsU7wCwY1n4fCXiOx/
         YuT6Ur+AARs6ohjppghlTtqQcUwCfWtAaIoEhQRrkoTTXQyEmNMj8U8zoKnlAl3mzWoe
         rtMjJW6PGbnJfmxKGY+ffeQZdgQs3WJpJ1Agb3th0AcxFYsMqN8aE5qIm0fgrWO7IHWY
         jsApmpftSQ8uaeW+hRrURqH4AjOlrPJT8XuUR36bb+OFhA56O0xtVMe91Gohsb76vT2b
         ZP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IBk+Y5UIskD7pUsAce0iPP9ZUG7jKaK14JTwUUmwVCE=;
        b=iiL4ts6JRlrBI5QmeB9v0IbFLzTLWqFO77BTLcHmPQaf86dQdHedtQGWQ293HBU96N
         5AqdHsNo+zTm/Uk1eZ3lKNEBC4xwsPvxRTyd9XmLvnD4OyMQCNh+kfYeL8y2gdNoQj2t
         DLJyl7WWiX5EjM3t5NAbedODOaJEKHXL/TV2cN8MQOHcAUdToyBzQ9LzPm/q9zNgu9bg
         37898eB1R1wRj5qc075x3+C5qMTJOBQqT70akoQSFFZqVJJS5eMD95KwamITHuA0xD/J
         gpqshM+FzWQqr9ghAE+TPT19Oq+nmLe8njw9ywp/IA+fn6Qry1AbfgiyY0+oTLvNoY74
         cfyw==
X-Gm-Message-State: AGRZ1gLkk9KNk8kr0Wwv5qlCrkKYx6fwwhFSmaKLIrjZnuz3aL0RKLqU
        HRfZywON8tVor3iKmJCYvH/CJitzzPs9PHOVTwE=
X-Google-Smtp-Source: AJdET5esF/kTM5cV1vXe9WwJ6aZlax3xhix9EZUpe9uEo1gOneLdUWX9BfOr+tehAPP3KV/Tdog/2UIeAGXRS2kCxSY=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr10717424itc.123.1540831388159;
 Mon, 29 Oct 2018 09:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181019145237.16079-1-pclouds@gmail.com> <CAGZ79kbQ_QLb_Oa3mg3q2FJUNoLkk_nzqoURHKY1U1i8iUSg4w@mail.gmail.com>
In-Reply-To: <CAGZ79kbQ_QLb_Oa3mg3q2FJUNoLkk_nzqoURHKY1U1i8iUSg4w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 17:42:42 +0100
Message-ID: <CACsJy8Aff3qkP6PYH9MXPDxjD94XoQSJYeinw+r62E9Zhj-02g@mail.gmail.com>
Subject: Re: [PATCH/WIP 00/19] Kill the_index, final part
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 7:38 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Fri, Oct 19, 2018 at 7:52 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > Stefan I see you start removing more references of the_repository in
> > another series (haven't really looked at it yet) so this is just heads
> > up so we could coordinate if needed. Still WIP, not really ready for
> > review yet.
>
> I'll take a brief look anyway, otherwise you wouldn't have put in on
> a mailing list :-P

Thanks. Just fyi. Since there are still plenty conflicts when merging
this with 'pu', I'll just wait until things settle a bit in 'master'
before resending.
--=20
Duy
