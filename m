From: Dominik Vogt <vogt@linux.vnet.ibm.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Wed, 11 Dec 2013 08:37:11 +0100
Message-ID: <20131211073711.GA4848@linux.vnet.ibm.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
 <xmqqsiu1yd7p.fsf@gitster.dls.corp.google.com>
 <20131210083531.GB4087@linux.vnet.ibm.com>
 <87bo0olebe.fsf@igel.home>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 08:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeMG-0008Q0-Bv
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab3LKHhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:37:17 -0500
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:46340 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3LKHhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:37:15 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <vogt@linux.vnet.ibm.com>;
	Wed, 11 Dec 2013 07:37:13 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
	by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Wed, 11 Dec 2013 07:37:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E7CBE219005E
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 07:37:11 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBB7axhB196934
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 07:37:00 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rBB7bBJ3029267
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 00:37:11 -0700
Received: from bl3ahm9f.de.ibm.com (dyn-9-152-212-171.boeblingen.de.ibm.com [9.152.212.171])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id rBB7bBnl029262
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 00:37:11 -0700
Received: from dvogt by bl3ahm9f.de.ibm.com with local (Exim 4.76)
	(envelope-from <vogt@linux.vnet.ibm.com>)
	id 1VqeM3-0001LV-7n
	for git@vger.kernel.org; Wed, 11 Dec 2013 08:37:11 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87bo0olebe.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13121107-1948-0000-0000-0000072E9F5D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239169>

On Tue, Dec 10, 2013 at 08:02:29PM +0100, Andreas Schwab wrote:
> Dominik Vogt <vogt@linux.vnet.ibm.com> writes:
> 
> > The second best approach I could think of is to stamp files with the
> > timestamp of the last commit that touched that, but I guess that is
> > not a cheap operation either.
> 
> I'm using this script for this:
[snip]

Hm, that runs 18 s on the local Gcc repository.  That's not as
expensive as I would have thought, but definitely not suitable to
run automatically on each checkout.  I wonder if performance could
be improved by integrating the script logic into the git-checkout
code (activated by a command line option).

On Tue, Dec 10, 2013 at 05:39:05PM -0800, Constantine A. Murenin wrote:
> You can already do this with a very small third-party script:
>
>     https://github.com/cnst/git-tools/blob/master/git-restore-mtime-core

That script just produces error messages for me.

Ciao

Dominik ^_^  ^_^

-- 

Dominik Vogt
IBM Germany
