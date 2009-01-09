From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] make diff --color-words customizable
Date: Fri, 9 Jan 2009 01:25:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901090121432.30769@pacific.mpi-cbg.de>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 09 01:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL5CK-0008LO-U3
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbZAIAYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755923AbZAIAYh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:24:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:43200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751877AbZAIAYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:24:36 -0500
Received: (qmail invoked by alias); 09 Jan 2009 00:24:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 09 Jan 2009 01:24:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UmttmiftUuuwPzt/a/YDZInRH52Z5r7T2D6yhzh
	RPVS/YiwfrPcN4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231459505-14395-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104975>

Hi,

On Fri, 9 Jan 2009, Thomas Rast wrote:

> Allows for user-configurable word splits when using --color-words. This 
> can make the diff more readable if the regex is configured according to 
> the language of the file.
> 
> For now the (POSIX extended) regex must be set via the environment
> GIT_DIFF_WORDS_REGEX.  Each (non-overlapping) match of the regex is
> considered a word.  Anything characters not matched are considered
> whitespace.  For example, for C try
> 
>   GIT_DIFF_WORDS_REGEX='[0-9]+|[a-zA-Z_][a-zA-Z0-9_]*|(\+|-|&|\|){1,2}|\S'
> 
> and for TeX try
> 
>   GIT_DIFF_WORDS_REGEX='\\[a-zA-Z@]+ *|\{|\}|\\.|[^\{} [:space:]]+'

Interesting idea.  However, I think it would be better to do the opposite, 
have _word_ patterns.  And even better to have _one_ pattern.

Then we could have a --color-words-regex=<regex> option.

BTW I think you could do what you intended to do with a _way_ smaller 
and more intuitive patch.

Ciao,
Dscho
