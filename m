X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 11:14:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061111340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
 <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
 <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <slrnend551.arq.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 10:14:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <slrnend551.arq.Peter.B.Baumann@xp.machine.xx>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33423>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grtmz-0001DF-5I for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759301AbWLFKOG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760427AbWLFKOG
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:14:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:54756 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759301AbWLFKOD
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:14:03 -0500
Received: (qmail invoked by alias); 06 Dec 2006 10:14:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 06 Dec 2006 11:14:01 +0100
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Peter Baumann wrote:

> On 2006-12-06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > You can have the same effect as what Junio wrote with the config:
> >
> > $ git repo-config remote.origin.url git://git.kernel.org/pub/scm/git/git.git
> > $ git repo-config remote.origin.fetch \
> > 	refs/heads/master:refs/remotes/origin/master
> > $ git repo-config remote.origin.fetch \
> > 	refs/heads/next:refs/remotes/origin/next ^$
> > $ git repo-config remote.origin.fetch \
> > 	+refs/heads/pu:refs/remotes/origin/pu ^$
> >
> 
> What's that ^$ for?

We misuse the "nice" ini format a little bit in git: we allow multiple 
values for certain keys, like "remote.origin.fetch".

The normal mode for repo-config is to replace the value for the given key. 
By appending a regular expression, you can limit the replacement to 
certain matching _values_. And since "^$" means empty string, it does not 
match any, ensuring an append instead of a replace.

Ciao,
Dscho
