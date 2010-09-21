From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Tue, 21 Sep 2010 16:35:26 -0700 (PDT)
Message-ID: <m3mxrak937.fsf@localhost.localdomain>
References: <1285080133451-5555023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 01:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyCN5-0002EZ-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 01:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab0IUXfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 19:35:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40351 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab0IUXf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 19:35:29 -0400
Received: by bwz11 with SMTP id 11so82195bwz.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zdFa7NgsJN/R85+evs0oxbbk0q+QPgjAGV334tlWR3w=;
        b=Ulit3k8VH/Yv3szCmTIPf/l9MUT5TBWmYHBU2lkrva8CyXVL9PS9Nfoxu0KLi4c3Yl
         WlRoPnptRLAN197wBygsTL8lgl2cYGrHhbE9XEnsgQ/NvGaYGVDNl7cMsUcDtDld07a2
         6LLCsUtyG68wk/AfId9ubPC/FTBrjJFo1AxSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HKecJds/lF//+B9ZotPGTiiGn96sbeh4decg4C/VY/DgjbO9HSAmHF7HbIzV+lwG18
         ehpi9tPhpwKSxecgAeOn/b54wkchAXpcBuRj5Ae/ulrPjCbxm5Syt75MJztaPRQg58DM
         9Dc33u6CIyjlKbxPry/4qzomjj/2zDCVCi2/o=
Received: by 10.204.118.65 with SMTP id u1mr8178269bkq.169.1285112128085;
        Tue, 21 Sep 2010 16:35:28 -0700 (PDT)
Received: from localhost.localdomain (abvk112.neoplus.adsl.tpnet.pl [83.8.208.112])
        by mx.google.com with ESMTPS id f10sm8068476bkl.17.2010.09.21.16.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 16:35:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8LMlZhZ032583;
	Wed, 22 Sep 2010 00:47:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8LMlPWD032576;
	Wed, 22 Sep 2010 00:47:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1285080133451-5555023.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156770>

FernandoBasso <FernandoBasso.br@gmail.com> writes:

> I am really a beginner in. Bear with me please.
> 
> Why do we merge, say a testing branch into the master branch ? What
> is the use of it ?

Short answer: to make it visible.  Usually only a specific set of
branches is published.

Long answer: the real question is why we should use topic branches.
The answer is to keep unfinished code separate and not visible untill
it is finished and ready to be shown.  

You create new [private] branch for developing a feature, 'testing' in
your example, develop code on it, and when code is ready you make it
visible by putting it on 'master' branch.  One of possibilities is to
merge 'testing' branch into 'master'.  Then people can use those
changes taking / fetching from a 'master' branch.
 
> When there is a conflict when merging branches (merging the testing
> into the current branch), should I edit the 'current' branch or the
> 'testing' branch ?

You edit files in your working directory.  You are on current
('master') branch, and you are creating state of the new [merge]
commit.

Edit files, add those files after resolving conflict, then run 'git
commit' which would notice that you were in conflicted merge and do
the right thing.

> 
> Should both branches have exactly the same code so that they can be
> merged without conflicts ?

No, if there is merge conflict you edit the files so they make sense,
incorporating your changes made on 'testing' branch with the changes
that were made on 'master' branch since branching point (merge base)
of 'testing' and 'master'.

Branches would merge without conflict if:

1. You did the changes on 'testing', while 'master' didn't move at all.
   This is so called "fast-forward" case and wouldn't even create merge
   conflict without --no-ff option.

2. Changes on 'testing' and on 'master' (since merge base) touch
   different files.  This is so called "trivial" merge (tree level
   merge to be more exact).

3. Changes on 'testing' and on 'master' touch different areas of
   files, so that textual 3-way merge succeeds.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
