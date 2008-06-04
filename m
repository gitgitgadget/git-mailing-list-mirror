From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: Re: git remote rename, why dosen't it exists?
Date: Wed, 04 Jun 2008 11:54:05 -0300
Message-ID: <1212591245.30731.17.camel@omicron.ep.petrobras.com.br>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>
	 <alpine.DEB.1.00.0806031449010.13507@racer.site.net>
	 <1212503641.30731.11.camel@omicron.ep.petrobras.com.br>
	 <alpine.DEB.1.00.0806032102350.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3uOH-0002LQ-B8
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYFDOyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbYFDOyL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:54:11 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:57851 "EHLO
	spunkymail-a16.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752112AbYFDOyK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 10:54:10 -0400
Received: from [127.0.0.1] (unknown [139.82.86.2])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by spunkymail-a16.g.dreamhost.com (Postfix) with ESMTP id 47D5B7D2D8;
	Wed,  4 Jun 2008 07:54:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806032102350.13507@racer.site.net>
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83786>

On Tue, 2008-06-03 at 21:12 +0100, Johannes Schindelin wrote:
> Hi,
> 
> [please do not top-post: it makes it very hard to follow the flow, 
> especially on a high-volume mailing list like this.]
> 
sorry about that. :-/ 

> On Tue, 3 Jun 2008, Victor Bogado da Silva Lins wrote:
> 
> > On Tue, 2008-06-03 at 14:49 +0100, Johannes Schindelin wrote:
> > 
> > > On Tue, 3 Jun 2008, Victor Bogado da Silva Lins wrote:
> > > 
> > > > Well, that's about it, I need to rename my remotes. Mainly to move 
> > > > the origin to another repository and I miss the feature. Since many 
> > > > time there is a reason for a missing feature, I fought that maybe I 
> > > > should ask here, before nosing around the sources... :)
> > > 
> > > The reason is easy to find: nobody cared enough about this feature to 
> > > implement it.
> > > 
> > > Just tell me if you want to do it, I'll provide you with the necessary 
> > > details.
> >
> > I don't mind trying. :P Pointers would help me, I already found that the
> > git-remote source is on the file builtin-remote.c, bu I have not yet
> > found the main function of it.
> 
> There is no main function, since it is a builtin.  The "main" function is 
> called cmd_remote().
> 
> You might find inspiration with the rm() function, or might even be able 
> to refactor the rm() function into an rm(), and an rm_or_rename() which
> does both rm() and rename() depending on a second parameter being NULL or 
> not.

I trying to refactor rm into rm_or_rename, but I stumbled into a
problem, how do I free a remote struct obtained with "remote_get"?
Another possibility would be another way to check if a remote already
exists without allocating it in case it does. The need comes from
testing whether the destination name already exists, if it does exists I
must free the remote_get and bail_out. 
