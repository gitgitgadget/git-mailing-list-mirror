From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] parseopt: introduce OPT_RECURSE to specify shared
 options
Date: Mon, 5 Nov 2007 13:46:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051340490.4362@racer.site>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site>
 <Pine.LNX.4.64.0711051315300.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 14:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip2Il-0004UH-1l
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 14:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbXKENrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 08:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbXKENrM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 08:47:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:34067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755149AbXKENrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 08:47:11 -0500
Received: (qmail invoked by alias); 05 Nov 2007 13:47:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 05 Nov 2007 14:47:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oa1JmIEboJ3k1DtwKC8YS64ve/lNkPQIsyhyYs/
	6uUFZMPl+RZZ5g
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711051315300.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63517>

Hi,

On Mon, 5 Nov 2007, Johannes Schindelin wrote:

> The diff options should not need to be defined in every user of the
> diffcore.  This provides the framework:
> 
> 	extern struct option *diff_options;
> 
> 	struct option options[] = {
> 		OPT_RECURSE(diff_options),
> 		...
> 		OPT_END(),
> 	};

After kicking this around a bit more on IRC, we had another idea.  Instead 
of introducing OPT_RECURSE(), do something like OPT__QUIET(), only this 
time in diff.h:

#define OPT__DIFF(opt) \
	OPT_BOOLEAN('p', NULL, &opt.format_patch, "show a patch"), \
	...

Pierre said this feels a bit "80s", so I'd like to hear other people's 
opinions.

Hmm?

Ciao,
Dscho
