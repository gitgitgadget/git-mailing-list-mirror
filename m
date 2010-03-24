From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Picking up multiple cherries at one go.
Date: Wed, 24 Mar 2010 10:21:29 +0100
Message-ID: <81b0412b1003240221o53196568r9c8f2e0b7a2f1fd7@mail.gmail.com>
References: <ffef8f9a1003240147o777d058jfacd79aa86908925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jozef Babjak <jozef.babjak@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 10:21:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuMmR-0006YH-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 10:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab0CXJVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 05:21:34 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:56861 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab0CXJVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 05:21:33 -0400
Received: by bwz1 with SMTP id 1so2657140bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=pIfum5MHkmPW9mCSawBVeBOcMMOS99HE1QfRtFIWvaE=;
        b=N31O7I1YVkbFugiEaOoa1IacgBJnv0Oue2aQPRAuPAbvhcotngIw1uDCNU/BZAebst
         h9IZLFe1Dy8QAVTL2T+EKCWPHyofuh+hVMiaoTrfwbg/UcHJvPNJynAa5cr5a2gBtcQC
         pD5TDDW53YJ2rLexy3hvl0m2JCzdLQ8ThvgeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=u+cg6IRTBTwsa8oSCME3MknLAwRejBgNKZegpxEIdEAWJxFZ5CAF7eftQ4XwLthkZL
         63KQJ2sxauo3s+LUYK/L9ESA+A8xnzlnZCVV41IvOEu9anX5W5cftZ0OovwcXXlQWS8H
         hmq8wpvuOm7CAAfH6ahMPWfN+7KJlmTP30IEU=
Received: by 10.204.161.208 with SMTP id s16mr6030200bkx.187.1269422490110; 
	Wed, 24 Mar 2010 02:21:30 -0700 (PDT)
In-Reply-To: <ffef8f9a1003240147o777d058jfacd79aa86908925@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143077>

On Wed, Mar 24, 2010 at 09:47, Jozef Babjak <jozef.babjak@gmail.com> wrote:
> However, last days I needed to split a long multi-purpose branch into
> several topic branches. The branch was created as a result of 'general
> cleanup and refactoring', but at the end of day I realized that some
> well-defined parts can be identified there and so I wanted to extract
> them to dedicated branches. Thus, cherry-pick and rebase were my
> friend for couple of days. Everything goes well, but there was a
> repetitive task - cherry picking multiple commits. Sometimes the
> process failed, because cherry picking led to conflicts. ...

Try git rebase -i (interactive) next time. It does not exactly what your
script does, but ... You may like it.

> To simplify this task, I wrote the shell script attached at the end of this
> email.The script named git_cherries.sh reads commit IDs from stdin and
> cherry-picks those commits to current branch. Everything is done on an
> auxilliary branch, ...

You can commit without a branch (called "detached HEAD").
Try "git checkout HEAD^0", for example.
No need to invent new branch names (and risk collisions).
