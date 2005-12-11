From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Latest cogito broken with bash-3.1
Date: Sun, 11 Dec 2005 09:31:07 +0100
Message-ID: <1134289867.9541.9.camel@blade>
References: <1134220724.15125.4.camel@blade>
	 <20051211001106.GV22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 09:34:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElMc0-0001sf-PS
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 09:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVLKIbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 03:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVLKIbM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 03:31:12 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:20381 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751341AbVLKIbL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 03:31:11 -0500
Received: from blade (p5487D91F.dip.t-dialin.net [84.135.217.31])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3) with ESMTP id jBB8Vg9U027844
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Sun, 11 Dec 2005 09:31:42 +0100
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051211001106.GV22159@pasky.or.cz>
X-Mailer: Evolution 2.5.2 
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_96_XX 
	autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on coyote.holtmann.net
X-Virus-Scanned: ClamAV 0.84/1207/Fri Dec  9 23:01:12 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13491>

Hi Petr,

> > The cogito is the latest from kernel.org and when calling cg-commit it
> > fails with this message:
> > 
> > cg-commit: line 200: syntax error near unexpected token `('
> > cg-commit: line 200: `       eval commitfiles=($(cat $filter | path_xargs git-diff-index -r -m HEAD -- | \'
> > 
> > I played a little bit with it and it seems all the eval statements are
> > broken with this bash version. I have no clue how to fix this, but maybe
> > you do.
> 
>   it seems like the newer bash is stricter than the older versions in
> some obscure regards. Quoting the eval arguments (which is the proper
> thing to do anyway) fixed that particular problem; I've hit another
> problem during a test commit wrt. whitespace separators - I've fixed
> that too, and pushed out.

it's now working again. Thanks. What do you think about another release?
I haven't checked the other distributions yet, but I just saw that
Debian unstable also moved to version 3.1 of bash.

There exists also another problem with the new bash. It is the broken
pipe error from cg-log.

cg-log: line 141: echo: write error: Broken pipe

The line number varies depending how much you scrolled and when you
scrolled to the end no broken pipe error comes up. Do you have any idea
on how to deal with this. I saw your comment about that bash is broken
and the extra trap command, but it doesn't help. I never saw that
problem with older versions of bash.

Regards

Marcel
