From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
 bit-masking
Date: Wed, 18 Feb 2009 14:59:29 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902181437260.6181@kiwi.cs.ucla.edu>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302> <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0902172354570.10279@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0902181238320.29723@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0902182219370.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:01:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZvPh-0000aS-OJ
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 00:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbZBRW7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZBRW7k
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:59:40 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:42269 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbZBRW7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 17:59:40 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n1IMxTQu008559;
	Wed, 18 Feb 2009 14:59:29 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n1IMxT8I008555;
	Wed, 18 Feb 2009 14:59:29 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0902182219370.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110591>

On Wed, 18 Feb 2009, Johannes Schindelin wrote:

> Okay, you asked for it.  I tried to be gentle.
> 
> I see _no_ value in your changes, and the diffstat as a _very_ real downside.
> 
> If the code would become clearer with your patch, I would not mind.  But I 
> find that the result is not more readable than the original.
> 
> As part of a parse-optification, I would not mind.  But before that, no.

Actually I appreciate your feedback, and the more direct the better.  The chief 
value I see in revising the code to accomplish these bit settings uniformly 
using well known macros is that later, if someone has good reason to extend the 
macro so it results in some new side effect, e.g. to update a dirty bit mask, 
the new behavior automatically cascades to every appropriate use out there in 
the code.  A macro is essentially a "code constant".  As with other constants, 
the benefit comes from defining it once and using it everywhere.  Is this effect 
not worth as much as I think it is?  Is there a hidden gotcha in my ideal?  Or 
does anyone else see value here?  Please speak up!

                                             -- Keith
