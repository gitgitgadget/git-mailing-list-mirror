From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Q] Changing the current branch (HEAD) in a bare repository - how?
Date: Fri, 06 Jun 2008 09:03:03 -0700 (PDT)
Message-ID: <m3k5h2y2iz.fsf@localhost.localdomain>
References: <a537dd660806060843p4e92932x4e0f5464c5fd1da1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Brian Foster" <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4eQ8-0005b6-2J
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 18:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbYFFQDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 12:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbYFFQDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 12:03:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:62372 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYFFQDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 12:03:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so712666fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 09:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Lesq50o8CmRm0fOWrD5eHWCEf+nR4YYOIplAKGY2SFU=;
        b=A0uuE+sGeBqfiO6W97JId6B+3jDVm4HQkJ2Xj7X0DHsjDATVA0D5bi3jlPDkZrmy0V
         13aERYRQxujUpVp+dffIWVOaPaLX8CNoQeUN4VAUsjNThIbwBTb+lxUkAw76c0A8q5MP
         r9X3sRgrhy+wltbP5H8ytviwf6byDsAVquJBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=vr/XmrTw6mylq5kD16Z9Yc6h4eUKoaeAdjb6/3yGGdfoa+qG6l0tf6gW/gU/UPQXlC
         SQ//BeDymlcB/7WZh1E5SPQhCTc3Dy+5Wbz24rfOw0Ycp7QLTXDzekZ7nsXyEBKEqfj8
         Fkb7Mkpa1G3D9CagRpJhI5YnxquH1FN1fRuyk=
Received: by 10.86.100.19 with SMTP id x19mr570763fgb.34.1212768185367;
        Fri, 06 Jun 2008 09:03:05 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.141])
        by mx.google.com with ESMTPS id l12sm5802660fgb.6.2008.06.06.09.03.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 09:03:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m56G32GS027791;
	Fri, 6 Jun 2008 18:03:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m56G317W027788;
	Fri, 6 Jun 2008 18:03:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a537dd660806060843p4e92932x4e0f5464c5fd1da1@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84085>

"Brian Foster" <brian.foster@innova-card.com> writes:

>  Using git 1.5.2.5 (Kubuntu 7.10) and a bare repository,
>  I started with (the commands and output below are typed
>  in by hand, mostly from memory):
> 
>     $ git branch -a
>     * master
>       foo
>     $
> 
>  and then changed the branch names:
> 
>     $ git branch -m master old-master
>     $ git branch -m foo master
> 
>  and got this:
> 
>     $ git branch -a
>       master
>     * old-master
>     $
> 
>  Now, how do I change the current branch to the (new)
>  `master'?  A `checkout' fails:
> 
>     $ git checkout master
>     fatal: /usr/bin/git-checkout cannot be used without a working tree.
>     $

In a bare repository it doesn't matter (almost) which branch is
current one (there is no _checked out_ branch, so it only matters as a
default checked out branch for clone, IIRC).
 
>  I (ultimately) hand-edited `HEAD' (apparently successfully),
>  but am wondering what I should have done or may have missed?

You have to rely on plumbing:

  $ git symbolic-ref HEAD master

(see documentation for details).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
