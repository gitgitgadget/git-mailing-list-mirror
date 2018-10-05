Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6501F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJFBjI (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 21:39:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35255 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFBjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 21:39:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id e187-v6so2800079wmf.0
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t9ExjtXsIFZcfIkOvOUnpFM8Fxi6TpgmoapFaAayXhM=;
        b=A/iJWbmNH13/z5B/rX2EJto7JG61JkCKX9GNSFK/bg82LEPjclBL6mUklY/LB8fE0H
         ziabcvHGwyini4I0rqQ/si4TKrgRTBvW7TCb0+z8FV4ODkEjuRTzI7o9/Ppf75l+LPye
         Rr8myZ61oUJOdYuQtR9ihl0qn1mo+teeAGNsV+zSRzijIhj0Ok3sImwt/dR9Fp4+fm53
         YmuraW+Yw4AB3ALB5xWE4EBdITrTe8raxgib4oRCHQCyRXNXsaQrWuzEMYh0Tek57cID
         jECeBoqBy/fz5HLlsc0QtRYBAdZgrFOj+5z3vmv+p0ciQ0zuArVf7+SWflg0ksn8ClK1
         FeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t9ExjtXsIFZcfIkOvOUnpFM8Fxi6TpgmoapFaAayXhM=;
        b=trYlIQQi9/wFDDSUe2aPkTPUdW4uu8p2tS+6w8ovVikn/DO5Pgyr5nPer09CwN4uYl
         11oVJv92UB+JGgZHXuyp2w1utVxSQAOvVGZP9ingjhIJs3i94yGEG3IDb4+gMw9sYKQv
         /ZMZkZWjLvByHFV666oSlNfc5aIsEcjza2Mc8eE/JrvZclegizDh5KW4eRcLkhgyPJnk
         rHAqBA2oABv300ZirUBBUXSjl78fy2PeQBbs9/Ah0Jw6PYptmIGO1haj1jWBhsn8TA8s
         G5ddzKXAP+tbHxtDLFsVeuoiPJNxgMmghlSOzgrl1Td1o2UYauDPoa6yowt+wksNs5wy
         9VRA==
X-Gm-Message-State: ABuFfoj2nchUkjFHb/3WJVNN51STpOMvBP9GVf3KyEhEXlCkSsW9uRk9
        tDivRnJJWQqg70BppDnFhBg=
X-Google-Smtp-Source: ACcGV63AtnnGx7OBk9RXPbje05AjuXr9khEQ/x1jcRkBzJLHxW6jWnBFzr3iVkXfxF7gUtUJrqdwIA==
X-Received: by 2002:a1c:ae08:: with SMTP id x8-v6mr8371975wme.86.1538764748553;
        Fri, 05 Oct 2018 11:39:08 -0700 (PDT)
Received: from localhost (x4d0c6f69.dyn.telefonica.de. [77.12.111.105])
        by smtp.gmail.com with ESMTPSA id j6-v6sm402775wmd.29.2018.10.05.11.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:39:07 -0700 (PDT)
Date:   Fri, 5 Oct 2018 20:39:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005183904.GV23446@localhost>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005162517.GB11254@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 12:25:17PM -0400, Jeff King wrote:
> On Fri, Oct 05, 2018 at 02:40:48PM +0200, SZEDER Gábor wrote:
> 
> > On Thu, Oct 04, 2018 at 07:17:47PM -0700, Jacob Keller wrote:
> > > Junio, do you want me to update the commit message on my side with the
> > > memory concerns? Or could you update it to mention memory as a noted
> > > trade off.
> > 
> > We have been running 'make -j2 coccicheck' in the static analysis
> > build job on Travis CI, which worked just fine so far.  The Travis CI
> > build environments have 3GB of memory available [1], but, as shown in
> > [2], with this patch the memory consumption jumps up to about
> > 1.3-1.8GB for each of those jobs.  So with two parallel jobs we will
> > very likely bump into this limit.
> > 
> > So this patch should definitely change that build script to run only a
> > single job.
> 
> It should still be a net win, since the total CPU seems to drop by a
> factor of 3-4.

Well, that's true when you have unlimited resources... :)  or it's
true even then, when I have just enough resources, but not much
contention.  After all, Coccinelle doesn't have to parse the same
header files over and over again.  However, on Travis CI, where who
knows how many other build jobs are running next to our static
analysis, it doesn't seem to be the case.

On current master with an additional 'time' in front:

  time make --jobs=2 coccicheck
  <...>
  695.70user 50.27system 6:27.88elapsed 192%CPU (0avgtext+0avgdata 91448maxresident)k
  5976inputs+2536outputs (42major+18411888minor)pagefaults 0swaps

  https://travis-ci.org/szeder/git/jobs/437733874#L574

With this patch, but without -j2 to fit into 3GB:

  960.50user 22.59system 16:23.74elapsed 99%CPU (0avgtext+0avgdata 1606156maxresident)k
  5976inputs+1320outputs (26major+4548440minor)pagefaults 0swaps

  https://travis-ci.org/szeder/git/jobs/437734003#L575

Note that both the runtime and the CPU time increased. (and RSS, of
course)

> Are we OK with saying 1.3-1.8GB is necessary to run coccicheck? That
> doesn't feel like an exorbitant request for a developer-only tool these
> days, but I have noticed some people on the list tend to have lousier
> machines than I do. ;)
> 
> -Peff
