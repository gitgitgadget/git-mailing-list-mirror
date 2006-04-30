From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote
 information in the config
Date: Sun, 30 Apr 2006 12:37:09 -0400
Message-ID: <BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
	<Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 18:42:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaF0Z-00055b-3D
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 18:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWD3Qmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 12:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWD3Qmt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 12:42:49 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:62320 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751166AbWD3Qms (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 12:42:48 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Apr 2006 09:41:47 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 251A2644C28;
	Sun, 30 Apr 2006 12:41:46 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060430123709.11fcdd5f.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Apr 2006 16:41:47.0448 (UTC) FILETIME=[F8E63380:01C66C74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:


> > the terminology and help make things clear.  We're not storing "Pull:"
> > information, we're storing config/remote.$NICK.fetch data.  It's really
> > used just by fetch, pull just happens to call fetch.
>
> I have no strong feelings either way.

Yeah, once you "get" it, it's not a problem; but it's not easy when you're
just learning git to separate fetch and pull.  It's made harder if git 
can't even keep them straight internally. :o/

[...]

> The latter should be done, because "git fetch" really is about fetching, 
> not playing games with the config.

Then we should also remove the --store option from pull and fetch.  It
can be set with git-repo-config.

> FETCH_HEAD can contain multiple refs. 

Which head does git-pull then use to merge, all of them?

> And I don't get the part about fetching from multiple remotes: 
> my patch does not allow for that.

Actually it does :o)  User just needs multiple remote.$nick.url entries 
in his config.

> But it does! Note the "uri_[current_uri++]" part of the patch.
[...]
> No. It is only used when there were no refspecs specified on the command 
> line:
> 
>         if (refspec_nr == 0)
>                 set_refspecs((const char**)refspecs_, current_refspec);

Right you are, on both counts.

Sean
