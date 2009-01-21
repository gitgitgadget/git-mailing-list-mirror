From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: unmerged flag at git diff-index
Date: Wed, 21 Jan 2009 03:48:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210343510.19014@racer>
References: <1976ea660901201813r7b03525ax39fd0e1ecfb1700e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 03:49:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPT9V-0002WC-MF
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 03:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbZAUCru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 21:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbZAUCrt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 21:47:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:38852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754108AbZAUCrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 21:47:49 -0500
Received: (qmail invoked by alias); 21 Jan 2009 02:47:47 -0000
Received: from pD9EB3014.dip0.t-ipconnect.de (EHLO noname) [217.235.48.20]
  by mail.gmx.net (mp020) with SMTP; 21 Jan 2009 03:47:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19H4kZJDq1H6ldFqW13yAk2nt+XQgZye2cdvI8Zq4
	CtUgc6upejBo/1
X-X-Sender: gene099@racer
In-Reply-To: <1976ea660901201813r7b03525ax39fd0e1ecfb1700e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106560>

Hi,

On Wed, 21 Jan 2009, Frank Li wrote:

> There are conflict when I call git merge
> git ls-files -u
> 100644 54d05e1c40c686027b611b702e014284e9ab9a31 1       a.c
> 100644 a8a1b77c0d92f33491a0a69a8645f02ececb1eb6 2       a.c
> 100644 642ba972b2234f63048abcca544b3926f94e04ee 3       a.c
> 
> but when use git diff-index HEAD
> :100644 100644 a8a1b77c0d92f33491a0a69a8645f02ececb1eb6 0000000000000000000000
> 0000000000000000 M      a.c
> 
> a.c flag is M: Modification of the contents or mode of a file.
> 
> I think it should be U: file is unmerged(you must complete the merge
> before it can be commited)

You're talking plumbing here.  And diff-index is about the differences 
between the working directory and the index _stage 0_.

I don't think that's a bug (what would you display? stage 1? stage 2? 
stage 3?), but even if it weren't, it is plumbing, and plumbing's UI is 
guaranteed to be stable.

So I guess that you really have to use "git ls-files --stage" at some 
stage :-)

Ciao,
Dscho
