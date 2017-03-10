Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D9B1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbdCJU0V (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:26:21 -0500
Received: from imap.thunk.org ([74.207.234.97]:45852 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753292AbdCJU0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=C3mMRpAiQiiaSKZex58G6E2au/ksyc631UPecnx919E=;
        b=RMgFPnNRA2sLH7srliyJ2pV0ps85WMfZYCFp4nTf5KoUKFrsJoZP3hrD73e+FCCQvLMn39dMGGyhjofDnBEShyu0qBPYGFWQ2qcutzTRoua6Zk/sjcOCmm3TrjqcNafIfStvc3/zJcJ3QCZrdVtoELcTyPO+2kMhR162kurnj0U=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1cmR78-0004Xm-QL; Fri, 10 Mar 2017 20:26:14 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C727C00495; Fri, 10 Mar 2017 15:26:09 -0500 (EST)
Date:   Fri, 10 Mar 2017 15:26:09 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org
Subject: Re: Stable GnuPG interface, git should use GPGME
Message-ID: <20170310202609.cegd6jak6cklq6my@thunk.org>
References: <201703101100.15214.bernhard.reiter@intevation.de>
 <CA+55aFxk7F103LADnmwc8wFySYQNiK6TcCQ0WSj+UTP-GihgcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxk7F103LADnmwc8wFySYQNiK6TcCQ0WSj+UTP-GihgcQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 10:54:19AM -0800, Linus Torvalds wrote:
>  - library versioning.
> 
>    I don't know why, but I've never *ever* met a library developer who
> realized that libraries were all about stable API's, and the library
> users don't want to fight different versions.

Actually, you have.  (Raises hand :-)

libext2fs has a stable API *and* ABI.  We add new functions instead of
changing function parameters (so ext2fs_block_iterate2() is
implemented in terms of ext2fs_block_iterate3(), and so on).  And
structures have magic numbers that have served as versioning signal.
This is actually not rocket science.  If you've met anyone who's
programmed for Multics, they did something similar.  And of course,
that's why we have the wait3(2) and wait(4) system calls.

I do have to agree with your general point, that most developers tend
to be *incredibly* sloppy with their interfaces.  That being said, not
all library developers are as bad as GNOME.  :-)

    	    	       	      	     - Ted
