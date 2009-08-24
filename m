Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 7194 invoked by uid 107); 24 Aug 2009 10:23:08 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 06:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbZHXKWt (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 06:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZHXKWt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 06:22:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:1356 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZHXKWs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 06:22:48 -0400
Received: by rv-out-0506.google.com with SMTP id f6so691263rvb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 03:22:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QaxWLcTA/oMKFY20W2OOVFayWzil4Nuv7XJT3F8CE14=;
        b=oJWtcqcBcP/IVnbt3TfWwNv9atkLhdqB0sjAMr0M+ZQedF81EWuEFoTSN5DPgpX9jA
         vbb3AJOKA74JO4DxjavjeQShB3rem+up5xsLGyKEQY2xNbfiqoJqn/HbMcxSTKLpsXcq
         8e0fCY4GfnnmYKrIVXVQBfRfFVBmZfhlNN3nY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dgZaos1rP5W+n0IsTvtNNjPnSOgU/E1TESoCU0kXKk5Y4ZxGHF7vEKAk4Y39u6v9da
         pQKunSP+63BiNC2d9MPOH2gXA2OusK8qlmKKKDAJEDTK3Ov3v23E2GV/hRwM0pyEI+yk
         9I/ScMjEFg3T6FfolIN8JRTIQ5vDf9d+lcokM=
Received: by 10.141.3.4 with SMTP id f4mr2079117rvi.163.1251109370786;
        Mon, 24 Aug 2009 03:22:50 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g22sm12387523rvb.0.2009.08.24.03.22.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 03:22:49 -0700 (PDT)
Date:	Mon, 24 Aug 2009 03:22:43 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Cc:	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
Subject: Re: Pulling one commit at a time.
Message-ID: <20090824102242.GA70861@gmail.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com> <4A9172D0.6030507@microchip.com> <20090824060710.6117@nanako3.lavabit.com> <4A92318F.6050105@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A92318F.6050105@microchip.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 24, 2009 at 11:52:07AM +0530, Sanjiv Gupta wrote:
> Excellent description. Thanks for that. I want to merge commits one by  
> one because I want to run a regression suite on each commit and  
> therefore know if any one is causing failures.

'git bisect' is your friend.

If your developers are disciplined and test each change as they
commit it then you're going to have fewer problems.

If they aren't, then make 'em send you patches.  Then you can
at least 'git am' each one and run the tests at each step,
including the critical steps where you merge various topics
together.

I'm not sure what exactly you're trying to accomplish, though.
I'm just making guesses without you telling us more.

Are you trying to do post-mortem change-that-introduced-bug
finding (git bisect), commit-time bug prevention
(patch-based workflows, using git commit hooks to disallow
commits that fail the tests, etc), or is it something
completely different?


HTH,

-- 
		David
