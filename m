Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CF81F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933672AbeGIRYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:24:37 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38695 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeGIRYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:24:36 -0400
Received: by mail-yw0-f195.google.com with SMTP id r3-v6so6814587ywc.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVZaau6Ul42pPfVgLnWau09ZjocyxYhQwbUlfwUVtuE=;
        b=ubwmjYpCVHCNcpnQZ/tINFoQovx3wozKHQoSmxWP9RRx5Dwmt31TrQhayY+x+E7xqT
         Ssj6GCADBXmcuULr2/NjxCbeYLHLqnCFwe6GKeF6GdalVtc4z5l+R3cHdpyC1yJB4XRX
         Ii8dafsdlqO8zWMdArcZJuk75T45Rp4eb8cvjcTXVw0gB0N0fS29LSLhtSBj1ZmZ9obo
         Fk2W+4/HPoome/rTcD3/PX+xg0eOTAq4qdDHhnIaO5AvRo/NTCghh3ZP661pMGv+wlLg
         osqXZh7UZGqUPV61XVDmjyhPbu0sAgQA/sZonNb2Y/VakdRz2l/K7EDav1k67oVb7Sh1
         Lz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVZaau6Ul42pPfVgLnWau09ZjocyxYhQwbUlfwUVtuE=;
        b=n9tMkGasedAhwdYcw/fKyK8nhsKECLw3yBT2eSZgBOOPByBaYs1qdfxvs7zk0wuvH5
         EdTMtlZRVskVO4oYUa8zBuRL7yUG/PF89I4zCCcq2GOHDAh9qw/ZVnLPekv/E4YNVnNw
         cjjfxq4HzE8SRV6SlDHtQ4QUwA1zhZuux49pq4/rlmS9ELUR6CLH9Ae5AYh9x5f+89oT
         i+s3S70PLRI1dzhxKHvUMp5UJ+EOs/TT/35CsMXp5BAnUJzwF+RmTrMf8OC6sKkcKLtF
         xwjWVe+USHx5wIasJU+/p3p+T0rcBOXFOAedvj8aIZgY9+L6Cl/50SIhCO+s6Pdlz2Po
         C65w==
X-Gm-Message-State: APt69E2MMnItDWXS25F3bCjVWKMPQP9RlYEShE078M0qzv7H+zVqR1S0
        dv4RT5upeCitandNR9yd8nRJlo+6Spg6A+tvtuymQw==
X-Google-Smtp-Source: AAOMgpcT1Pjq+qtbmzaVdfND+t4nHIoQgRqLgkbhOi+0nKXVXt2HiC7hVoycV8bndD88o+At44twwyXOBflffXna+Mk=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr10342068ywd.500.1531157075754;
 Mon, 09 Jul 2018 10:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net> <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
In-Reply-To: <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 10:24:24 -0700
Message-ID: <CAGZ79kaJKjWj9SY-cZYYcKShuooh3nuRqf26CzhCsusTXX42NA@mail.gmail.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/8/2018 7:36 PM, brian m. carlson wrote:
> > 100 bytes is not sufficient to ensure we can write a commit message
> > buffer when using a 32-byte hash algorithm.  Increase the buffer size to
> > ensure we have sufficient space.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >   refs/files-backend.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index a9a066dcfb..252f835bae 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
> >       char *logrec;
> >
> >       msglen = msg ? strlen(msg) : 0;
> > -     maxlen = strlen(committer) + msglen + 100;
> > +     maxlen = strlen(committer) + msglen + 200;
> >       logrec = xmalloc(maxlen);
> >       len = xsnprintf(logrec, maxlen, "%s %s %s\n",
> >                       oid_to_hex(old_oid),
>
> nit: 100 is not enough anymore, but wasn't a very descriptive value. 200
> may be enough now, but I'm not sure why.

That line was touched in by Michael in 7bd9bcf372d (refs: split filesystem-based
refs code into a new file, 2015-11-09) and before that by Ronnie in 2c6207abbd6
(refs.c: add a function to append a reflog entry to a fd, 2014-12-12)
and introduced
by Junio in 8ac65937d03 (Make sure we do not write bogus reflog
entries., 2007-01-26)
and it appears to me that 2*40 + 5 ought to be sufficient, but no
comments or commit
messages are found as to why we rather choose 100.
