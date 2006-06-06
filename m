From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Tue, 6 Jun 2006 07:39:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606060735400.29431@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk67v2o85.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606060117180.25685@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyij2mo8.fsf@assigned-by-dhcp.cox.net> <7vmzcr14ao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 07:39:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnUHT-0001uE-Sj
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 07:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWFFFjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 01:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWFFFjE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 01:39:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6099 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932095AbWFFFjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 01:39:02 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id ACB4D22DD;
	Tue,  6 Jun 2006 07:39:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9F5E52367;
	Tue,  6 Jun 2006 07:39:01 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 8672222DD;
	Tue,  6 Jun 2006 07:39:01 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzcr14ao.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21361>

Hi,

On Mon, 5 Jun 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > I know clone currently relies on init-db to create the directory if
> > it does not exist (I wrote the code after all).
> 
> Ah, I think I see the real problem is.  Alias handling is done
> too early, and for commands like init-db that does _not_ even
> want to look at an existing repository it tries to use GIT_DIR.
> 
> So how about this patch instead on top of yours?

Yes, I like it. I was so focused on reading the config early to be done 
with it, and avoiding reading the config twice (which it can do now, with 
your patch, but only if one is so insane to use nested aliases).

Your method of avoiding shadowing proper git commands is elegant, if maybe 
incomplete: you have no way of warning the user that the alias is not 
used. But then, I do not think that matters.

Ciao,
Dscho
