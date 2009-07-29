From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv3 6/8] First draft of notes tree parser with support for
 fanout subtrees
Date: Wed, 29 Jul 2009 18:45:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907291842360.7626@intel-tinevez-2-302>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <1248834326-31488-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCHl-0001Fx-4C
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbZG2Qpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbZG2Qpk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:45:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:39258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755170AbZG2Qpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 12:45:39 -0400
Received: (qmail invoked by alias); 29 Jul 2009 16:45:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 29 Jul 2009 18:45:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Jm/44uQkJxynw3IwsiOTowmNaIkzB9oLKDSsTSw
	lWwxzaQCCPTRpP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1248834326-31488-7-git-send-email-johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124370>

Hi,

On Wed, 29 Jul 2009, Johan Herland wrote:

> This is a relatively straightforward implementation of parsing notes 
> trees that use fanout directories to limit the size of individual tree 
> objects. This first draft uses a simple linked list for holding unparsed 
> subtree references (to be parsed on demand), and as such, this first 
> draft concentrates more on correctness than performance (AFAICS from 
> t3302, there is no measurable performance impact when no fanout subtrees 
> are present).

I know you want to have something working first and optimize then, but I 
imagined that the hashmap can actually contain the entries of the partial 
hashes, too.  You'll need to extend the data type, of course, to be able 
to say just how many digits of the SHA-1 are valid, and I guess for 
consistency you'll need to pad with 0s.

BTW have you done any performance benchmarks?  If so, how do they look?

Ciao,
Dscho
