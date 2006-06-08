From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 13:30:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jun 08 13:30:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoIig-0000Vc-QG
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 13:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWFHLab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 07:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWFHLab
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 07:30:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53178 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932285AbWFHLaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 07:30:30 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id BED44235A;
	Thu,  8 Jun 2006 13:30:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B30121D9A;
	Thu,  8 Jun 2006 13:30:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 977C01D31;
	Thu,  8 Jun 2006 13:30:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21477>


These two patches introduce the long awaited global config. Thanks to 
Paksy for pushing and starting it.

The first patch only does the reading part, while the second introduces the
--no-local flag to git-repo-config.

There are three subjects for discussion:

- The name. I personally prefer .gitconfig, since we talk about the repo
  config all the time. But I have no strong feelings there.

- The --no-local flag could be implemented more cleanly, but also less
  elegantly, by introducing git_config_set_multivar_in_file(). I hesitated
  to do that, because there would be even more places replicating the
  global / local path resolution.

- With this, repo-config does no longer merit its name. What do people think
  about making it a builtin named "git config"? (Of course, nothing hinders
  us to keep the synonymous "repo-config" indefinitely...)

Ciao,
Dscho
