From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: connecting existing local git repository to svn
Date: Tue, 27 Jan 2009 13:16:33 +0100
Message-ID: <bd6139dc0901270416u22b60fefp472935470b1db929@mail.gmail.com>
References: <497E8927.1060506@gmail.com>
	 <497EE386.5050805@drmicha.warpmail.net> <497EE4E8.8070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRmtD-0006TM-RX
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 13:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbZA0MQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 07:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZA0MQf
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 07:16:35 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:28495 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZA0MQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 07:16:34 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2750849yxm.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 04:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=ekZEiSnbh3UmSoqdidiR0ek60pAxhtbQSJUUp5nnvyg=;
        b=K1Ud4/FnQkQ9I5RZ+piXfuGg7huYrK0xMGyI0gsKpZFQVqGJsUj6Ju9haSS4SfxZYW
         suzV2FqYnPb8+V8QVt3copumlO7Dwf6Z9uvOyJou8JLnrx70mFTRko3XFX9iPxqtw6Ew
         eTkCHuOwy62QBMLFeTbJurpXuUGOEJaGnaYPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bttv0R4ZObC0bV1lquwHmdMATVfzgeXGwUuWu4SjnIZbgqdLPyp7VB6Myezetdsa/j
         b+wot6pTc4FVcC/p+7BZnf4EgcsPye+EvjInTEMaKEJQb5r9dweiPFasMLWY2e/WeEj3
         QF3GUtre1Pal15wGGa2NID8Cv+W5+9uU7yEiY=
Received: by 10.150.149.19 with SMTP id w19mr27796ybd.176.1233058593196; Tue, 
	27 Jan 2009 04:16:33 -0800 (PST)
In-Reply-To: <497EE4E8.8070705@gmail.com>
X-Google-Sender-Auth: 72fc03b8c2c7e41a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107337>

On Tue, Jan 27, 2009 at 11:41, Ittay Dror <ittay.dror@gmail.com> wrote:
> git: ----v1----v2----v3--v4---v5
> svn:                     \---v4--v5
>
> so the svn history starts from v3, but the git history remains unchanged.

Create the new branch from v3 then, and use git svn to pull it in.
Then you can do 'git rebase that-svn-branch' on your git branch to put
all commits (not as one big commit) on top of that branch point. Now
you 'git checkout' that-svn-branch and do 'git reset --hard
the-git-branch', which should now consist of
v1--v2--v3--v4(git)--v5(git), etc. If you do 'git svn dcommit' from
the that-svn-branch now it should dcommit to svn each of your git
commits individually. Of course, don't forget to make a backup before
you start messing around :P.

-- 
Cheers,

Sverre Rabbelier
