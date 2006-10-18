From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-log shows first parent and repeated last for octopus
 merge
Date: Wed, 18 Oct 2006 15:53:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610181551150.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eh5242$rar$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 15:54:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaBrM-0006DL-Qf
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 15:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWJRNx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 09:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWJRNx0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 09:53:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:26529 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161019AbWJRNxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 09:53:25 -0400
Received: (qmail invoked by alias); 18 Oct 2006 13:53:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 18 Oct 2006 15:53:24 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eh5242$rar$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29233>

Hi,

On Wed, 18 Oct 2006, Jakub Narebski wrote:

> When trying to find how many merges and how many octopus merges (merges with
> more than two parents) are in git.git repository I have encountered the
> following strange output of git-log:
> 
>  1000:jnareb@roke:~/git> git log --parents --full-history --max-count=1 \
>    211232bae64bcc60bbf5d1b5e5b2344c22ed767e -- a//b
>  commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e <last parent repeated>
>  Merge: d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b... d0d0d0b...
>  [...]

This happens because a//b rewrites the history, i.e. the parents are 
edited. IMHO it makes no sense at all to show the parents in such a case, 
since they are bogus.

Ciao,
Dscho
