From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 20:59:25 +0000
Message-ID: <20120727205925.GA14046@dcvr.yhbt.net>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org>
 <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <50130062.7090901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SurdD-0007mo-4A
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab2G0U70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:59:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60553 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab2G0U70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:59:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FCC1F5B5;
	Fri, 27 Jul 2012 20:59:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50130062.7090901@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202376>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.27 1:07 PM, Eric Wong wrote:
> > While Makefile.PL now finds .pm files on its own, it does not
> > detect new files after it generates perl/perl.mak.
> 
> Are you saying this doesn't work?
> 
> perl Makefile.PL
> make -f perl.mak
> touch Git/Foo.pm
> perl Makefile.PL
> make -f perl.mak

This works.

> or this?
> 
> perl Makefile.PL
> make -f perl.mak
> touch Git/Foo.pm
> make -f perl.mak
> 
> The former should work.  The latter is a MakeMaker limitation.  Makefile.PL
> hard codes the list of .pm files into the Makefile.

Yup, Junio's patch works around the MM limitation so the latter works.
