From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commit to wrong branch. How to fix?
Date: Fri, 04 Sep 2009 11:51:48 -0700 (PDT)
Message-ID: <m33a72lf0h.fsf@localhost.localdomain>
References: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
	<4AA13DF4.4050604@drmicha.warpmail.net>
	<26ae428a0909041103p4ecba8efvff6223f902e14f1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Howard Miller <howardsmiller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:52:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjdtN-0002YU-Kf
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbZIDSvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 14:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbZIDSvs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:51:48 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:49286 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217AbZIDSvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:51:48 -0400
Received: by fxm17 with SMTP id 17so875656fxm.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wmLsgd8xTEr73UI1ViIr+SCHMH21uWk+bjAG/Z/T4Vg=;
        b=iZvgnXWJIl/bXqPb7771shN8foMrBTkIuFxUBNWqfYWLb1j68Td0ahdxb3N0EHr3hs
         V1zKE04oxZ9L40zBzIzk8ty41ANlfQf/4Lx7MOZiLq2jquDivx05iAi8kCP/9UeC0/H8
         mIjfzUujApP7E7+RNm4TyL4ePncktflCORMm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kE8AZKyAjisv+OhogtOAfV+zMQ+3XCk3KcQMtt4RQhXvHzHUxUZUz7SmwYtHILi8Bi
         wEAfWcVwTfkJ37Huk5UZEwTpfn1TryCPAc64LSKXLOxQrzNa6CokAMl1yd45t0Ujr39C
         0n9tSYJw10nNgvqUWOLOOGItn9WVzGWXR3my4=
Received: by 10.86.227.1 with SMTP id z1mr5288734fgg.56.1252090309224;
        Fri, 04 Sep 2009 11:51:49 -0700 (PDT)
Received: from localhost.localdomain (abvd31.neoplus.adsl.tpnet.pl [83.8.201.31])
        by mx.google.com with ESMTPS id l19sm2230549fgb.16.2009.09.04.11.51.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 11:51:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n84IpkVm010218;
	Fri, 4 Sep 2009 20:51:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n84IphG3010215;
	Fri, 4 Sep 2009 20:51:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <26ae428a0909041103p4ecba8efvff6223f902e14f1a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127758>

Howard Miller <howardsmiller@googlemail.com> writes:

> I must admit I don't understand what 'reflog' is (more reading) - not heard
> of that before.

I'll try to explain it with some ASCII-art.

Let's say that you had the following situation:

  ...---A---B---C           <-- foo  <--- HEAD

Current branch is named 'foo', and three last commits on it are named
A, B, C.

Now you create new commit (I assume that you comitted unwanted
changes; the recipe would be different (much simpler) if you have
realized that you are on wrong branch[1] before committing)

[1] git aware shell prompt, countaing branch name, could help there

  ...---A---B---C---X           <-- foo  <--- HEAD

Reflog records that commit in 'foo' reflog and in HEAD reflog

  foo@{0}: X


You have realized that you are on wrong branch, and you did 
"git reset --hard HEAD^" (too early)

  ...---A---B---C               <-- foo  <--- HEAD
                 \
                  \-X

Reflog records that fact (it records where tip of branch was)

  foo@{0}: C
  foo@{1}: X


Then if you want to create new branch 'bar' with X, you would do

 $ git checkout -b bar foo@{1}

If you wanted to have this commit on some other existing branch, let's
call it 'baz', you would do instead (I think):

 $ git checkout baz
 $ git cherry-pick foo@{1}

HTH (hope that helps).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
