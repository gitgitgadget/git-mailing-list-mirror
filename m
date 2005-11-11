From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: tracking a tree that doesn't progress linearly
Date: Fri, 11 Nov 2005 17:58:54 +1300
Message-ID: <46a038f90511102058p6536b17crc7c9f7ce93167934@mail.gmail.com>
References: <17268.3463.252020.591687@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 06:00:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaR05-0005kp-Rr
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 05:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVKKE6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 23:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVKKE6z
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 23:58:55 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:41257 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932357AbVKKE6y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 23:58:54 -0500
Received: by zproxy.gmail.com with SMTP id i1so370127nzh
        for <git@vger.kernel.org>; Thu, 10 Nov 2005 20:58:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qVQ3Y7KdRMtTCwpHSoYt5BXWDhx2HQhPW54l74s+i3bFwTp1nQXiez+4tkXBTwtLQ9sbB/T1M06Tn0m+XxFzeUvxVSzK34s50umufAwYqA90VDV75UO1h1VuYSYPwO2pc65V7webXF2NG0PQhJ/4eFNHpd3ofm0zGJo7EC2rDsU=
Received: by 10.65.233.8 with SMTP id k8mr1881173qbr;
        Thu, 10 Nov 2005 20:58:54 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Thu, 10 Nov 2005 20:58:54 -0800 (PST)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17268.3463.252020.591687@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11557>

On 11/11/05, Paul Mackerras <paulus@samba.org> wrote:
> I want to be able to publish a git tree for others to follow but I
> also want to be retain the freedom to remove commits and/or rebase
> commits in the tree.

I sometimes want that too, but git doesn't have a 'rewind' semantics,
and probably for a good reason. The approach I am studying is to
create a thousand throaway short-lived branches. It is safe to publish
them as long as people following your branches _know_ that they'll be
orphaned, and that any commits they have on top of them they'll have
to rebase.

So you could publish your tree with devel-<datestamp> heads, and
announce when you're moving to a newer one. People tracking your
branches can tend register & checkout the new branches, and do a
git-merge to rebase their patches to your new branch, or replay them
with git-format-patch and git-am.

On the other hand, if  StGIT grows better support for sharing patches,
it could make all this look like the stone age.

cheers,


martin
