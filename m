Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EEA20248
	for <e@80x24.org>; Tue, 12 Mar 2019 01:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCLBIQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 21:08:16 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:36690 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCLBIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 21:08:16 -0400
Received: by mail-io1-f48.google.com with SMTP id f6so618028iop.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 18:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pWHLtJE0OtKr92JQeSpP8XJFR31Zmlig0zFOeI5U6Zk=;
        b=mXXSrHEc6EmSR17XGS2fwlt3M4ip9Cm4OVT8MplQuBX9h8+0jzEiUgiSeFUqaQxJ5q
         GTHX/ITlIwMFVRF/0EX+YLMTAmT3xHqBs7kTOD2cQeSkuetDy/3Ihdg5YLkwZSXVtXnF
         HQzT8mV3JUEHdYvRUJlTn5gq/Aoai3ZCks1mJkZxxugFv0J2kd1lATycKbz0gfNRQTYL
         uZ7EaLhfgtN5K+s0ardfMg7Fl90VqDoxoQaUqvbcHXKGfUBhfNFEKCrlipQ4WYcupSUE
         jeJL3C2QsvrDKzMwV5VdKmzfWyi8VqwWhlipXuCyx4PLw0cZ4Kwt9HSiT7b5PxG60Myf
         3CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pWHLtJE0OtKr92JQeSpP8XJFR31Zmlig0zFOeI5U6Zk=;
        b=NkX4zkHXxPNuwtwMANizgn3v58HGmnCQYQe2tSs8Q5sgE/ipVnpRuqgboOa/XAfdbO
         Gy0zB3mmleMXHLt50dSDUeMRcKdFMjQVc64OCx5EqF3/W1IWioPZIwHurW+Jx9H3MbAK
         2inTzB5z2aa0Ye6rlbpChGA9C4jZ+w4DmEsITTgFQi1tlvzGq3BQi13ly2nu96ZZg1C1
         VovzReGpK03ki4/OuZV5EfDb7r7GYQLDQ2ejPMSmayOb2CiYKp1TxKX2eKX/y/t9ie2O
         CgKhvrsT1k6xyc+W6iFr25CabGHfVNfSdOQC6WztAY6TALMpm4lDDkaMXifoKxUCnjmV
         JGeA==
X-Gm-Message-State: APjAAAWC5ITLMj+XOB4go2VAu8qR0OG2z/jc8FkOqeGZOzMzW8Taww0I
        249nCcIwNa7dtrkoorkVSTkb1inFVAVsGqYVJnU=
X-Google-Smtp-Source: APXvYqzztC3UeU5gUIBMFVVrpBbZmjkNJVDTek5SXbVtF3FT3JB457ilemYqtP61GX/8ON+V2CReanVmkg4wq3ALpEc=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr6056238iod.10.1552352895848;
 Mon, 11 Mar 2019 18:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com> <20190311222805.GA6215@flurp.local>
In-Reply-To: <20190311222805.GA6215@flurp.local>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 21:07:44 -0400
Message-ID: <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Mar 11, 2019 at 05:43:55PM -0400, Jeffrey Walton wrote:
> > On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > > > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > > > I put /usr/gnu/bin first on-path.
> > >
> > > The first question is if you are really running GNU 'sed'? My guess is
> > > "no, it's still picking up Solaris's 'sed'".
> >
> > I believe so. After modifying PATH, command -v returns:
> >
> >     Solaris tools:
> >          sed: /usr/gnu/bin/sed
> >          awk: /usr/gnu/bin/awk
> >         grep: /usr/gnu/bin/grep
> >
> > (This was added to my scripts to confirm).
> ...
>
> > Maybe Git would benefit from SED, AWK and GREP variables like PERL.
>
> Very possibly.

Another potential workaround is to use Perl. Perl is already a
prerequisite, it get passed to the test gear through PERL_PATH, and it
avoids Solaris' anemic tools.

Sadly my Perl sucks. You would be disappointed if I tried to whip up a patch.

Jeff
