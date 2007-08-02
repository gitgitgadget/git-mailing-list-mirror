From: Joel Reed <joelwreed@gmail.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 09:25:41 -0400
Message-ID: <20070802132541.GA9247@localdomain>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net> <vpq4pji3zwm.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021315510.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 15:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGaYg-0001Yk-5w
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 15:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbXHBNRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 09:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbXHBNRh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 09:17:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:11176 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbXHBNRg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 09:17:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so449738wxd
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 06:17:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=d9XGmZ0NIcSZiGVWngxJBmYglHxhbdGl6IygBN/CER94pqdRzZdaz3LksPkYWS7KKh8ys1qA5dD9x01FBo6Dk/LrLSyIonE47lTh885ekK+8tpZceOLnWp0Xl48eFQ0qd9Yz4jNTbPGS7dJTgZ7d7SfOxx77GqA6sY0CvvTCj1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Wub9hXqEgurxiX48wPVI0eOATThJXcFEz258zf/Wf6aDgBhHXgpOHOvFvDgN2IcglrH2S3Fy2EPiI6TTNR4kR5Qj79K32PSWUKVJgKx6YpOE2nssqycLJSpZewXIt8KHGxaetUyjj74NZryv81CLruQZY+skxDMimdJb+qxCS/Y=
Received: by 10.90.63.16 with SMTP id l16mr1763670aga.1186060655847;
        Thu, 02 Aug 2007 06:17:35 -0700 (PDT)
Received: from localhost ( [12.108.121.5])
        by mx.google.com with ESMTPS id 62sm2190783wri.2007.08.02.06.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 06:17:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708021315510.14781@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54549>

On Thu, Aug 02, 2007 at 01:19:55PM +0100, Johannes Schindelin wrote:

<snip>

> For performance reasons, git always compares the files' stat information 
> with that stored in the index.
> 
> By updating the file, you make that check fail always.
> 
> Without updating the index (which is not a read-only operation, and 
> therefore must not be done when doing a read-only operation like diff), 
> you will therefore _destroy_ the main reason of git's kick-ass 
> performance.

The idea that read-only operation like diff shouldn't update the
index makes a lot of sense.

But, as a user of git and not a git developer, I certainly _thought_
that git-status was a read-only operation as well. Now I know it
isn't, but this doesn't seem very consistent.

jr
