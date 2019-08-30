Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D5A1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3O3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 10:29:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44073 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfH3O3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 10:29:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so4388187wrv.11
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=msKTSvE90NAFcY+sCMjzs/feD0NvlMFvUf03+dEUPiM=;
        b=OY7C7oEbh7LIFNkH0aTXib++Bs9qYg8c64cpFNgeDKpn8RNKgqwHdLYN/ODx5gL/7P
         T3ywNcbU9BpfXt8IcTLskhj0mAN01SRRmbOlpl5RIu0mASbak/BHM6GsC6lS7bDjNGhr
         +A59mxU4rwJ+6Lma1cERrLq63Kk7ey6v3acb6BfkamNH7e4XE3ZB9lQeMtU7XkQVuDFW
         Dx6E2r/EqN1Y/blrtoJuODDOpRhwe9zD6La09zBkx2TLHaiqsJRpvxJuwK4+2OtqyiHr
         02S+i/JSwAoyqvW1k7oirgCQvz0RHUPqyujVznJ1+AB9hCEOTFXLWrGCOIQxNdHSdB1X
         muww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=msKTSvE90NAFcY+sCMjzs/feD0NvlMFvUf03+dEUPiM=;
        b=HMP8+rkVVv6IruBx/TmZBu99NPjW+uFeZJesG8ujbN2qsZxzs6SMuDc9wd53UW2mte
         vCuYzqrbAZrTytKxxaJMWC/U98F31b9ENmAJdqQ8b6yZ8Tj4KaCLbOwZepcHvDmi3m7t
         HvEOoyu9htrm3oCyUfxR5HCfFfNfMd+K6OK5x9omVebcAOaLBMyWckuZPn8MhGNegMTo
         2lVbn0NOvzVELf6IZi2WXg53ejxCS54oHQy9EtUQCigZfhcWSa9MwFAZlq99rBZgVqDj
         SaClFAR3/FcZ0MmDNzrzOEPplQV/EQHnuJLhGUIE5s9eOiw/Fpq6hgv/Tb5yddNgk5li
         ZTgA==
X-Gm-Message-State: APjAAAXTAMY2E1GknzRtFg89cFEqfesZTow+b23D28aFCMrYQ4wSwLqa
        YEJNQvXSOhd+b5yiszyZ5Qw=
X-Google-Smtp-Source: APXvYqyVqEV4ig5mlQ7dHoqshyWqdftqbPfvSGlCzqjCkTaXh1M4JQ2Lu382eSAZUk+t6H+Pe0xvtw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr18416394wrm.2.1567175375566;
        Fri, 30 Aug 2019 07:29:35 -0700 (PDT)
Received: from szeder.dev (x4db30fda.dyn.telefonica.de. [77.179.15.218])
        by smtp.gmail.com with ESMTPSA id p10sm7209680wma.8.2019.08.30.07.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 07:29:34 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:29:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Dmitry Nikulin <pastafariant@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF
 incorrectly?
Message-ID: <20190830142932.GJ8571@szeder.dev>
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
 <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
 <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
 <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 04:23:13PM +0300, Dmitry Nikulin wrote:
> On Fri, 30 Aug 2019 at 13:16, Phillip Wood <phillip.wood123@gmail.com> wrote:
> > I'm not sure why the last argument is being split in
> > your example. It is not split in the example below
> 
> I have replicated the splitting issue on my small demo repo [1]:
> 
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M origin/branch1
> origin/branch1-mv -- file1.txt file1-mv.txt
> ['./print_argv.py',
>  'file1.txt',
>  '/tmp/EWaCSc_file1.txt',
>  '2bef330804cb3f6962e45a72a12a3071ee9b5888',
>  '100644',
>  '/tmp/mtEiSc_file1-mv.txt',
>  'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>  '100644',
>  'file1-mv.txt',
>  'similarity index 90%\n'
>  'rename from file1.txt\n'
>  'rename to file1-mv.txt\n'
>  'index 2bef330..f8fd673 100644\n']

Another Python 2 vs 3 issue, perhaps?

  # Python2, good:
  $ GIT_EXTERNAL_DIFF='python2 ./print_argv.py' git --no-pager diff -M origin/branch1 origin/branch1-mv  -- file1.txt file1-mv.txt
  ['./print_argv.py',
   'file1.txt',
   '/tmp/ViB58B_file1.txt',
   '2bef330804cb3f6962e45a72a12a3071ee9b5888',
   '100644',
   '/tmp/p6OH9B_file1-mv.txt',
   'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
   '100644',
   'file1-mv.txt',
   'similarity index 90%\nrename from file1.txt\nrename to
  file1-mv.txt\nindex 2bef330..f8fd673 100644\n']
  # Python3, bad:
  $ GIT_EXTERNAL_DIFF='python3 ./print_argv.py' git --no-pager diff -M origin/branch1 origin/branch1-mv  -- file1.txt file1-mv.txt
  ['./print_argv.py',
   'file1.txt',
   '/tmp/5xD2DS_file1.txt',
   '2bef330804cb3f6962e45a72a12a3071ee9b5888',
   '100644',
   '/tmp/vvHQGS_file1-mv.txt',
   'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
   '100644',
   'file1-mv.txt',
   'similarity index 90%\n'
   'rename from file1.txt\n'
   'rename to file1-mv.txt\n'
   'index 2bef330..f8fd673 100644\n']

Let's just stick to plain old printf for now, as suggested by Phillip
earlier, to reduce unnecessary confusion.

