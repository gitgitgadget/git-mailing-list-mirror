X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Wed, 29 Nov 2006 07:58:40 -0800
Message-ID: <m2wt5es0r3.fsf@ziti.fhcrc.org>
References: <1164768702941-git-send-email-normalperson@yhbt.net>
	<11647687042130-git-send-email-normalperson@yhbt.net>
	<456D36CE.1060300@midwinter.com> <20061129085419.GB4486@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 15:58:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Nw3Yf+6sYChsKuYFZjSAeGKKBjX8Isd4nRZbNDpKJTFaxCaVwhiXxfv3vPE9zC+sY6+HzFEHQKMk5proowsL9Nr4jwwE1/qJjQGcfC80idpem1Gb3Ex1nXkG7Lax+NQlmIlMMs/2RhxQJZuA3aAwTmVbNV456BlMQ5VtlWtXbsI=
In-Reply-To: <20061129085419.GB4486@hand.yhbt.net> (Eric Wong's message of "Wed, 29 Nov 2006 00:54:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32646>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpRpU-0007rL-To for gcvg-git@gmane.org; Wed, 29 Nov
 2006 16:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935684AbWK2P6a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 10:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935774AbWK2P6a
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 10:58:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:57970 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935684AbWK2P6a
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 10:58:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1826485uga for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 07:58:28 -0800 (PST)
Received: by 10.78.183.15 with SMTP id g15mr2324974huf.1164815908429; Wed, 29
 Nov 2006 07:58:28 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id 39sm7985968hug.2006.11.29.07.58.26; Wed, 29 Nov 2006 07:58:27 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:
> I've been considering something along those lines.  I'm interested in
> renaming the current 'commit' command to something else (it still has
> its uses), but I haven't figured out what to call it...

I think this would be a sensible change and will help new users get
started with git-svn.  

> Also, something that can wrap (git commit && git svn dcommit) into one
> step would be nice.

For my workflow, that wouldn't be all that useful.  I find that I
accumulate a few commits locally and then send them all to svn.  For
this workflow, what would be useful is if dcommit could understand a
command like:

    git svn dcommit remotes/git-svn..HEAD~2

Sometimes I realize I should have sent a stack of commits to svn, but
now have some newer commits that aren't quite ready on the head of my
branch.  

While the workaround is easy (create a new branch and dcommit from
it), I think there is a usability argument in that when one
sees an example like dcommit foo..bar, one expects all
the other magic to work.  I feel for this and accidentally committed a
few commits I didn't want to send.  If nothing else, perhaps git-svn
could error out and say, "hey, I don't do that".

