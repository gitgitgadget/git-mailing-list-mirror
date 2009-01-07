From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 7 Jan 2009 11:07:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901071101480.7496@intel-tinevez-2-302>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>  <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de> <c09652430901061436w36c013ep938e9cfba43140c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-737314813-1231322835=:7496"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=D8yvind_Harboe?= <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 11:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKVL5-00005v-Ig
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 11:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbZAGKHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZAGKHU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 05:07:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:51385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751006AbZAGKHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 05:07:18 -0500
Received: (qmail invoked by alias); 07 Jan 2009 10:07:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 07 Jan 2009 11:07:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187lQcKDsc7xS9S/rgbnFdfZew9xp11f1iSxnbIVu
	f3FYn/FZxPTFdo
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <c09652430901061436w36c013ep938e9cfba43140c9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104780>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-737314813-1231322835=:7496
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 6 Jan 2009, Øyvind Harboe wrote:

> On Tue, Jan 6, 2009 at 11:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > $ git verify-pack -v $PACK | grep -v "^chain " | sort -n -k 4
> 
> I have never used the git verify-pack command, but I'm pretty sure the
> "Terminated" string isn't the normal output :-)
> 
> $ git verify-pack -v
> .git/objects/pack/pack-1e039b82d8ae53ef5ec3614a3021466663cc70a4
> Terminated

I did

	$ git grep Terminated

and came up empty :-)

Seriously, I guess this could be some OOM thing.  We _should_ handle this 
more gracefully, but it is possible that some uncatchable condition hits 
you, such as out-of-stack-space.

I'd try running the command either with strace or with gdb, and I'd look 
at $? after the command returns, to find out what is actually happening.

Hth,
Dscho

--8323329-737314813-1231322835=:7496--
