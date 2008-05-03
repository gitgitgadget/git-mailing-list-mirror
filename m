From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Parent-less branches
Date: Fri, 02 May 2008 17:17:43 -0700 (PDT)
Message-ID: <m38wys6y1q.fsf@localhost.localdomain>
References: <20080502232008.GA20092@ulrik-ibook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pedro Melo <melo@simplicidade.org>
To: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 02:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js5SV-0005F7-PS
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 02:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630AbYECARr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759381AbYECARr
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 20:17:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:30222 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758474AbYECARq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 20:17:46 -0400
Received: by ug-out-1314.google.com with SMTP id h3so178760ugf.16
        for <git@vger.kernel.org>; Fri, 02 May 2008 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=KH7oLHyOQgo/C0hLu8o5WTLUH8py/oEv5uhzl0ujCLQ=;
        b=mdy2eEDJgHFhmM2e1OFhFwHB/5uait3ZUY2ZDyheQSV9c1Tu+9qLTbHtx0QjLp7OsVX4yEI61+yaS091SQAFP1Z1vOiTy+F+nFXUuPxMR7zT4DDudAhraN9wWc0YGPfb96um79ChEfpx7ebcxMCCdzBAmvR0K5rWnnO1NIM/fI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=JeCREP7whD9FXYG2VJ/QfiNhcP7BE+LY/Dp34MPsX0hCDdkfp8IT7gmC5dwDzrbE1QMuGuTEyIuag2daKiUBlTD2Ig/VS34YxnuRwPKJWvKz4QLTG2+crY9fzMV8OFLCPJtiObtHIjg04ixdT3nvM6Emmbai2eHQF3wvN4D/22o=
Received: by 10.67.196.2 with SMTP id y2mr642111ugp.60.1209773864351;
        Fri, 02 May 2008 17:17:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.103])
        by mx.google.com with ESMTPS id b30sm6066465ika.3.2008.05.02.17.17.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 17:17:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m430HdT8022995;
	Sat, 3 May 2008 02:17:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m430HbO7022992;
	Sat, 3 May 2008 02:17:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080502232008.GA20092@ulrik-ibook>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81051>

Ulrik Sverdrup <ulrik.sverdrup@gmail.com> writes:
> Wincent Colaiuta <win@wincent.com> writes:
>>
>> I wanted to do this just the other day, but I did it all inside the  
>> one repo, and made some notes on the process here:
>> 
>> http://rails.wincent.com/wiki/Creating_independent_branches_with_Git
>> 
>> Basically, using "git write-tree" and "git commit-tree" plumbing.
> 
> I think I've seen this done much simpler, in this blog post:
> 
> http://madduck.net/blog/2007.07.11:creating-a-git-branch-without-ancestry/

And it is mentioned in http://git.or.cz/gitwiki/BlogPosts, athough not
yet in either GitTips or GitFaq.


In short the solution is to create content-less branch using:

  $ git symbolic-ref HEAD refs/heads/newbranch
  $ rm .git/index
 
then commit.

> Even though your instructions seem more complicated than they are since
> they mix setting up the parentless branch and preparing the first
> commit content.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
