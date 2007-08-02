From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 11:08:25 +1200
Message-ID: <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
References: <46AFCF3E.5010805@alum.mit.edu>
	 <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com>
	 <46B1F96B.7050107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:08:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjmQ-0002qa-KH
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327AbXHBXI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756262AbXHBXI1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:08:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:52277 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbXHBXI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:08:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so269234wra
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:08:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R8Sqy0oqtkl01GzZQAfAgseU4AFzb39rPM8VKVFyScYx9quN8POIQ/JadOdDlm4vaS9C8itM3LZy8J7QIZysidKK5UZyeK9hIDqFuVyFatVQMEIyoVPLgMTJ7yqbSAx9L6nM3H3BhpBu7J6CXUO4xzB0/1w9qYWvp9YpAwpGu44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IDDFXORZwfG3VvcOo2NBLJsQ0iizAhYrv2o2UDxYQBfAG7nrfxHERNpw6mgOBnlNN+gQMh4kfGwBRUfVuf95JoVXOvOI/1CLS/TEZhNcDkGBMAR4PJVUGJRLd+JZQG7EZNPWwODA2rtaQWNlDjCDvMN1N5zZI/HpL2TBGSmzM/E=
Received: by 10.90.103.2 with SMTP id a2mr2596355agc.1186096105805;
        Thu, 02 Aug 2007 16:08:25 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Thu, 2 Aug 2007 16:08:25 -0700 (PDT)
In-Reply-To: <46B1F96B.7050107@alum.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54638>

On 8/3/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> cvsps is not a conversion tool at all, though it is used by other
> conversion tools to generate the changesets.  It appears (I hope I am
> not misinterpreting things) to emphasize speed and incremental
> operation, for example attempting to make changesets consistent from one
> run to the next, even if the CVS repository has been changed prudently
> between runs.  cvsps does not appear to attempt to create atomic branch
> and tag creation commits or handle CVS's special vendorbranch behavior.
>  cvsps operates via the CVS protocol; you don't need filesystem access
> to the CVS repository.

100% in agreement. And though I can't claim to be happy with cvsps, in
many scenarios it is mighty useful, in spite of its significant warts.
 The "does incrementals" is hugely important these days, as lots of
people use git to run "vendor branches" of upstream projects that use
CVS.

To me, that's *the* killer-app feature of git. Of course, others see
different aspects of git as their deal-maker. But I'm sure I'm not
alone on this. Surely enough, others have written git-svn which
accomplishes this and more for those tracking SVN upstreams.

Is there any way we can run tweak cvs2svn to run incrementals, even if
not as fast as cvsps/git-cvsimport? The "do it remotely" part can be
worked around in most cases.

cheers,


martin
