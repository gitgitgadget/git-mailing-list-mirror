From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Sun, 19 Jun 2011 20:12:45 -0500
Message-ID: <20110620011245.GA25836@elie>
References: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Foley <pefoley2@verizon.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 03:13:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYT2z-0004Sr-Dq
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 03:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab1FTBM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 21:12:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58617 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab1FTBM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 21:12:56 -0400
Received: by iwn6 with SMTP id 6so785145iwn.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 18:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=r5kFlYCauDWjfmHbYmuG3eTGXMGBB/qPB37ZnbfPx+o=;
        b=AKYMZFO6hpu0DksgMFxRBKQsfB1KmgrXWi3t7x3TOoDoruqkMgCuMsf6Wr6scnkjpE
         ejCi7EYW73hqpkxt1Aw9lYaNzaxdPKXlXgzWmrZNJ1vq1vmnXiJjzX9fIO9UHgH2UZVX
         9Ipr0y610w3x3dHID60xaRvPapftqhW32w9Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qym52yqRP4g7d4flBUJLt4pHv49HYLWwHMzMoI7Oa6WGWeJNRjZCQAMd4U6CaqK2hb
         Nsp76u8UFseAj5vc1mGQO5FmGbOy5+7zhzhf5gsSh55hRTjLOXTo6S5jQQw2pQzetbx1
         RzVsn3RetOJQfE7n4p+3Ag/5CJT3ayctfwhQ8=
Received: by 10.42.150.9 with SMTP id y9mr2405105icv.350.1308532375236;
        Sun, 19 Jun 2011 18:12:55 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id hp8sm5013714icc.23.2011.06.19.18.12.52
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 18:12:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176044>

Hi,

Peter Foley wrote:

> This patch tries to organize the git source tree by moving the files which 
> make up libgit.a to a lib subdirectory.
> Before this patch the toplevel source directory contained 285 files. 
> After this patch the root directory will contain 167 files and 
> the lib subdirectory will contain 119 files
>
> Signed-off-by: Peter Foley <pefoley2@verizon.net>
> ---
>  Makefile                                     |  258 +++++++++++++-------------
>  abspath.c => lib/abspath.c                   |    0
>  advice.c => lib/advice.c                     |    0
[...]
>  zlib.c => lib/zlib.c                         |    0

Thanks for a reminder.  I had some vague hope that some "log --follow"
improvements[0] would arrive to make commands like "git log --follow
lib/branch.c" less painful, but that doesn't seem to be happening.
It's probably best not to wait forever.

As for the patch itself: my main thought is that I prefer to see
"branch.c" and "branch.h" in the same directory.  Aside from that, I
like it.  See [1] for some related discussion.

Regards,
Jonathan

[0] https://git.wiki.kernel.org/index.php/SoC2011Ideas#Better_git_log_--follow_support
[1] http://thread.gmane.org/gmane.comp.version-control.git/166424/focus=167154
