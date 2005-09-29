From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Edit log message after commit
Date: Wed, 28 Sep 2005 21:17:00 -0700
Message-ID: <12c511ca050928211769e4bf8e@mail.gmail.com>
References: <dhfjcu$36f$1@sea.gmane.org>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 06:19:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKpr6-0008Ec-F3
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVI2ERB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVI2ERB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:17:01 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:63172 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbVI2ERA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:17:00 -0400
Received: by zproxy.gmail.com with SMTP id 13so745328nzn
        for <git@vger.kernel.org>; Wed, 28 Sep 2005 21:17:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JbGJ7+4ucXaMnO3QjS7+FzmI2k+GSdlDOqKreOVK5ynFoHBCbp5qs9InL52Z3O51q2z9V77O+3aRjs7THULZkjauCSaA/niDdTCy/vsZijdFPgjnsQ1L0rrq4GVZTL2umSjuExJL0seuq7PLhm0iO4WHC4PUcz04WdzPaI8vzuQ=
Received: by 10.36.10.16 with SMTP id 16mr46189nzj;
        Wed, 28 Sep 2005 21:17:00 -0700 (PDT)
Received: by 10.36.58.18 with HTTP; Wed, 28 Sep 2005 21:17:00 -0700 (PDT)
To: Kevin Leung <hysoka@gmail.com>
In-Reply-To: <dhfjcu$36f$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9455>

> Is there any method to edit the log message after committed?
> I couldn't find any information in Documentation and in git mailing list.

No.  Once a git object is created it is immutable (since its name is the
hash of its contents).  If you realise right after you make a commit that
you want to change the message, you would have to redo it ... use
git diff or git whatchanged to get the details and the diffs, then use
git reset to backup, and re-apply.

If you have made subsequent commits, then you'll have to back those
out and redo them too.

If you have published your tree, then it's better to live with the 'bad'
commit than try to re-write history.

-Tony
