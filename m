From: "Matt Pearson" <404emailnotfound@gmail.com>
Subject: Re: Filtering mode changes
Date: Fri, 1 Aug 2008 08:23:07 -0400
Message-ID: <706b4240808010523y33694ebfjad772ef26e015cbb@mail.gmail.com>
References: <loom.20080801T111754-982@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stefan Naewe" <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 14:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOtg4-0002MP-AU
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 14:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbYHAMXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbYHAMXJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 08:23:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:3762 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYHAMXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 08:23:08 -0400
Received: by yw-out-2324.google.com with SMTP id 9so594175ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iJR2JvvuPuPRiAPPeM1vaxnZXrF+ChY8aKXHX5E29xI=;
        b=LdJQkJa+ymoIC4QtEc6zCxI4FCd0kkTWMjVtl8hWmCUIbrZx/rVmW/J095XrMnv8Pw
         D5yyPcUNdOVx46qF7SgNARlEt1ypy1di0UfBcHR5qmoIXD6ojrGy1zvyWYgBXYFt8X2r
         JPIJUWrtUUcQc/kamb0WsKC1+IBnuMQgK+RY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ri8E0Jv0kcy9+90Uw1GuuqIBYvI1Z1uWTJYPFuhwiOLrznBgH3Zndv9JE116rD9pJS
         yqxBYTSPDhFiHbdJl6R58m6+Rpz1bHQQk8F15KUmL4jFeKXtRLceWpJwWkoSB7lSmhn6
         K8fo3M+m7D2MUF3bTyTMnXIM2FQWyv1dv2Mmo=
Received: by 10.151.47.7 with SMTP id z7mr3153848ybj.111.1217593387262;
        Fri, 01 Aug 2008 05:23:07 -0700 (PDT)
Received: by 10.150.52.8 with HTTP; Fri, 1 Aug 2008 05:23:07 -0700 (PDT)
In-Reply-To: <loom.20080801T111754-982@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91062>

On Fri, Aug 1, 2008 at 7:25 AM, Stefan Naewe <stefan.naewe+git@gmail.com> wrote:
> Hi there.
>
> Here's my story:
>
> - I did some minor modifications to a repo that I want to 'give back'.
> - I worked on my own branch (of course).
> - I was stupid to edit the files (that live on a linux box) through a windows
>  network share.
> - When I created diffs (using 'git format-patch') to send send 'upstream', I
>  noticed that the edited files got their executable bit set (old mode 100644 ->
>  new mode 100755)
> - I created another commit to undo the mode changes.
>
> My question:
>
> Is there a way to create clean diffs (between master and my branch) that don't
> contain the 'double mode change' (from 644 to 755 to 644) ?
>

You probably want to use 'git rebase -i master' and the 'squash'
command to combine the changes into one. If multiple commits messed up
the permissions, use the 'edit' command and the rebase will stop after
the specified commits, allowing you to fix things up, then do 'git
commit --amend'. Use 'git rebase --continue' to continue fixing the
patches.
