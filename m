From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Bug report: git status does not report unmerged entries with
 copies
Date: Thu, 7 Apr 2011 09:53:48 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1104070948310.25447@debian>
References: <BANLkTikWVgsX6yEY=d7kEcO5PLMTRwDU_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 15:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7peq-00036y-Tc
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 15:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab1DGNx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 09:53:56 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57524 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab1DGNxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 09:53:55 -0400
Received: by qyg14 with SMTP id 14so1772398qyg.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=nZiVBIZNtFJ2rtKjH3jpyuqNa/8jOijpCCeLg/pmAYQ=;
        b=g+dJbQNceDi4cBoImrcUZKX7PnN47jjlrwjaWFj3a2/H2LhT8W07N2/bsHOPxyJaH0
         cGgTEqjnCNxH5/NJEsrffkS8oirFQ8iWnCiQ2V1Wi5Jq4btoUiB/WEsxwhXuNNwP7AVR
         5rkmthDli+OIbXWbMFKV+lMMxFcis9dwvGoSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=PVi3RhcJ/kZzazFkJsyVR6rEEk+zJYIgZ2cYR1FqSGBxk1vYUXoKEg2S7brOMeohM5
         J9IuFeI9f/CwUV6a98bwuLwrdm9/UJ3B8sqO4L8RHhDE4faUs7d0usuS9ixlV0wwbD+a
         ZriQ+5M0cBfGvLkaN20wDnQr9OSffZT+m2F8s=
Received: by 10.229.188.14 with SMTP id cy14mr660301qcb.231.1302184433838;
        Thu, 07 Apr 2011 06:53:53 -0700 (PDT)
Received: from [192.168.1.102] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id m7sm1181760qcg.17.2011.04.07.06.53.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 06:53:52 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <BANLkTikWVgsX6yEY=d7kEcO5PLMTRwDU_A@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171061>


On Wed, 6 Apr 2011, Mark Lodato wrote:

> Commit 4d4d572, "status: show worktree status of conflicted paths
> separately" introduced the following bug:  If one tries to merge two
> branches with a conflict, where the conflicting file was also copied
> in one of the branches, "git status" (but not "git status -sb" or
> git-gui) fails to report the unmerged status.  You can use the below
> test file to see the error.  A similar test should probably be
> integrated into one of the existing git-status test files, though you
> may need to get rid of the "sed -i" command.
> 
> $ git status
> # On branch master
> # Changes to be committed:
> #
> #       renamed:    file -> copy
> #
> $ git status -sb
> ## master
> R  file -> copy
>  U file
> 
> In the above, "git status" should have reported "file" being in an
> unmerged state.  It probably should also mark "copy" as a copy, not a
> rename.

I sent a patch for this not so long ago [1]. It is currently in "next"
as commit d7c9bf2. I think Junio said the plan is to release it in
1.7.5.


/Martin

 [1] http://thread.gmane.org/gmane.comp.version-control.git/169289/focus=169887
