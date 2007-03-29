From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 23:55:46 +0400
Message-ID: <20070329195546.GB8830@hermes>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 21:55:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX0im-00055H-9Q
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 21:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbXC2Tzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 15:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbXC2Tzg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 15:55:36 -0400
Received: from hu-out-0506.google.com ([72.14.214.231]:65235 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030622AbXC2Tzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 15:55:35 -0400
Received: by hu-out-0506.google.com with SMTP id 36so12628905hui
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 12:55:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TWiDABjidRVej8tGa63IcTFlaCwPvmQplUJoImUB1Z/Xdn9U3b+6IAky/qpcLaKNH+hGB/UbQfbcOaw0w6+iqOfegK9sn3lq33hWUhe+hGOInvXjgTveDX+iLqESn2vynyc/K2mROZug50KeVFYuweElp+yVcSNvCjmooEYT/j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=nVozk/QOuZgeMKJyrB9+YnuvrU8aTrIhjs1DzedFRBvrvV+NB+2ciS5KMEBkkP2MyMegoT/fbaXD9iZQAGQL7JdFJ6Ho+j9uAP4nxOQWwpNMAAEnsVtWix6UZ++WrT+U+n/1kCqqAF1AbDUwIAQzJROoojj29Wfevzw0FFJfnjM=
Received: by 10.66.243.2 with SMTP id q2mr1638011ugh.1175198133835;
        Thu, 29 Mar 2007 12:55:33 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id m1sm1483319uge.2007.03.29.12.55.32;
        Thu, 29 Mar 2007 12:55:33 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Thu, 29 Mar 2007 23:55:49 +0400 (MSD)
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070329183237.GB2809@steel.home>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43465>

On Thu, Mar 29, 2007 at 08:32:37PM +0200, Alex Riesen wrote:
> Alex Riesen, Thu, Mar 29, 2007 17:04:31 +0200:
> > CONFLICT (rename/rename): Rename 1->a in branch HEAD rename 1->b in B
> > Automatic merge failed; fix conflicts and then commit the result.
> > 
> > Tom, either the stack trace of -O0 -ggdb or your repo is badly needed.
> > The stack preferred, as I have that feeling it'll just work everywhere
> > else but your system (can you try it somewhere else, BTW?).
> 
> Ok-key... Thanks Tom, for the testcase. I believe we haven't had this
> one yet: the merge base in the second (inner) merge is the initial
> commit. Which is strange:

The actual case that caused the error didn't have the initial commit, I
used cg-admin-rewritehist to create a (slightly) smaller test case that
exhibited the behavior.

  Tom
