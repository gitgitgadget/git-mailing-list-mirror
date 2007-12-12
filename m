From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin
	command.
Date: Wed, 12 Dec 2007 10:04:26 -0500
Message-ID: <1197471866.9269.2.camel@hinata.boston.redhat.com>
References: <20071211195712.GA3865@bitplanet.net>
	 <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
	 <1197416286.7552.4.camel@hinata.boston.redhat.com>
	 <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0712121103510.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2T9o-0007fu-3j
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbXLLPE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXLLPE7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:04:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbXLLPE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:04:58 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBCF4XHp031789;
	Wed, 12 Dec 2007 10:04:33 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCF4XrK026746;
	Wed, 12 Dec 2007 10:04:33 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCF4WHw029517;
	Wed, 12 Dec 2007 10:04:32 -0500
In-Reply-To: <Pine.LNX.4.64.0712121103510.27959@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68046>

On Wed, 2007-12-12 at 11:12 +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 11 Dec 2007, Junio C Hamano wrote:
...
> >  * --shared optimization
> > 
> >    This is a very easy addition to "git remote add".  You make sure that
> >    the added remote repository is on a local machine, and set up
> >    alternates to point at its object store.
> 
> Concur.
> 
> Since I want to lose that dependency on cpio on Windows (which we fake by 
> using tar), I'll implement this in C anyway.

It's not used for --shared (which is just writing an alternates file),
it's used for -l, hardlinking locally cloned repos.  The code to replace
cpio is already in the patch I sent, look for clone_local().

cheers,
Kristian
