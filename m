Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD84F1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbcK3Xmw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:42:52 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33810 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbcK3Xmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:42:51 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so41773789pfb.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iaacjKRBP3+HGfYIp4P+FRuWvFIv5yat1zEIpp1GUKc=;
        b=VKzQYSHp4yHQfToFKqDNgYx6vX9nfDGdjSVqqlXJto9SS6uY59qj55lB+/m4o7GTSX
         XMDUbwSsp6+1t5w7gdCQHR9EtDt1cX0qGkVg/bYJt6PL1JGY+iFUYNriFv3dcDekXtdO
         rdcnZ5eWWSvry3uCrR7FhBK63gv/4J2rhqz4guvTszEQvWaTco1mGiEL7v1KPywo913D
         M2iaHJ3T/rI3943JnIkDq2g0WXt4Di1JE1ayIR9X3ljYIebmSm6UOEpHLE3V7089JVfJ
         +gbi/P1RItBGrSpzcu0kGHQ3lHuHDcUlwPYkDiMHiV2+GxtOF3lhELVIiuxgemqfU316
         +inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iaacjKRBP3+HGfYIp4P+FRuWvFIv5yat1zEIpp1GUKc=;
        b=mOA9gS6LgQ07osPo7QctuP2MjZ630K1QR+4ObVfmSDKsH/zITMVtFp1xZem+Uo07Ho
         fBFQUViU3chd1axibFJ8yFQCJQSOligKDsVN67NpEEJ09nhvHzYsHFXNFR37Fyg3gjwC
         97JLa5n5k2cwLOAY75VStI33ft7QMAIV7wdLGpgRuCq+xIGZHtv2mpa/rDSr1okwHKtx
         uZ4ajFmo7Ab+g6g03BjTb2stdSv7p9lJwKHb5SG843ZDNeoQqeIb/wSNWuhB/AJaGTtA
         4wTUPkfH+9TLwGpbOY78UpKfvSt1Z+fj9tseaoOTKpiqwEqK4LbFn6mDojdWHGHmacER
         /gFw==
X-Gm-Message-State: AKaTC03LrJuCUOgAQRJNv/KuQnbJWJz9kFYPA+gq0fdpMJpHcexxA5mVoG0+Y8QSlgqJPvgi
X-Received: by 10.99.56.19 with SMTP id f19mr64950660pga.72.1480549370992;
        Wed, 30 Nov 2016 15:42:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id r88sm105323275pfe.93.2016.11.30.15.42.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 15:42:49 -0800 (PST)
Date:   Wed, 30 Nov 2016 15:42:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130234248.GB192901@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Jeff King wrote:
> On Wed, Nov 30, 2016 at 06:32:04PM -0500, Jeff King wrote:
> 
> > On Wed, Nov 30, 2016 at 03:28:23PM -0800, Brandon Williams wrote:
> > 
> > > So I couldn't find a race condition in the code.  I tracked the problem
> > > to grep_source_load_file which attempts to run lstat on the file so that
> > > it can read it into a buffer.  The lstat call fails with ENOENT (which
> > > conveniently is skipped by the if statement which calls error_errno).  So
> > > for some reason the file cannot be found and read into memory resulting
> > > in nothing being grep'ed for that particular file (since the buffer is
> > > NULL).
> > 
> > That's definitely weird. Is it possible that any of the underlying calls
> > from another thread are using chdir()? I think realpath() make do that
> > behind the scenes, and there may be others.
> > 
> > A full strace from a failing case would be interesting reading. In
> > theory we should be able to get that by running the stress script for
> > long enough. :)
> 
> Actually, it failed pretty much immediately. I guess the extra stracing
> changes the timing to make the problem _more_ likely.
> 
> And indeed, I see:
> 
> 20867 lstat("fi:le",  <unfinished ...>
> 20813 <... read resumed> "", 232)       = 0
> 20871 futex(0x558cdec8b164, FUTEX_WAIT_PRIVATE, 7, NULL <unfinished ...>
> 20813 close(7 <unfinished ...>
> 20870 <... futex resumed> )             = 0
> 20869 lstat(".gitmodules",  <unfinished ...>
> 20813 <... close resumed> )             = 0
> 20865 set_robust_list(0x7f1df92579e0, 24 <unfinished ...>
> 20813 lstat("su:b/../.git/modules/su:b/commondir", 0x7ffecc8b3ac0) = -1 ENOENT (No such file or directory)
> 20865 <... set_robust_list resumed> )   = 0
> 20868 set_robust_list(0x7f1df7a549e0, 24 <unfinished ...>
> 20813 access("su:b/../.git/modules/su:b/objects", X_OK) = 0
> 20813 access("su:b/../.git/modules/su:b/refs", X_OK) = 0
> 20813 stat("su:b/../.git/modules/su:b", {st_mode=S_IFDIR|0755, st_size=280, ...}) = 0
> 20813 getcwd("/var/ram/git-stress/root-4/trash directory.t7814-grep-recurse-submodules/parent", 129) = 80
> 20869 <... lstat resumed> {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
> 20813 chdir("su:b/../.git/modules/su:b") = 0
> 20869 open(".gitmodules", O_RDONLY <unfinished ...>
> 20813 getcwd( <unfinished ...>
> 20867 <... lstat resumed> 0x7f1df8254cf0) = -1 ENOENT (No such file or directory)
> 
> where 20813 and 20867 are two threads of the main process. One is doing
> the lstat and the other calls chdir at the same moment.
> 
> -Peff

Yeah so it looks like the start_command function calls chdir.  Which
means any uses of the run-command interface are not thread safe....

For now the work around could be to just pass "-C <dir>" to the child
process instead of relying on run-command to chdir.

-- 
Brandon Williams
