From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: git pull versus fetch/merge
Date: Mon, 21 Jul 2008 13:30:12 +0200
Message-ID: <48847344.5060908@keyaccess.nl>
References: <488452D6.1060508@keyaccess.nl> <20080721102320.GA19776@atjola.homenet> <48846BC2.4090407@keyaccess.nl> <20080721110900.GA8550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKtZa-0001Z0-Is
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbYGUL17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 07:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYGUL17
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 07:27:59 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:44382 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYGUL17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 07:27:59 -0400
Received: from [213.51.146.189] (port=39142 helo=smtp2.tilbu1.nb.home.nl)
	by smtpq2.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KKtYb-0006aQ-M1; Mon, 21 Jul 2008 13:27:57 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:39360 helo=[192.168.0.3])
	by smtp2.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KKo0C-0005wt-25; Mon, 21 Jul 2008 07:32:04 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080721110900.GA8550@sigill.intra.peff.net>
X-Spam-Score: 1.0 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89348>

On 21-07-08 13:09, Jeff King wrote:

> On Mon, Jul 21, 2008 at 12:58:10PM +0200, Rene Herman wrote:
> 
>> Thank you. Also due to a reply on the ALSA list by Mark brown I now get  
>> this. Yes, the remote was rebased while I had it setup as a remote here  
>> it seems; only recently have it under this name, so I didn't think that  
>> was the case. After a "git remote rm tiwai, git remote add tiwai <url>"  
>> things work fine again as it fetched a completely new branch.
> 
> Note that adding the remote with "git remote add" will add a fetchspec
> line like this:
> 
> [remote "tiwai"]
>   fetch = +refs/heads/*:+refs/remotes/tiwai/*
> 
> where the '+' means to force fetching rewound branches instead of
> rejecting them (this is safe, since you are just overwriting tracking
> branches, not your local work).

Not here...

rene@7ixe4:~/src/linux/7ixe4$ git remote add tmp 
git://git.alsa-project.org/alsa-kernel.git
rene@7ixe4:~/src/linux/7ixe4$ tail -3 .git/config 

[remote "tmp"]
	url = git://git.alsa-project.org/alsa-kernel.git
	fetch = refs/heads/*:refs/remotes/tmp/*
rene@7ixe4:~/src/linux/7ixe4$ git --version
git version 1.5.5

> So this should not come up again; presumably your previous remote
> configuration was set up differently.

Must be something new or configuration dependent I presume? It's not an 
option to git-remote it seems (but yes, thanks, I guess I'll add the +s 
-- a failed merge is warning enough that I need to rebuild whatever 
branch I'm pulling it into I guess).

Rene.
