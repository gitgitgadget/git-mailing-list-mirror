X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Trouble with git-svn when upstream svn URL changed
Date: Fri, 08 Dec 2006 10:34:30 -0800
Message-ID: <m2wt52fd8p.fsf@ziti.local>
References: <m21wnai8qe.fsf@ziti.local> <20061208181109.GA10475@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 18:34:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=rWkCyt+/3k4tvPDS82UAO8yMbNkkB+4IrUQyLk03iyDRYnOn7RbRwDzjR2+xvcjKwr5zo1fjS5VBLQvy1OxexxMNqVbK+pTUq31TdXeuradguJZvhr+6jux//0inhJY2WZZZBk5aJ4s6NYoxSELX1gkbwLREVrh593QUgPu6pIQ=
In-Reply-To: <20061208181109.GA10475@localdomain> (Eric Wong's message of "Fri, 8 Dec 2006 10:11:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33718>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GskYO-0001mq-NS for gcvg-git@gmane.org; Fri, 08 Dec
 2006 19:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760824AbWLHSee (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 13:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760827AbWLHSed
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 13:34:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:5837 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760824AbWLHSed (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 13:34:33 -0500
Received: by wx-out-0506.google.com with SMTP id h27so886022wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 10:34:32 -0800 (PST)
Received: by 10.90.71.12 with SMTP id t12mr4551315aga.1165602872184; Fri, 08
 Dec 2006 10:34:32 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 38sm5412537wrl.2006.12.08.10.34.30; Fri, 08 Dec 2006 10:34:31 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:
> This is incorrect, rebuild is not designed to handle new urls.  

ok, I was lead astray by this part of the doc for rebuild:

         A Subversion URL may be optionally specified at the
         command-line if the directory/repository you're tracking has
         moved or changed protocols.

> However, git/git-svn are very flexible beasts :)
>
>> I guess I can create a fresh git repos using git-svn init and then
>> fetch all of my dev branches from the original repository.
>
> You can look at "Advanced Example: Tracking a Reorganized Repository"
> in the manpage.  Ignore the text about --follow-parent since you
> already have the old stuff fetched, and start following the instructions
> beginning with "# And now, we continue tracking the new revisions:"

Oh, sorry I didn't find that example.  This worked perfectly, thanks!

One question: My fingers are in the habit of typing remotes/git-svn.
Can I do:
   cd .git/svn
   rm -r git-svn
   mv git-newsvn git-svn

Or is there a safer way to rename?  Or are there other config-file
ways to make this work -- to provide an alias?

Thank you so much for the prompt reply.  Nice to get going again and
with the full history.

