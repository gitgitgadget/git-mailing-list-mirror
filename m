From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 01:59:17 +0400
Message-ID: <20080716215917.GG2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJF2t-0006cx-LA
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbYGPV7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbYGPV7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:59:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:59587 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbYGPV7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:59:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3609635fkq.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8BWSLBO0IAa0WjOjg3lRzYZhdXc+wR1Pf6KGZjAv1yk=;
        b=rSkv6TL6p/liwAZH1dM3J01Ii+G/mEq6OKvDEasi/SBKoxrNv74oekl/GiKQJr69Ci
         i0hfcAEXwhqxXSXh67yaTOLw+pWNgXJucIpDcFvSnNWY1k+1RNcNCpFYzKlWFYSHJJMS
         /1iDkVEP3rqdmZUQcckMSVt5oN/KwavWnwGxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RzysF5ePXEiKHsbRP+NX0InNOfM2hDFtlOJZCHXEOwj0wZ7h7t4WGRJIZV5VuBDEdQ
         Q+G15fGts1HksqZPTfGNhLP6Hc4sP5jI/89lyNgKRshKpM/H0W0cOIqJgiCbsDq536bX
         iUrlEp4XACCQpsxw4Wqyo2zLtcE82AXGdDB+U=
Received: by 10.86.80.5 with SMTP id d5mr2786465fgb.26.1216245561721;
        Wed, 16 Jul 2008 14:59:21 -0700 (PDT)
Received: from localhost ( [85.141.190.235])
        by mx.google.com with ESMTPS id l19sm1343192fgb.7.2008.07.16.14.59.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 14:59:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88767>

On Wed, Jul 16, 2008 at 02:51:30PM -0400, Avery Pennarun wrote:
> 
> svn avoids these excess merges by default, albeit because it puts your
> working copy at risk every time you do "svn update".

You can do "git pull --rebase" if you like. And there is a configuration
option that allows you to avoid typing --rebase every time. Or did you
mean to being to do that without saving your changes? I think the later
is really a bogus idea, and it should not be encouraged. The worst than
that can be only say "svn update" while you still have not saved changes
in your editor. Then you will have even more fun. So the rule should be:
save your changes first, and only then pull from the upstream.

BTW, one thing is to avoid excessive merges, and the other thing is to
do not have this feature at all. SVN is still not capable to merge,
because merge means to have more than one parent. SVN cannot do that.
What SVN does instead is very limited and buggy cherry-picking:
http://subversion.tigris.org/issues/show_bug.cgi?id=2897

In fact, this is not cherry-picking patches but per-file cherry-picking
and due to limitations of their automatic revision filtering, they have
a nice feature -- to edit svn:mergeinfo manually. Obviously, it is
impossible to visualize this per-file property well. Thus when you are
going to merge something in SVN, you have no slightest idea what you are
really doing.

Have fun,
Dmitry
