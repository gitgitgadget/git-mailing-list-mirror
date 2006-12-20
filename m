X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 19:05:09 -0800
Message-ID: <m2zm9j6zdm.fsf@ziti.local>
References: <m2mz5jegka.fsf@ziti.local> <20061219220900.GA3148@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 03:05:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=h1JdLq3MyRBhNlM2elmJE7adPXtiGYJG6gf8usDNI7Oyn8IpJdkiqRKFARgXubiKA8YD/i1rQ+RdUFOXbxQDIacJ0+hzSBWyuqa0kK2ZY6Y5iXYsrnR8zRDftqtZhn9eigIM87++FPyqQlla81ZJIadSXVGvxRR8s9zJyW7PSXY=
In-Reply-To: <20061219220900.GA3148@localdomain> (Eric Wong's message of "Tue, 19 Dec 2006 14:09:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34903>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwrm0-00051b-Uo for gcvg-git@gmane.org; Wed, 20 Dec
 2006 04:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964827AbWLTDF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 22:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWLTDF2
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 22:05:28 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:4687 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964827AbWLTDF1 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 22:05:27 -0500
Received: by nz-out-0506.google.com with SMTP id s1so807906nze for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 19:05:27 -0800 (PST)
Received: by 10.65.159.2 with SMTP id l2mr8513013qbo.1166583926910; Tue, 19
 Dec 2006 19:05:26 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 c5sm9404429qbc.2006.12.19.19.05.25; Tue, 19 Dec 2006 19:05:26 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:
> Huh?  safe_qx should've croaked or died, causing git-svn to exit before
> it could do any damage (via git-reset or git-rebase).  dcommit is not
> called inside any eval blocks, either...

*shrug* weird.  Looking at the code, I don't see how I could have seen
what I think I did.  Reproducing the error in a sandbox doesn't show
the git-reset behavior.  So unless I can reproduce it, I must have
done something else funny.  Sorry for the noise.

> Before, the 'remotes/git-svn..HEAD' argument meant absolutely nothing to
> dcommit (it silently ignored it).  Nowadays, you only need 'HEAD~2', the
> 'remotes/git-svn..' is already implied.
>
> 	git-svn dcommit HEAD~2

That's convenient in that it requires less typing.  I will try to
retrain my fingers.  I'm in the habit of reviewing the commits not in
svn with:

  git log remotes/git-svn..HEAD

And then editing the command like to be 'svn dcommit' instead of log.

Cheers,

+ seth
