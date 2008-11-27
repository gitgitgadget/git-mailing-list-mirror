From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] sha1_file: avoid bogus "file exists" error message
Date: Thu, 27 Nov 2008 12:41:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811271233590.2883@sys-0.hiltweb.site>
References: <20081120185628.GA25604@kodama.kitenet.net> <20081126181928.GA31007@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Nov 27 18:42:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5ksz-0006hf-V2
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 18:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYK0RlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 12:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYK0RlY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 12:41:24 -0500
Received: from mail.gmx.com ([74.208.5.67]:57830 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751706AbYK0RlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 12:41:24 -0500
Received: (qmail invoked by alias); 27 Nov 2008 17:41:22 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us003) with SMTP; 27 Nov 2008 12:41:22 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX19CKEQfCQBCHGHX0J619L4dqVypcfrKupor0lf/Ez
	KDjZ0eB7mvcoQs
In-Reply-To: <20081126181928.GA31007@kodama.kitenet.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101818>

On Wed, 26 Nov 2008, Joey Hess wrote:
> Joey Hess wrote:
> > Note that in both occasions that I've seen this failure, it has not been
> > due to a missing directory, or bad permissions
> 
> Actually, it was due to bad permissions. :-) Once git was fixed to
> actually say that, I figured out where to look to fix them.

This is strange since write_loose_object() which calls create_tmpfile()
checks for EPERM.  Perhaps this should be done in create_tmpfile()?
