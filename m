From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: Re: t5000-tar-tree.sh failing
Date: Thu, 21 Dec 2006 19:59:48 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061221185948.GA27072@informatik.uni-freiburg.de>
References: <20061221133746.GA13751@cepheus> <Pine.LNX.4.63.0612211458360.19693@wbgn013.biozentrum.uni-wuerzburg.de> <9A725DAA-FAA8-4779-A73D-ED117CC068C1@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 20:00:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxT93-0003yw-U6
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 19:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWLUS7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 13:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423033AbWLUS7z
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 13:59:55 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:59852 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423032AbWLUS7y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 13:59:54 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxT8y-0002Q9-UR; Thu, 21 Dec 2006 19:59:53 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBLIxnHm027208;
	Thu, 21 Dec 2006 19:59:49 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBLIxmoB027207;
	Thu, 21 Dec 2006 19:59:48 +0100 (MET)
To: Brian Gernhardt <benji@silverinsanity.com>
Mail-Followup-To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9A725DAA-FAA8-4779-A73D-ED117CC068C1@silverinsanity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35081>

Hello,

Brian Gernhardt wrote:
> Several other test frameworks provide a "skip" method to indicate why  
> we've skipped something.  We could do something similar...
> 
> if skip 'unzip -h' 'tests need unzip'; then
>    # unzip tests
> fi
> 
> skip() {
>   # Have not checked to see if this is anything resembling working code
>   if eval $1 > /dev/null 2>&1; then
>     true
>   else
>     echo "* skipping tests: $2" 1>&2
>     false
>   fi
> }
> 
> Mostly so that skipped tests are obvious, provide a reason, and have  
> a standardized display format.  Again, too busy in actual work to try  
> to do this myself right now, but might hack at it this afternoon if  
> nobody else (hopefully someone more fluent in shell than I am) does.

I'm not sure if (in this case) a missing unzip should be as silent as
you suggest.  The danger is, that s.o. makes a change, runs `make test`
and is then conviced that nothing broke.  So I think that the test
should fail, but with a more descriptive error than it is now. 

The downside is, you need unzip, svn, what ever more to run the test
suite.

Best regards
Uwe

-- 
Uwe Kleine-Koenig

http://www.google.com/search?q=gigabyte+in+bit
