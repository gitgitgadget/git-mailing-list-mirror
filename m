From: David Aguilar <davvid@gmail.com>
Subject: Re: 'git am' doubt
Date: Wed, 23 Sep 2009 16:54:33 -0700
Message-ID: <20090923235433.GB80337@gmail.com>
References: <a4c8a6d00909231520s53be6654ibf74d4430e7e82f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 02:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqbn3-0006HQ-Q2
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 02:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZIXABx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 20:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbZIXABx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 20:01:53 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:64262 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbZIXABw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 20:01:52 -0400
Received: by qw-out-2122.google.com with SMTP id 5so446149qwd.37
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PpI+avRVfnYjJ+3qNCOiE+CoP4hzc42nsJ6YyHGn+0E=;
        b=IiXH72CKEg65WzEF5BJaoqDDoS8EdWvZ70LWO3ASpmsWweDb7Xmz1udpibSL4TvpcM
         zqeSR9ZNQ4u+YPd8swBetDPqSOw33q37+GYdYp/UI6kvcfqRRpEe4aIkPx4arhFrW0Hu
         hl8KlAfiGUt5GC1ll+QwCjKK8BYkrvq+bebYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hk5ICRvZQhsALtleMaeL+p4ju8AFFCURVsFQyuneJ2DjBu8BOfBekG3PoYpInolwij
         7qYlFVIwkyTybiYquB1tpLCvdh3OPdg85G1bLSGsLxs2BbxR/qriNzZqvyo2p23q42pt
         A0IjMqHwnRjke5ffqBAh5jh2PWIZJR5KZBjUY=
Received: by 10.224.39.144 with SMTP id g16mr2597449qae.260.1253750076711;
        Wed, 23 Sep 2009 16:54:36 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 4sm422120qwe.45.2009.09.23.16.54.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Sep 2009 16:54:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a4c8a6d00909231520s53be6654ibf74d4430e7e82f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129013>

On Wed, Sep 23, 2009 at 07:20:53PM -0300, Thiago Farina wrote:
> Hi,
> 
> I'm trying to apply a patch from the mailing list using 'git am'.
> 
> What I'm doing is:
> 
> - In gmail:
>  - Save original, then I copied the content to a text editor.
> - In text editor:
>  - Remove the first empty line.
>  - Save the file in the same directory where I have the git source.
> - In git directory:
>  - $ git am -s ./filename.mbox
> 
> Of course I'm doing something wrong here, but I don't know what.
> The error is:
> cat: /home/tfarina/git/.git/rebase-apply/next: No such file or directory
> previous rebase directory /home/tfarina/git/.git/rebase-apply still
> exists but mbox given.


Perhaps you tried this previously and 'git am' failed?
In which case, run 'git am --abort'.


Now.. I've _never_ had luck saving patches out of gmail.
But, I've had good luck with its imap interface.
I use mutt, save emails to an mbox file, and use 'git am'
on them.  This has worked great for me.

For sending emails to the list, I use msmtp and a
~/.gitconfig setting:


[sendemail]
        smtpserver = /usr/bin/msmtp


Then it's simply 'git send-email <patch-file>'.


Here's a random page explaining how to use mutt with gmail.
http://shreevatsa.wordpress.com/2007/07/31/using-gmail-with-mutt-the-minimal-way/

I can send you my .muttrc if that helps.

Here's the git wiki page about msmtp, gmail, and
git-send-email:

http://git-scm.org/gitwiki/GitTips#Usingmsmtptosendyourpatches

-- 

	David
