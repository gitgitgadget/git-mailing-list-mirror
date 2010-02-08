From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 8 Feb 2010 17:15:58 -0500
Message-ID: <20100208221558.GA21718@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:16:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nebtn-00067C-D7
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0BHWQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:16:00 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:35438 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab0BHWP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:15:59 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id B9D6082205A; Mon,  8 Feb 2010 17:15:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100208213256.GA470@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139325>

* Jeff King (peff@peff.net) [100208 16:32]:
> > @@ -1071,7 +1071,8 @@ int transport_push(struct transport *transport,
> >  		}
> >  
> >  		if (!quiet && !ret && !refs_pushed(remote_refs))
> > -			fprintf(stderr, "Everything up-to-date\n");
> > +			fprintf(porcelain ? stdout : stderr,
> > +				"Everything up-to-date\n");
> >  		return ret;
> >  	}
> 
> This one, on the other hand, seems to me to be just noise. What does a
> --porcelain caller learn by seeing "Everything up-to-date" that it did
> not already know from seeing the list of refs?

I agree.  I don't see how sending this message to stdout could possibly help the
--porcelain caller.


            --larry
