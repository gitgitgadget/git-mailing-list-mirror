From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] git rev-parse: Fix --show-cdup inside symlinked   directory
Date: Tue, 15 Jul 2008 21:08:20 +0200
Message-ID: <487CF5A4.2070700@dawes.za.net>
References: <1216131208.19334.171.camel@gemini>	 <20080715145920.13529.25603.stgit@localhost>	 <alpine.DEB.1.00.0807151614510.8950@racer>	 <20080715154036.GR10151@machine.or.cz>  <1216140100.19334.189.camel@gemini> <1216141099.19334.196.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Yves Orton <yves.orton@booking.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIpuX-0007es-FI
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 21:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759342AbYGOTI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762793AbYGOTI4
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 15:08:56 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:58756 "EHLO
	spunkymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759342AbYGOTIz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 15:08:55 -0400
Received: from [192.168.201.100] (unknown [41.246.241.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a3.g.dreamhost.com (Postfix) with ESMTP id 3ED3015D4ED;
	Tue, 15 Jul 2008 12:08:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <1216141099.19334.196.camel@gemini>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88588>

Yves Orton wrote:

> Hmm, realizing that was the workdir it wanted i tried it like so:
> 
> [dmq@somewhere apps]$ git --work-tree="$(git-rev-parse --git-dir)/.."
> pull --rebase
> /usr/bin/git-sh-setup: line 139: cd: /home/dmq/git_tree/main/apps/.git:
> No such file or directory
> Unable to determine absolute path of git directory
> 
> Yet:
> 
> [dmq@somewhere apps]$ git-rev-parse --git-dir
> /home/dmq/git_tree/main/.git
> 
> is correct.
> 

Are you sure you don't want to specify the --git-dir rather than the 
work dir?

i.e.

git --git-dir="$(git-rev-parse --git-dir)" pull --rebase

Rogan
