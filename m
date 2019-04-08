Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505BA20248
	for <e@80x24.org>; Mon,  8 Apr 2019 14:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHO15 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 10:27:57 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42827 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDHO15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 10:27:57 -0400
Received: by mail-oi1-f176.google.com with SMTP id w139so10654192oie.9
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91SU1Wn2FFgRqf7MdYZvfgSZvx/0rZqVNiN7AEBtovM=;
        b=d16pXp0we6A/Ox1KGtvA2mSfZPtdE4jFRvn/a9XzsaTKiiq5KsP6AYxKo6/gJiJZPP
         wKsbcn4O7+E5c4kCAD2r7vvh4yPG6YqsdPiSnWa8Qzp/deHze8hhSIww8GVkF3UoYXrR
         BVBk4zLDdGnyhZnkxlFNkZIYXw8voqXrKzsjmi8ABtdtWx/5mHmuOv2hT4qGGgfm+6XC
         vY47APBfmkBZalDZVwxtI2kyjD2Keki4ZitjykPKAC7PVSCA+y8KeEvrgDA07iurwDq2
         agyNULS+obcGwDDUmSJ1TELwe3YO9bWwrPmzEDy/h0tUHYQAhfoflFATKxDksBANCzc2
         im7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91SU1Wn2FFgRqf7MdYZvfgSZvx/0rZqVNiN7AEBtovM=;
        b=CDIY/68NiipMp4cjk++X8e61Ub1mkyHeJwtmw4hSdfjO61GcSWIP2IYYp+4farSNRC
         glGOpo1J0+Pjf4YQ3qgq/dGlkP45gAhV8kdhvn1u2GCjYgoaU4T5fLM/DhxlpK1oJjCV
         Z7oSPEODPfE9yIxlVsDYMK+TqHaxOpDiAff1Pioqqqe/6QPayhjRsaQt3AbDOEDgvALv
         fcuASWfJJYOjFWQZgIlJBIoRMy5RWiDGOkVmtJ1voAg/eyK8VJQ0zuoypoAl9b0GE3B4
         n4wWo0X5CUDOmPGMqr/0TsqQ+YAvs1Bi/NBdLBlGoaFcAy8dYFOQI56moKtmBie2tj+S
         1sYg==
X-Gm-Message-State: APjAAAUrTFBNAuWjvKQQtfUDrPkJp1WZ46iBEVGWaApf//eYqWU81dIH
        KE/NY0NWdcTXMZhDW3bDwjMguDwKfzQ8PeqwYfKYJ1u9
X-Google-Smtp-Source: APXvYqyDbVznPpdhyExJvdi0GW/GIquQpW86cWKsqzf3cRlY4cSwxV8FW1jpB/xFbxD5swZIkJkTi22gXugz3Xzkw9Q=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr17282602oif.110.1554733676019;
 Mon, 08 Apr 2019 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
 <20190407183857.GA32487@hank.intra.tgummerer.com> <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
 <CACsJy8Dc3fuXWOOO-hNJqGNomufP7bffoHVf5hHLTubHQvq9vA@mail.gmail.com>
 <CAMknYENqH==YcAfU-B16Jytc4Pts4viNQn9deTFag++zZVb1+Q@mail.gmail.com> <CACsJy8D7mQZgJhZ4H8Z929EnjYe1Wp7idrbXqkUsmL1Ypn83dg@mail.gmail.com>
In-Reply-To: <CACsJy8D7mQZgJhZ4H8Z929EnjYe1Wp7idrbXqkUsmL1Ypn83dg@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Mon, 8 Apr 2019 19:57:44 +0530
Message-ID: <CAMknYENGZBQ6-8sJ5UrKS_ZLLoz79K8FYUHFQqSpV2JrkSuf6w@mail.gmail.com>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

while understanding add_index_entry_with_check()
i got to do_invalidate_path().

the commit hash for do_invalidate_path() function is
`749864627c2d3c33bbc56d7ba0b5542af698cc40`

in the commit message it is explained that, cache-tree is used to
store object names of index file objects and it is kept separate from
index file because adding it would change index file format.

the part i couldn't understand is:
"During various index manupulations, we selectively invalidate
the parts so that the next write-tree can bypass regenerating
tree objects for unchanged parts of the directory hierarchy."

what exactly does invalidating means here ?
