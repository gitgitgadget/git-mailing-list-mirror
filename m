X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn bug?
Date: Thu, 16 Nov 2006 07:32:07 -0800
Message-ID: <m2wt5v9zm0.fsf@ziti.local>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <m2psbocpbo.fsf@ziti.local>
	<20061115223709.GG24861@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 15:33:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=k9hVHGwapTO6BzZFns8SwF4wuN0QplMOP4N4K2+q5Hc7WS0eTn5gEk/+byQIz8Pvhny311VnYNXkJAx5i9c1Qo9UKwsr5t+uMCzAPzkGAF/vh02R6Hg81jOcQxVZgm2Zd2yG4ZFv0DudiUlInt8Ja2zQCp3j6vMrazbBCilVuS0=
In-Reply-To: <20061115223709.GG24861@spearce.org> (Shawn Pearce's message of "Wed, 15 Nov 2006 17:37:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31589>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkjDs-0005Jx-7K for gcvg-git@gmane.org; Thu, 16 Nov
 2006 16:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424165AbWKPPcN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 10:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424012AbWKPPcN
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 10:32:13 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:27923 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1424165AbWKPPcM
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 10:32:12 -0500
Received: by wr-out-0506.google.com with SMTP id i22so225762wra for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 07:32:11 -0800 (PST)
Received: by 10.65.237.1 with SMTP id o1mr492398qbr.1163691130495; Thu, 16
 Nov 2006 07:32:10 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 q19sm2876717qbq.2006.11.16.07.32.09; Thu, 16 Nov 2006 07:32:10 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:
> Seth Falcon <sethfalcon@gmail.com> wrote:
>> I always send commits as:
>> 
>> git-svn dcommit remotes/git-svn..master
>> 
>> Possibly replacing master with whatever git branch I'm working on.
>
> Or just:
>
>    git-svn dcommit remotes/git-svn..
>
> to send the current branch.

Yes, but be warned.  As I just discovered, dcommit always commits up
to the HEAD of the current branch.  So I just did:

git-svn dcommit remotes/git-svn..HEAD~3

And the ~3 was ignored.  :-(
Not a bug, as the doc says that dcommit operates on HEAD, but it would
be convenient to have this work -- especially since reviewing with
diff (or better log -p) seems natural.

