From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 09:13:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca> <e5d6i0$rnf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:13:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkbwI-0002NR-HV
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWE2HNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWE2HNU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:13:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:52696 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750708AbWE2HNT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:13:19 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 596B0D72;
	Mon, 29 May 2006 09:13:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 4CF02D4E;
	Mon, 29 May 2006 09:13:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 2D96EC38;
	Mon, 29 May 2006 09:13:18 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e5d6i0$rnf$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20926>

Hi,

On Mon, 29 May 2006, Jakub Narebski wrote:

> Michael Richardson wrote:
> 
> > This change adds $GIT_DIR/umask to contain a single line, an integer
> > which will be fed to umask(). This should also work for the git daemon,
> > which I personally do not use, so this may be inappropriate.
> 
> Shouldn't it be done rather via $GIT_DIR/config file, and 
> git-repo-config? I.e. instead of adding new file to repository layout,
> $GIT_DIR/umask, add core.umask to git configuration?

See also

http://thread.gmane.org/gmane.comp.version-control.git/13856/focus=13876

The essence of the thread: If you want to do anything useful in a non-bare 
repository, you are likely using other tools than git, which do not 
interpret core.umask or $GIT_DIR/umask.

If you use a bare repository, just make it shared. No need for an umask.

Hth,
Dscho
