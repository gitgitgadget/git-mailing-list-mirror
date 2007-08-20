From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 13:46:19 +0100
Message-ID: <200708201346.21557.andyparkins@gmail.com>
References: <1187603749.11595.10.camel@tom-desktop> <87bqd2bgb0.fsf@morpheus.local> <1187612156.11595.17.camel@tom-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Tom Schinckel <gunny01@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN6eR-0002Qf-J7
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 14:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbXHTMqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 08:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbXHTMqc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 08:46:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20735 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbXHTMqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 08:46:31 -0400
Received: by nf-out-0910.google.com with SMTP id g13so621216nfb
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 05:46:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pNwVqMYpugNPBALMz60Sl8PE9FM7lnMWmeYhVBrfFdKYWqKak1vS51HnzDehSMerkLb5cbaunuJs7W0iL4NzcnD+RQBF/36nIuvHd6ZtBgfu1/a8nxqqkY+mvRg6VsWrGpUJh0nB2nOw4/7q4w8STbTaAWhXZmf9aOM7dNhOLj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EiIKd5meF7grDcIL9kGsX8Zob8vCMSuBr5HuHVi8srZbcXw6dfJMzWvYG7B0gt4RM6nAOSLcfqSf4fwwStD3s1aICM/pXelXBGiA+ikF7yrHXZOjDrGhqvqahWhrBR8T2eyaPCoGP7q7hCt5coZQySBlR4dVQvGtxPwoK3N+JwM=
Received: by 10.86.57.9 with SMTP id f9mr4527104fga.1187613988891;
        Mon, 20 Aug 2007 05:46:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c24sm9903013ika.2007.08.20.05.46.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2007 05:46:27 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <1187612156.11595.17.camel@tom-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56211>

On Monday 2007 August 20, Tom Schinckel wrote:

> The reason I want to do that is so I can set up blind commits that I can
> add in a anacron job or something. The information about the files isn't
> really important

The point still stands though - what you are asking is to put information the 
commit message that is available outside of the commit message anyway - so 
why bother?  If you really don't care about a commit message, then just use

 git commit -a -m ""

This commits all (-a) changed files and uses an empty commit message (-m "").

Then later, if you wanted to see a summary of a particular commit

 git show --stat <commit hash>

For example, in my currently checked out git repository:

$ git show --stat HEAD
commit 83b3df7d582429d9036f34d2c95abfff7bf0ab24
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Jul 27 23:51:45 2007 -0700

    git-stash apply --index: optimize postprocessing
    
    Originally, "apply --index" codepath was bolted on to the
    "update working tree files and index, but then revert the
    changes we make to the index except for added files so that we
    do not forget about them" codepath, almost as an afterthought.
    Because "apply --index" first prepares the final index state
    upfront, "revert except the added paths" postprocessing does not
    have to be done.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 git-stash.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

In particular note the summary at the bottom - that's not stored in the commit 
message, but git is perfectly capably of telling you all about what files 
changed.  No need to put git-status in the log message as well.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
