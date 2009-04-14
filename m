From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Mon, 13 Apr 2009 23:40:35 -0400
Message-ID: <200904132340.36191.mlevedahl@gmail.com>
References: <20090413110947.GA15647@coredump.intra.peff.net> <20090413112104.GE15982@coredump.intra.peff.net> <7vmyakh5wc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 05:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtZfI-0002tf-Bv
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 05:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZDNDsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 23:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZDNDsx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 23:48:53 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:43900 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZDNDsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 23:48:53 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2742495qwh.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3KW3p2sh9oLYjmnCNNEhfxFg34JyssGEOAkvD8/O7p8=;
        b=KWMxxpDBwzL6TAeTUvOonoUxdArVoX4+JFiID6lgNfIMCXyWH/rG5xP0scOdLBs29J
         IbYVs3KncP72L0HobBzE7tP/D6kz0AQWAs6hFEOoEeTrtCQYwS5EUPGi72XtPHxqXpqO
         qwOsZqn7ciu1dZArRxBo2qt/OyCefyeXmV4lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lXlLCxn5PaK305OUDmyIaqHoPDI5fp+hkW55iRIzvOBKFu6qXQqsmIz1IaONZpqZ6M
         LivwRroeFbLjtZcrcI9pMxRoL0BS6VjWyDGWrkBywfKiIHeblaMjICy29frNNDUyfJf9
         iSQcup1Yl0rqVV0cLhwMVh9W+6t3BjMPclTKY=
Received: by 10.224.73.132 with SMTP id q4mr6888633qaj.319.1239680441132;
        Mon, 13 Apr 2009 20:40:41 -0700 (PDT)
Received: from hplap.localnet (pool-173-79-135-88.washdc.fios.verizon.net [173.79.135.88])
        by mx.google.com with ESMTPS id 8sm179642qwj.6.2009.04.13.20.40.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 20:40:40 -0700 (PDT)
User-Agent: KMail/1.11.1 (Linux/2.6.27.21-170.2.56.fc10.i686; KDE/4.2.1; i686; ; )
In-Reply-To: <7vmyakh5wc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116508>

On Monday 13 April 2009 12:31:31 Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > I hope this helps a little bit with Mark's confusion. But while writing
> > it, I really think it would be a simpler rule to say "if it's in
> > refs/heads/, then it's a branch" (which is similar to what Mark
> > suggested earlier).
> >
> > So "git checkout refs/heads/master" would be identical to "git checkout
> > master". That would require a code change, though.
>
> Sorry, but I do not get the logic behind such a change.
>

I think the question being posed is: Would unifying branch names across all 
git commands (i.e., always accepting refs/heads/master as naming branch 
master, and accepting master when that is unambiguous) sufficiently benefit 
new users trying to learn git that it would be worth the change? The fact that 
refs/heads/master will be interpreted as branch or non-branch, and possibly as 
refs/heads/refs/heads/master, being a different branch, across different git 
commands is certainly not "intuitively obvious" to new users.

In this vein, I suggest that
	$ git checkout --detach master
as a way to get a detached HEAD on branch master is more understandable than
	$ git checkout refs/heads/master

Mark
