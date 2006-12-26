From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors when updating an old git.git repository
Date: Tue, 26 Dec 2006 23:54:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612262350070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87d566ww3r.fsf@trews52.bothi.fi>
 <8c5c35580612260737vae2669dkac6a81fe863484d4@mail.gmail.com>
 <87ac1awjh0.fsf@trews52.bothi.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 23:54:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzLBi-00072T-D0
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 23:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbWLZWyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 17:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWLZWyV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 17:54:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:58330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932848AbWLZWyU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 17:54:20 -0500
Received: (qmail invoked by alias); 26 Dec 2006 22:54:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 26 Dec 2006 23:54:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Hannu Koivisto <azure@iki.fi>
In-Reply-To: <87ac1awjh0.fsf@trews52.bothi.fi>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35433>

Hi,

On Tue, 26 Dec 2006, Hannu Koivisto wrote:

> "Lars Hjemli" <hjemli@gmail.com> writes:
> 
> > On 12/26/06, Hannu Koivisto <azure@iki.fi> wrote:
> 
> > I guess you have some branch references in the file
> > .git/remotes/origin that shouldn't be there, so you can just remove
> > the lines that mention  'jc/bind', 'jc/bind-2' and 'gb/diffdelta' from
> > that file.
> 
> Thanks, but I don't need to fix the repository since a clean clone 
> works, I just wanted to report it so that git can be fixed, if possible.

Git works quite as expected here, so there is nothing to fix.

> error: no such remote ref refs/heads/jc/bind
> error: no such remote ref refs/heads/jc/bind-2
> error: no such remote ref refs/heads/gb/diffdelta

Since you said it is an older git repository, I guess that in your 
.git/remotes/origin are some lines like this:

	Pull: refs/heads/jc/bind:refs/heads/jc/bind

So, you _asked_ git to fetch these three branches! By not providing _any_ 
remote, you said: "look into .git/remotes/origin". And in that file you 
said: "fetch bind, bind-2 and diffdelta".

And git faithfully reports that it cannot fetch these branches (they are 
no longer there) and errors out.

Ciao,
Dscho
